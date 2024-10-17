import java.util.concurrent.atomic.{AtomicInteger, AtomicReference}

object ConcurrencyTroubles {
  private val value1: AtomicInteger = new AtomicInteger(1000)
  private val value2: AtomicInteger = new AtomicInteger(0)
  private val sum: AtomicReference[Int] = new AtomicReference(0)

  def moveOneUnit(): Unit = {
    value1.decrementAndGet()
    value2.incrementAndGet()
    if(value1.get() == 0) {
      value1.set(1000)
      value2.set(0)
    }
  }

  def updateSum(): Unit = {
    sum.set(value1.get() + value2.get())
  }
  
  def execute(): Unit = {
    while(true) {
      moveOneUnit()
      updateSum()
      Thread.sleep(50)
    }
  }

  def main(args: Array[String]): Unit = {
    for (i <- 1 to 48) {
      val thread = new Thread {
        override def run = execute()
      }
      thread.start()
    }
    
    while(true) {
      updateSum()
      println(sum.get() + " [" + value1.get() + " " + value2.get() + "]")
      Thread.sleep(100)
    }
  }
}
