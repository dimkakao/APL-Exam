class Node
  attr_accessor :data, :next_node

  def initialize(data)
    @data = data
    @next_node = nil
  end
end

class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def add_last(data)
    new_node = Node.new(data)
    @head.nil? ? @head = new_node : @tail.next_node = new_node
    @tail = new_node
  end

  def add_first(data)
    new_node = Node.new(data)
    new_node.next_node = @head
    @head = new_node
    @tail = new_node if @tail.nil?
  end

  def add_at_position(index, data)
    return add_first(data) if index == 0

    new_node = Node.new(data)
    current_node = @head
    (index - 1).times do
      return nil if current_node.nil? || current_node.next_node.nil?
      current_node = current_node.next_node
    end

    new_node.next_node = current_node.next_node
    current_node.next_node = new_node
    @tail = new_node if new_node.next_node.nil?

    new_node
  end

  def size
    count = 0
    current_node = @head
    while current_node
      count += 1
      current_node = current_node.next_node
    end
    count
  end

  def print_all
    elements = []
    current_node = @head
    while current_node
      elements << current_node.data
      current_node = current_node.next_node
    end
    elements.join(" -> ")
  end

  def search(data)
    current_node = @head
    while current_node
      return current_node if current_node.data == data
      current_node = current_node.next_node
    end
    nil
  end

  def remove_first
    return if @head.nil?
    removed_node = @head
    @head = @head.next_node
    @tail = nil if @head.nil?
    removed_node
  end

  def remove_last
    return if @head.nil?
    if @head == @tail
      removed_node = @head
      @head = nil
      @tail = nil
    else
      current_node = @head
      while current_node.next_node != @tail
        current_node = current_node.next_node
      end
      removed_node = @tail
      @tail = current_node
      @tail.next_node = nil
    end
    removed_node
  end

  def remove_from_position(index)
    return if @head.nil? || index < 0

    if index == 0
      return remove_first
    end

    current_node = @head
    (index - 1).times do
      return nil if current_node.nil? || current_node.next_node.nil?
      current_node = current_node.next_node
    end

    removed_node = current_node.next_node
    current_node.next_node = current_node.next_node.next_node if current_node.next_node
    @tail = current_node if current_node.next_node.nil?

    removed_node
  end
end

def print_menu
  puts "\nLinked List Menu:"
  puts "1. Add Last"
  puts "2. Add First"
  puts "3. Add at Position"
  puts "4. Size"
  puts "5. Print All"
  puts "6. Search"
  puts "7. Remove First"
  puts "8. Remove Last"
  puts "9. Remove from Position"
  puts "0. Exit"
  print "Enter your choice: "
end

linked_list = LinkedList.new

loop do
  print_menu
  choice = gets.chomp.to_i

  case choice
  when 1
    print "Enter data to add last: "
    data = gets.chomp
    linked_list.add_last(data)
    puts "Added #{data} to the end."
  when 2
    print "Enter data to add first: "
    data = gets.chomp
    linked_list.add_first(data)
    puts "Added #{data} to the beginning."
  when 3
    print "Enter position to add at: "
    position = gets.chomp.to_i
    print "Enter data to add at position #{position}: "
    data = gets.chomp
    linked_list.add_at_position(position, data)
    puts "Added #{data} at position #{position}."
  when 4
    puts "Size: #{linked_list.size}"
  when 5
    puts "Linked List: #{linked_list.print_all}"
  when 6
    print "Enter data to search: "
    data = gets.chomp
    node = linked_list.search(data)
    if node
      puts "Found #{data} in the list."
    else
      puts "#{data} not found in the list."
    end
  when 7
    removed = linked_list.remove_first
    puts "Removed First: #{removed&.data}"
  when 8
    removed = linked_list.remove_last
    puts "Removed Last: #{removed&.data}"
  when 9
    print "Enter position to remove from: "
    position = gets.chomp.to_i
    removed = linked_list.remove_from_position(position)
    puts "Removed from position #{position}: #{removed&.data}"
  when 0
    puts "Exiting. Goodbye!"
    break
  else
    puts "Invalid choice. Please enter a valid option."
  end
end
