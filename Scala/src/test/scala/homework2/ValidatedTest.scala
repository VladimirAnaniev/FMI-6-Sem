package homework2

import org.scalatest.{FlatSpec, FunSuite, Matchers}

import homework2.Validated.ValidatedTuple3

class ValidatedTest extends FlatSpec with Matchers {
  "zip" should "combine valid instances" in {
    Valid(1).zip(Valid("a")) shouldEqual Valid((1, "a"))
  }

  it should "combine errors from invalid instances" in {
    Invalid(1).zip(Invalid(Chain(2, 3))) shouldEqual Invalid(Chain(1, 2, 3))
  }

  "map" should "transform valid values" in {
    Valid(2).map(_ * 2) shouldEqual Valid(4)
  }

  it should "preserve errors" in {
    Invalid(5).map(_ => 3).map(_ => 7) shouldEqual Invalid(5)
  }

  "flatMap" should "transform valid values" in {
    Valid(2).flatMap(x => Valid(x * 2)) shouldEqual Valid(4)
  }

  it should "preserve errors?" in {
    Invalid(2).flatMap(_ => Invalid(5)) shouldEqual Invalid(Chain(2))
  }

  "ValidatedTuple3" should "zip valid values" in {
    val zipped = (Valid(1), Valid(2), Valid(3)).zip

    zipped shouldEqual Valid((1, 2, 3))
  }

  it should "chain invalid values" in {
    val zipped = (Invalid(2), Valid(5), Invalid(Chain(5,6))).zip

    zipped shouldEqual Invalid(Chain(2, 5, 6))
  }
}
