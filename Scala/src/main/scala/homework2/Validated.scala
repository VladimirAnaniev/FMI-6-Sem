package homework2

sealed trait Validated[+E, +A] {
  def isValid: Boolean = this match {
    case Invalid(_) => false
    case Valid(_) => true
  }

  def get[B >: A]: A = this match {
    case Valid(a) => a
    case _ => throw new IllegalAccessError("Called get on invalid Validated!")
  }

  def getOrElse[B >: A](default: => B): B = this match {
    case Invalid(_) => default
    case Valid(value) => value;
  }

  def orElse[F >: E, B >: A](default: => Validated[F, B]): Validated[F, B] = if (isValid) this else default

  def zip[EE >: E, B](vb: Validated[EE, B]): Validated[EE, (A, B)] = (this, vb) match {
    case (Valid(a), Valid(b)) => Valid((a, b))
    case (Invalid(a), Valid(_)) => Invalid(a)
    case (Valid(_), Invalid(b)) => Invalid(b)
    case (Invalid(a), Invalid(b)) => Invalid(a ++ b)
  }

  def map[B](f: A => B): Validated[E, B] = this match {
    case Valid(a) => Valid(f(a))
    case Invalid(b) => Invalid(b)
  }

  def map2[EE >: E, B, R](vb: Validated[EE, B])(f: (A, B) => R): Validated[EE, R] = zip(vb) map f.tupled

  def flatMap[EE >: E, B](f: A => Validated[EE, B]): Validated[EE, B] = map(f) match {
    case Valid(a) => a
    case Invalid(b) => Invalid(b)
  }

  def fold[B](invalid: Chain[E] => B, valid: A => B): B = this match {
    case Invalid(errors) => invalid(errors)
    case Valid(a) => valid(a)
  }

  def foreach(f: A => Unit): Unit = fold(_ => (), f)
}

case class Valid[+A](a: A) extends Validated[Nothing, A]

case class Invalid[+E](errors: Chain[E]) extends Validated[E, Nothing]

object Invalid {
  def apply[E](error: E): Invalid[E] = Invalid(Chain(error))
}

object Validated {
  def sequence[E, A](xs: List[Validated[E, A]]): Validated[E, List[A]] = ???

  implicit class ValidatedTuple2[EE, A, B](val tuple: (Validated[EE, A], Validated[EE, B])) extends AnyVal {
    def zip: Validated[EE, (A, B)] = tuple._1 zip tuple._2

    def zipMap[R](f: (A, B) => R): Validated[EE, R] = zip map f.tupled
  }

  implicit class ValidatedTuple3[EE, A, B, C](val tuple: (Validated[EE, A], Validated[EE, B], Validated[EE, C])) extends AnyVal {
    def zip: Validated[EE, (A, B, C)] = {
      val values = tuple.productIterator.toList.map(_.asInstanceOf[Validated[EE, Any]])

      if (values.forall(_.isValid))
        Valid((tuple._1.get, tuple._2.get, tuple._3.get))
      else
        values.reduce((a, b) => a.zip(b)).asInstanceOf[Validated[EE, (A, B, C)]]
    }

    def zipMap[R](f: (A, B, C) => R): Validated[EE, R] = zip map f.tupled
  }

  implicit class ValidatedTuple4[EE, A, B, C, D]
  (val tuple: (Validated[EE, A], Validated[EE, B], Validated[EE, C], Validated[EE, D])) extends AnyVal {
    def zip: Validated[EE, (A, B, C, D)] = {
      val values = tuple.productIterator.toList.map(_.asInstanceOf[Validated[EE, Any]])

      if (values.forall(_.isValid))
        Valid((tuple._1.get, tuple._2.get, tuple._3.get, tuple._4.get))
      else
        values.reduce((a, b) => a.zip(b)).asInstanceOf[Validated[EE, (A, B, C, D)]]
    }

    def zipMap[R](f: (A, B, C, D) => R): Validated[EE, R] = zip map f.tupled
  }

  implicit class ValidatedTuple5[EE, A, B, C, D, E]
  (val tuple: (Validated[EE, A], Validated[EE, B], Validated[EE, C], Validated[EE, D], Validated[EE, E])) extends AnyVal {
    def zip: Validated[EE, (A, B, C, D, E)] = {
      val values = tuple.productIterator.toList.map(_.asInstanceOf[Validated[EE, Any]])

      if (values.forall(_.isValid))
        Valid((tuple._1.get, tuple._2.get, tuple._3.get, tuple._4.get, tuple._5.get))
      else
        values.reduce((a, b) => a.zip(b)).asInstanceOf[Validated[EE, (A, B, C, D, E)]]
    }

    def zipMap[R](f: (A, B, C, D, E) => R): Validated[EE, R] = zip map f.tupled
  }

  implicit class ValidatedOption[A](val option: Option[A]) extends AnyVal {
    def toValidated[E](onEmpty: E): Validated[E, A] = option match {
      case None => Invalid(onEmpty)
      case Some(value) => Valid(value)
    }
  }
}
