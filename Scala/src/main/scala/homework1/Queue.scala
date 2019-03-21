package homework1

import java.util.NoSuchElementException

class Queue private (private val items: List[Int]) {
  def peek: Int = if (!isEmpty) items.head else throw new NoSuchElementException

  def push(n: Int): Queue = Queue(items ::: List(n))
  def pop: Queue = if (!isEmpty) Queue(items.tail) else throw new NoSuchElementException

  def isEmpty: Boolean = items.isEmpty
  def size: Int = items.size
}

object Queue {
  def empty: Queue = Queue(Nil)

  def apply(xs: Seq[Int]): Queue = new Queue(xs.toList)
}