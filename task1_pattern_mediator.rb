# Бережний Дмитро КС31
# Клас посередника
class Mediator
  def send_message(component, message)
    raise NotImplementedError, 'This method should be overridden by subclasses'
  end
end

# Клас компонета
class Component
  # Назва компонета і посередник
  attr_accessor :name, :mediator

  def initialize(name, mediator)
    @name = name
    @mediator = mediator
  end

  def send_message(message)
    @mediator.send_message(self, message)
  end

  def receive_message(message)
    puts "I am #{@name} and I have received the message: #{message}"
  end
end

class ConcreteMediator < Mediator
  def initialize(component1, component2)
    @component1 = component1
    @component2 = component2
  end

  def send_message(component, message)
    related_components[component].receive_message(message)
  end

  # Хеш відношення пов'язаних компонентів у цьому посереднику
  def related_components
    {
      @component2 => @component1,
      @component1 => @component2,
    }
  end

end

# Створюємо компоненти без посередника
component1 = Component.new('Component 1', nil)
component2 = Component.new('Component 2', nil)

# Створюємо наший конкретний посередник
mediator = ConcreteMediator.new(component1, component2)

# Додаємо наший конкретний посередник до компонентів
component1.mediator = mediator
component2.mediator = mediator

# Симулюємо роботу
component1.send_message('Hello from Component 1!')
component2.send_message('Hi from Component 2!')