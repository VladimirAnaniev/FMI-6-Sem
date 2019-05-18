package homework2

import scala.util.{Failure, Success, Try}

case class RegistrationForm(name: String,
                            email: String,
                            password: String,
                            passwordConfirmation: String,
                            birthYear: String,
                            birthMonth: String,
                            birthDay: String,
                            postalCode: String)

sealed trait RegistrationFormError

case object NameIsEmpty extends RegistrationFormError

case class InvalidEmail(email: String) extends RegistrationFormError

case object PasswordTooShort extends RegistrationFormError

case object PasswordRequiresGreaterSymbolVariety extends RegistrationFormError

case object PasswordsDoNotMatch extends RegistrationFormError

case class InvalidBirthdayDate(dateErrors: Chain[DateError]) extends RegistrationFormError

case class BirthdayDateIsInTheFuture(date: Date) extends RegistrationFormError

case class InvalidPostalCode(code: String) extends RegistrationFormError

sealed trait DateError

case class YearIsNotAnInteger(year: String) extends DateError

case class MonthIsNotAnInteger(month: String) extends DateError

case class DayIsNotAnInteger(day: String) extends DateError

case class MonthOutOfRange(month: Int) extends DateError

case class DayOutOfRange(day: Int) extends DateError

case class InvalidDate(date: Date) extends DateError

case class Email(user: String, domain: String)

case class User(name: String,
                email: Email,
                passwordHash: String,
                birthday: Date,
                postalCode: Option[String])

object UserRegistration {
  def registerUser(userCountryPostalCodeVerifier: String => Boolean, today: Date)
                  (form: RegistrationForm): Validated[RegistrationFormError, User] = (
    validateName(form.name),
    validateEmail(form.email),
    validatePassword(form.password, form.passwordConfirmation),
    validateBirthDay(form.birthYear, form.birthMonth, form.birthDay, today),
    validatePostalCode(form.postalCode, userCountryPostalCodeVerifier)
  ).zipMap(User)

  def validateName(name: String): Validated[RegistrationFormError, String] =
    if (name.isEmpty) Invalid(NameIsEmpty) else Valid(name)

  def validateEmail(email: String): Validated[RegistrationFormError, Email] = {
    val parts = email.split('@')

    if (parts.length != 2 || parts(0).isEmpty || parts(1).isEmpty)
      Invalid(InvalidEmail(email))
    else
      Valid(Email(parts(0), parts(1)))
  }

  def validatePassword(password: String, confirmation: String): Validated[RegistrationFormError, String] = {
    def hasRequiredLength(password: String): Validated[RegistrationFormError, String] =
      if (password.length >= 8) Valid(password) else Invalid(PasswordTooShort)

    def hasSymbolVariety(password: String): Validated[RegistrationFormError, String] = {
      var regex = "((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).+)".r

      if (regex.findFirstIn(password).isDefined) Valid(password) else Invalid(PasswordRequiresGreaterSymbolVariety)
    }

    def doPasswordsMatch(password: String, confirmation: String): Validated[RegistrationFormError, String] =
      if (password.equals(confirmation)) Valid(password) else Invalid(PasswordsDoNotMatch)

    (
      hasRequiredLength(password),
      hasSymbolVariety(password),
      doPasswordsMatch(password, confirmation)
    ).zipMap((_, _, _) => PasswordUtils.hash(password))
  }

  def validateBirthDay(birthYear: String, birthMonth: String, birthDay: String, today: Date): Validated[RegistrationFormError, Date] = {
    def isValidYear(yearString: String): Validated[DateError, Int] = {
      Try(yearString.toInt) match {
        case Success(year) => Valid(year)
        case Failure(_) => Invalid(YearIsNotAnInteger(yearString))
      }
    }

    def isValidMonth(monthString: String): Validated[DateError, Int] = {
      Try(monthString.toInt) match {
        case Success(month) => if (month < 1 || month > 12) Invalid(MonthOutOfRange(month)) else Valid(month)
        case Failure(_) => Invalid(MonthIsNotAnInteger(monthString))
      }
    }

    def isValidDay(dayString: String): Validated[DateError, Int] = {
      Try(dayString.toInt) match {
        case Success(day) => if (day < 1 || day > 31) Invalid(DayOutOfRange(day)) else Valid(day)
        case Failure(_) => Invalid(DayIsNotAnInteger(dayString))
      }
    }

    def isValidDateFormat(birthYear: String, birthMonth: String, birthDay: String): Validated[DateError, (Int, Int, Int)] = (
      isValidYear(birthYear),
      isValidMonth(birthMonth),
      isValidDay(birthDay),
    ).zip

    def isValidDate(dateValues: (Int, Int, Int)): Validated[DateError, Date] = dateValues match {
      case (year, month, day) => Date.applyOption(year, month, day) match {
        case Some(date) => Valid(date)
        case None => Invalid(InvalidDate(Date(year, month, day)))
      }
    }

    def isDateInTheFuture(date: Date): Validated[BirthdayDateIsInTheFuture, Date] =
      if (date.isAfter(today))
        Invalid(BirthdayDateIsInTheFuture(date))
      else
        Valid(date)


    val validatedDate = for {
      dateValues <- isValidDateFormat(birthYear, birthMonth, birthDay)
      validatedDate <- isValidDate(dateValues)
    } yield validatedDate

    validatedDate match {
      case Valid(date) => isDateInTheFuture(date)
      case Invalid(errors) => Invalid(InvalidBirthdayDate(errors))
    }
  }

  def validatePostalCode(postalCode: String, userCountryPostalCodeVerifier: String => Boolean): Validated[InvalidPostalCode, Option[String]] =
    if (postalCode.isEmpty)
      Valid(None)
    else if (userCountryPostalCodeVerifier(postalCode))
      Valid(Some(postalCode))
    else
      Invalid(InvalidPostalCode(postalCode))
}
