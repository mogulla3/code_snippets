class Human
  def greet
    "hello"
  end

  def eat(dish)
    "I'm going to eat #{dish}"
  end

  def sleep
    "I'm going to sleep"
    sleeping_hours = (1..12).to_a.sample
    raise RuntimeError if sleeping_hours < 3
  rescue RuntimeError
    "I couldn't sleep well"
  end
end