package homework2

import java.time.{DateTimeException, LocalDate}

import scala.util.Try

case class Date(year: Int, month: Int, day: Int) {
  def isAfter(other: Date): Boolean =
    LocalDate.of(year, month, day).isAfter(LocalDate.of(other.year, other.month, other.day))
}

object Date {

  def applyOption(year: Int, month: Int, day: Int): Option[Date] = Try {
    LocalDate.of(year, month, day)

    Date(year, month, day)
  }.toOption
}
