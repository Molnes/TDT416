import scala.collection.mutable.ArrayBuffer
object Main {
  def main(args: Array[String]): Unit = {
    // Task 1
    task1.run()

    // Task 2
    task2.run()

    // Task 3
    task3.run()
  }
}

object task1 {
  def run() = {
    // a)
    var arr = Array.range(1, 51)

    // b)
    println("Sum of the array: " + sumOfArray(arr))

    // c)
    println("Sum of the array using recursion: " + sumRecursive(arr))

    // d)
    println("Fibonacci of 10: " + Fibonacci(10))
    // The difference between Int and BigInt is that Int is a 32-bit signed integer, while BigInt can grow as large as you need it to be, depending on the size of the number you give it.
  }

  /**
   * Computes the sum of all elements in an array of integers.
   *
   * @param arr An array of integers whose elements are to be summed.
   * @return The sum of all elements in the input array.
   */
  def sumOfArray(arr: Array[Int]): Int = {
    var sum = 0
    for (i <- 0 until arr.length) {
      sum += arr(i)
    }
    return sum
  }

  /**
   * Computes the sum of an array of integers using recursion.
   *
   * @param arr The array of integers to sum.
   * @return The sum of the integers in the array. If the array is empty, returns 0.
   */
  def sumRecursive(arr: Array[Int]): Int = {
    if (arr.isEmpty) 0
    else arr.head + sumRecursive(arr.tail)
  }

  /**
   * Computes the Fibonacci number for a given position.
   *
   * @param n The position in the Fibonacci sequence.
   * @return The Fibonacci number at the given position.
   */
  def Fibonacci(n: BigInt): BigInt = {
    if (n <= 1) n
    else Fibonacci(n - 1) + Fibonacci(n - 2)
  }

}

// Task 2
object task2 {
  def run() = {

    // a)  assignment 3 task 1
    var x1 = ArrayBuffer[Double]()
    var x2 = ArrayBuffer[Double]()
    var realSol = ArrayBuffer[Boolean]()

    QuadraticEquation(2, 1, -1, realSol, x1, x2)
    println("Real solutions: " + realSol)
    println("x1: " + x1)
    println("x2: " + x2)

    x1.clear()
    x2.clear()
    realSol.clear()

    QuadraticEquation(2, 1, 2, realSol, x1, x2)
    println("Real solutions: " + realSol)
    println("x1: " + x1)
    println("x2: " + x2)

    // assignment 3 task 4
    val f = Quadratic(3, 2, 1)
    println(f(2))

  }

  /**
   * Solves the quadratic equation of the form ax^2 + bx + c = 0.
   *
   * @param a The coefficient of x^2.
   * @param b The coefficient of x.
   * @param c The constant term.
   * @param realSol An ArrayBuffer to store whether the solutions are real (true) or not (false).
   * @param x1 An ArrayBuffer to store the first solution (if it exists).
   * @param x2 An ArrayBuffer to store the second solution (if it exists).
   *
   * The function calculates the discriminant (d) of the quadratic equation:
   * - If d > 0, there are two distinct real solutions, which are added to x1 and x2.
   * - If d == 0, there is one real solution, which is added to x1.
   * - If d < 0, there are no real solutions, and realSol is updated to false.
   */
  def QuadraticEquation(
      a: Double,
      b: Double,
      c: Double,
      realSol: ArrayBuffer[Boolean],
      x1: ArrayBuffer[Double],
      x2: ArrayBuffer[Double]
  ) = {
    var d = b * b - 4 * a * c
    if (d > 0) {
      realSol += true
      x1 += (-b + Math.sqrt(d)) / (2 * a)
      x2 += (-b - Math.sqrt(d)) / (2 * a)
    } else if (d == 0) {
      realSol += true
      x1 += -b / (2 * a)
    } else {
      realSol += false
    }
  }

  /**
   * Defines a quadratic function based on the coefficients a, b, and c.
   *
   * @param a The coefficient of the x^2 term.
   * @param b The coefficient of the x term.
   * @param c The constant term.
   * @return A function that takes an integer x and computes the value of the quadratic equation a*x^2 + b*x + c.
   */
  def Quadratic(a: Int, b: Int, c: Int): Int => Int = { (x: Int) =>
    a * x * x + b * x + c
  }
}

object task3 {

  def run() = {
    // a)
    val t1 = runner(() => println("Thread 1 is running"))
    val t2 = runner(() => println("Thread 2 is running"))
    val t3 = runner(() => println("Thread 3 is running"))

    // b)
    t1.start()
    t2.start()
    t3.start()

    // c)
    t1.join()
    t2.join()
    t3.join()
  }

  /**
   * Creates a new thread that will execute the given task.
   *
   * @param task A function with no arguments and no return value that represents the task to be executed.
   * @return A new Thread instance that will run the provided task when started.
   */
  def runner(task: () => Unit): Thread = {
    new Thread(() => task())
  }
}
