package homework1

import Functions._

object Main extends App {
  println(fromDigits(List(1, 2, 3))) // 123
  println(fromDigits(List(1, 12, 4), 16)) // 452; съответства на шестнайдесетичното число 1C4

  println(parseInteger("123")) // 123
  println(parseInteger("1C4", 16)) // 452
  println(parseInteger("-0111001", 2)) // -57

  println(zipMap(List(1, 2, 3), List(4, 5, 6), _ * _)) // List(4, 10, 18)
  println(zipMap(List(3, 6), List(20, 30, 40), (x, y) => y - x)) // List(17, 24)

  println(countCoinChangeVariants(List(1, 2, 5), 6)) // 5
}