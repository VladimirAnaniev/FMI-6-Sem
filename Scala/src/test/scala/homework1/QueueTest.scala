package homework1

import org.scalatest.FunSuite

class QueueTest extends FunSuite {
  test("Empty Queue should have size 0 and be empty") {
    val empty = Queue.empty
    assert(empty.size == 0)
    assert(empty.isEmpty)
  }

  test("Queue with 3 elements should have size 3 and not be empty") {
    val q = Queue(List(1, 2, 3))
    assert(q.size === 3)
    assert(!q.isEmpty)
  }

  test("Peek should return first element") {
    val q = Queue(List(1, 2, 3))
    assert(q.peek === 1)
  }

  test("Pop should return new queue and not modify old") {
    val q = Queue(List(1, 2, 3))
    val q2 = q.pop

    assert(q.size === 3)
    assert(q.peek === 1)

    assert(q2.size === 2)
    assert(q2.peek === 2)
  }

  test("Push should return new queue and not modify old") {
    val q = Queue(List(1, 2, 3))
    val q2 = q.push(4)

    assert(q.size === 3)
    assert(q.peek === 1)

    assert(q2.size === 4)
    assert(q2.peek === 1)
  }
}
