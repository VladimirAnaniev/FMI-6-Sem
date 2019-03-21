package homework1

object Functions {
  def fromDigits(digits: List[Int], radix: Int = 10): Int = {
    val powers: List[Int] = (digits.length - 1 to 0 by -1).toList

    def calculate: (Int, Int) => Int = _ * Math.pow(radix, _).toInt

    zipMap(digits, powers, calculate).sum
  }

  def parseInteger(integer: String, radix: Int = 10): Int =
    if (integer.head == '-') -1 * fromDigits(integer.toList.tail.map(_.asDigit), radix)
    else fromDigits(integer.toList.map(_.asDigit), radix)

  def zipMap(a: List[Int], b: List[Int], f: (Int, Int) => Int): List[Int] = a.zip(b).map(f.tupled(_))

  def countCoinChangeVariants(denominations: List[Int], change: Int): Int =
    if(change == 0) 1
    else if(change < 0 || denominations.isEmpty) 0
    else countCoinChangeVariants(denominations, change - denominations.head) + countCoinChangeVariants(denominations.tail, change)


  def bfsTraversal(start: Int, end: Int, neighbours: Int => List[Int]): Queue = ???
}
