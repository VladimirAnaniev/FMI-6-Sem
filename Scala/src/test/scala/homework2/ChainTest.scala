package homework2

import org.scalatest.{FlatSpec, Matchers}

class ChainTest extends FlatSpec with Matchers {
  "++" should "append two chains" in {
    (Chain(1, 2) ++ Chain(3, 4)) shouldEqual Chain(1, 2, 3, 4)
  }

  "max" should "return the biggest element" in {
    Chain(1, 20, 13, -6).max shouldEqual 20
  }


  "min" should "return the smallest element" in {
    Chain(1, 20, 13, -6).min shouldEqual -6
  }

  "listify" should "normalize the chain" in {
    Append(Append(Singleton(1), Singleton(2)), Append(Singleton(3), Singleton(4))).listify shouldEqual Append(Singleton(1), Append(Singleton(2), Append(Singleton(3), Singleton(4))))
  }

  "map" should "transform the values" in {
    Chain(1, 2, 4, 8).map(_ * 3) shouldEqual Chain(3, 6, 12, 24)
  }

  "flatMap" should "transform the values and flatten" in {
    Chain(1, 2, 3).flatMap(x => Chain(1, 2 to x toList: _*)) shouldEqual Chain(1, 1, 2, 1, 2, 3)
  }
}
