object HelloWorldApp {
  def main(args: Array[String]): Unit = {
        val fruits = List("apple", "banana", "avocado", "papaya")

        val countsToFruits = fruits.groupBy(fruit => fruit.count(_ == 'a'))

        for (count, fruits) <- countsToFruits do
            println(s"with 'a' × $count = $fruits")

  }}