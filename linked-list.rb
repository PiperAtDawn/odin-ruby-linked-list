class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end

  def has_next?
    next_node ? true : false
  end

  def to_s
    value ? value.to_s : 'nil'
  end
end

class LinkedList
  attr_accessor :head, :tail
  def initialize
    @head = nil
    @tail = nil
  end

  def empty?
    head ? false : true
  end

  def append(value)
    if self.empty?
      self.head = Node.new(value)
      self.tail = head
    else
      self.tail.next_node = Node.new(value)
      self.tail = tail.next_node
    end
  end

  def prepend(value)
    if self.empty?
      self.head = Node.new(value)
      self.tail = head
    else
      self.head = Node.new(value, head)
    end
  end

  def pop
    if self.empty?
      return

    elsif head == tail
      self.head = self.tail = nil
      return

    end
    cur = head
    loop do
      if cur.next_node == tail
        self.tail = cur
        self.tail.next_node = nil
        break
      else
        cur = cur.next_node
      end
    end
  end 

  def to_s
    if self.empty?
      puts 'nil'
      return
    end
    cur = head
    str = ''
    loop do
      str += "#{cur.value} -> "
      if cur.has_next?
        cur = cur.next_node
      else
        str += 'nil'
        break
      end
    end
    puts str
  end

  def size
    return 0 if self.empty?
    size = 1
    cur = head
    loop do
      if cur.has_next?
        size += 1
        cur = cur.next_node
      else
        break
      end
    end
    size
  end

  def contains?(value)
    cur = head
    loop do
      if !cur
        return false
      elsif cur.value == value
        return true
      end
      cur = cur.next_node
    end
  end

  def find(value)
    cur = head
    index = 0
    loop do
      if !cur
        return nil
      elsif cur.value == value
        return index
      end
      index += 1
      cur = cur.next_node
    end
  end

  def at(index)
    cur = head
    [*1..index].each do
      break if !cur

      cur = cur.next_node
    end
    cur
  end

  def insert_at(value, index)
    if index < 0
      return
    elsif index == 0
      self.head = Node.new(value, head)
      return
    end

    prev = at(index - 1)
    return if !prev

    prev.next_node = Node.new(value, prev.next_node)
  end

  def remove_at(index)
    if index < 0
      return
    elsif index == 0
      self.head = head.next_node
      return
    end

    prev = at(index - 1)
    return if !prev

    prev.next_node = prev.next_node.next_node
  end
end

list = LinkedList.new
list.append(1)
list.append(2)
list.prepend(3)
list.prepend(4)
list.to_s
# => 4 -> 3 -> 1 -> 2 -> nil

i = 1
puts "At position #{i}: #{list.at(i)}"
# => At position 1: 3

list.pop
list.to_s
# => 4 -> 3 -> 1 -> 2 -> nil

n = 1
puts "List contains #{n}: #{list.contains?(n)}"
# => true

puts "#{n} is at position #{list.find(n)}"
# => 1 is at position 2

list.insert_at(6, 2)
list.insert_at(7, 0)
list.to_s
# => 7 -> 4 -> 3 -> 6 -> 1 -> nil

list.remove_at(2)
list.remove_at(0)
list.to_s
# => 4 -> 6 -> 1 -> nil