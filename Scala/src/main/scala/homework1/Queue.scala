package homework1

class Queue private (private val items: List[Int]) {
  def peek: Int = items.head

  def push(n: Int): Queue = Queue(items ::: List(n))
  def pop: Queue = Queue(items.tail)

  def isEmpty: Boolean = items.isEmpty
  def size: Int = items.size
}

object Queue {
  def empty: Queue = Queue(Nil)

  def apply(xs: Seq[Int]): Queue = new Queue(xs.toList)
}