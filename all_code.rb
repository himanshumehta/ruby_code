# In memory filesystem
class FileSystem
  def initialize
    @root = {}
  end

  def ls(path)
    dirs = path.split("/")[1..-1]
    current_dir = get_dir(dirs)
    return [current_dir.file_name] if current_dir.is_a?(File)

    current_dir.keys.sort
  end

  def mkdir(path)
    dirs = parse_path(path)
    current_dir = @root

    dirs.each do |dir_name|
      current_dir[dir_name] = {} if current_dir[dir_name].nil?
      current_dir = current_dir[dir_name]
    end

    nil
  end

  def add_content_to_file(file_path, content)
    dirs = parse_path(file_path)
    file_name = dirs.pop
    current_dir = get_dir(dirs)

    if current_dir[file_name].nil?
      current_dir.merge!({ "#{file_name}" => File.new(file_name, content) })
    else
      current_dir[file_name].content += content
    end

    nil
  end

  def read_content_from_file(file_path)
    dirs = parse_path(file_path)
    current_dir = get_dir(dirs)

    current_dir.content
  end

  private

  def parse_path(path)
    path.split("/")[1..-1]
  end

  def get_dir(dirs)
    current_dir = @root
    dirs&.each do |dir|
      current_dir = current_dir[dir]
    end

    current_dir
  end
end

# `File` is an existing class name in Ruby
# `FileSystem::File` namespace prevents naming collisions
class FileSystem
  class File
    attr_accessor :file_name, :content

    def initialize(file_name, content)
      @file_name = file_name
      @content = content
    end
  end
end

fileSystem = FileSystem.new
p fileSystem.ls("/")
p fileSystem.mkdir("/a/b/c")
p fileSystem.add_content_to_file("/a/b/c/d", "hello")
p fileSystem.ls("/")
p fileSystem.read_content_from_file("/a/b/c/d")

# >> []
# >> nil
# >> nil
# >> ["a"]
# >> "hello"

# Simple ruby app with db
require "bundler/inline"
require "active_record"
require "sqlite3"

gemfile do
  source "https://rubygems.org"
  gem "json", require: false
  gem "activerecord", "~> 5.0", ">= 5.0.0.1"
  gem "sqlite3", "~> 1.4"
  gem "pry"
end

puts "Gems installed and loaded!"

# # Connect to an in-memory sqlite3 database
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:",
)

# # Define a minimal database schema
ActiveRecord::Schema.define do
  create_table :shows, force: true do |t|
    t.string :name
  end

  create_table :episodes, force: true do |t|
    t.string :name
    t.belongs_to :show, index: true
  end
end

# # Define the models
class Show < ActiveRecord::Base
  has_many :episodes, inverse_of: :show
end

class Episode < ActiveRecord::Base
  belongs_to :show, inverse_of: :episodes, required: true
end

# # Create a few records...
show = Show.create!(name: "Big Bang Theory")
pp "show"
pp show

first_episode = show.episodes.create!(name: "Pilot")
second_episode = show.episodes.create!(name: "The Big Bran Hypothesis")

episode_names = show.episodes.pluck(:name)

puts "#{show.name} has #{show.episodes.size} episodes named #{episode_names.join(", ")}."
# # =>

# Mutex
@lock = Mutex.new # For thread safety

def transfer_from_savings(x)
  @lock.synchronize do
    # @savings -= x
    # @withdraw += x
  end
end

# String to number
def to_int_or_nil(string)
  Integer(string || "")
rescue ArgumentError
  nil
end

def str_to_int(num_in_str)
  num_in_int = to_int_or_nil(num_in_str)
  exit_execution unless num_in_int
  num_in_int
end

p str_to_int(2)

# >> 2

# Array to string
def compact_to_string(array)
  result_string = ""
  size = array.size

  array.each_with_index do |result, idx|
    next unless result.is_a? String
    result_string += result

    result_string += ", " if idx != size - 1
  end

  result_string
end

p compact_to_string(["array", 2, "dfd"])



# Multithreading
def method_1
  a = 0
  while a <= 3
    puts "method_1: #{a}"
    sleep(1)
    a += 1
  end

  puts "Global variable: #{$str}"
end

def method_2
  b = 0

  while b <= 3
    puts "method_2: #{b}"
    sleep(0.5)
    b += 1
  end

  puts "Global variable: #{$str}"
end

x = Thread.new { method_1 }
y = Thread.new { method_2 }

x.join
y.join

# LRU
# Exception classes - storage full, not found
class LRUCache
  attr_accessor :elems

  def initialize(capacity)
    @capacity = capacity
    # Storage can be dependency
    @elems = {}
  end

  def get(key)
    val = @elems.delete key
    if val
      @elems[key] = val
    else
      -1
    end
  end

  def put(key, value)
    # Eviction policy can be injected
    @elems.delete key
    @elems[key] = value
    @elems.delete @elems.first.first if @elems.size > @capacity
  end
end

lRUCache = LRUCache.new(2)
pp lRUCache.put(1, 5)
pp lRUCache.put(2, 2)
pp lRUCache.put(3, 5)
pp lRUCache.put(4, 6)
pp lRUCache.get(3)
pp lRUCache.elems

# >> nil
# >> nil
# >> 5
# >> 2
# >> 5
# >> {4=>6, 3=>5}

# Doubly linked list
LLNode = Struct.new(:data, :next, :previous)

def initialize(*entries)
  @size = 0
  return if entries.empty?

  @first = LLNode.new(entries.shift, nil, nil)
  @last = @first
  @size = 1
  push(*entries) unless entries.empty?
end

def insert(index, data)
  old_node = @first
  index.times do |_i|
    old_node = old_node.next
  end
  new_node = LLNode.new(data, old_node, old_node.previous)
  old_node.previous.next = new_node
  old_node.previous = new_node
  self
end

def delete(index)
  old_node = @first
  index.times do |_i|
    old_node = old_node.next
  end
  old_node.previous.next = old_node.next
  old_node.next.previous = old_node.previous
end

# State machine
class TrafficLight
  def initialize
    @state = nil
  end

  def next_state(klass = Green)
    @state = klass.new(self)
    @state.beep
    @state.start_timer
  end
end

class State
  def initialize(state)
    @state = state
  end
end

class Green < State
  def beep
    puts "Green beep!"
  end

  def next_state
    @state.next_state(Red)
  end

  def start_timer
    sleep 1
    next_state
  end
end

class Red < State
  def beep
    puts "Red beep!"
  end

  def start_timer
    sleep 1
    next_state
  end

  def next_state
    @state.next_state(Yellow)
  end
end

class Yellow < State
  def beep
    puts "Yellow beep!"
  end

  def start_timer
    sleep 1
  end
end

tl = TrafficLight.new
tl.next_state

# >> Green beep!
# >> Red beep!
# >> Yellow beep!

# Pub Sub
module Publisher
  def subscribe(subscribers)
    @subscribers ||= []
    @subscribers += subscribers
  end

  def broadcast(event, *payload)
    @subscribers ||= [] # @subscribers is nil, we can't do each on it
    @subscribers.each do |subscriber|
      subscriber.public_send(event.to_sym, *payload) if subscriber.respond_to?(event)
    end
  end
end

class Event
  attr_reader :code, :title

  def initialize(code:, title:)
    @code = code
    @title = title
  end

  def to_s
    "#{@code} #{@title}"
  end
end

class AddSubscribers
  include Publisher

  attr_reader :events

  def initialize(subscribers:)
    @events = []
    subscribe(subscribers)
  end

  def send(event)
    @events << event
    broadcast(:event_added, event)
  end
end

class Subscriber1
  def event_added(event)
    print(event)
  end

  private

  def print(message)
    puts "[#{Time.now}] #{message}"
  end
end

class Subscriber2
  def event_added(_)
    send_event!
  end

  def send_event!
    print "\a Event sent"
  end
end

event1 = Event.new(code: "DRP", title: "Dr.Pepper")
event2 = Event.new(code: "CCL", title: "Coca-Cola")

subscribers = AddSubscribers.new(subscribers: [Subscriber1.new, Subscriber2.new])

subscribers.send(event1)
subscribers.send(event2)

# >> [2022-10-04 00:13:01 +0530] DRP Dr.Pepper
# >> \a Event sent[2022-10-04 00:13:01 +0530] CCL Coca-Cola
# >> \a Event sent

# Bridge design pattern
# The Abstraction defines the interface for the "control" part of the two class
# hierarchies. It maintains a reference to an object of the Implementation
# hierarchy and delegates all of the real work to this object.
class Abstraction
  # @param [Implementation] implementation
  def initialize(implementation)
    @implementation = implementation
  end

  # @return [String]
  def operation
    "Abstraction: Base operation with:\n" \
    "#{@implementation.operation_implementation}"
  end
end

# You can extend the Abstraction without changing the Implementation classes.
class ExtendedAbstraction < Abstraction
  # @return [String]
  def operation
    "ExtendedAbstraction: Extended operation with:\n" \
    "#{@implementation.operation_implementation}"
  end
end

# The Implementation defines the interface for all implementation classes. It
# doesn't have to match the Abstraction's interface. In fact, the two interfaces
# can be entirely different. Typically the Implementation interface provides
# only primitive operations, while the Abstraction defines higher-level
# operations based on those primitives.
class Implementation
  # @abstract
  #
  # @return [String]
  def operation_implementation
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# Each Concrete Implementation corresponds to a specific platform and implements
# the Implementation interface using that platform's API.
class ConcreteImplementationA < Implementation
  # @return [String]
  def operation_implementation
    'ConcreteImplementationA: Here\'s the result on the platform A.'
  end
end

class ConcreteImplementationB < Implementation
  # @return [String]
  def operation_implementation
    'ConcreteImplementationB: Here\'s the result on the platform B.'
  end
end

# Except for the initialization phase, where an Abstraction object gets linked
# with a specific Implementation object, the client code should only depend on
# the Abstraction class. This way the client code can support any abstraction-
# implementation combination.
def client_code(abstraction)
  # ...

  print abstraction.operation

  # ...
end

# The client code should be able to work with any pre-configured abstraction-
# implementation combination.

implementation = ConcreteImplementationA.new
abstraction = Abstraction.new(implementation)
client_code(abstraction)

puts "\n\n"

implementation = ConcreteImplementationB.new
abstraction = ExtendedAbstraction.new(implementation)
client_code(abstraction)

# Bytes to string
bytes = [
  104, 116, 116, 112, 115,
  58, 47, 47, 119, 119,
  119, 46, 106, 118, 116,
  46, 109, 101,
]

puts bytes.pack("C*").force_encoding("UTF-8")
puts bytes.map { |num| num.chr }.join

# >> https://www.jvt.me
# >> https://www.jvt.me

# HashTable
class HashTable
  class Slot
    attr_accessor :key, :value, :vacated

    def initialize(key, value)
      @key = key
      @value = value
      @vacated = false
    end

    def free
      self.value = nil
      self.vacated = true
    end
  end

  attr_accessor :size

  def initialize
    @slots = 5
    fill_table @slots
    @rebuilds = 0
    self.size = 0
    @h1 = ->(k) { k % @slots }
    @h2 = ->(k) { 1 + (k % (@slots - 1)) }
  end

  def upsert(key, value)
    if (slot = find_slot(key))
      slot.value = value
      return
    end

    0.upto(@slots - 1) do |index|
      index = double_hash key.hash, index
      slot = @table[index]
      if slot.nil? || slot.vacated
        @table[index] = Slot.new key, value
        self.size += 1
        return
      end
    end
    raise "Weak hash function"
  end

  def get(key)
    if (slot = find_slot(key))
      return slot.value if slot.key == key
    end

    0.upto(@slots - 1) do |index|
      index = double_hash key.hash, index
      slot = @table[index]
      if slot.nil? || slot.vacated
        return nil
      end
      if slot.key == key
        return slot.value
      end
    end
  end

  def delete(key)
    find_slot(key)&.free
  end

  def find_slot(key)
    0.upto(@slots - 1) do |i|
      index = double_hash key.hash, i
      slot = @table[index]
      return nil if slot.nil?
      return slot if slot.key == key
    end
    nil
  end

  private

  PRIMES = [13, 31, 61, 127, 251, 509]
  MAX_REBUILDS = 6

  def fill_table(slots)
    @table = []
    0.upto(slots - 1) do |i|
      @table << nil
    end
  end

  def rebuild
    if @rebuilds >= MAX_REBUILDS
      raise "Too many rebuilds"
    end

    old = @table
    @slots = PRIMES[@rebuilds]
    fill_table @slots
    self.size = 0
    old.each do |e|
      upsert e.key, e.value if e
    end
    @rebuilds += 1
  end

  def double_hash(hashcode, index)
    h1 = @h1.call hashcode
    h2 = @h2.call hashcode
    ((h1 + (h2 * index)) % @slots).abs()
  end
end

ht = HashTable.new
# ht.upsert("foo", "bar")
ht.upsert("fool", "baar")
# pp ht.get("foo")
# pp ht.get("fool")
# ht.delete("foo")
# ht.delete("fool")

pp ht.find_slot("fool")
pp ht.find_slot("fool")
pp ht.find_slot("fool")
pp ht.get("fool")

p Dir.pwd

# >> #<HashTable::Slot:0x00007fa813811790
# >>  @key="fool",
# >>  @vacated=false,
# >>  @value="baar">
# >> #<HashTable::Slot:0x00007fa813811790
# >>  @key="fool",
# >>  @vacated=false,
# >>  @value="baar">
# >> #<HashTable::Slot:0x00007fa813811790
# >>  @key="fool",
# >>  @vacated=false,
# >>  @value="baar">
# >> "baar"
# >> "/Users/hmehta/playground/low_level_design/data_structure/ruby_data_structure_dsdf_ale"
-
# Start of ./low_level_design/cache_service.rb
# * Design Cache Service
# Aprroach->
# 1-Requirement Clarification,
# 2-Stated Asumption early on.
# 3- Stated which Data Structure will using with pros and cons.
# 4- Made Sure Eviction Should be configurable.( Dependency injection)
# 5- Verbally stated the process of get and put, eviction.
# 6- Wrote Code.

# Multi-level cache
-
# Start of ./low_level_design/doubly_linked_list.rb
require 'pp'

class LinkedList
  LLNode = Struct.new(:data, :next, :previous)

  attr_accessor :first, :last, :size

  alias length size

  def initialize(*entries)
    @size = 0
    return if entries.empty?

    @first = LLNode.new(entries.shift, nil, nil)
    @last = @first
    @size = 1
    push(*entries) unless entries.empty?
  end

  def empty?
    @size == 0
  end

  def [] index
    current_node = @first
    index.times do
      current_node = current_node.next
    end
    current_node.data
  end

  def []= index, data
    if index > @size - 1
      ((index - @size) + 1).times do |_i|
        push nil
      end
      @last.data = data
    else
      current_node = @first
      index.times do |_i|
        current_node = current_node.next
      end
      current_node.data = data
    end
    self
  end

  def insert(index, data)
    old_node = @first
    index.times do |_i|
      old_node = old_node.next
    end
    new_node = LLNode.new(data, old_node, old_node.previous)
    old_node.previous.next = new_node
    old_node.previous = new_node
    self
  end

  def delete(index)
    old_node = @first
    index.times do |_i|
      old_node = old_node.next
    end
    old_node.previous.next = old_node.next
    old_node.next.previous = old_node.previous
  end

  def each
    current_node = @first
    @size.times do |_i|
      yield current_node.data
      current_node = current_node.next
    end
  end

  def push(*elements)
    elements.each do |element|
      node = LLNode.new(element, nil, @last)
      @first = node if @first.nil?
      @last.next = node unless @last.nil?
      @last = node
      @size += 1
    end
    self
  end

  alias << push

  def pop
    raise "pop should not be called as list is empty" if @size == 0

    last = @last
    @last = last.previous
    @size -= 1
  end

  # LLNode = Struct.new(:data, :next, :previous)
  def unshift(*elements)
    elements.each do |element|
      node = LLNode.new(element, @first, nil)
      if @first.nil?
        @first = node
        @last = node
      else
        @first.previous = node
        node.next = @first
        @first = node
      end
      @size += 1
    end
  end

  def shift
    raise "Shift should not be called as list is empty" if @size == 0

    node = @first
    @first = node.next
    @first.previous = nil
    @size -= 1
    node.data
  end

  def index(data)
    current_node = @first
    i = 0
    until current_node.nil?
      return i if data == current_node.data

      current_node = current_node.next
      i += 1
    end
    nil
  end

  def to_a
    current_node = @first
    array = []
    until current_node.nil?
      array << current_node.data
      current_node = current_node.next
    end
    array
  end

  def to_s
    to_a.to_s
  end
end

ll = LinkedList.new('one')
ll.first.data # => 'one'
ll[0] # => 'one'
ll << 'two' # => ["one", "two"]
ll.size # => 2
ll.length # => 2
ll.last.data # => 'two'
ll[ll.size - 1] # => 'two'

# linked lists can act as stacks
ll.push 'three' # => ["one", "two", "three"]
ll.size # => 3
ll.pop # => "three"
ll.size # => 2
puts ll # => ["one", "two"]

# or as queues
ll.push 'three' # => ["one", "two", "three"]
ll.shift # => 'one'
ll.size # => 2
# ll.first.data 'two'

# we can insert and delete
ll.insert(1, 'one point five') # => ["two", "one point five", "three"]
ll.delete(1)
ll.to_s # => ['two', 'three']-e 
# Start of ./low_level_degn/in_memory_file_system.rb
class FileSystem

  def initialize
    @root = {}
  end

  def ls(path)
    dirs = path.split("/")[1..-1]
    current_dir = get_dir(dirs)
    return [current_dir.file_name] if current_dir.is_a?(File)

    current_dir.keys.sort
  end

  def mkdir(path)
    dirs = parse_path(path)
    current_dir = @root

    dirs.each do |dir_name|
      current_dir[dir_name] = {} if current_dir[dir_name].nil?
      current_dir = current_dir[dir_name]
    end

    nil
  end

  def add_content_to_file(file_path, content)
    dirs = parse_path(file_path)
    file_name = dirs.pop
    current_dir = get_dir(dirs)

    if current_dir[file_name].nil?
      current_dir.merge!({ "#{file_name}" => File.new(file_name, content) })
    else
      current_dir[file_name].content += content
    end

    nil
  end

  def read_content_from_file(file_path)
    dirs = parse_path(file_path)
    current_dir = get_dir(dirs)

    current_dir.content
  end

  private

  def parse_path(path)
    path.split("/")[1..-1]
  end

  def get_dir(dirs)
    current_dir = @root
    dirs&.each do |dir|
      current_dir = current_dir[dir]
    end

    current_dir
  end
end

# `File` is an existing class name in Ruby
# `FileSystem::File` namespace prevents naming collisions
class FileSystem
  class File
    attr_accessor :file_name, :content

    def initialize(file_name, content)
      @file_name = file_name
      @content = content
    end
  end
end

fileSystem = FileSystem.new
p fileSystem.ls("/")
p fileSystem.mkdir("/a/b/c")
p fileSystem.add_content_to_file("/a/b/c/d", "hello")
p fileSystem.ls("/")
p fileSystem.read_content_from_file("/a/b/c/d")

# >> []
# >> nil
# >> nil
# >> ["a"]
# >> "hello"
-
# Start of ./low_level_design/notification_service/notification_service.rb
# https://medium.com/double-pointer/system-design-interview-notification-service-86cb5c266218

# Youtube channel - System design interview
# Video name - System design interview  - Notification service

# FR
# subscribe
# broadcast
# AddSubscribers

# NFR
# Scalable
# Available
# Performant



module Publisher
  def subscribe(subscribers)
  end

  def broadcast(event, *payload)
  end
end

class Event
  attr_reader :code, :title

  def initialize(code:, title:)
    @code = code
    @title = title
  end

  def to_s; end
end

class AddSubscribers
  include Publisher

  attr_reader :events

  def initialize(subscribers:)
    @events = []
    subscribe(subscribers)
  end

  def send(event)
    @events << event
    broadcast(:event_added, event)
  end
end

class Subscriber1
  def event_added(event)
    print(event)
  end

  private

  def print(message); end
end

class Subscriber2
  def event_added(_)
    send_event!
  end

  def send_event!; end
end

event1 = Event.new(code: "DRP", title: "Dr.Pepper")
event2 = Event.new(code: "CCL", title: "Coca-Cola")

subscribers = AddSubscribers.new(subscribers: [Subscriber1.new, Subscriber2.new])

subscribers.send(event1)
subscribers.send(event2)

# >> [2022-10-04 00:13:01 +0530] DRP Dr.Pepper
# >> \a Event sent[2022-10-04 00:13:01 +0530] CCL Coca-Cola
# >> \a Event sent
-
# Start of ./low_level_design/parking_lot.rb
# https://github.com/rogojagad/parking-lot-interview-problem

##  Car
# - reg_no
# - color

## ParkingLot class

# ParkingLot attributes
# - Slots - [nil, nil, nil] - Array.new(3)

# ParkingLot methods
# - available_slot, return first index where slots is nil
# - park(car:, slot_num:); slots[slot_num] = car
# - leave(slot_num); slots[slot_num] = nil
# - get_reg_numbers_by_color(color)
# - get_slot_num_by_reg_no(reg_no)
# - get_slot_num_by_color(color)

## ParkingSystem

# ParkingSystem attributes
# :parking_lot

# ParkingSystem methods
# Wrapper for parking lot with utilities and file mode and interactive mode

## Utilities
# - print_result(output)
# def receive_user_input
#   STDIN.gets.strip
# end
# str_to_int(num_in_str)
# compact_to_string(array)
# print_table(slots)
# exit_execution
# def exit_execution
#   utilities.print_result "Argument is not integer, check again"
#   exit 1
# end
-
# Start of ./low_level_design/ruby_command_line_input.rb
puts "Give your inputs"

while (a = gets.chomp) != "exit"
  puts a
end

# or use until as below
until (a = gets.chomp) =~ /(?:ex|qu)it/i
  puts a
end
 

# Start of ./low_level_design/parking-lot-interview-problem/functional_spec/spec/spec_helper.rb
require "bundler/setup"
require "pty"
require "timeout"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def run_command(pty, command)
  stdout, stdin, pid = pty
  stdin.puts command
  sleep(0.3)
  stdout.readline
end

def fetch_stdout(pty)
  stdout, stdin, pid = pty
  res = []
  while true
    begin
      Timeout::timeout 0.5 do
        res << stdout.readline
      end
    rescue EOFError, Errno::EIO, Timeout::Error
      break
    end
  end

  return res.join('').gsub(/\r/,'')
end
 

# Start of ./low_level_design/parking-lot-interview-problem/functional_spec/spec/parking_lot_spec.rb
require 'spec_helper'

RSpec.describe 'Parking Lot' do
  let(:pty) { PTY.spawn('parking_lot') }

  before(:each) do
    run_command(pty, "create_parking_lot 3\n")
  end

  it "can create a parking lot", :sample => true do
    expect(fetch_stdout(pty)).to end_with("Created a parking lot with 3 slots\n")
  end

  it "can park a car" do
    run_command(pty, "park KA-01-HH-3141 Black\n")
    expect(fetch_stdout(pty)).to end_with("Allocated slot number: 1\n")
  end
  
  it "can unpark a car" do
    run_command(pty, "park KA-01-HH-3141 Black\n")
    run_command(pty, "leave 1\n")
    expect(fetch_stdout(pty)).to end_with("Slot number 1 is free\n")
  end
  
  it "can report status" do
    run_command(pty, "park KA-01-HH-1234 White\n")
    run_command(pty, "park KA-01-HH-3141 Black\n")
    run_command(pty, "park KA-01-HH-9999 White\n")
    run_command(pty, "status\n")
    expect(fetch_stdout(pty)).to end_with(<<-EOTXT
Slot No.    Registration No    Colour
1           KA-01-HH-1234      White
2           KA-01-HH-3141      Black
3           KA-01-HH-9999      White
EOTXT
)
  end
  
  pending "add more specs as needed"
end

# Start of ./low_level_design/parking-lot-interview-problem/functional_spec/spec/end_to_end_spec.rb
require 'spec_helper'

RSpec.describe 'End To End Suite' do
  describe "full scenarios" do
    let(:commands) do
      [
          "create_parking_lot 6\n",
          "park KA-01-HH-1234 White\n",
          "park KA-01-HH-9999 White\n",
          "park KA-01-BB-0001 Black\n",
          "park KA-01-HH-7777 Red\n",
          "park KA-01-HH-2701 Blue\n",
          "park KA-01-HH-3141 Black\n",
          "leave 4\n",
          "status\n",
          "park KA-01-P-333 White\n",
          "park DL-12-AA-9999 White\n",
          "registration_numbers_for_cars_with_colour White\n",
          "slot_numbers_for_cars_with_colour White\n",
          "slot_number_for_registration_number KA-01-HH-3141\n",
          "slot_number_for_registration_number MH-04-AY-1111\n"
      ]
    end

    let(:expected) do
      [
          "Created a parking lot with 6 slots\n",
          "Allocated slot number: 1\n",
          "Allocated slot number: 2\n",
          "Allocated slot number: 3\n",
          "Allocated slot number: 4\n",
          "Allocated slot number: 5\n",
          "Allocated slot number: 6\n",
          "Slot number 4 is free\n",
          "Slot No.    Registration No    Colour\n1           KA-01-HH-1234      White\n2           KA-01-HH-9999      White\n3           KA-01-BB-0001      Black\n5           KA-01-HH-2701      Blue\n6           KA-01-HH-3141      Black\n",
          "Allocated slot number: 4\n",
          "Sorry, parking lot is full\n",
          "KA-01-HH-1234, KA-01-HH-9999, KA-01-P-333\n",
          "1, 2, 4\n",
          "6\n",
          "Not found\n"
      ]
    end

    it "input from file" do
      pty = PTY.spawn("parking_lot #{File.join(File.dirname(__FILE__), '..', 'fixtures', 'file_input.txt')}")
      print 'Testing file input: '
      expect(fetch_stdout(pty)).to eq(expected.join(''))
    end

    it "interactive input" do
      pty = PTY.spawn("parking_lot")
      print 'Testing interactive input: '
      commands.each_with_index do |cmd, index|
        print cmd
        run_command(pty, cmd)
        expect(fetch_stdout(pty)).to end_with(expected[index])
      end
    end
  end
end

# Start of ./low_level_design/parking-lot-interview-problem/spec/spec_helper.rb
# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require_relative '../lib/dependencies'
RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # The settings below are suggested to provide a good initial experience
  # with RSpec, but feel free to customize to your heart's content.
  #   # This allows you to limit a spec run to individual examples or groups
  #   # you care about by tagging them with `:focus` metadata. When nothing
  #   # is tagged with `:focus`, all examples get run. RSpec also provides
  #   # aliases for `it`, `describe`, and `context` that include `:focus`
  #   # metadata: `fit`, `fdescribe` and `fcontext`, respectively.
  #   config.filter_run_when_matching :focus
  #
  #   # Allows RSpec to persist some state between runs in order to support
  #   # the `--only-failures` and `--next-failure` CLI options. We recommend
  #   # you configure your source control system to ignore this file.
  #   config.example_status_persistence_file_path = "spec/examples.txt"
  #
  #   # Limits the available syntax to the non-monkey patched syntax that is
  #   # recommended. For more details, see:
  #   #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
  #   #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
  #   config.disable_monkey_patching!
  #
  #   # This setting enables warnings. It's recommended, but in some cases may
  #   # be too noisy due to issues in dependencies.
  #   config.warnings = true
  #
  #   # Many RSpec users commonly either run the entire suite or an individual
  #   # file, and it's useful to allow more verbose output when running an
  #   # individual spec file.
  #   if config.files_to_run.one?
  #     # Use the documentation formatter for detailed output,
  #     # unless a formatter has already been configured
  #     # (e.g. via a command-line flag).
  #     config.default_formatter = "doc"
  #   end
  #
  #   # Print the 10 slowest examples and example groups at the
  #   # end of the spec run, to help surface which specs are running
  #   # particularly slow.
  #   config.profile_examples = 10
  #
  #   # Run specs in random order to surface order dependencies. If you find an
  #   # order dependency and want to debug it, you can fix the order by providing
  #   # the seed, which is printed after each run.
  #   #     --seed 1234
  #   config.order = :random
  #
  #   # Seed global randomization in this process using the `--seed` CLI option.
  #   # Setting this allows you to use `--seed` to deterministically reproduce
  #   # test failures related to randomization by passing the same `--seed` value
  #   # as the one that triggered the failure.
  #   Kernel.srand config.seed
end

# Start of ./low_level_design/parking-lot-interview-problem/spec/parking_lot_spec.rb
# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ParkingLot do
  let(:slots_size) { Random.rand(3..10) }
  subject(:parking_lot) { ParkingLot.new slots_size }

  describe '#initialize and attr_accessor' do
    it 'receives size' do
      parking_lot = ParkingLot.new slots_size
      expect(parking_lot.slots.size).to eq(slots_size)
    end
  end

  describe '#available_slot' do
    context 'empty slot available' do
      it 'returns the index of the first found empty slot' do
        slots = ['a', nil, 'b', 'c']

        allow(parking_lot).to receive(:slots).and_return(slots)

        expect(parking_lot.available_slot).to eq(1)
      end
    end

    context 'empty slot unavailable' do
      it 'returns nil' do
        slot = %w[a a a a]

        allow(parking_lot).to receive(:slots).and_return(slot)

        expect(parking_lot.available_slot).to eq(nil)
      end
    end
  end

  describe '#park' do
    it 'park car object on empty slot' do
      slot_num = slots_size - 1
      car = double

      parking_lot.park(car: car, slot_num: slot_num)

      expect(parking_lot.slots[slot_num]).to eq(car)
    end
  end

  describe '#leave' do
    let(:slot_num) { slots_size - 1 }

    before do
      car = double
      parking_lot.slots[slot_num] = car
    end

    it 'nullified parking lot with corresponding index' do
      parking_lot.leave(slot_num)

      expect(parking_lot.slots[slot_num]).to be_nil
    end
  end

  describe '#get_reg_numbers_by_color' do
    let(:car1) { instance_double Car }
    let(:car2) { instance_double Car }
    let(:car3) { instance_double Car }
    before do
      allow(car1).to receive(:reg_no).and_return('qwe')
      allow(car2).to receive(:reg_no).and_return('asd')
      allow(car3).to receive(:reg_no).and_return('zxc')
      allow(car1).to receive(:color).and_return('white')
      allow(car2).to receive(:color).and_return('black')
      allow(car3).to receive(:color).and_return('white')
    end

    it 'returns array of registration number' do
      slots = [car1, car2, car3]
      expected_array = %w[qwe zxc]

      allow(parking_lot).to receive(:slots).and_return(slots)
      result = parking_lot.get_reg_numbers_by_color 'white'
      expect(result).to eq(expected_array)
    end
  end

  describe '#get_slot_num_by_reg_no' do
    let(:car1) { instance_double Car }
    let(:car2) { instance_double Car }
    let(:car3) { instance_double Car }
    let(:slots) { [car1, car2, car3] }

    before do
      allow(car1).to receive(:reg_no).and_return('qwe')
      allow(car2).to receive(:reg_no).and_return('asd')
      allow(car3).to receive(:reg_no).and_return('zxc')

      allow(car1).to receive(:color).and_return('white')
      allow(car2).to receive(:color).and_return('black')
      allow(car3).to receive(:color).and_return('white')

      allow(parking_lot).to receive(:slots).and_return(slots)
    end

    context 'car with reg_no exist' do
      it 'returns slot number for corresponding reg_no' do
        result = parking_lot.get_slot_num_by_reg_no 'asd'
        expect(result).to eq('2')
      end
    end

    context 'car with reg_no not exist' do
      it 'returns nil' do
        result = parking_lot.get_slot_num_by_reg_no 'lkj'
        expect(result).to be_nil
      end
    end
  end

  describe 'get_slot_num_by_color' do
    let(:car1) { instance_double Car }
    let(:car2) { instance_double Car }
    let(:car3) { instance_double Car }
    let(:slots) { [car1, car2, car3] }

    before do
      allow(car1).to receive(:reg_no).and_return('qwe')
      allow(car2).to receive(:reg_no).and_return('asd')
      allow(car3).to receive(:reg_no).and_return('zxc')

      allow(car1).to receive(:color).and_return('white')
      allow(car2).to receive(:color).and_return('black')
      allow(car3).to receive(:color).and_return('white')

      allow(parking_lot).to receive(:slots).and_return(slots)
    end

    context 'car with this color exists' do
      it 'returns array of slot number' do
        expected_array = %w[1 3]

        result = parking_lot.get_slot_num_by_color 'white'

        expect(result).to eq(expected_array)
      end
    end

    context 'car with this color does not exist' do
      it 'returns empty array' do
        result = parking_lot.get_slot_num_by_color 'purple'

        expect(result.size).to eq(0)
      end
    end
  end
end

# Start of ./low_level_design/parking-lot-interview-problem/spec/parking_system_spec.rb
# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ParkingSystem do
  let(:utilities) { instance_double Utilities }
  let(:command_to_func_hash) do
    { create_parking_lot: parking_system.method(:create_parking_lot),
      leave: parking_system.method(:leave_process),
      registration_numbers_for_cars_with_colour: parking_system.method(:registration_numbers_by_color),
      slot_numbers_for_cars_with_colour: parking_system.method(:slot_numbers_by_color),
      slot_number_for_registration_number: parking_system.method(:slot_num_by_registration_number) }
  end

  subject(:parking_system) { ParkingSystem.new utilities }

  describe '#initialize and attr_reader' do
    it 'has Utilities object as attribute' do
      expect(parking_system.utilities).to eq(utilities)
    end

    it 'has proper command_to_func_hash attribute' do
      expect(parking_system.command_to_func_hash).to eq(command_to_func_hash)
    end
  end

  describe '#run' do
    context 'system argument given' do
      it 'runs in file mode' do
        ARGV.replace ['filename']
        expect(parking_system).to receive(:set_input_path).with('filename')
        expect(parking_system).to receive(:file_mode)
        parking_system.run
      end
    end

    context 'system argument not given' do
      it 'runs in interactive mode' do
        ARGV.replace [nil]
        expect(parking_system).to receive(:interactive_mode)
        parking_system.run
      end
    end
  end

  describe '#parse_user_input' do
    let(:input) { double }

    context 'one statement command' do
      it 'prints report in table format' do
        parking_lot = instance_double ParkingLot
        slots = %w[aaa www]

        allow(input).to receive(:split).and_return(['command1'])
        allow(parking_system).to receive(:parking_lot).and_return(parking_lot)
        allow(parking_lot).to receive(:slots).and_return(slots)

        allow(parking_system).to receive(:utilities).and_return(utilities)
        expect(utilities).to receive(:print_table).with(slots)
      end
    end

    context 'two statement command' do
      it 'calls two_statement_command parser function' do
        allow(input).to receive(:split).and_return(%w[command1 command2])

        expect(parking_system).to receive(:two_statement_command)
          .with(%w[command1 command2])
      end
    end

    context 'three statement command' do
      it 'calls park_process parser function' do
        allow(input).to receive(:split)
          .and_return(%w[command1 command2 command3])

        expect(parking_system).to receive(:check_and_park)
          .with(%w[command1 command2 command3])
      end
    end

    after do
      parking_system.parse_user_input input
    end
  end

  describe '#create_parking_lot' do
    it 'create new parking lot with given size' do
      input = Random.rand(1..10)
      parking_lot = instance_double ParkingLot

      allow(parking_system).to receive(:utilities).and_return(utilities)

      expect(utilities).to receive(:str_to_int).with(input.to_s)
                                               .and_return(input)
      expect(ParkingLot).to receive(:new).with(input).and_return(parking_lot)
      expect(utilities).to receive(:print_result)
        .with('Created a parking lot with ' + input.to_s + ' slots')

      parking_system.create_parking_lot(input.to_s)
    end
  end

  describe '#leave_park_slot' do
    it 'empties the corresponding slot' do
      parking_lot = instance_double ParkingLot
      slot_num = Random.rand(1..10)

      allow(parking_system).to receive(:parking_lot)
        .and_return(parking_lot)
      expect(parking_lot).to receive(:leave).with(slot_num)

      parking_system.leave_park_slot(slot_num)
    end
  end

  describe '#leave_process' do
    it 'runs leaving parking slot process properly' do
      allow(parking_system).to receive(:utilities).and_return(utilities)
      expect(utilities).to receive(:str_to_int).with('5').and_return(5)
      expect(parking_system).to receive(:leave_park_slot).with(4)
      expect(utilities).to receive(:print_result)
        .with('Slot number 5 is free')

      parking_system.leave_process '5'
    end
  end

  describe '#registration_numbers_by_color' do
    it 'retrieve reg_number of cars with corresponding color' do
      array = [
        'b 1234 a',
        'c 2345 b',
        'd 3456 d'
      ]
      expected_string = 'b 1234 a, c 2345 b, d 3456 d'

      parking_lot = double
      color = 'white'

      allow(parking_system).to receive(:parking_lot)
        .and_return(parking_lot)
      expect(parking_lot).to receive(:get_reg_numbers_by_color)
        .with(color)
        .and_return(array)

      allow(parking_system).to receive(:utilities).and_return(utilities)
      expect(utilities).to receive(:compact_to_string)
        .with(array)
        .and_return(expected_string)

      expect(utilities).to receive(:print_result)
        .with(expected_string)

      parking_system.registration_numbers_by_color color
    end
  end

  describe '#slot_numbers_by_color' do
    it 'retrieve slot number of cars with corresponding color' do
      array = [1, 3, 4]
      parking_lot = double
      color = 'white'
      expected_string = '1, 3, 4'

      allow(parking_system).to receive(:parking_lot)
        .and_return(parking_lot)
      allow(parking_system).to receive(:utilities).and_return(utilities)

      expect(parking_lot).to receive(:get_slot_num_by_color)
        .with(color)
        .and_return(array)

      expect(utilities).to receive(:compact_to_string)
        .with(array)
        .and_return(expected_string)

      expect(utilities).to receive(:print_result).with(expected_string)

      parking_system.slot_numbers_by_color color
    end
  end

  describe '#slot_num_by_registration_number' do
    let(:parking_lot) { double }
    let(:reg_no) { 'qwe 123 asd' }

    context 'registration number exist' do
      it 'returns slot number in string' do
        slot_num = Random.rand(1..10).to_s

        allow(parking_system).to receive(:parking_lot)
          .and_return(parking_lot)
        allow(parking_system).to receive(:utilities)
          .and_return(utilities)

        expect(parking_lot).to receive(:get_slot_num_by_reg_no)
          .with(reg_no)
          .and_return(slot_num)

        expect(utilities).to receive(:print_result)
          .with(slot_num.to_s)

        parking_system.slot_num_by_registration_number(reg_no)
      end
    end

    context 'registration number not exist' do
      it 'returns not found string' do
        allow(parking_system).to receive(:parking_lot)
          .and_return(parking_lot)
        expect(parking_lot).to receive(:get_slot_num_by_reg_no)
          .with(reg_no)
          .and_return(nil)

        result = parking_system.slot_num_by_registration_number(reg_no)

        expect(result).to eq('Not found')
      end
    end
  end

  describe '#park_on_slot' do
    it 'parks new car in an empty slot' do
      car = double
      parking_lot = double
      reg_no = 'b 6213 z'
      color = 'black'
      slot_num = Random.rand(1...5)
      expect(Car).to receive(:new).with(reg_no: reg_no, color: color)
                                  .and_return(car)

      allow(parking_system).to receive(:parking_lot)
        .and_return(parking_lot)
      expect(parking_lot).to receive(:park).with(car: car,
                                                 slot_num: slot_num)

      parking_system.park_on_slot(reg_no: reg_no,
                                  color: color,
                                  slot_num: slot_num)
    end
  end

  describe '#check_and_park' do
    let(:reg_no) { 'qwe' }
    let(:color) { 'blue' }
    let(:slot_num) { slot_num = Random.rand(1..10) }
    let(:parking_lot) { instance_double ParkingLot }

    before do
      allow(parking_system).to receive(:parking_lot).and_return(parking_lot)
    end

    context 'slot available' do
      it 'calls park process' do
        allow(parking_lot).to receive(:available_slot).and_return(slot_num)

        expect(parking_system).to receive(:park_process).with(reg_no: reg_no,
                                                              color: color,
                                                              slot_num: slot_num)
      end
    end

    context 'slot unavailable' do
      it 'calls print_result with prints not found message' do
        allow(parking_lot).to receive(:available_slot).and_return(nil)
        allow(parking_system).to receive(:utilities).and_return(utilities)

        expect(utilities).to receive(:print_result)
          .with('Sorry, parking lot is full')
      end
    end

    after do
      parking_system.check_and_park(['park', reg_no, color])
    end
  end

  describe '#file_mode' do
    it 'opens file and run program from file input' do
      file = StringIO.new "test1\ntest2\ntest3"
      path = 'dummy/path'

      allow(parking_system).to receive(:input_path).and_return(path)
      expect(File).to receive(:open).with(path, 'r')
                                    .and_return(file)
      expect(parking_system).to receive(:parse_user_input)
        .exactly(3).times

      parking_system.file_mode
    end
  end

  describe '#two_statement_command' do
    let(:size) { Random.rand(3..10) }

    it 'calls proper function based on given command' do
      input = ['create_parking_lot', size]

      allow(parking_system).to receive(:command_to_func_hash)
        .and_return(command_to_func_hash)

      expect(command_to_func_hash[input[0].to_sym])
        .to receive(:call).with(input[1])

      parking_system.two_statement_command(input)
    end
  end

  describe '#park_process' do
    it 'parks a car and print allocated slot number' do
      reg_no = 'asd'
      color = 'maroon'
      slot_num = Random.rand(1..10)

      expect(parking_system).to receive(:park_on_slot).with(
        reg_no: reg_no,
        color: color,
        slot_num: slot_num
      )

      allow(parking_system).to receive(:utilities).and_return(utilities)

      expect(utilities).to receive(:print_result)
        .with('Allocated slot number: ' + (slot_num + 1).to_s)

      parking_system.park_process(reg_no: reg_no,
                                  color: color,
                                  slot_num: slot_num)
    end
  end
end

# Start of ./low_level_design/parking-lot-interview-problem/spec/utilities_spec.rb
# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Utilities do
  subject(:utilities) { Utilities.new }

  describe '#print_result' do
    it 'prints given result to STDOUT' do
      output_str = 'output string'

      expect(STDOUT).to receive(:puts).with(output_str)

      utilities.print_result output_str
    end
  end

  describe '#receive_user_input' do
    it 'receive and return user input' do
      input_str = 'input string'

      allow(STDIN).to receive(:gets) { input_str }

      expect(utilities.receive_user_input).to eq(input_str)
    end
  end

  describe '#to_int_or_nil' do
    context 'string convertable to int number' do
      it 'return int number' do
        expect(utilities.to_int_or_nil('123')).to eq(123)
      end
    end

    context 'string unconvertable to int number' do
      it 'return nil' do
        expect(utilities.to_int_or_nil('one')).to eq(nil)
      end
    end
  end

  describe 'str_to_int' do
    context 'given string is convertable to int' do
      it 'returns int number' do
        expect(utilities).to receive(:to_int_or_nil).with('2').and_return(2)
        expect(utilities.str_to_int('2')).to eq(2)
      end
    end

    context 'given string is not convertable' do
      it 'exit_execution' do
        expect(utilities).to receive(:to_int_or_nil).with('two').and_return(nil)
        expect(utilities).to receive(:exit_execution)
        utilities.str_to_int('two')
      end
    end
  end

  describe '#compact_to_string' do
    it 'converts given array to proper string format' do
      array = %w[
        qwe
        asd
        zxc
        dfgert
      ]

      expected_string = 'qwe, asd, zxc, dfgert'

      result = utilities.compact_to_string(array)

      expect(result).to eq(expected_string)
    end
  end

  describe '#print_table' do
    let(:car1) { instance_double Car }
    let(:car2) { instance_double Car }

    let(:slots) { [car1, car2] }

    before do
      allow(car1).to receive(:reg_no).and_return('qwe')
      allow(car2).to receive(:reg_no).and_return('asd')

      allow(car1).to receive(:color).and_return('white')
      allow(car2).to receive(:color).and_return('black')
    end

    it 'prints array of Car object in proper string format' do
      table_format = "Slot No.    Registration No    Colour\n"

      slots.each_with_index do |slot, idx|
        next unless slot

        table_format += (idx + 1).to_s + '           ' + slot.reg_no + '      ' + slot.color
        table_format += "\n"
      end

      expect(utilities).to receive(:print_result).with(table_format)

      utilities.print_table(slots)
    end
  end
end

# print table

# Start of ./low_level_design/parking-lot-interview-problem/spec/car_spec.rb
# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Car do
  let(:reg_no) { 'ASD 123 HH' }
  let(:color) { 'White' }
  subject(:car) { Car.new(reg_no: reg_no, color: color) }

  it 'has proper attribute value' do
    expect(car.reg_no).to eq(reg_no)
    expect(car.color).to eq(color)
  end
end

# Start of ./low_level_design/parking-lot-interview-problem/lib/dependencies.rb
# frozen_string_literal: true

require_relative 'parking_system'
require_relative 'parking_lot'
require_relative 'car'
require_relative 'utilities'

# Start of ./low_level_design/parking-lot-interview-problem/lib/utilities.rb
# frozen_string_literal: true

class Utilities
  def print_result(output)
    puts output
  end

  def receive_user_input
    STDIN.gets.strip
  end

  def to_int_or_nil(string)
    Integer(string || '')
  rescue ArgumentError
    nil
  end

  def str_to_int(num_in_str)
    num_in_int = to_int_or_nil(num_in_str)
    exit_execution unless num_in_int
    num_in_int
  end

  def compact_to_string(array)
    result_string = ''
    size = array.size

    array.each_with_index do |result, idx|
      result_string += result

      result_string += ', ' if idx != size - 1
    end

    result_string
  end

  def print_table(slots)
    table_format = "Slot No.    Registration No    Colour\n"

    slots.each_with_index do |slot, idx|
      next unless slot

      table_format += (idx + 1).to_s + '           ' + slot.reg_no + '      ' + slot.color
      table_format += "\n"
    end

    print_result table_format
  end

  private

  def exit_execution
    utilities.print_result 'Argument is not integer, check again'
    exit 1
  end
end

# Start of ./low_level_design/parking-lot-interview-problem/lib/main.rb
# frozen_string_literal: true

require_relative 'dependencies'

ParkingSystem.new(Utilities.new).run

# Start of ./low_level_design/parking-lot-interview-problem/lib/car.rb
class Car
  attr_reader :reg_no, :color

  def initialize(reg_no:, color:)
    @reg_no = reg_no
    @color = color
  end
end

# Start of ./low_level_design/parking-lot-interview-problem/lib/parking_lot.rb
# frozen_string_literal: true

class ParkingLot
  attr_reader :slots
  def initialize(size)
    @slots = Array.new(size)
  end

  def available_slot
    slots.each_with_index do |slot, idx|
      return idx if slot.nil?
    end

    nil
  end

  def park(car:, slot_num:)
    slots[slot_num] = car
  end

  def leave(slot_num)
    slots[slot_num] = nil
  end

  def get_reg_numbers_by_color(color)
    result = []
    slots.each do |slot|
      next unless slot

      result << slot.reg_no if slot.color == color
    end

    result
  end

  def get_slot_num_by_reg_no(reg_no)
    slots.each_with_index do |slot, idx|
      next unless slot

      return (idx + 1).to_s if slot.reg_no == reg_no
    end

    nil
  end

  def get_slot_num_by_color(color)
    result = []
    slots.each_with_index do |slot, idx|
      next unless slot

      result << (idx + 1).to_s if slot.color == color
    end

    result
  end
end

# Start of ./low_level_design/parking-lot-interview-problem/lib/parking_system.rb
# frozen_string_literal: true

class ParkingSystem
  attr_reader :input_path, :parking_lot, :utilities, :command_to_func_hash

  def initialize(utilities)
    @utilities = utilities

    @command_to_func_hash = {
      create_parking_lot: method(:create_parking_lot),
      leave: method(:leave_process),
      registration_numbers_for_cars_with_colour: method(:registration_numbers_by_color),
      slot_numbers_for_cars_with_colour: method(:slot_numbers_by_color),
      slot_number_for_registration_number: method(:slot_num_by_registration_number)
    }
  end

  def leave_park_slot(slot_num)
    parking_lot.leave slot_num
  end

  def create_parking_lot(size_in_str)
    size_in_int = utilities.str_to_int size_in_str
    @parking_lot = ParkingLot.new(size_in_int)

    utilities
      .print_result('Created a parking lot with ' + size_in_str + ' slots')
  end

  def registration_numbers_by_color(color)
    results = parking_lot.get_reg_numbers_by_color(color)
    results_in_str = utilities.compact_to_string(results)

    utilities.print_result results_in_str
  end

  def slot_numbers_by_color(color)
    results = parking_lot.get_slot_num_by_color(color)
    utilities.print_result utilities.compact_to_string(results)
  end

  def slot_num_by_registration_number(reg_no)
    slot_num = parking_lot.get_slot_num_by_reg_no(reg_no)
    return 'Not found' unless slot_num

    utilities.print_result slot_num.to_s
  end

  def park_on_slot(reg_no:, color:, slot_num:)
    car = Car.new(reg_no: reg_no, color: color)
    parking_lot.park(car: car, slot_num: slot_num)
  end

  def park_process(reg_no:, color:, slot_num:)
    park_on_slot(reg_no: reg_no, color: color, slot_num: slot_num)
    utilities.print_result 'Allocated slot number: ' + (slot_num + 1).to_s
  end

  def leave_process(num_in_str)
    num_in_int = utilities.str_to_int(num_in_str)
    leave_park_slot(num_in_int - 1)
    utilities.print_result 'Slot number ' + num_in_str + ' is free'
  end

  def two_statement_command(splitted_input)
    command_to_func_hash[splitted_input[0].to_sym].call splitted_input[1]
  end

  def check_and_park(splitted_input)
    slot_num = parking_lot.available_slot

    if slot_num
      park_process(reg_no: splitted_input[1],
                   color: splitted_input[2],
                   slot_num: slot_num)
    else
      utilities.print_result 'Sorry, parking lot is full'
    end
  end

  def parse_user_input(input)
    splitted_input = input.split
    if splitted_input.size == 1
      utilities.print_table parking_lot.slots
    elsif splitted_input.size == 2
      two_statement_command splitted_input
    elsif splitted_input.size == 3
      check_and_park splitted_input
    end
  end

  def interactive_mode
    loop do
      parse_user_input utilities.receive_user_input
    end
  end

  def file_mode
    input_file = File.open(input_path, 'r')

    input_file.each_line do |line|
      parse_user_input line
    end
  end

  def run
    input_filename = ARGV[0]

    if input_filename
      set_input_path input_filename
      file_mode
    else
      interactive_mode
    end
  end

  private

  def set_input_path(filename)
    @input_path = filename
    # puts @input_path
  end
end

# Start of ./low_level_design/prefix_trie.rb
class Trie
  attr_accessor :root

  def initialize
    @root = {}
    @end = "#"
  end

  def insert(word)
    node = @root
    0.upto(word.length - 1) do |i|
      char = word[i]
      if not node[char]
        node[char] = {}
      end
      node = node[char]
    end
    node[@end] = true
  end

  def search(word)
    node = @root
    0.upto(word.length - 1) do |i|
      char = word[i]
      return false if not node[char]
      node = node[char]
    end
    node[@end] == true
  end

  def prefix(word)
    node = @root
    0.upto(word.length - 1) do |i|
      char = word[i]
      return false if not node[char]
      node = node[char]
    end
    true
  end
end

obj = Trie.new()
obj.insert("word")
p obj.search("word")
p obj.prefix("wo")
p obj.prefix("eo")
p obj.root

# >> true
# >> true
# >> false
# >> {"w"=>{"o"=>{"r"=>{"d"=>{"#"=>true}}}}}

# Start of ./low_level_design/state_machine.rb
class TrafficLight
  def initialize
    @state = nil
  end

  def next_state(klass = Green)
    @state = klass.new(self)
    @state.beep
    @state.start_timer
  end
end

class State
  def initialize(state)
    @state = state
  end
end

class Green < State
  def beep
    puts "Green beep!"
  end

  def next_state
    @state.next_state(Red)
  end

  def start_timer
    sleep 1
    next_state
  end
end

class Red < State
  def beep
    puts "Red beep!"
  end

  def start_timer
    sleep 1
    next_state
  end

  def next_state
    @state.next_state(Yellow)
  end
end

class Yellow < State
  def beep
    puts "Yellow beep!"
  end

  def start_timer
    sleep 1
  end
end

tl = TrafficLight.new
tl.next_state

# >> Green beep!
# >> Red beep!
# >> Yellow beep!

# Start of ./low_level_design/unique_id_generator.rb
# frozen_string_literal: true

# Name	Binary Size	String Size	Features
# UUID	16 bytes	36 chars	configuration free, not sortable
# shortuuid	16 bytes	22 chars	configuration free, not sortable
# Snowflake	8 bytes	up to 20 chars	needs machin/DC configuration, needs central server, sortable
# MongoID	12 bytes	24 chars	configuration free, sortable
# xid	12 bytes	20 chars	configuration free, sortable

# Xid implementatin in Ruby
require 'socket'
require 'securerandom'
require 'date'

class Xid
  RAW_LEN = 12

  @@generator = nil

  def initialize(id = nil)
    @@generator ||= Generator.new(init_rand_int, real_machine_id)
    @value = id || @@generator.generate.unpack('C12')
  end

  def next
    @string = nil
    @value = @@generator.generate.unpack('C12')
    string
  end

  attr_reader :value

  def pid
    # type: () -> int
    (value[7] << 8 | value[8])
  end

  def counter
    # type: () -> int
    value[9] << 16 | value[10] << 8 | value[11]
  end

  def machine
    # type: () -> str
    value[4..6].map(&:chr).join('')
  end

  def datetime
    Time.at(time).to_datetime
  end

  def time
    # type: () -> int
    value[0] << 24 | value[1] << 16 | value[2] << 8 | value[3]
  end

  def inspect
    "Xid('#{string}')"
  end

  def to_s
    string
  end

  def bytes
    # type: () -> str
    @value.pack('c12')
  end

  def ==(other)
    # type: (Xid) -> bool
    to_s == other.to_s
  end

  def <(other)
    # type: (Xid) -> bool
    to_s < other.to_s
  end

  def >(other)
    # type: (Xid) -> bool
    to_s > other.to_s
  end

  def self.from_string(str)
    raise 'Invalid Xid' if str.nil? || !str.match(/^[a-v0-9]{20}$/i)

    val = Base32.b32decode(str)
    value_check = val.select { |x| x >= 0 && x <= 255 }

    (value_check.length..RAW_LEN - 1).each do |i|
      value_check[i] = false
    end

    raise 'Invalid Xid' unless value_check.all?

    Object.const_get(name).new(val)
  end

  private

  def string
    # type: () -> str
    @string ||= Base32.b32encode(value)
  end

  def init_rand_int
    # type: () -> int
    SecureRandom.random_number(16_777_215)
  end

  def real_machine_id
    # type: () -> int
    Digest::MD5.digest(Socket.gethostname).unpack1('N')
  rescue StandardError
    init_rand_int
  end

  # Xid Generator
  class Generator
    attr_accessor :value

    def initialize(rand_val = nil, machine_id = 0)
      @mutex = Mutex.new
      @rand_int = rand_val || rand(65_535)
      @pid = Process.pid
      @machine_id = machine_id
    end

    def generate
      # () -> str
      @mutex.synchronize do
        @rand_int += 1
      end
      [::Time.new.to_i, @machine_id, @pid, @rand_int << 8].pack('N NX n NX')
    end
  end
end

class Xid::Base32
  # 0123456789abcdefghijklmnopqrstuv - Used for encoding
  ENCODE_HEX = %w[0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j
                  k l m n o p q r s t u v].freeze
  TRIM_LEN = 20

  # Start class methods
  class << self
    def decode_hex_map
      Hash[ENCODE_HEX.each_with_index.map { |x, i| [x, i] }]
    end

    def b32encode(src)
      encode(src)
    end

    def b32decode(src)
      decode(src, ENCODE_HEX)
    end

    def encode(id)
      dst = []
      dst[19] = ENCODE_HEX[(id[11] << 4) & 0x1f]
      dst[18] = ENCODE_HEX[(id[11] >> 1) & 0x1f]
      dst[17] = ENCODE_HEX[(id[11] >> 6) & 0x1f | (id[10] << 2) & 0x1f]
      dst[16] = ENCODE_HEX[id[10] >> 3]
      dst[15] = ENCODE_HEX[id[9] & 0x1f]
      dst[14] = ENCODE_HEX[(id[9] >> 5) | (id[8] << 3) & 0x1f]
      dst[13] = ENCODE_HEX[(id[8] >> 2) & 0x1f]
      dst[12] = ENCODE_HEX[id[8] >> 7 | (id[7] << 1) & 0x1f]
      dst[11] = ENCODE_HEX[(id[7] >> 4) & 0x1f | (id[6] << 4) & 0x1f]
      dst[10] = ENCODE_HEX[(id[6] >> 1) & 0x1f]
      dst[9] = ENCODE_HEX[(id[6] >> 6) & 0x1f | (id[5] << 2) & 0x1f]
      dst[8] = ENCODE_HEX[id[5] >> 3]
      dst[7] = ENCODE_HEX[id[4] & 0x1f]
      dst[6] = ENCODE_HEX[id[4] >> 5 | (id[3] << 3) & 0x1f]
      dst[5] = ENCODE_HEX[(id[3] >> 2) & 0x1f]
      dst[4] = ENCODE_HEX[id[3] >> 7 | (id[2] << 1) & 0x1f]
      dst[3] = ENCODE_HEX[(id[2] >> 4) & 0x1f | (id[1] << 4) & 0x1f]
      dst[2] = ENCODE_HEX[(id[1] >> 1) & 0x1f]
      dst[1] = ENCODE_HEX[(id[1] >> 6) & 0x1f | (id[0] << 2) & 0x1f]
      dst[0] = ENCODE_HEX[id[0] >> 3]

      dst.join('')
    end

    def decode(src, _str_map)
      src.downcase!

      end_loop = false
      result = []
      while src && !src.empty? && !end_loop
        dst = [0] * 5
        dbuf = [0] * 8
        src_len = 8

        9.times do |i|
          if i >= src.length
            src_len = i
            end_loop = true
            break
          end
          char = src[i]
          dbuf[i] = decode_hex_map[char]
        end

        dst[4] = (dbuf[6] << 5) | (dbuf[7]) if src_len >= 8
        dst[3] = (dbuf[4] << 7) | (dbuf[5] << 2) | (dbuf[6] >> 3) if src_len >= 7
        dst[2] = (dbuf[3] << 4) | (dbuf[4] >> 1) if src_len >= 5
        dst[1] = (dbuf[1] << 6) | (dbuf[2] << 1) | (dbuf[3] >> 4) if src_len >= 4
        dst[0] = (dbuf[0] << 3) | (dbuf[1] >> 2) if src_len >= 2

        dst = dst.map { |x| x & 0xff }

        if src_len == 2
          dst = dst[0]
        elsif src_len == 4
          dst = dst[0..1]
        elsif src_len == 5
          dst = dst[0..2]
        elsif src_len == 7
          dst = dst[0..3]
        elsif src_len == 8
          dst = dst[0..4]
        end

        result += dst
        src = src[8..src.length]
      end

      result
    end
  end
  # END - Class methods
end

guid = Xid.new
pp guid.to_s
pp guid.next

# Alternative encoding lib

require "base32"

encoded = Base32.encode("chunky bacon!")  #==> "MNUHK3TLPEQGEYLDN5XCC==="
decoded = Base32.decode(encoded)          #==> "chunky bacon!"

puts %("#{decoded}" is "#{encoded}" in base32)

# >> "cctqj9g0edis5fb429tg"
# >> "cctqj9g0edis5fb429u0"
# >> "chunky bacon!" is "MNUHK3TLPEQGEYLDN5XCC===" in base32

# Start of ./low_level_design/template_project/spec/spec_helper.rb
# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# See https://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.
=begin
  # This allows you to limit a spec run to individual examples or groups
  # you care about by tagging them with `:focus` metadata. When nothing
  # is tagged with `:focus`, all examples get run. RSpec also provides
  # aliases for `it`, `describe`, and `context` that include `:focus`
  # metadata: `fit`, `fdescribe` and `fcontext`, respectively.
  config.filter_run_when_matching :focus

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  # https://relishapp.com/rspec/rspec-core/docs/configuration/zero-monkey-patching-mode
  config.disable_monkey_patching!

  # This setting enables warnings. It's recommended, but in some cases may
  # be too noisy due to issues in dependencies.
  config.warnings = true

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = "doc"
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
=end
end

# Start of ./low_level_design/template_project/lib/main.rb
puts "Running"
require_relative "system"

System.new.run

# Start of ./low_level_design/template_project/lib/system.rb
class System
  attr_reader :input_path

  def run
    input_filename = ARGV[0]

    if input_filename
      set_input_path input_filename
      file_mode
    else
      interactive_mode
    end
  end

  def set_input_path(filename)
    @input_path = filename
    # puts @input_path
  end

  def interactive_mode
    loop do
      p STDIN.gets.strip
    end
  end

  def file_mode
    input_file = File.open(input_path, "r")

    input_file.each_line do |line|
      p line
    end
  end
end

# Start of ./low_level_design/design_in_memory_sql_database.rb
# https://kishannigam.medium.com/designing-an-in-memory-rdms-database-91027751f95a
# * Design an in-memory sql database. Functionalities required were -

# - It should be possible to create or delete tables in a database.
# - A table definition comprises columns which have types. They can also have constraints
# - The supported column types are string and int.
# - The string type can have a maximum length of 20 characters.
# - The int type can have a minimum value of -1024 and a maximum value of 1024.
# - Support for mandatory fields (tagging a column as required)
# - It should be possible to insert records in a table.
# - It should be possible to print all records in a table.

# Follow-ups -

# - How can we add filter records whose column values match a given value?
# - What design pattern would be used?

# Database, Table , Row , Column
# Column
# - String columnName;
# - enum Type {INT,STRING};
# - Type columnType;

# Database
# - String databaseName
# - tableMap = new HashMap ();

# Row
# - Integer rowId;
# - Map<Column, Object> columnData;

# Table
# - Integer autoIncrementId;
# - String name;
# - Map<String,Column> columnMap = new HashMap ();
# - List<Row> rows = new ArrayList ();

# ```ruby
class Column
  COLUMN_TYPE = { "int" => 0, "string" => 1 }
  attr_accessor :columnType, :columnName

  def column(columnType, columnName)
    return "Invalid columnType" unless COLUMN_TYPE.has_key? columnType
    return "Invalid columnName" unless columnName.is_a? String
    @columnName = string_columnName
    @columnType = type_columnType
  end

  def getColumnName
    return columnName
  end
end

class Row
  attr_accessor :rowId, :columnData

  def initialize(rowId, columnData)
    return "Invalid rowId" unless rowId.is_a? Integer
    return "Invalid columnData" unless rowId.is_a? Hash
    @rowId = rowId
    @columnData = columnData
  end

  def getRowId
    @rowId
  end

  def getColumnData
    @columnData
  end
end

class Table
  attr_accessor :autoIncrementId, :name, :columnMap, :rows

  def initialize(tableName, columns)
    @autoIncrementId = 1
    @name = tableName
    populateColumnMap(columns)
  end

  def truncateRows
    @rows.clear
  end

  def insertRow(column, columnValues)
    checkIfColumnExists
    rowId = getAutoIncrementId
    columnData = Hash.new(columnValues)
    row = Row.new(rowId, columnData)
    rows << row
  end

  def printRows
    pp rows
  end

  def getRecordsByColumnValue(column, value)
    rows = []
    # for(Row row:this.rows) {
    #     Object columnValue = row.getColumnData().get(column);
    #     if(columnValue.equals(value)) {
    #         rows.add(row);
    #     }
    # }
    # System.out.println("Printing matching rows for Table: "+this.name);
    # printRecords(rows);
  end

  def printRecords(rows)
    #     System.out.print("\t");
    #     for(Map.Entry<String,Column> entry : this.columnMap.entrySet()) {
    #         System.out.print("\t"+entry.getKey()+"\t");
    #     }
    #     for(Row row: rows) {
    #         System.out.print("\n\t"+row.getRowId()+".");
    #         for(Map.Entry<Column, Object> entry : row.getColumnData().entrySet()) {
    #             System.out.print("\t"+entry.getValue()+"\t");
    #         }
    #     }
    #     System.out.print("\n");
    # }

  end

  def populateColumnMap(columns)
    # for(Column column: columns) {
    #     columnMap.put(column.getColumnName(),column);
    # }
  end

  def getAutoIncrementId()
    @autoIncrementId += 1
    @autoIncrementId
  end

  def checkIfColumnExists(columnName)
    # if(!columnMap.containsKey(columnName)) {
    #     System.out.println("TableName: "+this.name+" does not contains column: "+columnName);
    #     return false;
    # }
    # return true;
  end
end

class Database
  attr_accessor :databaseName, :tableMap

  def initialize(databaseName)
    @databaseName = databaseName
  end

  def createTable(tableName, columns)
    # if(checkIfTableExists(tableName)) System.out.println("TableName: "+ tableName+" already exists!");
    # Table table = new Table(tableName, columns);
    # tableMap.put(tableName, table);
    # return;
  end

  def dropTable(tableName)
    # if(!checkIfTableExists(tableName)) return;
    # tableMap.remove(tableName);
    # System.out.println("TableName: "+tableName+" dropped!");
    # return;
  end

  def truncate(tableName)
    # if(!checkIfTableExists(tableName)) return;
    # Table table = tableMap.get(tableName);
    # table.truncateRows();
  end

  def insertTableRows(tableName, columnValues)
    # if(!checkIfTableExists(tableName)) return;
    # Table table = tableMap.get(tableName);
    # table.insertRow(columnValues);
  end

  def printTableAllRows(tableName)
    # if(!checkIfTableExists(tableName)) return;
    # Table table = tableMap.get(tableName);
    # table.printRows();
  end

  def filterTableRecordsByColumnValue(tableName, column, value)
    # if(!checkIfTableExists(tableName)) return;
    # Table table = tableMap.get(tableName);
    # table.getRecordsByColumnValue(column, value);
  end

  def checkIfTableExists(tableName)
    # if(!tableMap.containsKey(tableName)) {
    #     System.out.println("TableName: "+tableName+" does not exists");
    #     return false;
    # }
    # return true;
  end
end

class DatabaseManager
  attr_accessor :databaseHashMap

  def initialize
    @databaseHashMap = {}
  end

  def createDatabase(databaseName)
  end

  def deleteDatabase(databaseName)
  end

  def getDatabaseHashMap
  end

  def setDatabaseHashMap(databaseHashMap)
    @databaseHashMap = databaseHashMap
  end
end

name = Column.new("name", "string")
age = Column.new("age", "int")
salary = Column.new("salary", "int")
db = Database.new("MyDB")
columns = []
columns.add(name)
columns.add(age)
columns.add(salary)
tableName = "Employee"
db.createTable(tableName, columns)
columnValues = {}
columnValues["name"] = "John"
columnValues["age"] = 25
columnValues["salary"] = 10000
db.insertTableRows(tableName, columnValues)
columnValues.clear()
columnValues["name"] = "Kim"
columnValues["age"] = 28
columnValues["salary"] = 12000
db.insertTableRows(tableName, columnValues)
db.printTableAllRows(tableName)
db.filterTableRecordsByColumnValue(tableName, age, 28)
db.filterTableRecordsByColumnValue(tableName, name, "John")
db.truncate(tableName)
db.dropTable(tableName)
db.printTableAllRows(tableName)

# Start of ./low_level_design/simple_ruby_app_with_db.rb
require "bundler/inline"
require "active_record"
require "sqlite3"

gemfile do
  source "https://rubygems.org"
  gem "json", require: false
  gem "activerecord", "~> 5.0", ">= 5.0.0.1"
  gem "sqlite3", "~> 1.4"
end

puts "Gems installed and loaded!"

# # Connect to an in-memory sqlite3 database
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:",
)

# # Define a minimal database schema
ActiveRecord::Schema.define do
  create_table :shows, force: true do |t|
    t.string :name
  end

  create_table :episodes, force: true do |t|
    t.string :name
    t.belongs_to :show, index: true
  end
end

# # Define the models
class Show < ActiveRecord::Base
  has_many :episodes, inverse_of: :show
end

class Episode < ActiveRecord::Base
  belongs_to :show, inverse_of: :episodes, required: true
end

# # Create a few records...
show = Show.create!(name: "Big Bang Theory")

first_episode = show.episodes.create!(name: "Pilot")
second_episode = show.episodes.create!(name: "The Big Bran Hypothesis")

episode_names = show.episodes.pluck(:name)

puts "#{show.name} has #{show.episodes.size} episodes named #{episode_names.join(", ")}."
# # =>

# >> Gems installed and loaded!
# >> -- create_table(:shows, {:force=>true})
# >>    -> 0.0042s
# >> -- create_table(:episodes, {:force=>true})
# >>    -> 0.0008s
# >> Big Bang Theory has 2 episodes named Pilot, The Big Bran Hypothesis.

# !> WARN: Unresolved or ambigious specs during Gem::Specification.reset:
# !>       minitest (~> 5.1)
# !>       Available/installed versions of this gem:
# !>       - 5.16.3
# !>       - 5.14.4
# !>       - 5.14.1
# !>       - 5.11.3
# !>       - 5.0.0
# !> WARN: Clearing out unresolved specs. Try 'gem cleanup <gem>'
# !> Please report a bug if this causes problems.

# Start of ./low_level_design/ruby_pub_sub_design_pattern.rb
module Publisher
  def subscribe(subscribers)
    @subscribers ||= []
    @subscribers += subscribers
  end

  def broadcast(event, *payload)
    @subscribers ||= []
    @subscribers.each do |subscriber|
      subscriber.public_send(event.to_sym, *payload) if subscriber.respond_to?(event)
    end
  end
end

class Event
  attr_reader :code, :title

  def initialize(code:, title:)
    @code = code
    @title = title
  end

  def to_s
    "#{@code} #{@title}"
  end
end

class AddSubscribers
  include Publisher

  attr_reader :events

  def initialize(subscribers:)
    @events = []
    subscribe(subscribers)
  end

  def send(event)
    @events << event
    broadcast(:event_added, event)
  end
end

class Subscriber1
  def event_added(event)
    print(event)
  end

  private

  def print(message)
    puts "[#{Time.now}] #{message}"
  end
end

class Subscriber2
  def event_added(_)
    send_event!
  end

  def send_event!
    print "\a Event sent"
  end
end

event1 = Event.new(code: "DRP", title: "Dr.Pepper")
event2 = Event.new(code: "CCL", title: "Coca-Cola")

subscribers = AddSubscribers.new(subscribers: [Subscriber1.new, Subscriber2.new])

subscribers.send(event1)
subscribers.send(event2)

# >> [2022-10-04 00:13:01 +0530] DRP Dr.Pepper
# >> \a Event sent[2022-10-04 00:13:01 +0530] CCL Coca-Cola
# >> \a Event sent

class ConcreteBuilder1
  def initialize
    reset
  end

  def reset
    @product = Product1.new
  end

  def product
    product = @product
    reset
    product
  end

  def produce_part_a
    @product.add("PartA1")
  end

  def produce_part_b
    @product.add("PartB1")
  end

  def produce_part_c
    @product.add("PartC1")
  end
end

class Product1
  def initialize
    @parts = []
  end

  def add(part)
    @parts << part
  end

  def list_parts
    print 'Product parts: #{@parts.join(', ")}"
  end
end

class Director
  attr_accessor :builder

  def initialize
    @builder = nil
  end

  def builder=(builder)
    @builder = builder
  end

  def build_minimal_viable_product
    @builder.produce_part_a
  end

  def build_full_featured_product
    @builder.produce_part_a
    @builder.produce_part_b
    @builder.produce_part_c
  end
end

director = Director.new
builder = ConcreteBuilder1.new
director.builder = builder
puts "Standard basic product: "
director.build_minimal_viable_product
builder.product.list_parts
puts "

"
puts "Standard full featured product: "
director.build_full_featured_product
builder.product.list_parts
puts "

"
puts "Custom product: "
builder.produce_part_a
builder.produce_part_b
builder.product.list_parts

class SimpleCommand
  def initialize(payload)
    @payload = payload
  end

  def execute
    puts 'SimpleCommand: See, I can do simple things like printing (#{@payload})'
  end
end

class ComplexCommand < Command
  def initialize(receiver, a, b)
    @receiver = receiver
    @a = a
    @b = b
  end

  def execute
    print "ComplexCommand: Complex stuff should be done by a receiver object"
    @receiver.do_something(@a)
    @receiver.do_something_else(@b)
  end
end

class Receiver
  def do_something(a)
    print 'Receiver: Working on (#{a}.)'
  end

  def do_something_else(b)
    print 'Receiver: Also working on (#{b}.)'
  end
end

class Invoker
  def on_start=(command)
    @on_start = command
  end

  def on_finish=(command)
    @on_finish = command
  end

  def do_something_important
    puts "Invoker: Does anybody want something done before I begin?"
    @on_start.execute if @on_start.is_a? Command
    puts "Invoker: ...doing something really important..."
    puts "Invoker: Does anybody want something done after I finish?"
    @on_finish.execute if @on_finish.is_a? Command
  end
end

invoker = Invoker.new
invoker.on_start = SimpleCommand.new("Say Hi!")
receiver = Receiver.new
invoker.on_finish = ComplexCommand.new(receiver, "Send email", "Save report")
invoker.do_something_important

# Start of ./low_level_design/ruby_multi_threading.rb
threads = []
threads << Thread.new { puts "Whats the big deal" }
threads << Thread.new { 3.times { puts "Threads are fun!" } }
threads.each(&:join) 
Thread.abort_on_exception = true

thr = Thread.new { puts "Whats the big deal again" }
thr.join

$str = "Test string"

# ----------------------------------------------------------------

def method_1
  a = 0
  while a <= 3
    puts "method_1: #{a}"
    sleep(1)
    a += 1
  end

  puts "Global variable: #{$str}"
end

def method_2
  b = 0

  while b <= 3
    puts "method_2: #{b}"
    sleep(0.5)
    b += 1
  end

  puts "Global variable: #{$str}"
end

x = Thread.new { method_1 }
y = Thread.new { method_2 }

x.join
y.join

# >> Whats the big deal
# >> Threads are fun!
# >> Threads are fun!
# >> Threads are fun!
# >> Whats the big deal again

# Start of ./low_level_design/queue_script_spec.rb
require "test/unit"

class Queue
  Node = Struct.new :element, :next

  attr_reader :head, :tail, :size

  def initialize(items = [])
    @head = nil
    @tail = nil
    @size = 0

    items.to_a.each { |element| enqueue element }
  end

  def enqueue(element)
    n = Node.new element, nil
    if @tail
      @tail.next = n
      @tail = n
    else
      @head = @tail = n
    end
    @size += 1
    element
  end

  alias << enqueue
  alias push enqueue

  def dequeue
    return nil unless @head

    n = @head
    if @size == 1
      clear
      return n.element
    end

    @head = n.next
    @size -= 1
    n.element
  end

  alias pop dequeue

  def front
    @head.element
  end

  def empty?
    @size.zero?
  end

  def clear
    @head = nil
    @tail = nil
    @size = 0
  end
end

# # if __FILE__ == $0
# end
class TestQueue < Test::Unit::TestCase
  def setup
    @queue = Queue.new
  end

  def teardown
    @queue.clear
  end

  def test_simple
    element = 1
    @queue.enqueue element

    assert_equal element, @queue.front
    assert_equal 1, @queue.size
    assert !@queue.empty?

    assert_equal element, @queue.dequeue
    assert_equal 0, @queue.size
    assert @queue.empty?
  end
end

# >> Loaded suite queue_script_spec
# >> Started
# >> .
# >> Finished in 0.00035 seconds.
# >> -------------------------------------------------------------------------------
# >> 1 tests, 6 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
# >> 100% passed
# >> -------------------------------------------------------------------------------
# >> 2857.14 tests/s, 17142.86 assertions/s
# Start of ./low_level_design/unit_spec.rb
require "test/unit"

class A
  attr_accessor :test

  def initialize
    @test = 10
  end
end

class TestA < Test::Unit::TestCase
  def setup
    @a = A.new
  end

  def teardown
  end

  def test_simple
    assert_equal @a.test, 10
    assert_not_nil @a
  end
end

# >> Loaded suite unit_spec
# >> Started
# >> .
# >> Finished in 0.000246 seconds.
# >> -------------------------------------------------------------------------------
# >> 1 tests, 1 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
# >> 100% passed
# >> -------------------------------------------------------------------------------
# >> 4065.04 tests/s, 4065.04 assertions/s

# Start of ./low_level_design/simple_document_service.rb
# Design and implement a Simple document Service where users can create documents and read the same.
# A document has a name and associated string content. Document=> <name{string}, content{string}>
# All documents are private when created.
# Owners of documents can {grant} {read OR edit} access to other users
# Only the owner can delete a document
# Username will be just a string. Every action like create/read/edit/delete must be made on behalf of a user


# Start of ./low_level_design/top_trending_topic.rb
# https://mecha-mind.medium.com/system-design-top-k-trending-hashtags-4e12de5bb846

# Start of ./low_level_design/lru_cache.rb
# Exception classes - storage full, not found
class LRUCache
  attr_accessor :elems

  def initialize(capacity)
    @capacity = capacity
    # Storage can be dependency
    @elems = {}
  end

  def get(key)
    val = @elems.delete key
    if val
      @elems[key] = val
    else
      -1
    end
  end

  def put(key, value)
    # Eviction policy can be injected
    @elems.delete key
    @elems[key] = value
    @elems.delete @elems.first.first if @elems.size > @capacity
  end
end

lRUCache = LRUCache.new(2)
pp lRUCache.put(1, 5)
pp lRUCache.put(2, 2)
pp lRUCache.put(3, 5)
pp lRUCache.put(4, 6)
pp lRUCache.get(3)
pp lRUCache.elems

# >> nil
# >> nil
# >> 5
# >> 2
# >> 5
# >> {4=>6, 3=>5}

# Start of ./low_level_design/print_table.rb
def print_table(slots)
  table_format = "Slot No.    Registration No    Colour\n"

  slots.each_with_index do |slot, idx|
    next unless slot
    table_format += (idx + 1).to_s + "           " + slot["reg_no"] + "      " + slot["color"]
    table_format += "\n"
  end

  print_result table_format
end

def print_result(output)
  puts output
end

slots = [
  { "reg_no" => "KA052", "color" => "red" },
]

print_table(slots)

# >> "here"
# >> 0
# >> "KA052"
# >> "red"
# >> Slot No.    Registration No    Colour
# >> 1           KA052      red

# Start of ./low_level_design/bytes_to_string.rb
bytes = [
  104, 116, 116, 112, 115,
  58, 47, 47, 119, 119,
  119, 46, 106, 118, 116,
  46, 109, 101,
]

puts bytes.pack("C*").force_encoding("UTF-8")
puts bytes.map { |num| num.chr }.join

# >> https://www.jvt.me
# >> https://www.jvt.me

# Start of ./interview/PhonePe/main.rb
# We have 2 objects
# Entity
# Tags
# Assumptions:
# We will only create tags which are allowed. See INSTRUMENT, STATE and CITY in below file.
# In case tag is not allowed, we will log it out and return. We can also raise an exception if required.

# class Entity
class Entity
  attr_reader :entity_id, :tags

  @@instances = []

  def initialize(entity_id:, tags:)
    @entity_id = entity_id
    @tags = tags
    process_tags(tags, entity_id) 
    @@instances << self
  end

  # Find or create a new tag
  def process_tags(tags, entity_id)
    tags.each do |name|
      Tag.new(name: name, entity_id: entity_id) unless Tag.find(name)
    end
  end

  def self.find(entity_id:)
    @@instances.each do |entity|
      return entity if entity_id == entity.entity_id
    end
    nil
  end

  def self.clear
    @@instances.clear
  end
end

class Tag
  @@instances = []

  # TODO: Move INSTRUMENT, STATE and CITY to database so we can add or remove them.
  INSTRUMENT = %w[Wallet Upi].freeze
  STATE = %w[Karnataka Rajasthan].freeze
  CITY = %w[Bangalore Mysuru Jodhpur].freeze
  @@tracked_instruments = Hash.new(0)
  @@tracked_states = Hash.new(0)
  @@tracked_cities = Hash.new(0)

  attr_reader :name

  def initialize(name, entity_id)
    @name = name
    @entity_id = entity_id
    @@instances << self
  end

  def self.start_tracking(tag:)
    if INSTRUMENT.include? tag
      @@tracked_instruments = {
        "UPI" => 1,
        "WALLETY" => 2
      }

      @@tracked_instruments = {
        "UPI" => {
          "ENTITY_ID_123", "456"
        },
        "WALLETY" => {
          "123", "456"
        }
      }

      @@tracked_states = {
        "Karnataka" => {
          "ENTITY_ID_123", "456"
        },
        "WALLETY" => {
          "123", "456"
        }
      }

      entity1 , UPI - yes

      # UPI, Karnataka, Bangalore
      # UPI, Karnataka, Mysore
      # getCounts(UPI, Karnataka, Bangalore) - 1
      # 

      # "ENTITY_ID_123", "456" - 2


      # ["ENTITY_ID_123", "456", "ENTITY_ID_123", "456"].uniq

      @@tracked_instruments[tag] += 1
    elsif STATE.include? tag
      @@tracked_states[tag] += 1
    elsif CITY.include? tag
      @@tracked_cities[tag] += 1
    else
      # We can also raise an exception
      puts "Tag not supported."
      nil
    end
  end

  def self.stop_tracking(entity_id:)
    tags = Entity.find(entity_id: entity_id).tags
    tags.each do |tag|
      if INSTRUMENT.include? tag
        @@tracked_instruments[tag] -= 1
      elsif STATE.include? tag
        @@tracked_states[tag] -= 1
      elsif CITY.include? tag
        @@tracked_cities[tag] -= 1
      end
    end
  end

  def self.get_counts(tags:)
    count = 0
    tags.each do |tag|
      if INSTRUMENT.include? tag
        count += @@tracked_instruments[tag]
      elsif STATE.include? tag
        count += @@tracked_states[tag]
      elsif CITY.include? tag
        count += @@tracked_cities[tag]
      end
    end
    count
  end

  def self.all
    @@instances
  end

  def self.find(name)
    @@instances.each do |tag_name|
      return true if name == tag_name.name[:name]
    end
    false
  end

  def self.clear
    @@instances.clear
  end
end

# startTracking(4221, ["Wallet", "Karnataka", "Bangalore"]);
def start_tracking(entity_id:, tags:)
  Entity.new(entity_id: entity_id, tags: tags)
  tags.each do |tag|
    Tag.start_tracking(tag: tag)
  end
end

# stopTracking(1112);
def stop_tracking(entity_id:)
  Tag.stop_tracking(entity_id: entity_id)
end

# getCounts(["UPI", "Karnataka", "Bangalore"])
def get_counts(tags:)
  Tag.get_counts(tags: tags)
end

require 'test/unit'
if __FILE__ == $0
  class TestPendency < Test::Unit::TestCase
    def teardown
      Entity.clear
      Tag.clear
    end

    def test_start_tracking
      start_tracking(entity_id: 23, tags: %w[Wallet Upi])
      count = get_counts(tags: %w[Wallet Upi])
      assert_equal count, 2
      stop_tracking(entity_id: 23)
    end

    def test_tags_not_allowed
      start_tracking(entity_id: 24, tags: %w[Jodhpur InvalidTag])
      count = get_counts(tags: %w[Jodhpur InvalidTag])
      assert_equal count, 1
      stop_tracking(entity_id: 24)
    end

    def test_stop_tracking
      start_tracking(entity_id: 22, tags: %w[Karnataka Bangalore])
      stop_tracking(entity_id: 22)
      count = get_counts(tags: %w[Karnataka Bangalore])
      assert_equal count, 0
    end

    def test_get_counts
      start_tracking(entity_id: 21, tags: %w[Rajasthan Mysuru])
      count = get_counts(tags: %w[Rajasthan Mysuru])
      assert_equal count, 2
    end
  end
end

# >> Loaded suite main
# >> Started
# >> ...Tag not supported.
# >> .
# >> Finished in 0.00069 seconds.
# >> -------------------------------------------------------------------------------
# >> 4 tests, 4 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
# >> 100% passed
# >> -------------------------------------------------------------------------------
# >> 5797.10 tests/s, 5797.10 assertions/s

# Start of ./interview/PhonePe/sample.rb
pp 1

# >> 1
# Start of ./interview/google/coding/longest_palindrome_substring.rb
def longest_palindrome(s)
  n = s.length
  max_palindrome = ""
  
  for i in 0...n
    # expand around odd length palindromes
    l = i
    r = i
    while l >= 0 && r < n && s[l] == s[r]
      l -= 1
      r += 1
    end
    odd_palindrome = s[l+1..r-1]
    
    # expand around even length palindromes
    l = i
    r = i + 1
    while l >= 0 && r < n && s[l] == s[r]
      l -= 1
      r += 1
    end
    even_palindrome = s[l+1..r-1]
    
    # keep track of longest palindrome found so far
    if odd_palindrome.length > max_palindrome.length
      max_palindrome = odd_palindrome
    end
    if even_palindrome.length > max_palindrome.length
      max_palindrome = even_palindrome
    end
  end
  
  max_palindrome
end

# Start of ./interview/razor_pay_lld/dependencies.rb
require_relative "document"

# Start of ./interview/razor_pay_lld/document.rb
require "json"
require_relative "id_generator"

class Document
  attr_accessor :data

  def initialize(data)
    @id = IdGenerator.instance.get_id
    check_data_type(data)
    @data = data
  end

  def check_data_type(data)
    if data.is_a?(String)
      res = JSON.parse(data)
    else
      res = data
    end

    res.each do |key, value|
      puts value.class
      raise "Data type not supported" unless value.is_a?(Integer) || value.is_a?(String) || value.is_a?(Array) || value.is_a?(Hash)

      if value.is_a?(Hash)
        check_data_type(value)
      end
    end
  end
end

json = '{"desc":{"someKey":2,"anotherKey":"value"}}'
p Document.new(json)
p Document.new(json)

# >> Hash
# >> Integer
# >> String
# >> #<Document:0x00007f945b036d20 @id=1, @data="{\"desc\":{\"someKey\":2,\"anotherKey\":\"value\"}}">
# >> Hash
# >> Integer
# >> String
# >> #<Document:0x00007f945b036730 @id=2, @data="{\"desc\":{\"someKey\":2,\"anotherKey\":\"value\"}}">

# Start of ./interview/razor_pay_lld/collection.rb
require_relative "dependencies"

class Collection
  def initialize(name)
    @name, @data = name, []
  end

  def add_document(document)
    raise if @name.nil?
    raise "Document type not supported." unless document.is_a?(Document)
    @data << document
  end

  def search_collection(search_key)
    raise "Collection not present." if @name.nil?
    @data.each_with_index do |item, idx|
      puts JSON.parse(item.data)
      return idx if JSON.parse(item.data) == search_key
    end
    return -2
  end

  def update_collection(search_document, key, updated_value)
    raise "Collection not present." if @name.nil?
    update_item_id = -2
    @data.each_with_index do |item, idx|
      puts JSON.parse(item.data)
      update_item_id = idx if JSON.parse(item.data) == search_key
    end

    if update_item_id == 0 || update_item_id.positive?
      document = @data[update_item_id]
      updated_document_data = update_hash_value(document.data, key, updated_value)
      @data[update_item_id].data = updated_document_data
    end

    return update_item_id
  end

  def update_hash_value(obj, key, val)
    if obj.respond_to?(:key?) && obj.key?(key)
      obj[key] = val
      obj[key]
      obj
    elsif obj.respond_to?(:each)
      r = nil
      obj.find { |*a| r = nested_hash_value(a.last, key) }
      r
    end
  end

  def delete_collection
    @name = nil
  end
end

json = '{"desc":{"someKey":2,"anotherKey":"value"}}'
hash = { "desc" => { "someKey" => 2, "anotherKey" => "value" } }
other_hash = { "desc" => { "someotherKey" => 2, "anotherKey" => "value" } }
document = Document.new(json)
collection = Collection.new("users")
p collection.add_document(document)
p collection.search_collection(hash)
# collection.search_collection(other_hash)
# p collection.delete_collection
# collection.update_collection(hash, "desc", "3")

# >> Hash
# >> Integer
# >> String
# >> #<Document:0x00007f9ade04ee00 @id=1, @data="{\"desc\":{\"someKey\":2,\"anotherKey\":\"value\"}}">
# >> Hash
# >> Integer
# >> String
# >> #<Document:0x00007f9ade04e888 @id=2, @data="{\"desc\":{\"someKey\":2,\"anotherKey\":\"value\"}}">
# >> Hash
# >> Integer
# >> String
# >> [#<Document:0x00007f9ade04e1d0 @id=3, @data="{\"desc\":{\"someKey\":2,\"anotherKey\":\"value\"}}">]
# >> {"desc"=>{"someKey"=>2, "anotherKey"=>"value"}}
# >> 0

# Start of ./interview/razor_pay_lld/play.rb

# Start of ./interview/razor_pay_lld/id_generator.rb
class IdGenerator
  @instance = new
  @@a = 1

  private_class_method :new
  def self.instance
    @uuid = 0
    @instance
  end

  def get_id
    id = self.singleton_class.class_variable_get(:@@a)
    self.singleton_class.class_variable_set(:@@a, id + 1)
    return id
  end
end

# p IdGenerator.instance.get_id
# p IdGenerator.instance.get_id
# p IdGenerator.instance.get_id

# >> 1
# >> 2
# >> 3

# Start of ./interview/razorpay/code.rb

# Start of ./interview/sharechat/code.rb
# Binary search
sorted = [1, 2, 3, 3, 3, 4, 4, 4, 5, 6]
num = 4
# jyotirmay @sharechat.co

def solve(sorted, num)
  right = sorted.length - 1
  left = 0
  result = -1

  while left <= right
    mid = left + (right - left) / 2
    if sorted[mid] == num
      result = mid
      left = mid + 1
    elsif sorted[mid] > num
      right = mid - 1
    else
      left = mid + 1
    end
  end

  return result
end

p solve(sorted, num)

# >> 7

# Given a linked list, swap every two adjacent nodes and return its head.
# You must solve the problem without modifying the values in the list's nodes (i.e., only nodes themselves may be changed.)

# 1 -> 2 -> 3 -> 4
# 2 -> 1 -> 3 -> 4
# 2 -> 1 -> 4 -> 3

# k = 3

# 1 -> 2 -> 3 -> 4 -> 5 -> 6
# 3 -> 2 -> 1 -> 6 -> 5 -> 4

# head node - val, next
# node 2 - val, next

# -> i, j
# i = curr
# j = next_node

# temp = j.next
# j.next -> i
# i.next = temp
# i += 2
# j += 2

class Node
  attr_accessor :val, :next_node

  def initialize(next_node, val)
    @next_node = next_node
    @val = val
  end
end

node_3 = Node.new(nil, 4)
node_2 = Node.new(node_3, 3)
node_1 = Node.new(node_2, 2)
head = Node.new(node_1, 1)

# k = 3
# 1 -> 2 -> 3 -> 4 -> 5 -> 6
# 3 -> 2 -> 1 -> 6 -> 5 -> 4

# def solve(head, k)
#   curr = head
#   p curr
#   while curr&.next_node
#     next_node = curr.next_node
#     temp = next_node.next_node
#     next_node.next_node = curr
#     curr.next_node = temp
#     curr = curr.next_node
#   end
# end

# def solve(head)
#   curr = head
#   temp = nil

#   k.times do |i| # ~> NameError: undefined local variable or method `k' for main:Object
#     temp_arr << curr
#     curr = curr.next_node
#   end
#   temp = curr.next_node
# end

def print(curr)
  while curr
    p curr.val
    curr = curr.next_node
  end
end

def reverse(head, k)
  curr = head
  count = 0
  while curr
    first = head
    second = first.next_node
    temp = second&.next_node
    second.next_node = first
    first.next_node = temp
    curr = temp
    count += 1
    break if count == k - 1
  end
end

def solve(head, k)
  curr = head
  while curr # O(n)
    reverse(curr, k) # O(n)
    k.times do # O(k)
      curr = curr&.next_node
    end
  end
end

# p solve(head, 2)
p reverse(head, k)
print(node_1)

# Start of ./interview/company/PhonePe/design_guru_state.rb
class Context
  attr_accessor :state
  private :state

  def initialize(state)
    transition_to(state)
  end

  def transition_to(state)
    puts "Context: Transition to #{state.class}"
    @state = state
    @state.context = self
  end

  def request1
    @state.handle1
  end

  def request2
    @state.handle2
  end
end

class State
  attr_accessor :context

  def handle1
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def handle2
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteStateA < State
  def handle1
    puts 'ConcreteStateA handles request1.'
    puts 'ConcreteStateA wants to change the state of the context.'
    @context.transition_to(ConcreteStateB.new)
  end

  def handle2
    puts 'ConcreteStateA handles request2.'
  end
end

class ConcreteStateB < State
  def handle1
    puts 'ConcreteStateB handles request1.'
  end

  def handle2
    puts 'ConcreteStateB handles request2.'
    puts 'ConcreteStateB wants to change the state of the context.'
    @context.transition_to(ConcreteStateA.new)
  end
end

context = Context.new(ConcreteStateA.new)
context.request1
context.request2

# Start of ./interview/company/PhonePe/read_and_write_to_file.rb
# How to read file?
file = File.open("users.txt")
file_data = file.read
# "user1\nuser2\nuser3\n"

file_data = file.readlines.map(&:chomp)
# ["user1", "user2", "user3"]

file.close

file_data = File.read("user.txt").split
# ["user1", "user2", "user3"]

File.foreach("users.txt") { |line| puts line }

# How to write file?
File.open("log.txt", "w") { |f| f.write "#{Time.now} - User logged in\n" }

File.write("log.txt", "data...")

# To use this method in append mode:
File.write("log.txt", "data...", mode: "a")

# If you want to write an array to a file you’ll have to convert it into a string first.
File.write("log.txt", [1, 2, 3].join("\n"), mode: "a")

# You are going to be using methods like:

# rename
# size
# exists?
# extname
# basename
# dirname
# directory?
# file?

# Renaming a file
File.rename("old-name.txt", "new-name.txt")
# File size in bytes
File.size("users.txt")
# Does this file already exist?
File.exist?("log.txt")
# Get the file extension, this works even if the file doesn't exists
File.extname("users.txt")
# => ".txt"
# Get the file name without the directory part
File.basename("/tmp/ebook.pdf")
# => "ebook.pdf"
# Get the path for this file, without the file name
File.dirname("/tmp/ebook.pdf")
# => "/tmp"
# Is this actually a file or a directory?
File.directory?("cats")

# The last example makes more sense if you are looping through the contents of a directory listing.

# def find_files_in_current_directory
#   entries = Dir.entries(".")
#   entries.reject { |entry| File.directory?(entry) }
# end

# Directory Operations
# Using Dir.glob you can get a list of all the files that match a certain pattern.

# Here are some examples:

# All files in current directory
Dir.glob("*")
# All files containing "spec" in the name
Dir.glob("*spec*")
# All ruby files
Dir.glob("*.rb")

# This one line of code will recursively list all files in Ruby, starting from the current directory:
Dir.glob("**/**")

# Use this if you only want to search for directories:
Dir.glob("**/**/")

# Using the Dir class it’s also possible to print the current working directory:
Dir.pwd

# Check if a directory is empty:
Dir.empty?("/tmp")
# false

# Check if a directory exists:
Dir.exist?("/home/jesus")
# true

# Extra
File.open("/usr/local/widgets/data").each do |line|
  puts line if line =~ /blue/
end
logfile = File.new("/tmp/log", "w")
logfile.close
File.expand_path('~/tmp')
fh = Tempfile.new('tmp')
fh.sync = true # autoflushes
10.times { |i| fh.puts i }
fh.rewind
puts 'Tmp file has: ', fh.readlines

# Start of ./interview/company/PhonePe/gas_station.rb
def can_complete_circuit(gas, cost)
  return -1 if gas.inject(0, :+) < cost.inject(0, :+)

  total = 0
  start = 0
  gas.length.times do |i|
    total += gas[i] - cost[i]

    if total.negative?
      total = 0
      start = i + 1
    end
  end

  start
end

gas = [1, 2, 3, 4, 5]
cost = [3, 4, 5, 1, 2]

p can_complete_circuit(gas, cost)

# >> 3

# Start of ./interview/company/PhonePe/in_memory_file_system.rb
require 'pp'

class FileSystem
  def initialize
    @root = {}
  end

  attr_reader :root

  def ls(path)
    dirs = parse_path(path)
    current_dir = get_dir(dirs)
    return [current_dir.file_name] if current_dir.is_a?(File)

    current_dir.keys.sort
  end

  def mkdir(path)
    dirs = parse_path(path)
    current_dir = @root

    dirs.each do |dir_name|
      current_dir[dir_name] = {} if current_dir[dir_name].nil?
      current_dir = current_dir[dir_name]
    end

    nil
  end

  def parse_path(path)
    dirs = path.split('/')
    dirs.shift
    dirs
  end

  def get_dir(dirs)
    current_dir = @root
    dirs.each do |dir|
      current_dir = current_dir[dir]
    end

    current_dir
  end

  def add_content_to_file(file_path, content)
    dirs = parse_path(file_path)
    file_name = dirs.pop
    current_dir = get_dir(dirs)

    if current_dir[file_name].nil?
      current_dir.merge!({ file_name.to_s => File.new(file_name, content) })
    else
      current_dir[file_name].content += content
    end
  end

  def read_content_from_file(file_path)
    dirs = parse_path(file_path)
    current_dir = get_dir(dirs)

    current_dir.content
  end
end

class FileSystem
  class File
    attr_accessor :file_name, :content

    def initialize(file_name, content)
      @file_name = file_name
      @content = content
    end
  end
end

fs = FileSystem.new
pp fs.ls('/')
fs.mkdir('/a/b/c')
pp fs.ls('')
pp fs
pp fs.add_content_to_file("/a/b/c/d", "hello")
pp fs.read_content_from_file("/a/b/c/d")

# >> []
# >> ["a"]
# >> #<FileSystem:0x00007f8a46846b60 @root={"a"=>{"b"=>{"c"=>{}}}}>
# >> {"d"=>#<FileSystem::File:0x00007f8a428330f0 @content="hello", @file_name="d">}
# >> "hello"

# Start of ./interview/company/PhonePe/encrypt_decrypt.rb
data = { name: "Andy A.", email: "andy+hello@example.com", created_on: "2018-01-20" }

require 'openssl'
require 'uri'
require 'base64'
require 'json'
require 'cgi'

cipher = OpenSSL::Cipher.new('aes-256-cbc')
cipher.encrypt

key = cipher.random_key
iv = cipher.random_iv

encrypted = cipher.update(data.to_json) + cipher.final

pp CGI.escape(Base64.encode64(encrypted))

decipher = OpenSSL::Cipher.new('aes-256-cbc')
decipher.decrypt
decipher.key = key
decipher.iv = iv

plain = decipher.update(encrypted) + decipher.final

data = JSON.parse(plain)
pp data

# >> "O3zIcGyeBRGERQ3Lkw05Eo9L8MB6i0O3f8z3d77vVfUASlONmxD1%2BMOyML3U%0AHKc%2FrrM0rqYTFmXnnePXBqDGDEAZRhyGTHWNBXeAw6pzxAM%3D%0A"
# >> {"name"=>"Andy A.",
# >>  "email"=>"andy+hello@example.com",
# >>  "created_on"=>"2018-01-20"}

# Start of ./interview/company/PhonePe/common.rb
bytes = [
  104, 116, 116, 112, 115,
  58, 47, 47, 119, 119,
  119, 46, 106, 118, 116,
  46, 109, 101
]

puts bytes.pack('C*').force_encoding('UTF-8')
puts bytes.map { |num| num.chr }.join

# >> https://www.jvt.me
# >> https://www.jvt.me
class Context
  attr_accessor :state
  private :state

  def initialize(state)
    transition_to(state)
  end

  def transition_to(state)
    puts "Context: Transition to #{state.class}"
    @state = state
    @state.context = self
  end

  def request1
    @state.handle1
  end

  def request2
    @state.handle2
  end
end

class State
  attr_accessor :context

  def handle1
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def handle2
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteStateA < State
  def handle1
    puts 'ConcreteStateA handles request1.'
    puts 'ConcreteStateA wants to change the state of the context.'
    @context.transition_to(ConcreteStateB.new)
  end

  def handle2
    puts 'ConcreteStateA handles request2.'
  end
end

class ConcreteStateB < State
  def handle1
    puts 'ConcreteStateB handles request1.'
  end

  def handle2
    puts 'ConcreteStateB handles request2.'
    puts 'ConcreteStateB wants to change the state of the context.'
    @context.transition_to(ConcreteStateA.new)
  end
end

context = Context.new(ConcreteStateA.new)
context.request1
context.request2
data = { name: "Andy A.", email: "andy+hello@example.com", created_on: "2018-01-20" }

require 'openssl'
require 'uri'
require 'base64'
require 'json'
require 'cgi'

cipher = OpenSSL::Cipher.new('aes-256-cbc')
cipher.encrypt

key = cipher.random_key
iv = cipher.random_iv

encrypted = cipher.update(data.to_json) + cipher.final

pp CGI.escape(Base64.encode64(encrypted))

decipher = OpenSSL::Cipher.new('aes-256-cbc')
decipher.decrypt
decipher.key = key
decipher.iv = iv

plain = decipher.update(encrypted) + decipher.final

data = JSON.parse(plain)
pp data

# >> "O3zIcGyeBRGERQ3Lkw05Eo9L8MB6i0O3f8z3d77vVfUASlONmxD1%2BMOyML3U%0AHKc%2FrrM0rqYTFmXnnePXBqDGDEAZRhyGTHWNBXeAw6pzxAM%3D%0A"
# >> {"name"=>"Andy A.",
# >>  "email"=>"andy+hello@example.com",
# >>  "created_on"=>"2018-01-20"}
require 'pp'

class FileSystem
  def initialize
    @root = {}
  end

  attr_reader :root

  def ls(path)
    dirs = parse_path(path)
    current_dir = get_dir(dirs)
    return [current_dir.file_name] if current_dir.is_a?(File)

    current_dir.keys.sort
  end

  def mkdir(path)
    dirs = parse_path(path)
    current_dir = @root

    dirs.each do |dir_name|
      current_dir[dir_name] = {} if current_dir[dir_name].nil?
      current_dir = current_dir[dir_name]
    end

    nil
  end

  def parse_path(path)
    dirs = path.split('/')
    dirs.shift
    dirs
  end

  def get_dir(dirs)
    current_dir = @root
    dirs.each do |dir|
      current_dir = current_dir[dir]
    end

    current_dir
  end

  def add_content_to_file(file_path, content)
    dirs = parse_path(file_path)
    file_name = dirs.pop
    current_dir = get_dir(dirs)

    if current_dir[file_name].nil?
      current_dir.merge!({ file_name.to_s => File.new(file_name, content) })
    else
      current_dir[file_name].content += content
    end
  end

  def read_content_from_file(file_path)
    dirs = parse_path(file_path)
    current_dir = get_dir(dirs)

    current_dir.content
  end
end

class FileSystem
  class File
    attr_accessor :file_name, :content

    def initialize(file_name, content)
      @file_name = file_name
      @content = content
    end
  end
end

fs = FileSystem.new
pp fs.ls('/')
fs.mkdir('/a/b/c')
pp fs.ls('')
pp fs
pp fs.add_content_to_file("/a/b/c/d", "hello")
pp fs.read_content_from_file("/a/b/c/d")

# >> []
# >> ["a"]
# >> #<FileSystem:0x00007f8a46846b60 @root={"a"=>{"b"=>{"c"=>{}}}}>
# >> {"d"=>#<FileSystem::File:0x00007f8a428330f0 @content="hello", @file_name="d">}
# >> "hello"
module Publisher
  def subscribe(subscribers)
    @subscribers ||= []
    @subscribers += subscribers
  end

  def broadcast(event, *payload)
    @subscribers ||= [] # @subscribers is nil, we can't do each on it
    @subscribers.each do |subscriber|
      subscriber.public_send(event.to_sym, *payload) if subscriber.respond_to?(event)
    end
  end
end

class Event
  attr_reader :code, :title

  def initialize(code:, title:)
    @code = code
    @title = title
  end

  def to_s
    "#{@code} #{@title}"
  end
end

class AddSubscribers
  include Publisher

  attr_reader :events

  def initialize(subscribers:)
    @events = []
    subscribe(subscribers)
  end

  def send(event)
    @events << event
    broadcast(:event_added, event)
  end
end

class Subscriber1
  def event_added(event)
    print(event)
  end

  private

  def print(message)
    puts "[#{Time.now}] #{message}"
  end
end

class Subscriber2
  def event_added(_)
    send_event!
  end

  def send_event!
    print "\a Event sent"
  end
end

event1 = Event.new(code: "DRP", title: "Dr.Pepper")
event2 = Event.new(code: "CCL", title: "Coca-Cola")

subscribers = AddSubscribers.new(subscribers: [Subscriber1.new, Subscriber2.new])

subscribers.send(event1)
subscribers.send(event2)

# >> [2022-10-04 00:13:01 +0530] DRP Dr.Pepper
# >> \a Event sent[2022-10-04 00:13:01 +0530] CCL Coca-Cola
# >> \a Event sent
# How to read file?
file = File.open("users.txt")
file_data = file.read
# "user1\nuser2\nuser3\n"

file_data = file.readlines.map(&:chomp)
# ["user1", "user2", "user3"]

file.close

file_data = File.read("user.txt").split
# ["user1", "user2", "user3"]

File.foreach("users.txt") { |line| puts line }

# How to write file?
File.open("log.txt", "w") { |f| f.write "#{Time.now} - User logged in\n" }

File.write("log.txt", "data...")

# To use this method in append mode:
File.write("log.txt", "data...", mode: "a")

# If you want to write an array to a file you’ll have to convert it into a string first.
File.write("log.txt", [1, 2, 3].join("\n"), mode: "a")

# You are going to be using methods like:

# rename
# size
# exists?
# extname
# basename
# dirname
# directory?
# file?

# Renaming a file
File.rename("old-name.txt", "new-name.txt")
# File size in bytes
File.size("users.txt")
# Does this file already exist?
File.exist?("log.txt")
# Get the file extension, this works even if the file doesn't exists
File.extname("users.txt")
# => ".txt"
# Get the file name without the directory part
File.basename("/tmp/ebook.pdf")
# => "ebook.pdf"
# Get the path for this file, without the file name
File.dirname("/tmp/ebook.pdf")
# => "/tmp"
# Is this actually a file or a directory?
File.directory?("cats")

# The last example makes more sense if you are looping through the contents of a directory listing.

# def find_files_in_current_directory
#   entries = Dir.entries(".")
#   entries.reject { |entry| File.directory?(entry) }
# end

# Directory Operations
# Using Dir.glob you can get a list of all the files that match a certain pattern.

# Here are some examples:

# All files in current directory
Dir.glob("*")
# All files containing "spec" in the name
Dir.glob("*spec*")
# All ruby files
Dir.glob("*.rb")

# This one line of code will recursively list all files in Ruby, starting from the current directory:
Dir.glob("**/**")

# Use this if you only want to search for directories:
Dir.glob("**/**/")

# Using the Dir class it’s also possible to print the current working directory:
Dir.pwd

# Check if a directory is empty:
Dir.empty?("/tmp")
# false

# Check if a directory exists:
Dir.exist?("/home/jesus")
# true

# Extra
File.open("/usr/local/widgets/data").each do |line|
  puts line if line =~ /blue/
end
logfile = File.new("/tmp/log", "w")
logfile.close
File.expand_path('~/tmp')
fh = Tempfile.new('tmp')
fh.sync = true # autoflushes
10.times { |i| fh.puts i }
fh.rewind
puts 'Tmp file has: ', fh.readlines
threads = []
threads << Thread.new { puts "Whats the big deal" }
threads << Thread.new { 3.times { puts "Threads are fun!" } }
threads.each { |thr| thr.join }
Thread.abort_on_exception = true

thr = Thread.new { puts "Whats the big deal" }
thr.join

$str = "Test string"

# ----------------------------------------------------------------

def method_1
  a = 0
  while a <= 3
    puts "method_1: #{a}"
    sleep(1)
    a += 1
  end

  puts "Global variable: #{$str}"
end

def method_2
  b = 0

  while b <= 3
    puts "method_2: #{b}"
    sleep(0.5)
    b += 1
  end

  puts "Global variable: #{$str}"
end

x = Thread.new { method_1 }
y = Thread.new { method_2 }

x.join
y.join

# >> Whats the big deal
# >> Threads are fun!
# >> Threads are fun!
# >> Threads are fun!
# >> Whats the big deal
# >> method_1: 0
# >> method_2: 0
# >> method_2: 1
# >> method_1: 1
# >> method_2: 2
# >> method_2: 3
# >> method_1: 2
# >> Global variable: Test string
# >> method_1: 3
# >> Global variable: Test string
class FileSystem
  attr_reader :cache

  def initialize
    @cache = { '/' => -1 }
  end

  def create_path(path, value)
    return false if cache[path]
    return false unless cache['/' + path.split('/')[1..-2].join('/')]

    @cache[path] = value
    true
  end

  def get(path)
    cache.fetch(path, -1)
  end
end

fs = FileSystem.new
pp fs.create_path("/leet", 1)
pp fs.create_path("/leet/code", 5)
pp fs.get("/leet/code")


def can_complete_circuit(gas, cost)
  return -1 if gas.inject(0, :+) < cost.inject(0, :+)
  total = 0
  start = 0
  gas.length.times do |i|
    total += gas[i] - cost[i]

    if total.negative?
      total = 0
      start = i + 1
    end
  end

  start
end

gas = [1, 2, 3, 4, 5]
cost = [3, 4, 5, 1, 2]

p can_complete_circuit(gas, cost)

# >> 3
class LRUCache
  def initialize(capacity)
    @capacity = capacity
    @elems = {}
  end

  def get(key)
    val = @elems.delete key
    if val
      @elems[key] = val
    else
      -1
    end
  end

  def put(key, value)
    @elems.delete key
    @elems[key] = value
    @elems.delete @elems.first.first if @elems.size > @capacity
  end
end

lRUCache = LRUCache.new(2)
pp lRUCache.put(1, 5)
pp lRUCache.put(2, 2)
pp lRUCache.get(1)
pp lRUCache.put(3, 3)
pp lRUCache.get(2)
pp lRUCache.put(4, 4)
require 'test/unit'

class Queue
  Node = Struct.new :element, :next

  attr_reader :head, :tail, :size

  def initialize(items = [])
    @head = nil
    @tail = nil
    @size = 0

    items.to_a.each { |element| enqueue element }
  end

  def enqueue(element)
    n = Node.new element, nil
    if @tail
      @tail.next = n
      @tail = n
    else
      @head = @tail = n
    end
    @size += 1
    element
  end

  alias << enqueue
  alias push enqueue

  def dequeue
    return nil unless @head

    n = @head
    if @size == 1
      clear
      return n.element
    end

    @head = n.next
    @size -= 1
    n.element
  end

  alias pop dequeue

  def front
    @head.element
  end

  def back
    @tail.element
  end

  def empty?
    @size.zero?
  end

  def clear
    @head = nil
    @tail = nil
    @size = 0
  end

  def each
    return unless @head

    n = @head
    while n
      yield n.element
      n = n.next
    end
  end
end

# # if __FILE__ == $0
# end
class TestQueue < Test::Unit::TestCase
  def setup
    @queue = Queue.new
  end

  def teardown
    @queue.clear
  end

  def test_simple
    element = 1
    @queue.enqueue element

    assert_equal element, @queue.front
    assert_equal 1, @queue.size
    assert !@queue.empty?

    assert_equal element, @queue.dequeue
    assert_equal 0, @queue.size
    assert @queue.empty?
  end
end

queue = Queue.new
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)
queue.enqueue(4)
# queue.each do |n|
#   pp n
# end
pp queue.dequeue

pp "should"
queue.each do |n|
  pp n
end

# >> 1
# >> "should"
# >> 2
# >> 3
# >> 4
# >> Loaded suite queue
# >> Started
# >> .
# >> Finished in 0.00041 seconds.
# >> -------------------------------------------------------------------------------
# >> 1 tests, 6 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
# >> 100% passed
# >> -------------------------------------------------------------------------------
# >> 2439.02 tests/s, 14634.15 assertions/s
require 'open-uri'

class WordsProvider
  DATABASE_URL = "http://seriousorange.com/words.txt"
  DATABASE_PATH = "words.txt"

  def random_word
    ensure_database
    all_words.sample
  end

  def all_words
    ensure_database
    File.read(DATABASE_PATH).split
  end

  private

  def ensure_database
    File.write(DATABASE_PATH, open(DATABASE_URL).read) unless File.exist?(DATABASE_PATH)
  end
end
class TrafficLight
  def initialize
    @state = nil
  end

  def next_state(klass = Green)
    @state = klass.new(self)
    @state.beep
    @state.start_timer
  end
end

class State
  def initialize(state)
    @state = state
  end
end

class Green < State
  def beep
    puts "Green beep!"
  end

  def next_state
    @state.next_state(Red)
  end

  def start_timer
    sleep 5
    next_state
  end
end

class Red < State
end

class Yellow < State
end

tl = TrafficLight.new
tl.next_state

# Code builder
```ruby
# for-loop method
for n in 0..1
  puts n
end

0
1
=> 0..1

# times method
2.times do |n|
  puts n
end

0
1
=> 2

# range method
(0..1).each do |n|
  puts n
end

0
1
=> 0..1

# upto method
0.upto(1) do |n|
  puts n
end

0
1
=> 0


# Recursion
# 2 things
# Base condition
# Choice diagram
# For base condition - Think of smallest valid input
# Nested array with default - initialization and iterate

data = 2.times.collect { [0] * 10 }

data.each_with_index do |row, row_idx|
  row.each_with_index do |col, col_idx|
    print [row, row_idx, col, col_idx]
  end
end

# ---> Rows
# |
# |
# Columns

# Take one element at a time from string
x = xstr[0..0]
xs = xstr[1..-1]
y = ystr[0..0]
ys = ystr[1..-1]

# Edge boundary items in grid
# Edge boundary items in grid
n = 3
m = 4

n.times do |i|
  m.times do |j|
    if (i * j == 0 || i == n - 1 || j == m - 1)
      p [i, j]
    end
  end
end

# Knapsack core logic
return 0 if n.zero? || w.zero?

if wt[n - 1] <= w
  [(val[n - 1] + knapsack(wt, val, w - wt[n - 1], n - 1)), knapsack(wt, val, w, n - 1)].max
else
  knapsack(wt, val, w, n - 1)
end

# Knapsack memoized
t = array = (w + 1).times.collect { [-1] * (n + 1) }
# Store result in t[n][w] and read back if exists

# Knapsack top-down
# ---> w
# |
# |
# n

# In ruby set you can add value only once, if you try to add duplicate, it will return nil
require "set"
s1 = Set[]
s2 = Set[]

if s1.add?(5) && s1.add?(3)
  p "11"
end

if s2.add?(5) && s2.add?(5)
  p "22"
end

# >> "11"

names = %w{fred jess john}
ages = [38,76,91]

p names.zip(ages)

p Hash[names.zip(ages)]

# >> [["fred", 38], ["jess", 76], ["john", 91]]
# >> {"fred"=>38, "jess"=>76, "john"=>91}

false || true || false || true || false    # => true
false || false || false || false || false  # => false
false && true && false && true && false    # => false
true && true                               # => true

x = [1, 1, 2, 4]
y = [1, 2, 2, 2]

# intersection
x & y # => [1, 2]

# union
x | y # => [1, 2, 4]

# difference
x - y            # => [4]


nums = [[1, 2, 3], [4, 5, 6]]
p nums.transpose
p nums.transpose.map(&:sum)

# >> [[1, 4], [2, 5], [3, 6]]
# >> [5, 7, 9]

require 'logger'
logger       = Logger.new(STDOUT)
logger.error("Took longer than #{timeout} to #{message.inspect}")
```


# frozen_string_literal: true

# Name	Binary Size	String Size	Features
# UUID	16 bytes	36 chars	configuration free, not sortable
# shortuuid	16 bytes	22 chars	configuration free, not sortable
# Snowflake	8 bytes	up to 20 chars	needs machin/DC configuration, needs central server, sortable
# MongoID	12 bytes	24 chars	configuration free, sortable
# xid	12 bytes	20 chars	configuration free, sortable

# Xid implementatin in Ruby
require 'socket'
require 'securerandom'
require 'date'

class Xid
  RAW_LEN = 12

  @@generator = nil

  def initialize(id = nil)
    @@generator ||= Generator.new(init_rand_int, real_machine_id)
    @value = id || @@generator.generate.unpack('C12')
  end

  def next
    @string = nil
    @value = @@generator.generate.unpack('C12')
    string
  end

  attr_reader :value

  def pid
    # type: () -> int
    (value[7] << 8 | value[8])
  end

  def counter
    # type: () -> int
    value[9] << 16 | value[10] << 8 | value[11]
  end

  def machine
    # type: () -> str
    value[4..6].map(&:chr).join('')
  end

  def datetime
    Time.at(time).to_datetime
  end

  def time
    # type: () -> int
    value[0] << 24 | value[1] << 16 | value[2] << 8 | value[3]
  end

  def inspect
    "Xid('#{string}')"
  end

  def to_s
    string
  end

  def bytes
    # type: () -> str
    @value.pack('c12')
  end

  def ==(other)
    # type: (Xid) -> bool
    to_s == other.to_s
  end

  def <(other)
    # type: (Xid) -> bool
    to_s < other.to_s
  end

  def >(other)
    # type: (Xid) -> bool
    to_s > other.to_s
  end

  def self.from_string(str)
    raise 'Invalid Xid' if str.nil? || !str.match(/^[a-v0-9]{20}$/i)

    val = Base32.b32decode(str)
    value_check = val.select { |x| x >= 0 && x <= 255 }

    (value_check.length..RAW_LEN - 1).each do |i|
      value_check[i] = false
    end

    raise 'Invalid Xid' unless value_check.all?

    Object.const_get(name).new(val)
  end

  private

  def string
    # type: () -> str
    @string ||= Base32.b32encode(value)
  end

  def init_rand_int
    # type: () -> int
    SecureRandom.random_number(16_777_215)
  end

  def real_machine_id
    # type: () -> int
    Digest::MD5.digest(Socket.gethostname).unpack1('N')
  rescue StandardError
    init_rand_int
  end

  # Xid Generator
  class Generator
    attr_accessor :value

    def initialize(rand_val = nil, machine_id = 0)
      @mutex = Mutex.new
      @rand_int = rand_val || rand(65_535)
      @pid = Process.pid
      @machine_id = machine_id
    end

    def generate
      # () -> str
      @mutex.synchronize do
        @rand_int += 1
      end
      [::Time.new.to_i, @machine_id, @pid, @rand_int << 8].pack('N NX n NX')
    end
  end
end

class Xid::Base32
  # 0123456789abcdefghijklmnopqrstuv - Used for encoding
  ENCODE_HEX = %w[0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j
                  k l m n o p q r s t u v].freeze
  TRIM_LEN = 20

  # Start class methods
  class << self
    def decode_hex_map
      Hash[ENCODE_HEX.each_with_index.map { |x, i| [x, i] }]
    end

    def b32encode(src)
      encode(src)
    end

    def b32decode(src)
      decode(src, ENCODE_HEX)
    end

    def encode(id)
      dst = []
      dst[19] = ENCODE_HEX[(id[11] << 4) & 0x1f]
      dst[18] = ENCODE_HEX[(id[11] >> 1) & 0x1f]
      dst[17] = ENCODE_HEX[(id[11] >> 6) & 0x1f | (id[10] << 2) & 0x1f]
      dst[16] = ENCODE_HEX[id[10] >> 3]
      dst[15] = ENCODE_HEX[id[9] & 0x1f]
      dst[14] = ENCODE_HEX[(id[9] >> 5) | (id[8] << 3) & 0x1f]
      dst[13] = ENCODE_HEX[(id[8] >> 2) & 0x1f]
      dst[12] = ENCODE_HEX[id[8] >> 7 | (id[7] << 1) & 0x1f]
      dst[11] = ENCODE_HEX[(id[7] >> 4) & 0x1f | (id[6] << 4) & 0x1f]
      dst[10] = ENCODE_HEX[(id[6] >> 1) & 0x1f]
      dst[9] = ENCODE_HEX[(id[6] >> 6) & 0x1f | (id[5] << 2) & 0x1f]
      dst[8] = ENCODE_HEX[id[5] >> 3]
      dst[7] = ENCODE_HEX[id[4] & 0x1f]
      dst[6] = ENCODE_HEX[id[4] >> 5 | (id[3] << 3) & 0x1f]
      dst[5] = ENCODE_HEX[(id[3] >> 2) & 0x1f]
      dst[4] = ENCODE_HEX[id[3] >> 7 | (id[2] << 1) & 0x1f]
      dst[3] = ENCODE_HEX[(id[2] >> 4) & 0x1f | (id[1] << 4) & 0x1f]
      dst[2] = ENCODE_HEX[(id[1] >> 1) & 0x1f]
      dst[1] = ENCODE_HEX[(id[1] >> 6) & 0x1f | (id[0] << 2) & 0x1f]
      dst[0] = ENCODE_HEX[id[0] >> 3]

      dst.join('')
    end

    def decode(src, _str_map)
      src.downcase!

      end_loop = false
      result = []
      while src && !src.empty? && !end_loop
        dst = [0] * 5
        dbuf = [0] * 8
        src_len = 8

        9.times do |i|
          if i >= src.length
            src_len = i
            end_loop = true
            break
          end
          char = src[i]
          dbuf[i] = decode_hex_map[char]
        end

        dst[4] = (dbuf[6] << 5) | (dbuf[7]) if src_len >= 8
        dst[3] = (dbuf[4] << 7) | (dbuf[5] << 2) | (dbuf[6] >> 3) if src_len >= 7
        dst[2] = (dbuf[3] << 4) | (dbuf[4] >> 1) if src_len >= 5
        dst[1] = (dbuf[1] << 6) | (dbuf[2] << 1) | (dbuf[3] >> 4) if src_len >= 4
        dst[0] = (dbuf[0] << 3) | (dbuf[1] >> 2) if src_len >= 2

        dst = dst.map { |x| x & 0xff }

        if src_len == 2
          dst = dst[0]
        elsif src_len == 4
          dst = dst[0..1]
        elsif src_len == 5
          dst = dst[0..2]
        elsif src_len == 7
          dst = dst[0..3]
        elsif src_len == 8
          dst = dst[0..4]
        end

        result += dst
        src = src[8..src.length]
      end

      result
    end
  end
  # END - Class methods
end

guid = Xid.new
pp guid.to_s
pp guid.next

# Alternative encoding lib

require "base32"

encoded = Base32.encode("chunky bacon!")  #==> "MNUHK3TLPEQGEYLDN5XCC==="
decoded = Base32.decode(encoded)          #==> "chunky bacon!"

puts %("#{decoded}" is "#{encoded}" in base32)

# >> "cctqj9g0edis5fb429tg"
# >> "cctqj9g0edis5fb429u0"
# >> "chunky bacon!" is "MNUHK3TLPEQGEYLDN5XCC===" in base32

# One file ruby script

require 'bundler/inline'
require 'active_record'
require 'sqlite3'

gemfile do
  source 'https://rubygems.org'
  gem 'json', require: false
  gem 'activerecord', '~> 5.0', '>= 5.0.0.1'
  gem 'sqlite3', '~> 1.4'
  gem 'pry'
end

puts 'Gems installed and loaded!'

# # Connect to an in-memory sqlite3 database
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# # Define a minimal database schema
ActiveRecord::Schema.define do
  create_table :shows, force: true do |t|
    t.string :name
  end

  create_table :episodes, force: true do |t|
    t.string :name
    t.belongs_to :show, index: true
  end
end

# # Define the models
class Show < ActiveRecord::Base
  has_many :episodes, inverse_of: :show
end

class Episode < ActiveRecord::Base
  belongs_to :show, inverse_of: :episodes, required: true
end

# # Create a few records...
show = Show.create!(name: 'Big Bang Theory')
pp "show"
pp show

first_episode = show.episodes.create!(name: 'Pilot')
second_episode = show.episodes.create!(name: 'The Big Bran Hypothesis')

episode_names = show.episodes.pluck(:name)

puts "#{show.name} has #{show.episodes.size} episodes named #{episode_names.join(', ')}."
# # =>

# Start of ./interview/company/PhonePe/design_file_system.rb
class FileSystem
  attr_reader :cache

  def initialize
    @cache = { '/' => -1 }
  end

  def create_path(path, value)
    return false if cache[path]
    return false unless cache['/' + path.split('/')[1..-2].join('/')]

    @cache[path] = value
    true
  end

  def get(path)
    cache.fetch(path, -1)
  end
end

fs = FileSystem.new
pp fs.create_path("/leet", 1)
pp fs.create_path("/leet/code", 5)
pp fs.get("/leet/code")


# Start of ./interview/company/PhonePe/read_data_from_file.rb
require 'open-uri'

class WordsProvider
  DATABASE_URL = "http://seriousorange.com/words.txt"
  DATABASE_PATH = "words.txt"

  def random_word
    ensure_database
    all_words.sample
  end

  def all_words
    ensure_database
    File.read(DATABASE_PATH).split
  end

  private

  def ensure_database
    File.write(DATABASE_PATH, open(DATABASE_URL).read) unless File.exist?(DATABASE_PATH)
  end
end

# Start of ./interview/company/PhonePe/queue.rb
require 'test/unit'

class Queue
  Node = Struct.new :element, :next

  attr_reader :head, :tail, :size

  def initialize(items = [])
    @head = nil
    @tail = nil
    @size = 0

    items.to_a.each { |element| enqueue element }
  end

  def enqueue(element)
    n = Node.new element, nil
    if @tail
      @tail.next = n
      @tail = n
    else
      @head = @tail = n
    end
    @size += 1
    element
  end

  alias << enqueue
  alias push enqueue

  def dequeue
    return nil unless @head

    n = @head
    if @size == 1
      clear
      return n.element
    end

    @head = n.next
    @size -= 1
    n.element
  end

  alias pop dequeue

  def front
    @head.element
  end

  def back
    @tail.element
  end

  def empty?
    @size.zero?
  end

  def clear
    @head = nil
    @tail = nil
    @size = 0
  end

  def each
    return unless @head

    n = @head
    while n
      yield n.element
      n = n.next
    end
  end
end

# # if __FILE__ == $0
# end
class TestQueue < Test::Unit::TestCase
  def setup
    @queue = Queue.new
  end

  def teardown
    @queue.clear
  end

  def test_simple
    element = 1
    @queue.enqueue element

    assert_equal element, @queue.front
    assert_equal 1, @queue.size
    assert !@queue.empty?

    assert_equal element, @queue.dequeue
    assert_equal 0, @queue.size
    assert @queue.empty?
  end
end

queue = Queue.new
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)
queue.enqueue(4)
# queue.each do |n|
#   pp n
# end
pp queue.dequeue

pp "should"
queue.each do |n|
  pp n
end

# >> 1
# >> "should"
# >> 2
# >> 3
# >> 4
# >> Loaded suite queue
# >> Started
# >> .
# >> Finished in 0.00041 seconds.
# >> -------------------------------------------------------------------------------
# >> 1 tests, 6 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
# >> 100% passed
# >> -------------------------------------------------------------------------------
# >> 2439.02 tests/s, 14634.15 assertions/s

# Start of ./interview/company/upgrad_wolves/wolves.rb
def recursive_keys(data)
  data.keys + data.values.map { |value| recursive_keys(value) if value.is_a?(Hash) }
end

def all_keys(data)
  result = []
  data.each do |key, value|
    if value.is_a?(Hash)
      value.each do |child_key, child_value|
        keys = recursive_keys(child_value).flatten.compact.uniq
        result << if keys == []
                    "#{key}.#{child_key}"
                  else
                    "#{key}.#{child_key}.#{keys.join('.')}"
                  end
      end
    else
      result << key
    end
  end
  result.reverse
end

# Start of ./interview/company/upgrad_wolves/coderbyte/fiormatted_number.rb
# Not working

def FormattedNumber(strArr)
  # Splitting string by commas
  l = strArr[0].split(",")

  # Traversing through list l
  for i in (0..l.length - 1)

    # Checking for 2 adjacent commas and more than 3 numbers between 2 commas
    return "false" if l[i].length.zero?

    # Splitting element by decimal
    f = l[i].split(".")

    # Making sure decimal is not placed at the start or end of the element
    return "false" if f[0].length.zero? || f[-1].length.zero?

    # Checking first element
    if i.zero?

      # Making sure not more than 1 decimal is placed
      return "false" if f.length > 2

      # Making sure there are only 3 digits before decimal
      return "false" if f[0].length > 3

    # Checking for last element
    elsif i == (l.length - 1) && l.length > 1

      # Making sure not more than 1 decimal is placed
      return "false" if f.length > 2

      # Making sure decimal is placed after 3 digits
      return "false" if f[0].length != 3

    # Checking middle elements
    else

      # Making sure no decimal is placed
      return "false" if f.length > 1

      # Making sure element length is 3 only
      return "false" if l[i].length != 3
    end
  end

  # Returning "true" if all the commas and decimals are placed correctly
  "true"
end

pp FormattedNumber "1,093,222.04"
pp FormattedNumber "2,567.00.2"

# >> "true"
# >> "true"

# Start of ./interview/company/upgrad_wolves/coderbyte/longest_word.rb
def LongestWordLength(str) 
    
    n = str.length()
    res = 0 
    curr_len = 0
    
    for i in (0..n-1)     
        # If current character is
        # not end of current word.
        if (str[i] != ' ') 
            curr_len += 1
        # If end of word is found
        else
            res = [res, curr_len].max()
            curr_len = 0
        end
    end
    
    # We do max one more time to consider
    # last word as there won't be any space
    # after last word.
    return [res, curr_len].max()
 end
 
# Driver Code
s = "I am an intern at geeksforgeeks"
p (LongestWordLength(s))

# >> 13
# Start of ./interview/company/upgrad_wolves/coderbyte/seating_arrangement.rb
def SeatingStudents(arr)  
    K = arr[0]
    occupied = arr[1...]
    
    rows = K/2.to_i
    
    seats = []
    x = 0
    
    for i in (0..rows-1) 
      seats.push([])
      for j in (0..1) 
        if occupied.include? x + 1 
          full_seat = true
        else
          full_seat = false
        end
        seats[i].push(String(full_seat))
        x+=1
      end
    end
    
    seating = 0
    for i in (0..rows-1-1) 
      if((seats[i][0] == String(false)) && (seats[i][1] == String(false))) 
        seating+=1
      end
      
      if((seats[i][0] == String(false)) && (seats[i+1][0] == String(false))) 
        seating+=1
      end
      
      if((seats[i][1] == String(false)) && (seats[i + 1][1] == String(false))) 
        seating+=1
      end
    end
    
    if((seats[rows - 1][0] == String(false)) && (seats[rows - 1][1] == String(false))) 
      seating+=1
    end
    return seating
  end
  
  pp seating_students([12, 2, 3, 6, 7, 10, 11])
  
  # Start of ./interview/company/upgrad_wolves/coderbyte/stock_picker.rb
def StockPicker(arr)
    cost = 0
    maxcost = 0
  
    mini = arr[0]
    arr.length.times do |i|
      mini = [mini, arr[i]].min
      cost = arr[i] - mini
      maxcost = [maxcost, cost].max
    end
  
    maxcost
  end
  
  p StockPicker([10, 12, 4, 5, 9])
  # Start of ./interview/company/upgrad_wolves/coderbyte/html_tags.rb
def html_elements(string)
  open_tags = %w[b i em div p]
  close_tags = ['/b', '/i', '/em', '/div', '/p']

  stack = []

  tags = string.scan(%r{[(/)*a-z]+})
  pp ["tags", tags]
  tags.each do |tag|
    if open_tags.include? tag
      stack.push(tag)
    elsif close_tags.include? tag
      check = close_tags.find_index(tag)
      stack.pop if stack.length.positive? && (open_tags[check] == stack[stack.length - 1])
    end
  end
  if stack
    pp ["stack", stack]
    return stack[-1]
  end

  true
end

pp html_elements '<div><div><b></b></div></p>'

# >> ["tags", ["div", "div", "b", "/b", "/div", "/p"]]
# >> ["stack", ["div"]]
# >> "div"

# Start of ./interview/company/opendoor/code.rb
data = {
  "2016-baby-center-girls" => ["Sophia", "Emma", "Olivia", "Ava", "Mia", "Isabella", "Riley", "Aria", "Zoe", "Charlotte", "Lily", "Layla", "Amelia", "Emily", "Madelyn", "Aubrey", "Adalyn", "Madison", "Chloe", "Harper", "Abigail", "Aaliyah", "Avery", "Evelyn", "Kaylee", "Ella", "Ellie", "Scarlett", "Arianna", "Hailey", "Nora", "Addison", "Brooklyn", "Hannah", "Mila", "Leah", "Elizabeth", "Sarah", "Eliana", "Mackenzie", "Peyton", "Maria", "Grace", "Adeline", "Elena", "Anna", "Victoria", "Camilla", "Lillian", "Natalie"],
  "2016-baby-center-boys" => ["Jackson", "Aiden", "Lucas", "Liam", "Noah", "Ethan", "Mason", "Caden", "Oliver", "Elijah", "Grayson", "Jacob", "Michael", "Benjamin", "Carter", "James", "Jayden", "Logan", "Alexander", "Caleb", "Ryan", "Luke", "Daniel", "Jack", "William", "Owen", "Gabriel", "Matthew", "Connor", "Jayce", "Isaac", "Sebastian", "Henry", "Muhammad", "Cameron", "Wyatt", "Dylan", "Nathan", "Nicholas", "Julian", "Eli", "Levi", "Isaiah", "Landon", "David", "Christian", "Andrew", "Brayden", "John", "Lincoln"],
  "2015-baby-center-girls" => ["Sophia", "Emma", "Olivia", "Ava", "Mia", "Isabella", "Zoe", "Lily", "Emily", "Madison", "Amelia", "Riley", "Madelyn", "Charlotte", "Chloe", "Aubrey", "Aria", "Layla", "Avery", "Abigail", "Harper", "Kaylee", "Aaliyah", "Evelyn", "Adalyn", "Ella", "Arianna", "Hailey", "Ellie", "Nora", "Hannah", "Addison", "Mackenzie", "Brooklyn", "Scarlett", "Anna", "Mila", "Audrey", "Isabelle", "Elizabeth", "Leah", "Sarah", "Lillian", "Grace", "Natalie", "Kylie", "Lucy", "Makayla", "Maya", "Kaitlyn"],
  "2015-baby-center-boys" => ["Jackson", "Aiden", "Liam", "Lucas", "Noah", "Mason", "Ethan", "Caden", "Logan", "Jacob", "Jayden", "Oliver", "Elijah", "Alexander", "Michael", "Carter", "James", "Caleb", "Benjamin", "Jack", "Luke", "Grayson", "William", "Ryan", "Connor", "Daniel", "Gabriel", "Owen", "Henry", "Matthew", "Isaac", "Wyatt", "Jayce", "Cameron", "Landon", "Nicholas", "Dylan", "Nathan", "Muhammad", "Sebastian", "Eli", "David", "Brayden", "Andrew", "Joshua", "Samuel", "Hunter", "Anthony", "Julian", "Dominic"],
  "2015-us-official-girls" => ["Emma", "Olivia", "Sophia", "Ava", "Isabella", "Mia", "Abigail", "Emily", "Charlotte", "Harper"],
  "2015-us-official-boys" => ["Noah", "Liam", "Mason", "Jacob", "William", "Ethan", "James", "Alexander", "Michael", "Benjamin"],
}

def solve(data)
  processed_data = {}
  data.each do |key, val|
    val.each_with_index do |name, idx|
      index = idx + 1
      if processed_data.has_key? name.downcase
        processed_data[name.downcase][0].insert(index, key.downcase)
        processed_data[name.downcase][1].insert(index + 1, idx + 1)
      else
        processed_data[name.downcase] = [[].insert(index, [key.downcase]), [].insert(index, [idx + 1])]
      end
    end
  end
  processed_data
end

processed_data = solve(data)
result = processed_data["sophia"]
p result[0].compact.zip(result[1].compact)

result = processed_data["nicholas"]
p result[0].compact.zip(result[1].compact)

# >> [["2015-baby-center-girls", [1]], [["2016-baby-center-girls"], 1], ["2015-us-official-girls", 3]]
# >> [["2015-baby-center-boys", 36], [["2016-baby-center-boys"], [39]]]

# Start of ./interview/company/deliveroo_karat/lowest_common_ancestor_binary_tree.rb
# The initial return conditions return a truthy value if there is a match and a falsey value if you have hit the bottom of the branch.
# The initial return conditions cover the case where a root is its own ancestor/descendant.

def lowest_common_ancestor(root, p, q)
  return root if !root || root == p || root == q

  left = lowest_common_ancestor(root.left, p, q)
  right = lowest_common_ancestor(root.right, p, q)
  return right unless left
  return left unless right

  root
end

# Start of ./interview/company/deliveroo_karat/max_length_repeated_subarray.rb
# @param {Integer[]} a
# @param {Integer[]} b
# @return {Integer}
def find_length(a, b)
  n = a.length
  m = b.length
  dp = Array.new(n + 1, 0) { Array.new(m + 1, 0) }
  max_len = 0
  for i in 1..n
    for j in 1..m
      if a[i - 1] == b[j - 1]
        dp[i][j] = 1 + (dp[i - 1][j - 1])
        max_len = [max_len, dp[i][j]].max
      end
    end
  end
  max_len
end

# Start of ./interview/company/deliveroo_karat/decode_string.rb
def decode_string(s)
  stack = []
  s.each_char do |c|
    if c == "]"
      s1 = ""
      while stack.last != "["
        s1 = stack.pop + s1
      end
      stack.pop # remove '['
      n = ""
      while !stack.empty? && stack.last.match?(/[0-9]/) # eg. "100[leetcode]"
        n = stack.pop + n
      end
      stack.push(s1 * n.to_i)
    else
      stack.push(c)
    end
  end
  stack.join
end

# Start of ./interview/company/deliveroo_karat/subdomain_visit_count.rb
# Leetcode: 811. Subdomain Visit Count.
# https://leetcode.com/problems/subdomain-visit-count/
# Runtime: 60 ms, faster than 100.00% of Ruby online submissions for Subdomain Visit Count.
# Memory Usage: 9.8 MB, less than 100.00% of Ruby online submissions for Subdomain Visit Coun
# @param {String[]} cpdomains
# @return {String[]}
def subdomain_visits(cpdomains)
  h = {} # hash that going to count domains.
  cpdomains.each do |x|
    number, domain = x.split(" ")
    number = number.to_i
    domain = domain.split(?.)
    while !domain.empty?
      str = domain.join(?.)
      h[str] ||= 0
      h[str] += number
      domain.shift
    end
  end
  h.to_a.map { |x| "#{x[1]} #{x[0]}" }
end

cpdomains = ["900 google.mail.com", "50 yahoo.com", "1 intel.mail.com", "5 wiki.org"]

p subdomain_visits(cpdomains)

# >> ["900 google.mail.com", "901 mail.com", "951 com", "50 yahoo.com", "1 intel.mail.com", "5 wiki.org", "5 org"]

# Start of ./interview/company/deliveroo_karat/valid_sudoku.rb
def is_valid_sudoku(board)
  boxes = Array.new(3) { Array.new(3) { Set.new } }
  rows = Array.new(9) { Set.new }
  cols = Array.new(9) { Set.new }

  board.each_with_index do |array, row|
    array.each_with_index do |num, col|
      next if num == "."
      return false unless boxes[row / 3][col / 3].add?(num) && rows[row].add?(num) && cols[col].add?(num)
    end
  end
  true
end

# Start of ./interview/company/deliveroo_karat/hit_counter.rb
class HitCounter
  def initialize()
    @hash = {}
  end

  def hit(timestamp)
    @hash[timestamp] ||= 0
    @hash[timestamp] += 1
  end

  def get_hits(timestamp)
    count = 0
    (timestamp - 299..timestamp).each do |time|
      count += @hash[time] if @hash[time]
    end
    count
  end
end

# Start of ./interview/company/deliveroo_karat/word_search.rb
require "set"

def dfs(board, word, i, j)
  return true if word == ""
  return false if i.negative? || j.negative? || i >= board.length || j >= board[0].length || board[i][j] != word[0]

  temp = board[i][j]
  board[i][j] = "#"
  word = word[1..-1]

  return true if dfs(board, word, i - 1, j)
  return true if dfs(board, word, i, j - 1)
  return true if dfs(board, word, i + 1, j)
  return true if dfs(board, word, i, j + 1)

  board[i][j] = temp
  false
end

def exist(board, word)
  return false if board.flatten.uniq.length < word.split("").uniq.length

  (0...board.length).each do |i|
    (0...board[0].length).each do |j|
      return true if dfs(board, word, i, j)
    end
  end
  false
end

board = [["A", "B", "C", "E"], ["S", "F", "C", "S"], ["A", "D", "E", "E"]]
word = "ABCCED"
p exist(board, word)

# >> true

# Start of ./interview/company/deliveroo_karat/same_card_3_times_in_one_hour.rb
def alert_names(key_name, key_time)
  alerts_hash = Hash.new([])

  key_name.each_with_index do |name, index|
    alerts_hash[name] += [parse_time(key_time[index])]
  end

  result = []

  alerts_hash.each do |name, times|
    break if times.length < 3
    sorted_times = times.sort

    (2..sorted_times.length - 1).each do |i|
      distance = sorted_times[i] - sorted_times[i - 2]

      if distance <= 60
        result << name
        break
      end
    end
  end

  result.sort
end

def parse_time(time)
  hours, minutes = time.split(":")
  hours.to_i * 60 + minutes.to_i
end

# Start of ./interview/company/deliveroo_karat/course_schedule_2.rb
def find_order(num_courses, prerequisites)
  indegree = Hash.new(0)
  adj_list = Hash.new()

  num_courses.times do |i|
    indegree[i] = 0
    adj_list[i] = []
  end

  prerequisites.each do |i, o|
    indegree[i] += 1
    adj_list[o] << i
  end

  stack = []
  indegree.each do |d, c|
    stack.push(d) if c == 0
  end

  arr = []
  until stack.empty?
    d = stack.pop
    arr << d
    adj_list[d].each do |c|
      indegree[c] -= 1
      stack << c if indegree[c] == 0
    end
  end
  arr.size == num_courses ? arr : []
end

# Start of ./interview/company/deliveroo_karat/count_char.rb
def count_characters(words, chars)
  value = 0
  chars_counts = Hash.new(0)
  chars.chars.each { |char| chars_counts[char] += 1 }

  words.each do |word|
    word_chars = word.chars
    available_chars = chars_counts.dup
    value += word_chars.size if can_form_word?(word_chars, available_chars)
  end

  value
end

def can_form_word?(word_chars, available_chars)
  word_chars.each do |char|
    available_chars[char] -= 1
    return false unless available_chars[char] >= 0
  end
  true
end

array = ["cat", "bt", "hat", "tree"]
chars = "atach"

p count_characters(array, chars)

# >> 6

# Start of ./interview/company/deliveroo_karat/no_of_islands.rb
def countislands(land)
  rows = land.length
  cols = land[0].length
  if rows.zero?
    0
  else
    islands = 0
    for i in 0...rows
      for j in 0...cols
        if land[i][j] == 1
          marknearby(land, i, j, rows, cols)
          islands += 1
        end
      end
    end
    islands
  end
end

def marknearby(land, i, j, rows, cols)
  return if i >= rows || i < 0 || j >= cols || j < 0 || land[i][j] != 1

  land[i][j] = 2
  marknearby(land, i - 1, j, rows, cols)
  marknearby(land, i + 1, j, rows, cols)
  marknearby(land, i, j - 1, rows, cols)
  marknearby(land, i, j + 1, rows, cols)
end

land = [
  [1, 1, 0, 0, 0],
  [1, 1, 0, 0, 0],
  [0, 0, 1, 0, 0],
  [0, 0, 0, 1, 1],
]

p countislands(land)
p land

# >> 3
# >> [[2, 2, 0, 0, 0], [2, 2, 0, 0, 0], [0, 0, 2, 0, 0], [0, 0, 0, 2, 2]]

# Start of ./interview/company/deliveroo_karat/word_search_2.rb
def build_trie(words)
  trie = {}
  words.each do |word|
    node = trie
    word.each_char do |c|
      node[c] ||= {}
      node = node[c]
    end
    node[:word] = word
  end
  trie
end

def find_words(board, words)
  m = board.size
  n = board[0].size

  trie = build_trie(words)
  output = []
  (0..m - 1).each do |i|
    (0..n - 1).each do |j|
      if trie[board[i][j]]
        dfs(board, i, j, trie, output)
      end
    end
  end
  output
end

def dfs(board, i, j, parent, output)
  return if i < 0 || i >= board.size || j < 0 || j >= board[0].size

  letter = board[i][j]
  current = parent[letter]
  return unless current

  output << current.delete(:word) if current[:word]

  board[i][j] = "#"

  row = [0, -1, 0, 1]
  col = [1, 0, -1, 0]

  4.times do |d|
    dfs(board, i + row[d], j + col[d], current, output)
  end
  board[i][j] = letter
  parent.delete(letter) if current.empty?
end

board = [["o", "a", "a", "n"], ["e", "t", "a", "e"], ["i", "h", "k", "r"], ["i", "f", "l", "v"]]
words = ["oath", "pea", "eat", "rain"]
p find_words(board, words)

# >> {"o"=>{"a"=>{"t"=>{"h"=>{:word=>"oath"}}}}, "p"=>{"e"=>{"a"=>{:word=>"pea"}}}, "e"=>{"a"=>{"t"=>{:word=>"eat"}}}, "r"=>{"a"=>{"i"=>{"n"=>{:word=>"rain"}}}}}
# >> ["oath", "eat"]

# Start of ./interview/company/deliveroo_karat/flood_fill.rb
def flood_fill(image, sr, sc, new_color)
  color = image[sr][sc]
  image[sr][sc] = new_color
  return image if color == new_color #if no painting req

  flood_fill(image, sr - 1, sc, new_color) if sr > 0 && image[sr - 1][sc] == color
  flood_fill(image, sr, sc - 1, new_color) if sc > 0 && image[sr][sc - 1] == color
  flood_fill(image, sr + 1, sc, new_color) if sr + 1 < image.size && image[sr + 1][sc] == color
  flood_fill(image, sr, sc + 1, new_color) if sc + 1 < image[0].size && image[sr][sc + 1] == color

  image
end

image = [[0, 0, 0], [0, 0, 0]], sr = 0, sc = 0, color = 0

print flood_fill(image, sr, sc, color)

# >> [[0, 0], 0, 0, 0]

# Start of ./interview/company/deliveroo_karat/text_justification.rb
def full_justify(words, max_width)
  res = []
  line = []
  length = 0
  (0...words.length).each do |i|
    # reached end of line
    if length + words[i].length > max_width
      res.push(full_justify_line(line, max_width))
      length = 0
      line = []
    end
    line.push(words[i])
    length += words[i].length + 1
  end
  res.push(left_justify_line(line, max_width))
  res
end

def left_justify_line(line, max_width)
  res = ""
  line[0...-1].each do |word|
    res.concat(word + " ")
  end
  res.concat(line[-1])
  right_padding = max_width - res.length
  res.concat(" " * right_padding)
  res
end

def full_justify_line(line, max_width)
  if line.length == 1
    return left_justify_line(line, max_width)
  end
  gaps = line.length - 1
  char_length = 0
  line.each { |word| char_length += word.length }
  spaces = max_width - char_length

  even_spaces = spaces / gaps
  odd_spaces = spaces % gaps

  res = ""
  line[0...-1].each do |word|
    res.concat(word)
    res.concat(" " * even_spaces)
    if odd_spaces > 0
      res.concat(" ")
      odd_spaces -= 1
    end
  end
  res.concat(line[-1])
  res
end

# Start of ./interview/company/deliveroo_karat/shortest_path_binary_matrix.rb
def shortest_path_binary_matrix(grid)
  return -1 if grid[0][0] == 1 || grid[grid.size - 1][grid.size - 1] == 1

  queue = [[0, 0, 1]]
  while (x, y, move = queue.shift)
    return move if x == grid.size - 1 && y == grid.size - 1

    moveset(x, y).each do |new_x, new_y|
      queue << [new_x, new_y, move + 1] if add_to_queue?(new_x, new_y, grid)
    end
  end
  -1
end

def add_to_queue?(x, y, grid)
  return false if x < 0 || y < 0 || x >= grid.size || y >= grid.size
  return false if grid[x][y] != 0
  grid[x][y] = 2
  true
end

def moveset(x, y)
  [[x + 1, y], [x - 1, y], [x + 1, y + 1], [x - 1, y - 1], [x + 1, y - 1], [x - 1, y + 1], [x, y - 1], [x, y + 1]]
end

grid = [[0, 1], [1, 0]]

p shortest_path_binary_matrix(grid)

# >> 2

# Start of ./interview/company/deliveroo_karat/contain_all_numbers.rb
def check_valid(matrix)
  (matrix + matrix.transpose).all? do |x|
    x.uniq.length == matrix.length
  end
end

matrix = [[1, 2, 3], [3, 1, 2], [2, 3, 1]]
p check_valid(matrix)

# >> true

# Start of ./interview/company/deliveroo_karat/find_all_zero.rb
def findend(i, j, a, output, index)
  x = a.length
  y = a[0].length
  # flag to check column edge case,
  # initializing with 0
  flagc = 0
  # flag to check row edge case,
  # initializing with 0
  flagr = 0
  (i..x).each do |m|
    # loop breaks where first 1 encounters
    if a[m][j] == 1
      flagr = 1 # set the flag
      return
    end
    # pass because already processed
    if a[m][j] == 5
      return
    end
    (j..y).each do |n|
      # loop breaks where first 1 encounters
      if a[m][n] == 1
        flagc = 1 # set the flag
        return
      end
      # fill rectangle elements with any
      # number so that we can exclude
      # next time
      a[m][n] = 5
    end
  end

  if flagr == 1
    output[index].append(m - 1)
  else
    # when end point touch the boundary
    output[index].append(m)
  end

  if flagc == 1
    output[index].append(n - 1)
  else
    # when end point touch the boundary
    output[index].append(n)
  end
end

def get_rectangle_coordinates(a)
  # output array where we are going
  # to store our output
  output = []
  # It will be used for storing start
  # and end location in the same index
  index = -1

  (0..(a.length - 1)).each do |i|
    (0..(a[0].length - 1)).each do |j|
      if a[i][j]&.zero?
        # storing initial position
        # of rectangle
        output.append([i, j])

        # will be used for the
        # last position
        index += 1
        findend(i, j, a, output, index)
      end
    end
  end
  p ["output", output]
end

# driver code
tests = [
  [1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 0, 0, 0, 1],
  [1, 0, 1, 0, 0, 0, 1],
  [1, 0, 1, 1, 1, 1, 1],
  [1, 0, 1, 0, 0, 0, 0],
  [1, 1, 1, 0, 0, 0, 1],
  [1, 1, 1, 1, 1, 1, 1],
]

p get_rectangle_coordinates(tests)

# >> ["output", [[2, 3], [3, 1], [3, 3], [4, 1], [5, 1], [5, 3]]]
# >> ["output", [[2, 3], [3, 1], [3, 3], [4, 1], [5, 1], [5, 3]]]

# Start of ./interview/company/deliveroo_karat/no_of_closed_island.rb
# Incorrect - Fix solution

# def countclosedislands(grid)
#   closed = 0
#   visited_areas = grid.length.times.collect { [0] * grid[0].length }
#   grid.length.times do |i|
#     grid[i].length.times do |j|
#       if grid[i][j].zero? && visited_areas[i][j].zero?
#         if checkArea(grid, visited_areas, i, j)
#           closed += 1
#         else
#           closed = 0
#         end
#       end
#     end
#   end
#   closed
# end

# def checkArea(grid, visited_areas, i, j)
#   closed = 1
#   if i >= 0 && i < (grid.length) && j >= 0 && j < (grid[0].length)
#     if grid[i][j].zero? && visited_areas[i][j].zero?
#       visited_areas[i][j] = 1
#       if i.zero? || i == (grid.length - 1) || j.zero? || j == (grid[0].length - 1)
#         closed = 0
#       end
#       closed = checkArea(grid, visited_areas, i - 1, j)
#       closed = checkArea(grid, visited_areas, i, j + 1)
#       closed = checkArea(grid, visited_areas, i + 1, j)
#       closed = checkArea(grid, visited_areas, i, j - 1)
#     end
#   end
#   closed
# end

# land = [
#   [1, 1, 1, 1, 0],
#   [1, 1, 0, 1, 1],
#   [0, 0, 1, 0, 1],
#   [0, 0, 0, 1, 1],
# ]

# p countclosedislands(land)
# p land

# # >> 4
# # >> [[1, 1, 1, 1, 0], [1, 1, 0, 1, 1], [0, 0, 1, 0, 1], [0, 0, 0, 1, 1]]

# Start of ./coding/dfs/diameter_binary_tree.rb

class Node
 attr_reader :value
 attr_accessor :left, :right
 def initialize(value)
  @value = value
  @left =nil
  @right =nil
 end
end

array = [2,4,5]

root = Node.new(2)
root.left = Node.new(4)
root.right = Node.new(5)

def diameter_of_binary_tree(root)
    @result = 1
    dfs(root)
    @result - 1 # result has number of nodes in longest path, -1 of the gives us edges
end

def dfs(node)
    return 0 if !node
    l, r = dfs(node.left), dfs(node.right)
    @result = [@result, l + r + 1].max

    [l, r].max + 1
end


p diameter_of_binary_tree(root)

# Start of ./coding/dfs/no_closed_island.rb
# @param {Integer[][]} grid
# @return {Integer}
def closed_island(grid)
  rows = grid.length
  cols = grid[0].length
  if rows == 0
    return 0
  else
    islands = 0
    for i in 1...rows-1
      for j in 1...cols-1
        if grid[i][j] == 0
          islands += 1 if marknearby(grid,i,j,rows,cols)
        end
      end
    end
    return islands
  end
end
def marknearby(land,i,j,rows,cols,closed_land=0)
  if land[i][j] != 0
    return true
  elsif (i == rows-1 || i == 0 || j == cols-1 || j == 0) &&land[i][j] == 0
    return false
  else
    land[i][j] = 2
    left = marknearby(land,i-1,j,rows,cols)
    right = marknearby(land,i+1,j,rows,cols)
    up = marknearby(land,i,j-1,rows,cols)
    down = marknearby(land,i,j+1,rows,cols)
    return left && right && up && down
  end
end

# Start of ./coding/dfs/path_sum_2.rb


class Node
 attr_reader :value
 attr_accessor :left, :right
 def initialize(value)
  @value = value
  @left =nil
  @right =nil
 end
end

RESULT = []
def count_path_sum(root=nil,sum=0)
	path_sum = 0
	path = []
	dfs(root, sum, path, path_sum)
end

def dfs(root, sum, path, path_sum)
	if root.nil?
	  return 0
	end

	path_sum += root.value

	if root.left.nil? && root.right.nil? && sum == path_sum
		temp = path + [root.value]
		RESULT << temp
	end
	path << root.value
	dfs(root.left, sum, path, path_sum)
	dfs(root.right, sum, path, path_sum)
	path_sum -= root.value
	path.pop
end

root = Node.new(5)
root.left = Node.new(4)
root.right = Node.new(8)
root.left.left = Node.new(11)
root.left.left.right = Node.new(2)
root.left.left.left = Node.new(7)
root.right.right = Node.new(4)
root.right.right.left = Node.new(5)
root.right.right.right = Node.new(1)
root.right.left = Node.new(13)
count_path_sum(root=root,sum=22)

p RESULT


# Start of ./coding/dfs/is_balanced.rb

def is_balanced(root=nil)
	dfs(root)
	true
rescue
	false
end

def dfs(root)
	return 0 if root.nil?

	left = dfs(root.left)
	right = dfs(root.right)

	if (left - right).abs > 1
		raise false
	end

	1 + [left, right].max
end

root = Node.new(1)
root.left = Node.new(2)
root.right = Node.new(12)
root.right.right = nil
root.right.left = nil
root.left.left = Node.new(3)
root.left.right = Node.new(13)
root.left.left.left = Node.new(4)
root.left.left.right = Node.new(14)

is_balanced(root=root)


# Start of ./coding/dfs/max_sum_path_any_node_to_any_node.rb
class Node
 attr_reader :val
 attr_accessor :left, :right
 def initialize(val)
  @val = val
  @left =nil
  @right =nil
 end
end

def max_path_sum(root)
    @result = -(1 << 64)
    dfs(root)
    @result
end

def dfs(node)
    return 0 if !node
    l, r = dfs(node.left), dfs(node.right)
    temp = [[l,r].max + node.val, node.val].max
    ans = [temp, l + r + node.val].max
    @result = [@result, ans].max
    return temp
end

p max_path_sum(root)

# Start of ./coding/sort/bubble_sort.rb
def bubble_sort(arr)
  return arr if arr.size < 2
  swap = true
  while swap
    swap = false
    (arr.length - 1).times do |x|
      if arr[x] > arr[x+1]
        arr[x], arr[x+1] = arr[x+1], arr[x]
        swap = true
      end
    end
  end
  arr
end

bubble_sort([3,2,4])

# Start of ./coding/sort/sort.rb
def bubble_sort(arr)
  return arr if arr.size < 2
  swap = true
  while swap
    swap = false
    (arr.length - 1).times do |x|
      if arr[x] > arr[x + 1]
        arr[x], arr[x + 1] = arr[x + 1], arr[x]
        swap = true
      end
    end
  end
  arr
end

bubble_sort([3, 2, 4])

def insertion_sort(array)
  (array.length).times do |j|
    while j > 0
      if array[j - 1] > array[j]
        array[j - 1], array[j] = array[j], array[j - 1]
      else
        break
      end
      pp array
      j -= 1
    end
  end
  array
end

array = [5, 4, 3, 4, 3, 0]
p insertion_sort(array)

# >> [4, 5, 3, 4, 3, 0]
# >> [4, 3, 5, 4, 3, 0]
# >> [3, 4, 5, 4, 3, 0]
# >> [3, 4, 4, 5, 3, 0]
# >> [3, 4, 4, 3, 5, 0]
# >> [3, 4, 3, 4, 5, 0]
# >> [3, 3, 4, 4, 5, 0]
# >> [3, 3, 4, 4, 0, 5]
# >> [3, 3, 4, 0, 4, 5]
# >> [3, 3, 0, 4, 4, 5]
# >> [3, 0, 3, 4, 4, 5]
# >> [0, 3, 3, 4, 4, 5]
# >> [0, 3, 3, 4, 4, 5]

def quick_sort(array, first, last)
  if first < last
    j = partition(array, first, last)
    quick_sort(array, first, j - 1)
    quick_sort(array, j + 1, last)
  end
  return array
end

def partition(array, first, last)
  pivot = array[last]
  pIndex = first
  i = first
  while i < last
    if array[i].to_i <= pivot.to_i
      array[i], array[pIndex] = array[pIndex], array[i]
      pIndex += 1
    end
    i += 1
  end
  array[pIndex], array[last] = array[last], array[pIndex]
  return pIndex
end

# Start of ./coding/sort/insertion_sort.rb
def insertion_sort(array)
  (array.length).times do |j|
    while j > 0
      if array[j - 1] > array[j]
        array[j - 1], array[j] = array[j], array[j - 1]
      else
        break
      end
      pp array
      j -= 1
    end
  end
  array
end

array = [5, 4, 3, 4, 3, 0]
p insertion_sort(array)

# >> [4, 5, 3, 4, 3, 0]
# >> [4, 3, 5, 4, 3, 0]
# >> [3, 4, 5, 4, 3, 0]
# >> [3, 4, 4, 5, 3, 0]
# >> [3, 4, 4, 3, 5, 0]
# >> [3, 4, 3, 4, 5, 0]
# >> [3, 3, 4, 4, 5, 0]
# >> [3, 3, 4, 4, 0, 5]
# >> [3, 3, 4, 0, 4, 5]
# >> [3, 3, 0, 4, 4, 5]
# >> [3, 0, 3, 4, 4, 5]
# >> [0, 3, 3, 4, 4, 5]
# >> [0, 3, 3, 4, 4, 5]

# Start of ./coding/sort/merge_sort.rb
def merge_sort(array)
  if array.length <= 1
    return array
  end

  array_size = array.length
  middle = (array.length / 2).round

  left_side = array[0...middle]
  right_side = array[middle...array_size]

  sorted_left = merge_sort(left_side)
  sorted_right = merge_sort(right_side)

  merge(array, sorted_left, sorted_right)

  return array
end

def merge(array, sorted_left, sorted_right)
  left_size = sorted_left.length
  right_size = sorted_right.length

  array_pointer = 0
  left_pointer = 0
  right_pointer = 0

  while left_pointer < left_size && right_pointer < right_size
    if sorted_left[left_pointer] < sorted_right[right_pointer]
      array[array_pointer] = sorted_left[left_pointer]
      left_pointer += 1
    else
      array[array_pointer] = sorted_right[right_pointer]
      right_pointer += 1
    end
    array_pointer += 1
  end

  while left_pointer < left_size
    array[array_pointer] = sorted_left[left_pointer]
    left_pointer += 1
    array_pointer += 1
  end

  while right_pointer < right_size
    array[array_pointer] = sorted_right[right_pointer]
    right_pointer += 1
    array_pointer += 1
  end

  return array
end

# Start of ./coding/sort/quick_sort.rb
def quick_sort(array, first, last)
  if first < last
    j = partition(array, first, last)
    quick_sort(array, first, j - 1)
    quick_sort(array, j + 1, last)
  end
  return array
end

def partition(array, first, last)
  pivot = array[last]
  pIndex = first
  i = first
  while i < last
    if array[i].to_i <= pivot.to_i
      array[i], array[pIndex] = array[pIndex], array[i]
      pIndex += 1
    end
    i += 1
  end
  array[pIndex], array[last] = array[last], array[pIndex]
  return pIndex
end

# Start of ./coding/hash_coding_questions/wolves_interview_print_key_dot_nested.rb
def recursive_keys(data)
    data.keys + data.values.map { |value| recursive_keys(value) if value.is_a?(Hash) }
  end
  
  def all_keys(data)
    result = []
    data.each do |key, value|
      if value.is_a?(Hash)
        value.each do |child_key, child_value|
          keys = recursive_keys(child_value).flatten.compact.uniq
          result << if keys == []
                      "#{key}.#{child_key}"
                    else
                      "#{key}.#{child_key}.#{keys.join('.')}"
                    end
        end
      else
        result << key
      end
    end
    result.reverse
end
  
data = {
    "a" => {
      "b" => {
        "c" => []
      },
      "d" => {}
    },
    "e" => "e",
    "f" => nil,
    "g" => -2
  }
  
pp all_keys(data)

# >> ["g", "f", "e", "a.d", "a.b.c"]
# Start of ./coding/hash_coding_questions/print_recursively_all_nested_keys.rb
data = {
  "a" => {
    "b" => {
      "c" => [],
    },
    "d" => {},
  },
  "e" => "e",
  "f" => nil,
  "g" => -2,
}

def recursive_keys(data)
  # data.keys + data.values.map { |value| recursive_keys(value) if value.is_a?(Hash) }
  data.keys + data.values.map { |i| recursive_keys(i) if i.is_a? Hash }
end

def all_keys(data)
  recursive_keys(data).flatten.compact.uniq
end

pp all_keys(data)

# >> ["a", "e", "f", "g", "b", "d", "c"]

# Start of ./coding/lcs/lcs_substring.rb
def longest_common_substring(text1, text2)
    dp = Array.new(text1.size + 1) { Array.new(text2.size + 1, 0) }
  
    1.upto(text1.size).each do |i|
      1.upto(text2.size).each do |j|
        dp[i][j] = if text1[i - 1] == text2[j - 1]
                     dp[i - 1][j - 1] + 1
                   else
                     #  [dp[i - 1][j], dp[i][j - 1]].max
                     0
                   end
      end
    end
  
    lcs = ""
  
    i = text1.size - 1
    j = text2.size - 1
    while i >= 0 && j >= 0
      if text1[i] == text2[j]
        lcs << text1[i]
        i -= 1
        j -= 1
      elsif dp[i - 1][j] > dp[i][j - 1]
        i -= 1
      elsif dp[i - 1][j] < dp[i][j - 1]
        j -= 1
      else
        i -= 1
        j -= 1
      end
    end
  
    pp ["lcs", lcs.reverse]
    lcs.length
  end
  
  p longest_common_substring("abathist", "hisathis")
  
  # >> ["lcs", "athis"]
  # >> 5
  
  # Start of ./coding/lcs/lcs_dp.rb
def longest_common_subsequence(text1, text2)
  dp = Array.new(text1.size + 1) { Array.new(text2.size + 1, 0) }

  1.upto(text1.size).each do |i|
    1.upto(text2.size).each do |j|
      dp[i][j] = if text1[i - 1] == text2[j - 1]
          dp[i - 1][j - 1] + 1
        else
          [dp[i - 1][j], dp[i][j - 1]].max
        end
    end
  end

  dp[text1.size][text2.size]
end

# Start of ./coding/lcs/longest_repeating_subsequence.rb
def longest_repeating_subsequence(text1, text2)
    dp = Array.new(text1.size + 1) { Array.new(text2.size + 1, 0) }
  
    1.upto(text1.size).each do |i|
      1.upto(text2.size).each do |j|
        dp[i][j] = if text1[i - 1] == text2[j - 1] && i != j
                     dp[i - 1][j - 1] + 1
                   else
                     [dp[i - 1][j], dp[i][j - 1]].max
                   end
      end
    end
   
    dp[text1.size][text2.size]
  end
  
  a = "AABEBCDD"
  pp longest_repeating_subsequence(a, a)
  
  # >> 3
  
  # Start of ./coding/lcs/lcs_recursive_memoized.rb
def longest_common_subsequence_1(text1, text2)
  memo = Array.new(text1.length) { Array.new(text2.length) }
  return helper(text1, text2, 0, 0, memo)
end

def helper(text1, text2, p1, p2, memo)
  return 0 if (p1 >= text1.length) || (p2 >= text2.length)

  return memo[p1][p2] if memo[p1][p2]

  if text1[p1] == text2[p2]
    memo[p1][p2] = 1 + helper(text1, text2, p1 + 1, p2 + 1, memo)
  else
    memo[p1][p2] = [helper(text1, text2, p1 + 1, p2, memo), helper(text1, text2, p1, p2 + 1, memo)].max
  end
end

def longest_common_subsequence_2(text1, text2)
  @memo = (text1.length + 1).times.collect { [nil] * (text2.length + 1) }
  @text1 = text1
  @text2 = text2
  return helper(@text1.length, @text2.length)
  @memo[@text1.length][@text2.length]
end

def helper(p1, p2)
  return 0 if (p1.zero?) || (p2.zero?)
  return @memo[p1][p2] if @memo[p1][p2]

  if @text1[p1 - 1] == @text2[p2 - 1]
    @memo[p1][p2] = 1 + helper(p1 - 1, p2 - 1)
  else
    @memo[p1][p2] = [helper(p1 - 1, p2), helper(p1, p2 - 1)].max
  end
end

p longest_common_subsequence("thisisatest", "testing123testing")

# Start of ./coding/lcs/longest_common_subsequence.rb
def longest_common_subsequence(text1, text2)
  dp = Array.new(text1.size + 1) { Array.new(text2.size + 1, 0) }

  1.upto(text1.size).each do |i|
    1.upto(text2.size).each do |j|
      dp[i][j] = if text1[i - 1] == text2[j - 1]
          dp[i - 1][j - 1] + 1
        else
          [dp[i - 1][j], dp[i][j - 1]].max
        end
    end
  end

  lcs = ""

  i = text1.size - 1
  j = text2.size - 1
  while i >= 0 && j >= 0
    if text1[i] == text2[j]
      lcs << text1[i]
      i -= 1
      j -= 1
    elsif dp[i - 1][j] > dp[i][j - 1]
      i -= 1
    elsif dp[i - 1][j] < dp[i][j - 1]
      j -= 1
    else
      i -= 1
      j -= 1
    end
  end

  pp ["lcs", lcs.reverse]
  dp[text1.size][text2.size]
end

p longest_common_subsequence("aebece", "acbcdce")

# Start of ./coding/lcs/lcs_recursive.rb
def lcs(xstr, ystr)
  return "" if xstr.empty? || ystr.empty?

  x = xstr[0..0]
  xs = xstr[1..-1]
  y = ystr[0..0]
  ys = ystr[1..-1]
  if x == y
    x + lcs(xs, ys)
  else
    [lcs(xstr, ys), lcs(xs, ystr)].max_by(&:size)
  end
end

p lcs("thisisatest", "testing123testing")

# >> "tsitest"


# Start of ./coding/lcs/shortest_common_super_sequence.rb
def shortest_common_supersequence(str1, str2)
    dp = Array.new(str1.size + 1) { Array.new(str2.size + 1, 0) }
  
    # for loop has advantage that it will set variables i and j
    for i in 1..str1.size # rubocop:disable Style/for
      for j in 1..str2.size # rubocop:disable Style/for
        dp[i][j] = if str1[i - 1] == str2[j - 1]
                     dp[i - 1][j - 1] + 1
                   else
                     [dp[i - 1][j], dp[i][j - 1]].max
                   end
      end
    end
  
    lcs = []
    while i.positive? && j.positive?
      if str1[i - 1] == str2[j - 1]
        lcs << str1[i - 1]
        i -= 1
        j -= 1
      elsif dp[i - 1][j] < dp[i][j - 1]
        lcs << str2[j - 1]
        j -= 1
      elsif dp[i - 1][j] > dp[i][j - 1]
        lcs << str1[i - 1]
        i -= 1
      end
    end
  
    while i.positive?
      lcs << str1[i - 1]
      i -= 1
    end
  
    while j.positive?
      lcs << str2[j - 1]
      j -= 1
    end
  
    pp ["lcs", lcs.reverse.join]
  end
  
  p shortest_common_supersequence("abac", "cab")
  
  # >> ["lcs", "cabac"]
  # >> ["lcs", "cabac"]
  
  # Start of ./coding/recursion/tower_of_hanoi.rb
a = [1, 2, 3, 4]
b = []
c = []

def move_disk(number_of_disks, source, destination, helper)
  if number_of_disks == 1
    print(number_of_disks, source, destination, helper)
    destination.unshift(source.shift)
  else
    move_disk(number_of_disks - 1, source, helper, destination)
    destination.unshift(source.shift)
    move_disk(number_of_disks - 1, helper, destination, source)
  end
end

def print(number_of_disks, source, destination, helper)
  p "Moving n = #{number_of_disks}, from source #{source}, to destination #{destination},helper #{helper}"
end

move_disk(4, a, b, c)
p a, b, c

# >> "Moving n = 1, from source [1, 2, 3, 4], to destination [],helper []"
# >> "Moving n = 1, from source [1], to destination [2],helper [3, 4]"
# >> "Moving n = 1, from source [1, 2], to destination [4],helper [3]"
# >> "Moving n = 1, from source [1, 4], to destination [2, 3],helper []"
# >> "Moving n = 1, from source [1, 2, 3], to destination [4],helper []"
# >> "Moving n = 1, from source [1, 4], to destination [2],helper [3]"
# >> "Moving n = 1, from source [1, 2], to destination [],helper [3, 4]"
# >> "Moving n = 1, from source [1], to destination [2, 3, 4],helper []"
# >> []
# >> [1, 2, 3, 4]
# >> []

# Start of ./coding/recursion/k_th_grammar.rb
def kth_grammar(n, k)
  if n == 1 && k == 1
    return 0
  end

  mid = (2 ** (n - 1)) / 2

  if k <= mid
    return kth_grammar(n - 1, k)
  elsif k > mid
    res = (kth_grammar(n - 1, k - mid) == 0) ? 1 : 0
    return res
  end
end

p kth_grammar(4, 3)

# >> 1

# Start of ./coding/recursion/generate_all_balanced_parenthesis.rb
require "set"

OUTPUT = Set.new
OPEN = "("
CLOSE = ")"

def main(input)
  solve(input, input, input, "")
end

def solve(input, open, close, output)
  if open == 0 && close == 0
    OUTPUT << output
    return
  end

  if open != 0
    output_1 = output.clone
    output_1 << OPEN
    solve(input - 1, open - 1, close, output_1)
  end

  if close > open
    output_2 = output.clone
    output_2 << CLOSE
    solve(input, open, close - 1, output_2)
  end

  return
end

p main(3)
p OUTPUT

# >> nil
# >> #<Set: {"((()))", "(()())", "(())()", "()(())", "()()()"}>

# Start of ./coding/recursion/print_unique_subset_powerset.rb
require "set"

input = "aab"
OUTPUT = Set.new

def main(input)
  solve(input, "")
end

def solve(input, output)
  if input.length == 0
    OUTPUT << output
    return
  end
  # p ["BEFORE input, output, output_1, output_2", input, output, nil, nil]
  output_1 = output.clone
  output_2 = output.clone
  remove = input.slice!(0)
  output_2 << remove
  # p ["AFTER input, output, output_1, output_2", input, output, output_1, output_2]
  solve(input.dup, output_1.dup)
  solve(input.dup, output_2.dup)
  return
end

p main(input)
p OUTPUT

# >> nil
# >> #<Set: {"", "b", "a", "ab", "aa", "aab"}>

# Start of ./coding/recursion/josephus_problem.rb
require "set"

# Input: N = 5 and k = 2
# Output: 3

# Input: N = 7 and k = 3
# Output: 4

$global_variable = 0

def solve(n, k)
  if n.length == 1
    p n
    return n
  end

  $global_variable = ($global_variable + k - 1) % n.length
  n.delete_at($global_variable)
  solve(n, k)
end

solve([*1..7], 3)

# >> [4]

# Start of ./coding/recursion/permutation_with_spaces.rb
require "set"

input = "abc"
OUTPUT = []

def main(input)
  solve(input[1..-1], input[0])
end

def solve(input, output)
  if input.length == 0
    OUTPUT << output
    return
  end

  output_1 = output.clone
  output_2 = output.clone
  output_1 << "_#{input[0]}"
  output_2 << "#{input[0]}"

  solve(input[1..-1], output_1)
  solve(input[1..-1], output_2)
  return
end

p main(input)
p OUTPUT

# >> nil
# >> ["a_b_c", "a_bc", "ab_c", "abc"]

# Start of ./coding/recursion/permutation_with_case_change.rb
require "set"

input = "ab"
OUTPUT = []

def main(input)
  solve(input, "")
end

def solve(input, output)
  if input.length == 0
    OUTPUT << output
    return
  end

  output_1 = output.clone
  output_2 = output.clone
  output_1 << "#{input[0].swapcase}"
  output_2 << "#{input[0]}"

  solve(input[1..-1], output_1)
  solve(input[1..-1], output_2)
  return
end

p main(input)
p OUTPUT

# >> nil
# >> ["AB", "Ab", "aB", "ab"]

# Start of ./coding/knapsack/count_subsets.rb
def count_subsets(set, n, target_sum, memo = {})
  return 1 if target_sum == 0
  return 0 if n == 0 && target_sum != 0

  memo_key = "#{n}-#{target_sum}"
  return memo[memo_key] if memo.key?(memo_key)

  if set[n-1] > target_sum
    memo[memo_key] = count_subsets(set, n-1, target_sum, memo)
  else
    memo[memo_key] = count_subsets(set, n-1, target_sum - set[n-1], memo) + count_subsets(set, n-1, target_sum, memo)
  end

  memo[memo_key]
end

set = [2, 3, 5, 6, 8, 10]
target_sum = 10
n = 6

puts count_subsets(set, n, target_sum)

# Start of ./coding/knapsack/test.rb

# Start of ./coding/knapsack/double_knapsack.rb
def knapsack(w_array,w1,w2,n)
  if n==0 || w1+w2 == 0
    return 0
  elsif w_array[n-1] > w1 && w_array[n-1] > w2
    return knapsack(w_array,w1,w2,n-1)
  elsif w_array[n-1] <= w1 && w_array[n-1] > w2
    return [w_array[n-1] + knapsack(w_array,w1 - w_array[n-1],w2,n-1),knapsack(w_array,w1,w2,n-1)].max
  elsif w_array[n-1] > w1 && w_array[n-1] <= w2
    return [w_array[n-1] + knapsack(w_array,w1,w2-w_array[n-1],n-1),knapsack(w_array,w1,w2,n-1)].max
  else
    return [w_array[n-1] + knapsack(w_array,w1 - w_array[n-1],w2,n-1),w_array[n-1] + knapsack(w_array,w1,w2-w_array[n-1],n-1),knapsack(w_array,w1,w2,n-1)].max
  end
end
w_array = [8,5,7,10]
w1=11
w2=11
n = w_array.length
p knapsack(w_array,w1,w2,n)

# Start of ./coding/knapsack/knapsack_top_down.rb
val = [60, 100, 120]
wt = [10, 20, 30]
w = 50
n = val.length
t = (n + 1).times.collect { [-1] * (w + 1) }

(n + 1).times do |row|
  (w + 1).times do |col|
    if row == 0 || col == 0
      t[row][col] = 0
    end
  end
end

(1..n).each do |i|
  (1..w).each do |j|
    if wt[i - 1] <= j
      t[i][j] = [val[i - 1] + t[i - 1][j - wt[i - 1]], t[i - 1][j]].max
    else
      t[i][j] = t[i - 1][j]
    end
  end
end

p t[n][w]

# >> 220

# Start of ./coding/knapsack/KS_BOTTOM_UP_TOP_DOWN.rb
def knapsack_top_down(weights, values, W, n, t)
  return 0 if n == 0 || W == 0

  return t[n][W] if t[n][W] != -1

  if weights[n - 1] <= W
    t[n][W] = [values[n - 1] + knapsack_top_down(weights, values, W - weights[n - 1], n - 1, t), knapsack_top_down(weights, values, W, n - 1, t)].max
  else
    t[n][W] = knapsack_top_down(weights, values, W, n - 1, t)
  end

  t[n][W]
end

weights = [10, 20, 30]
values = [60, 100, 120]
W = 50
n = weights.length

t = Array.new(n + 1) { Array.new(W + 1, -1) }

puts knapsack_top_down(weights, values, W, n, t)

########################################################

def knapsack_bottom_up(weights, values, W, n)
  t = Array.new(n + 1) { Array.new(W + 1, 0) }

  for i in 1..n
    for w in 1..W
      if weights[i - 1] <= w
        t[i][w] = [values[i - 1] + t[i - 1][w - weights[i - 1]], t[i - 1][w]].max
      else
        t[i][w] = t[i - 1][w]
      end
    end
  end

  t[n][W]
end

weights = [10, 20, 30]
values = [60, 100, 120]
W = 50
n = weights.length

puts knapsack_bottom_up(weights, values, W, n)

# Start of ./coding/knapsack/knapsack_ruby/unbounded_or_rod_cutting.rb
def knapsack(wt, val, w, n)
  return 0 if n.zero? || w.zero?
  if wt[n - 1] <= w
    [(val[n - 1] + knapsack(wt, val, w - wt[n - 1], n)), knapsack(wt, val, w, n - 1)].max
  else
    knapsack(wt, val, w, n - 1)
  end
end

val = [60, 100, 120]
wt = [10, 20, 30]
w = 50
n = val.length
p knapsack(wt, val, w, n)

# >> 300

# Start of ./coding/knapsack/knapsack_ruby/subset_sum_top_down.rb
set = [3, 27, 34, 4, 12, 5, 2]
sum = 30
n = set.length

t = (n + 1).times.collect { [nil] * (sum + 1) }
rows, columns = n + 1, sum + 1

rows.times do |row|
  columns.times do |col|
    if col == 0
      t[row][col] = true
    end
    if row == 0 && col != 0
      t[row][col] = false
    end
  end
end

(1..n).each do |i|
  (1..sum).each do |j|
    if j < set[i - 1]
      t[i][j] = t[i - 1][j]
    end

    t[i][j] = t[i - 1][j - set[i - 1]] || t[i - 1][j]
  end
end

p t[n][sum]

# >> true

# Start of ./coding/knapsack/knapsack_ruby/subset_sum_recursive.rb
set = [3, 27, 34, 4, 12, 5, 2]
sum = 30
n = set.length

# print(isSubSetSum(set, n, sum))

def isSubSetSum(set, sum, n)
  return true if sum == 0
  return false if n == 0 && sum != 0

  if sum < set[n - 1]
    return isSubSetSum(set, sum, n - 1)
  end

  isSubSetSum(set, sum - set[n - 1], n - 1) || isSubSetSum(set, sum, n - 1)
end

p isSubSetSum(set, sum, n)

# >> false

# Start of ./coding/knapsack/knapsack_ruby/minimum_subset_difference.rb
def minimum_subset_difference_positive_number_only(nums)
  set = nums

  sum = set.inject(0, :+)
  n = set.length

  t = (n + 1).times.collect { [nil] * (sum + 1) }
  rows, columns = n + 1, sum + 1

  rows.times do |row|
    columns.times do |col|
      if col == 0
        t[row][col] = true
      end
      if row == 0 && col != 0
        t[row][col] = false
      end
    end
  end

  (1..n).each do |i|
    (1..sum).each do |j|
      if j < set[i - 1]
        t[i][j] = t[i - 1][j]
      end

      t[i][j] = t[i - 1][j - set[i - 1]] || t[i - 1][j]
    end
  end

  row_length = ((sum + 1) / 2).ceil

  s1 = t[-1][0..row_length].rindex { |item| item == true }
end

set = [1, 2, 5, 11]
p minimum_subset_difference_positive_number_only(set)

# >> 10
# >> 8

# Start of ./coding/knapsack/knapsack_ruby/minimum_number_of_coins.rb
require "awesome_print"
# |---w+1 == Sum
# |
# n+1 == Size of array
#
# Infinity,Infinity,Infinity,Infinity,Infinity
# 0
# 0
# 0

def coin_change(coins, amount)
  weights = coins
  n = coins.length
  w = amount
  t = dp(weights, w, n)
  return -1 if t[n][w] == Float::INFINITY
  return 0 if amount == 0

  t[n][w]
end

def dp(weights, w, n)
  rows = n + 1
  cols = w + 1
  t = Array.new(rows, -1) { Array.new(cols, -1) }

  (n + 1).times do |i|
    (w + 1).times do |j|
      if i == 1 && t[i][j] == -1
        t[i][j] = if (j % weights[0]).zero?
            j / weights[0]
          else
            Float::INFINITY - 1
          end
      end

      t[i][j] = 0 if j.zero? # Fill zero in 1st columns
      t[i][j] = Float::INFINITY - 1 if i.zero? # Fill infinity in 1st row
    end
  end

  (2..n).each do |i|
    (1..w).each do |j|
      t[i][j] = if weights[i - 1] <= j
          [1 + t[i][j - weights[i - 1]], t[i - 1][j]].min
        else
          t[i - 1][j]
        end
    end
  end
  t
end

coins = [1, 2]
amount = 3
pp coin_change(coins, amount)

# #  [[Infinity, Infinity, Infinity], [0, -1, -1], [0, -1, -1]]

# >> 2

# Start of ./coding/knapsack/knapsack_ruby/count_number_of_subset.rb
set = [2, 3, 5, 6, 8, 10]
sum = 10
n = 6

# print(isSubSetSum(set, n, sum))

def isSubSetSum(set, sum, n)
  return 1 if sum == 0
  return 0 if n == 0 && sum != 0

  if sum < set[n - 1]
    return isSubSetSum(set, sum, n - 1)
  end

  isSubSetSum(set, sum - set[n - 1], n - 1) + isSubSetSum(set, sum, n - 1)
end

p isSubSetSum(set, sum, n)

# >> 3

# Start of ./coding/knapsack/knapsack_ruby/recursive.rb
# def knapsack(wt, val, w, n)
#   if n == 0 || w == 0
#     return 0
#   end

#   if wt[n - 1] <= w
#     return [(val[n - 1] + knapsack(wt, val, w - wt[n - 1], n - 1)), knapsack(wt, val, w, n - 1)].max
#   else
#     return knapsack(wt, val, w, n - 1)
#   end
# end

def knapsack(wt, val, w, n)
  return 0 if w == 0 || n == 0

  if wt[n - 1] <= w
    return [knapsack(wt[0..n - 2], val[0..n - 2], w - wt[n - 1], n - 1) + val[n - 1],
            knapsack(wt[0..n - 2], val[0..n - 2], w, n - 1)].max
  else
    knapsack(wt[0..n - 2], val[0..n - 2], w, n - 1)
  end
end

val = [60, 100, 120]
wt = [10, 20, 30]
w = 50
n = val.length

p knapsack(wt, val, w, n)

# >> 220

# Start of ./coding/knapsack/knapsack_ruby/recursive_memo.rb
val = [60, 100, 120]
wt = [10, 20, 30]
w = 50
n = val.length

t = (n + 1).times.collect { [-1] * (w + 1) }

def knapsack(wt, val, w, n, t)
  if wt == 0 or n == 0
    return 0
  end

  if t[n][w] != -1
    return t[n][w]
  end

  if wt[n - 1] <= w
    t[n][w] = [val[n - 1] + knapsack(wt, val, w - wt[n - 1], n - 1, t), knapsack(wt, val, w, n - 1, t)].max
  else
    t[n][w] = knapsack(wt, val, w, n - 1, t)
  end
  return t[n][w]
end

p knapsack(wt, val, w, n, t)

# >> 220

# Start of ./coding/knapsack/knapsack_ruby/top_down.rb
val = [60, 100, 120]
wt = [10, 20, 30]
w = 50
n = val.length

t = (n + 1).times.collect { [-1] * (w + 1) }
rows, columns = n + 1, w + 1

rows.times do |row|
  columns.times do |col|
    if row == 0 || col == 0
      t[row][col] = 0
    end
  end
end

(1..n).each do |i|
  (1..w).each do |j|
    if wt[i - 1] <= j
      t[i][j] = [t[i - 1][j - wt[i - 1]] + val[i - 1], t[i - 1][j]].max
    else
      t[i][j] = t[i - 1][j]
    end
  end
end

p t[n][w]

# >> 220

# Start of ./coding/knapsack/knapsack_ruby/recursive_memoized.rb
def knapsack(wt, w, val, n, t)
  # wt is weight array
  # val is value array
  # w is weight
  # n is length

  return 0 if n == 0
  return 0 if w == 0
  return t[n][w] if t[n][w] != -1

  if wt[n - 1] <= w
    t[n][w] = [knapsack(wt, w - wt[n - 1], val, n - 1, t) + val[n - 1], knapsack(wt, w, val, n - 1, t)].max
  else
    t[n][w] = knapsack(wt, w, val, n - 1, t)
  end
  p t
  return t[n][w]
end

val = [60, 100, 120]
wt = [10, 20, 30]
w = 50
n = val.length
t = (n + 1).times.collect { [-1] * (w + 1) }
p knapsack(wt, w, val, n, t)

# Start of ./coding/knapsack/knapsack_ruby/coin_ways_recursive.rb
coins = [1, 2, 3]
sum = 5
n = coins.length

def coins_ways(coins, sum, n)
  return 1 if sum == 0
  return 0 if n == 0 && sum != 0

  if coins[n - 1] <= sum
    coins_ways(coins, sum - coins[n - 1], n) + coins_ways(coins, sum, n - 1)
  else
    coins_ways(coins, sum, n - 1)
  end
end

p coins_ways(coins, sum, n)

# >> 5

# Start of ./coding/knapsack/knapsack_ruby/equal_sum_partition.rb
# It is not ruby code, suprise
# Do not worry as code is there in file named subset_sum.rb
def findPartion(arr, n):
    sum = 0
    for i in range(0,n):
        sum += arr[i]
    if sum % 2 != 0:
        return False
    return isSubSetSum(arr, n, sum/2)

def isSubSetSum(set, n, sum):
    if sum == 0:
        return True
    if (n == 0 and sum != 0):
        return False
    if set[n-1] > sum:
        return isSubSetSum(set, n-1, sum)
    return isSubSetSum(set, n-1, sum - set[n-1]) or isSubSetSum(set, n-1, sum)

print(findPartion([3, 4, 5, 12], 4))


# Start of ./coding/knapsack/coin_change_max_ways.rb
weights = [2, 3, 6]
n = weights.length
w = 6

rows, cols = n + 1, w + 1  # your values
t = Array.new(rows, -1) { Array.new(cols, -1) }

(n + 1).times do |i|
  (w + 1).times do |j|
    if i == 0
      t[i][j] = 0
    end
    if j == 0
      t[i][j] = 1
    end
  end
end

(1..n).each do |i|
  (1..w).each do |j|
    if weights[i - 1] <= j
      t[i][j] = t[i][j - weights[i - 1]] + t[i - 1][j]
    else
      t[i][j] = t[i - 1][j]
    end
  end
end

p t[n][w]

# >> 3

# Start of ./coding/knapsack/min_subset_sum.rb
 def min_subset_sum(numbers)
  total = numbers.sum
  t = subset_sum(numbers, total, numbers.length)
  vector = []
  (t[-1].length / 2).times do |i|
    vector << i if t[-1][i]
  end
  mn = Float::INFINITY
  vector.each do |ele|
    mn = [mn, total - 2 * ele].min
  end
  mn
end

def subset_sum(numbers, total, n)
  t = Array.new(n + 1) { Array.new(total + 1) }
  (n + 1).times do |i|
    (total + 1).times do |j|
      if i.zero?
        t[i][j] = false
      elsif j.zero?
        t[i][j] = true
      elsif numbers[i - 1] <= j
        t[i][j] = t[i - 1][j - numbers[i - 1]] || t[i - 1][j]
      else
        t[i][j] = t[i - 1][j]
      end
    end
  end
  t
end

numbers = [3, 1, 4, 2, 2, 1]
puts min_subset_sum(numbers)

# Start of ./coding/binary_search/binary_search.rb
def binary_search(arr, el)
  end_ = arr.length - 1
  start_ = 0

  while start_ <= end_
    mid = start_ + (end_ - start_) / 2
    if arr[mid] == el
      return mid
    elsif arr[mid] > el
      end_ = mid - 1
    else
      start_ = mid + 1
    end
  end

  return -1
end

p binary_search([76, 88, 93, 94, 97, 100], 100)

# Start of ./coding/graph/bfs_adjacency_list.rb
=begin
AdjacencyListnode - id, next - id hold data
Vertices - data, next, last - same as id but for vertices
=end
class Node
  attr_accessor :data, :next_node

  def initialize(data, next_node = nil)
    self.data = data
    self.next_node = next_node
  end
end

class Queue
  attr_accessor :head, :tail, :length

  def initialize
    @head = nil
    @tail = nil
    @length = 0
  end

  def enqueue(data)
    return unless data
    node = Node.new data

    unless self.head
      self.head = node
    else
      self.tail.next_node = node
    end

    self.tail = node
    self.length += 1
  end

  def dequeue
    return nil unless self.length > 0
    self.head = self.head.next_node
    self.tail = nil if self.length == 1
    self.length -= 1
  end

  def peek
    self.head
  end

  def size
    self.length
  end

  def clear
    while peek
      dequeue
    end
  end

  def each
    return unless block_given?

    current = self.head
    while current
      yield current
      current = current.next_node
    end
  end

  def print
    if self.length == 0
      puts "empty"
    else
      self.each do |curr_node|
        puts curr_node.data
      end
    end
  end
end

q = Queue.new
q.enqueue "foo"
q.enqueue "bar"
pp q.size
pp q.peek
q.dequeue
pp q.size

class AdjacencyListnode
  attr_accessor :id, :next

  def initialize(id)
    self.id = id
    self.next = nil
  end
end

class Vertices
  attr_accessor :data, :next, :last

  def initialize(data)
    self.data = data
    self.next = nil
    self.last = nil
  end
end

class Graph
  attr_accessor :size, :node

  def initialize(size)
    self.size = size
    self.node = Array.new(size) { nil }
    self.setData
  end

  def setData
    if self.size <= 0
      print ("\nEmpty graph")
    else
      index = 0
      while index < self.size
        self.node[index] = Vertices.new(index)
        index += 1
      end
    end
  end

  def connect(start, last)
    edge = AdjacencyListnode.new(last)
    if self.node[start].next == nil
      self.node[start].next = edge
    else
      self.node[start].last.next = edge
    end

    self.node[start].last = edge
  end

  def addEdge(start, last)
    if start >= 0 && start < self.size && last >= 0 && last < self.size
      self.connect(start, last)
      #   if start == last
      #     return
      #   end

      #   self.connect(last, start)
    else
      print("\nSomething went wrong")
    end
  end

  def printGraph
    if self.size > 0
      index = 0
      while index < self.size
        print("\nAdjacency list of vertex ", index, " :")
        temp = self.node[index].next
        while temp != nil
          print(" ", self.node[temp.id].data)
          temp = temp.next
        end

        index += 1
      end
    end
  end

  def bfs(point)
    return if point < 0 || self.size <= 0 || point > self.size

    q = Queue.new
    visited = Array.new(self.size) { false }
    q.enqueue point

    while q.size > 0
      current = q.peek.data
      visited[current] = true
      print(" ", current)
      q.dequeue
      temp = self.node[current].next
      while temp != nil
        q.enqueue temp.id if visited[temp.id] == false
        temp = temp.next
      end
    end
  end
end

g = Graph.new(6)
#  Connect node with an edge
g.addEdge(0, 1)
g.addEdge(0, 5)
g.addEdge(1, 1)
g.addEdge(2, 1)
g.addEdge(3, 0)
g.addEdge(3, 3)
g.addEdge(4, 2)
g.addEdge(4, 3)
g.addEdge(5, 1)
#  print graph element
g.printGraph()
puts
g.bfs(4)

# >> 2
# >> #<Node:0x00007f9b378e8210
# >>  @data="foo",
# >>  @next_node=#<Node:0x00007f9b378e8170 @data="bar", @next_node=nil>>
# >> 1
# >>
# >> Adjacency list of vertex 0 : 1 5
# >> Adjacency list of vertex 1 : 1
# >> Adjacency list of vertex 2 : 1
# >> Adjacency list of vertex 3 : 0 3
# >> Adjacency list of vertex 4 : 2 3
# >> Adjacency list of vertex 5 : 1
# >>  4 2 3 1 0 5

# Start of ./coding/graph/adjacency_list_representation_directed_graph.rb
=begin
AdjacencyListnode - id, next - id hold data
Vertices - data, next, last - same as id but for vertices


=end

class AdjacencyListnode
  attr_accessor :id, :next

  def initialize(id)
    self.id = id
    self.next = nil
  end
end

class Vertices
  attr_accessor :data, :next, :last

  def initialize(data)
    self.data = data
    self.next = nil
    self.last = nil
  end
end

class Graph
  attr_accessor :size, :node

  def initialize(size)
    self.size = size
    self.node = Array.new(size) { nil }
    self.setData
  end

  def setData
    if self.size <= 0
      print ("\nEmpty graph")
    else
      index = 0
      while index < self.size
        self.node[index] = Vertices.new(index)
        index += 1
      end
    end
  end

  def connect(start, last)
    edge = AdjacencyListnode.new(last)
    if self.node[start].next == nil
      self.node[start].next = edge
    else
      self.node[start].last.next = edge
    end

    self.node[start].last = edge
  end

  def addEdge(start, last)
    if start >= 0 && start < self.size && last >= 0 && last < self.size
      self.connect(start, last)
    else
      print("\nSomething went wrong")
    end
  end

  def printGraph
    if self.size > 0
      index = 0
      while index < self.size
        print("\nAdjacency list of vertex ", index, " :")
        temp = self.node[index].next
        while temp != nil
          print(" ", self.node[temp.id].data)
          temp = temp.next
        end

        index += 1
      end
    end
  end
end

g = Graph.new(5)
#  Connect node with an edge
g.addEdge(0, 1)
g.addEdge(1, 2)
g.addEdge(1, 4)
g.addEdge(2, 0)
g.addEdge(2, 3)
g.addEdge(4, 3)
#  print graph element
g.printGraph()

# >>
# >> Adjacency list of vertex 0 : 1
# >> Adjacency list of vertex 1 : 2 4
# >> Adjacency list of vertex 2 : 0 3
# >> Adjacency list of vertex 3 :
# >> Adjacency list of vertex 4 : 3

# Start of ./coding/graph/adjacency_list_representation_undirected_graph.rb
=begin
AdjacencyListnode - id, next - id hold data
Vertices - data, next, last - same as id but for vertices


=end

class AdjacencyListnode
  attr_accessor :id, :next

  def initialize(id)
    self.id = id
    self.next = nil
  end
end

class Vertices
  attr_accessor :data, :next, :last

  def initialize(data)
    self.data = data
    self.next = nil
    self.last = nil
  end
end

class Graph
  attr_accessor :size, :node

  def initialize(size)
    self.size = size
    self.node = Array.new(size) { nil }
    self.setData
  end

  def setData
    if self.size <= 0
      print ("\nEmpty graph")
    else
      index = 0
      while index < self.size
        self.node[index] = Vertices.new(index)
        index += 1
      end
    end
  end

  def connect(start, last)
    edge = AdjacencyListnode.new(last)
    if self.node[start].next == nil
      self.node[start].next = edge
    else
      self.node[start].last.next = edge
    end

    self.node[start].last = edge
  end

  def addEdge(start, last)
    if start >= 0 && start < self.size && last >= 0 && last < self.size
      self.connect(start, last)
      if start == last
        return
      end

      self.connect(last, start)
    else
      print("\nSomething went wrong")
    end
  end

  def printGraph
    if self.size > 0
      index = 0
      while index < self.size
        print("\nAdjacency list of vertex ", index, " :")
        temp = self.node[index].next
        while temp != nil
          print(" ", self.node[temp.id].data)
          temp = temp.next
        end

        index += 1
      end
    end
  end
end

g = Graph.new(5)
#  Connect node with an edge
g.addEdge(0, 1)
g.addEdge(0, 2)
g.addEdge(0, 4)
g.addEdge(1, 2)
g.addEdge(1, 4)
g.addEdge(2, 3)
g.addEdge(3, 4)
g.printGraph()

# >> 
# >> Adjacency list of vertex 0 : 1 2 4
# >> Adjacency list of vertex 1 : 0 2 4
# >> Adjacency list of vertex 2 : 0 1 3
# >> Adjacency list of vertex 3 : 2 4
# >> Adjacency list of vertex 4 : 0 1 3

# Start of ./coding/graph/dfs_bfs.rb
class Node
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
    @left, @right = nil, nil
  end
end

root = Node.new(3)
child_l = Node.new(9)
child_r = Node.new(20)
grand_child_r_l = Node.new(15)
grand_child_r_r = Node.new(7)
grand_child_l_l = Node.new(33)
child_r.left = grand_child_r_l
child_r.right = grand_child_r_r
child_l.left = grand_child_l_l
r

def dfs(node)
  p node.val
  children = [node.left, node.right].compact
  children.each do |child|
    dfs(child)
  end
end

dfs(root)
puts

def bfs(node)
  queue = []
  queue.push(node)
  while (queue.size != 0)
    node = queue.shift
    p node.val
    children = [node.left, node.right].compact
    children.each do |child|
      queue.push(child)
    end
  end
end

bfs(root)

puts

def max_depth(root)
  return 0 if root.nil?
  queue = [root]
  depth = 0
  while !queue.empty?
    for i in 0..queue.length - 1
      node = queue.shift
      queue.push(node.left) if node.left
      queue.push(node.right) if node.right
    end
    depth += 1
  end
  depth
end

p max_depth(root)

# >> 3
# >> 9
# >> 33
# >> 20
# >> 15
# >> 7
# >>
# >> 3
# >> 9
# >> 20
# >> 33
# >> 15
# >> 7
# >>
# >> 3

# Start of ./coding/graph/dfs_adjacency_list_directed.rb
=begin
AdjacencyListnode - id, next - id hold data
Vertices - data, next, last - same as id but for vertices


=end

class AdjacencyListnode
  attr_accessor :id, :next

  def initialize(id)
    self.id = id
    self.next = nil
  end
end

class Vertices
  attr_accessor :data, :next, :last

  def initialize(data)
    self.data = data
    self.next = nil
    self.last = nil
  end
end

class Graph
  attr_accessor :size, :node

  def initialize(size)
    self.size = size
    self.node = Array.new(size) { nil }
    self.setData
  end

  def setData
    if self.size <= 0
      print ("\nEmpty graph")
    else
      index = 0
      while index < self.size
        self.node[index] = Vertices.new(index)
        index += 1
      end
    end
  end

  def connect(start, last)
    edge = AdjacencyListnode.new(last)
    if self.node[start].next == nil
      self.node[start].next = edge
    else
      self.node[start].last.next = edge
    end

    self.node[start].last = edge
  end

  def addEdge(start, last)
    if start >= 0 && start < self.size && last >= 0 && last < self.size
      self.connect(start, last)
      #   if start == last
      #     return
      #   end

      #   self.connect(last, start)
    else
      print("\nSomething went wrong")
    end
  end

  def printGraph
    if self.size > 0
      index = 0
      while index < self.size
        print("\nAdjacency list of vertex ", index, " :")
        temp = self.node[index].next
        while temp != nil
          print(" ", self.node[temp.id].data)
          temp = temp.next
        end

        index += 1
      end
    end
  end

  def printDFS(point)
    if self.size <= 0 || point < 0 || point >= self.size
      print("\nNothing for DFS")
      return
    end

    visit = Array.new(self.size) { false }
    self.dfs(visit, point)
  end

  def dfs(visit, point)
    return if visit[point] == true
    visit[point] = true
    print(" ", point)

    temp = self.node[point].next
    while temp != nil
      dfs(visit, temp.id)
      temp = temp.next
    end
  end
end

g = Graph.new(6)
g.addEdge(0, 1)
g.addEdge(0, 5)
g.addEdge(1, 1)
g.addEdge(2, 1)
g.addEdge(3, 0)
g.addEdge(3, 3)
g.addEdge(4, 2)
g.addEdge(4, 3)
g.addEdge(5, 1)
g.printGraph
puts

g.printDFS(4)

# >>
# >> Adjacency list of vertex 0 : 1 5
# >> Adjacency list of vertex 1 : 1
# >> Adjacency list of vertex 2 : 1
# >> Adjacency list of vertex 3 : 0 3
# >> Adjacency list of vertex 4 : 2 3
# >> Adjacency list of vertex 5 : 1
# >>  4 2 1 3 0 5

# Start of ./coding/graph/bfs_shortest_path_adjacency_list.rb
=begin

+----+
v    |
A--->B--->F
|         ^
V         |
C--->D----+
     |
     v
     E
   
=end

graph = {
  "A" => ["B", "C"],
  "B" => ["A", "F"],
  "C" => ["D"],
  "D" => ["E", "F"],
  "E" => [],
  "F" => [],
}

def bfs(graph, start, goal)
  q = Queue.new
  q.enq start
  shortest_path_helper = { start => nil }

  while !q.empty?
    curr = q.deq
    if graph.key? curr
      return shortest_path(shortest_path_helper, goal) if curr == goal

      graph[curr].each do |neighbor|
        if !shortest_path_helper.key? neighbor
          shortest_path_helper[neighbor] = curr
          q.enq neighbor
        end
      end
    end
  end
end

def shortest_path(shortest_path_helper, goal)
  path = []
  while !goal.nil?
    path << goal
    goal = shortest_path_helper[goal]
  end

  path.reverse
end

p bfs(graph, "A", "F") # => ["A", "B", "F"]
p bfs(graph, "A", "E") # => ["A", "C", "D", "E"]
p bfs(graph, "B", "E") # => ["B", "A", "C", "D", "E"]

# >> ["A", "B", "F"]
# >> ["A", "C", "D", "E"]
# >> ["B", "A", "C", "D", "E"]

# Start of ./coding/graph/dfs_adjacency_matrix.rb
class Graph
  def initialize(v, e)
    @v = v
    @e = e
    @adj = Array.new(v, 0) { Array.new(v, 0) }
  end

  def addEdge(start, e)
    # Considering a bidirectional edge
    @adj[start][e] = 1
    @adj[e][start] = 1
  end

  def dfs(start, visited)
    print(start, " ")
    visited[start] = true

    for i in 0..@v
      if @adj[start][i] == 1 && visited[i] == false
        dfs(i, visited)
      end
    end
  end
end

v, e = 5, 4

# Create the graph
g = Graph.new(v, e)
g.addEdge(0, 1)
g.addEdge(0, 2)
g.addEdge(0, 3)
g.addEdge(0, 4)

# Visited vector to so that a vertex
# is not visited more than once
# Initializing the vector to false as no
# vertex is visited at the beginning
visited = Array.new(v, false)
g.dfs(0, visited)

# >> 0 1 2 3 4 
# Start of ./coding/graph/bfs_adjacency_matrix.rb
class Graph
  def initialize(v, e)
    @v = v
    @e = e
    @adj = Array.new(v, 0) { Array.new(v, 0) }
  end

  def addEdge(start, e)
    # Considering a bidirectional edge
    @adj[start][e] = 1
    @adj[e][start] = 1
  end

  def bfs(start)
    visited = Array.new(@v, false)
    q = [start]

    while q.length > 0
      curr = q.shift

      print(curr, " ") if visited[curr] == false
      visited[curr] = true
      for i in 0..@v
        if @adj[curr][i] == 1 && visited[i] == false
          print(i, " ")
          q.append i
          visited[i] = true
        end
      end
    end
  end
end

v, e = 8, 4

# Create the graph
g = Graph.new(v, e)
g.addEdge(1, 2)
g.addEdge(1, 5)
g.addEdge(1, 3)
g.addEdge(2, 6)
g.addEdge(2, 4)
g.addEdge(5, 4)
g.addEdge(3, 4)
g.addEdge(3, 7)

g.bfs(1)

# >> 1 2 3 5 4 6 7 



# Start of ./coding/graph/implement_graph_using_hashmap_undirected.rb
class Node
  attr_reader :value

  def initialize(value)
    @value = value
    @adjacent_nodes = []
  end

  def add_edge(adjacent_node)
    @adjacent_nodes << adjacent_node
  end
end

class Graph
  def initialize
    @nodes = {}
  end

  def add_node(node)
    @nodes[node.value] = node
  end

  def add_edge(node1, node2)
    @nodes[node1].add_edge(@nodes[node2])
    @nodes[node2].add_edge(@nodes[node1])
  end
end

# Start of ./coding/odd_even_jump.rb
require "awesome_print"
require "pp"

def odd_even_jumps(arr)
  arr_with_index = arr.each_with_index.map { |num, idx| [idx, num] }

  odd_sorted_arr = arr_with_index.sort do |(idx1, num1), (idx2, num2)|
    if num1 == num2
      idx1 <=> idx2
    else
      num1 <=> num2
    end
  end

  even_sorted_arr = arr_with_index.sort do |(idx1, num1), (idx2, num2)|
    if num1 == num2
      idx1 <=> idx2
    else
      num2 <=> num1
    end
  end

  odd_next = Array.new(arr.length, nil)
  odd_stack = []

  odd_sorted_arr.each do |(idx, num)|
    while !odd_stack.empty? && idx > odd_stack[-1]
      odd_next[odd_stack.pop] = idx
    end
    odd_stack.push(idx)
  end

  even_next = Array.new(arr.length, nil)
  even_stack = []

  even_sorted_arr.each do |(idx, num)|
    while !even_stack.empty? && idx > even_stack[-1]
      even_next[even_stack.pop] = idx
    end
    even_stack.push(idx)
  end

  odd_good = Array.new(arr.length, nil)
  even_good = Array.new(arr.length, nil)

  odd_good[-1] = 1
  even_good[-1] = 1

  (arr.length - 2).downto(0) do |i|
    even_index = odd_next[i]
    if even_index.nil? || even_good[even_index].nil?
      odd_good[i] = 0
    else
      odd_good[i] = even_good[even_index]
    end

    odd_index = even_next[i]
    if odd_index.nil? || odd_good[odd_index].nil?
      even_good[i] = 0
    else
      even_good[i] = odd_good[odd_index]
    end
  end

  pp even_good
  pp odd_good

  return odd_good.count(1)
end

arr = [2, 3, 1, 1, 4]
pp odd_even_jumps(arr)
-e 
# Start of ./coding/mcm/mcm_recursive.rb
def mch(p, i, j)
  if i == j
    return 0
  end

  _min = (1 << 64)

  (i...j).each do |n|
    count = mch(p,i,n) + mch(p,n+1,j) + (p[i-1] * p [n] * p[j])
    if count < _min
      _min = count
    end
  end

  return _min
end

arr = [1, 2, 3, 4, 3]
n = arr.length
p mch(arr, 1, n-1)
-e 
# Start of ./coding/mcm/_recursive.rb
def mch(p, i, j)
  if i == j
    return 0
  end

  _min = (1 << 64)

  (i...j).each do |n|
    count = mch(p,i,n) + mch(p,n+1,j) + (p[i-1] * p [n] * p[j])
    if count < _min
      _min = count
    end
  end

  return _min
end

arr = [1, 2, 3, 4, 3]
n = arr.length
p mch(arr, 1, n-1)
-e 
# Start of ./coding/leet/two_sum.rb
# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
  h = {}
  nums.each_with_index do |a, i|
    n = target - a
    return [h[n], i] if h[n]
    h[a] = i
  end
end
-e 
# Start of ./coding/leet/k_closest_point_to_origin.rb
def k_closest(points, k)
    res = {}
    points.each do |point|
      res[point] = Euclideandistance.new(
            [point[0],point[1]],
            [0,0]
        ).distance
    end
    res
    sorted = Hash[res.sort_by{|k, v| v}].keys
    return sorted.first(k)
end

class Euclideandistance
  include Math
  attr_reader :∫from, :to
  def initialize(from, to)
    @from = from
    @to = to
  end
  def distance
    # First; group the x's and y's, then sum the squared difference in x's and y's
    Math.sqrt(@from.zip(@to).reduce(0) { |sum, p| sum + (p[0] - p[1]) ** 2 })
  end
end

-e 
# Start of ./coding/leet/min_steps.rb
def min_steps(n)
	return 0 if n ==1
	return n if n < 5
	return min_steps(n/2) + 2 if n.even?
	return min_odd_steps(n) unless n.even?
end

def min_odd_steps(n)
	if prime?(n)
		return n
	else
		smallest_divisor = smallest_odd_divisor(n)
		return smallest_divisor + min_steps(n/smallest_divisor)
	end
end

def prime?(num)
	return false if num <= 1
  	Math.sqrt(num).to_i.downto(2).each {|i| return false if num % i == 0}
  	true
end

def smallest_odd_divisor(n)
 	sanum = (3..n).step(2).each do |num|
 		num
  		break num if n % num == 0
	end
	return sanum
end

def even?(n)
	n % 2 == o
end

p min_steps(54)

# 1+1

# >> 11
-e 
# Start of ./coding/leet/restore_ip_address.rb
def valid?(s)
  num = s.to_i
  num.to_s == s && num >= 0 && num < 256
end

def dfs(s, parts)
  if parts.size == 3
    @candidates << [parts + [s]].join(".") if valid?(s)
    return
  end

  (0..[2, s.size - 1].min).each { |i|
    word = s[0..i]
    dfs(s[i + 1..-1], parts + [word]) if valid?(word)
  }
end

def restore_ip_addresses(s)
  @candidates = []
  dfs(s, [])
  @candidates
end

s = "02000"
p restore_ip_addresses(s)

# >> ["0.20.0.0"]
-e 
# Start of ./coding/leet/add_two_numbers.rb
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def add_two_numbers(l1, l2)
  
  dummy = result = ListNode.new(carry = 0)
  while l1 && l2
    tmp = l1.val + l2.val + carry
    carry, value = tmp > 9 ? 1: 0, tmp > 9 ? tmp - 10 : tmp
    result.next = ListNode.new(value)
    result = result.next
    l1, l2 = l1.next, l2.next
  end
  result.next = carry == 0 ? l1 || l2 : add_two_numbers(l1 || l2, ListNode.new(1))
  dummy.next
end

puts 1 + 1

# >> 2

-e 
# Start of ./coding/euler ruby/euclidean_distance.rb
class Euclideandistance
  include Math                                                                 # => Euclideandistance
  attr_reader :from, :to                                                       # => nil

  def initialize(from, to)
    @from = from                                                               # => [3, 5]
    @to = to                                                                   # => [9, 15]
  end                                                                          # => :initialize

  def distance
    # First; group the x's and y's, then sum the squared difference in x's and y's
    Math.sqrt(@from.zip(@to).reduce(0) { |sum, p| sum + (p[0] - p[1])**2 }) # => 11.661903789690601
  end                                                                          # => :distance
end                                                                            # => :distance

Euclideandistance.new([3, 5], [9, 15]).distance  # => 11.661903789690601
-e 
# Start of ./coding/sliding_window/max_sum_sub_array.rb

=begin
This problem is example of fixed window size
Right way to solve any sliding window

Set two pointers
i = j = 0
window size k = j - i + 1

Run loop while j < size

if j - i + 1 < k
    window size is smaller
    do work
    j++    
else j - i + 1 == k
    window size is matching
    do work
    i++
    j++    
=end

def max_sum_sub_array(arr, k)
    sub_array_sums = []
	# arr.each_with_index do |val, idx|
    upto = arr.length - k + 1
    (0...upto).each_with_index do |val, idx|
        i = idx
        j = k + i - 1
        if sub_array_sums.length > 0
            sum = sub_array_sums[-1] + arr[j] - arr[i-1]
        else
            sum = sum_starting_sub_array(arr, i, j)
        end
        sub_array_sums << sum
    end     
    p "sub_array_sums": sub_array_sums
    sub_array_sums.max
end

def sum_starting_sub_array(arr, i, j)
    sum = 0 
    (i..j).each do |i|
        sum += arr[i]
    end
    p "sum": sum
    sum
end

# Window size k = j - i + 1
w_array = [2,5,1,8,2,9,1]
k = 3
p max_sum_sub_array(w_array, k)

# This is not best way
# We can use k = j - i + 1 condition to write better code. Refer to other solutions in same

# >> {:sum=>8}
# >> {:sub_array_sums=>[8, 14, 11, 19, 12]}
# >> 19

-e 
# Start of ./coding/sliding_window/minimum_window_substring.rb

=begin

# array = ["t", "i", "m", "e", "t", "o", "p", "r", "a", "c", "t", "i", "c", "e"]
# required = ["t", "o", "c"]

i = j = 0

Maintain a map with count of required chars
required_map = {
     "t" => 1, 
     "o" => 1, 
     "c" => 1
}

Also maintain count of chars required - Whenever count of char required is zero, decrease count by 1
char_count = 3 
min_window_substring = []


while j < size    
    if condition char found having key in required map
        Decrease count of char in map by 1
        Check if char required count is zero and if it is - decrease char_count by 1
        If count is zero - Trigger while i < j
        j++
    end
end

while i < j 
    if Previous pointer char found having key in required map 
        Increase char count by 1
        Update char_count if it was zero 
    end

    if Current pointer char found having key in required map
        Decrease count of char in map by 1
        Check if char required count is zero and if it is - decrease char_count by 1
    end

    i++
end    

return 


=end

# def minimum_window_substring(array, required)
#     while j < size do   
#         if condition char found having key in required map
#             Decrease count of char in map by 1
#             Check if char required count is zero and if it is - decrease char_count by 1
#             If count is zero - Trigger while i < j
#             j++
#         end
#     end

#     while i < j do
#         if Previous pointer char found having key in required map 
#             Increase char count by 1
#             Update char_count if it was zero 
#         end

#         if Current pointer char found having key in required map
#             Decrease count of char in map by 1
#             Check if char required count is zero and if it is - decrease char_count by 1
#         end

#         i++
#     end 
# end


=begin
This problem is example of fixed window size
Right way to solve any sliding window

Set two pointers
i = j = 0
window size k = j - i + 1

Run loop while j < size

if j - i + 1 < k
    window size is smaller
    do work
    j++    
else j - i + 1 == k
    window size is matching
    do work
    i++
    j++    
=end

def minimum_window_substring(array, required)
    i = j = 0
    # window size k = j - i + 1
    k = j - i + 1
    char_length = required.length
    char_map = required.group_by(&:itself).transform_values(&:count)

    while < array.length
        if j - i + 1 < char_length
            if char_map.key?(array[i])
                char_map[array[i]] -= 1
                char_length = char_length - 1
            end
            j++
        elsif j - i + 1 == k
            j++
        elsif j - i + 1 == k
            j++ 
            i++
        end
    end
end

array = "timetopractice".split('')
required = "toc".split('')
p minimum_window_substring(array, required)

# ["t", "i", "m", "e", "t", "o", "p", "r", "a", "c", "t", "i", "c", "e"]
# ["t", "o", "c"]

# >> {"t"=>1, "o"=>1, "c"=>1}
# >> {"t"=>1, "o"=>1, "c"=>1}-e 
# Start of ./coding/sliding_window/largest_sub_array_size_k.rb

# =begin
# This problem is example of variable window size
# Right way to solve any sliding window

# Set two pointers
# i = j = 0
# sum = 0
# while j < size
#     calculate sum = sum + sum[j]
#     if sum == condition met    
#         store result, which is window size j - i + 1 
#         update sum - subtract value of i
#         i++
#         j++
#     else
#         j++
#     end
# =end

def largest_sub_array_size_k(arr, k)
    i = j = 0
    sum = 0
    window_sizes = []
    while j < arr.length do
        sum = sum + arr[j] if sum < k
        if sum == k
             window_sizes << (j - i + 1) 
             sum = sum - arr[i]
             i += 1
             j += 1
        elsif sum > k 
            sum = sum - arr[i]
            i += 1
        elsif sum < k
            j += 1     
        end
    end
    window_sizes.max
end

w_array = [4,1,1,1,2,3,5]
k = 5
p largest_sub_array_size_k(w_array, k)

-e 
# Start of ./coding/play.rb
-e 
# Start of ./coding/bfs/leet_binary_tree_level_order_traversal.rb
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root
# @return {Integer[][]}

def level_order(root, result = [], level = 0)
  return result unless root

  result << [] if result.length == level
  result[level] << root.val
  level_order(root.left, result, level + 1)
  level_order(root.right, result, level + 1)
end
-e 
# Start of ./coding/bfs/minimum_depth_binary_tree.rb
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @return {Integer}
def min_depth(root)
  return 0 unless root
  return 1 if root.right.nil? && root.left.nil?
  left = root.left ? min_depth(root.left) : 1 << 64
  right = root.right ? min_depth(root.right) : 1 << 64

  return [left,right].min + 1
end
-e 
# Start of ./coding/bfs/leet_island.rb
def countislands(land)
  rows = land.length
  cols = land[0].length
  if rows.zero?
    0
  else
    islands = 0
    for i in 0...rows
      for j in 0...cols
        if land[i][j] == 1
          marknearby(land, i, j, rows, cols)
          islands += 1
        end
      end
    end
    islands
  end
end

def marknearby(land, i, j, rows, cols)
  return if i >= rows || i < 0 || j >= cols || j < 0 || land[i][j] != 1

  land[i][j] = 2
  marknearby(land, i - 1, j, rows, cols)
  marknearby(land, i + 1, j, rows, cols)
  marknearby(land, i, j - 1, rows, cols)
  marknearby(land, i, j + 1, rows, cols)
end

land = [[1, 1, 1, 0, 0],
        [1, 1, 0, 0, 1]]

p countislands(land)

# >> 2
-e 
# Start of ./coding/bfs/leet_symmetric.rb
class Node
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

def isymmetric(root = nil)
  if root.nil?
    true
  else
    checksymmetry(root.left, root.right)
  end
end

def checksymmetry(left_node, right_node)
  if left_node && right_node
    left_node.value == right_node.value && checksymmetry(left_node.left,
                                                         right_node.right) && checksymmetry(left_node.right,
                                                                                            right_node.left)
  else
    left_node == right_node
  end
end
root = Node.new(1)
root.left = Node.new(2)
root.right = Node.new(2)
root.left.left = Node.new(3)
root.left.right = Node.new(4)
root.right.left = Node.new(4)
root.right.right = Node.new(3)
p isymmetric(root = root)
-e 
# Start of ./coding/matrix/design_excel_sum.rb
class Excel
  attr_accessor :r, :c, :data, :formulas

  def initialize(r, c)
    @r, @c = decodeCord(r, c)
    rows = @r + 1
    cols = @c + 1
    @data = Array.new(rows, 0) { Array.new(cols, 0) }
    @formulas = {}
  end

  def decodeCord(r, c)
    return r.to_i - 1, c.ord - "A".ord + 1
  end

  def set(r, c, v)
    r, c = decodeCord(r, c)
    @data[r][c] = v
    if @formulas[r] && @formulas[r][c]
      @formulas[r][c] = nil
    end
  end

  def get(r, c)
    r, c = decodeCord(r, c)
    if @formulas[r] && @formulas[r][c]
      return computeFormula(r, c)
    end
    return @data[r][c]
  end

  def computeFormula(r, c)
    ans = 0
    @formulas[r][c].each do |str|
      startI, startJ, endI, endJ = parseRange(str)
      for i in startI..(endI)
        for j in startJ..(endJ)
          if @formulas[i] && @formulas[i][j]
            ans += computeFormula(i, j)
          else
            ans += @data[i][j]
          end
        end
      end
    end
    return ans
  end

  def parseRange(str)
    start_str = str
    end_str = str
    if str.include? ":"
      start_str = str.split(":")[0]
      end_str = str.split(":")[1]
    end
    startI, startJ = decodeCord(start_str[1..-1], start_str[0])
    endI, endJ = decodeCord(end_str[1..-1], end_str[0])
    return startI, startJ, endI, endJ
  end

  def sum(r, c, strs)
    r, c = decodeCord(r, c)
    if @formulas[r]
      @formulas[r].merge!({ c => strs })
    else
      @formulas[r] = { c => strs }
    end
    return computeFormula(r, c)
  end
end

obj = Excel.new(5, "E")
p obj.set(1, "A", 5)
p obj.data
p obj.set(1, "B", 3)
p obj.set(1, "C", 2)
p obj.sum(1, "C", ["A1", "A1:B1"])
p obj.data
p obj.formulas
p obj.get(1, "C")
p obj.set(1, "B", 5)
p obj.get(1, "C")
p obj.sum(1, "B", ["A1:A5"])
p obj.formulas
p obj.set(5, "A", 10)
p obj.get(1, "B")
p obj.data
p obj.get(1, "C")
p obj.data
p obj.sum(3, "C", ["A1:C1", "A1:A5"])
p obj.data
p obj.formulas
p obj.set(3, "A", 3)
p obj.get(1, "B")
p obj.get(1, "C")
p obj.get(3, "C")
p obj.get(5, "A")
-e 
# Start of ./coding/pseudo_code/dp_5_hour/grid_traveller.rb
#########################################
def gridTraveller(n,m, memo)
  return memo[n][m] if  memo[n][m] != 0
  return 1 if m == 1 && n == 1
  return 0 if m == 0 || n == 0

  memo[n][m] = gridTraveller(n-1,m, memo) + gridTraveller(n,m-1, memo)
end

memo = []
n = 30
m = 50
memo = Array.new(n+1) {Array.new(m+1, 0)}
p memo
puts gridTraveller(n,m, memo)
#########################################
def gridTraveller(n,m)
  result = Array.new(n+1) {Array.new(m+1, 1)}
  result[0][0] = 0

  (1..n-1).each do |i|
    (1..m-1).each do |j|
      result[i][j] = result[i-1][j] + result[i][j-1]
    end
  end

  result[n-1][m-1]
end

n = 50
m = 30
puts gridTraveller(n,m)
# 2105556772509601296600

# Time complexity: O(n*m)
# Space complexity: O(n*m)

#########################################
# Alternate solution
def gridTraveller_2(n,m)
  result = Array.new(n+1) {Array.new(m+1, 0)}
  result[1][1] = 1

  (0..n).each do |i|
    (0..m).each do |j|
      current = result[i][j]
      if j+1 <= m
        result[i][j+1] += current
      end
      if i+1 <= n
        result[i+1][j] += current
      end
    end
  end

  result[n][m]
end

n = 50
m = 30
puts gridTraveller_2(n,m)
# >> 2105556772509601296600

# Time complexity: O(n*m)
# Space complexity: O(n*m)
#########################################
-e 
# Start of ./coding/pseudo_code/dp_5_hour/canSum.rb
# require 'benchmark'
# Benchmark.bm do |x|
#   x.report("factorial(10000)") { puts poor_fib(10) }
# end

#########################################
def canSum(targetSum, numbers)
  return true if targetSum == 0
  return false if targetSum < 0

  numbers.each do |num|
    remainder = targetSum - num
    if canSum(remainder, numbers) == true
      return true
    end
  end

  return false
end
# m = target sum
# n = length of array
# Time Complexity: O(n^m)
# Space Complexity: O(m)

# canSum - Memo
def canSum(num, numbers, memo = {})
  return true if num == 0
  return false if num < 0
  return memo[num] if memo.has_key?(num)

  for number in numbers # Adding Time complexity equal to O(length of numbers)
    if canSum(num - number, numbers, memo) == true # Adding Time complexity equal to O(num)
      memo[num] = true
      return true
    end
  end

  memo[num] = false
  return false
end
# m = target sum
# n = length of array
# Time Complexity: O(n*m)
# Space Complexity: O(m)

# canSum - Tabulation
def canSum(targetSum, numbers)
  table = Array.new(targetSum + 1, false)
  table[0] = true

  (0..targetSum).each do |i|
    if table[i] == true
      numbers.each do |num|
        table[i + num] = true
      end
    end
  end

  return table[targetSum]
end
# m = target sum
# n = length of array
# Time Complexity: O(m*n)
# Space Complexity: O(m)

p canSum(7, [2, 3]) # true
p canSum(7, [5, 3, 4, 7]) # true
p canSum(7, [2, 4]) # false
p canSumTabulation(7, [2, 3]) # true
p canSumTabulation(7, [5, 3, 4, 7]) # true
p canSumTabulation(7, [2, 4]) # false

# >> true
# >> true
# >> false
# >> true
# >> true
# >> false
-e 
# Start of ./coding/pseudo_code/dp_5_hour/fib.rb
#########################################
# What is fib 0 to 10?
# 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55
def poor_fib(n)
 if n <= 2
    1
  else
    poor_fib(n-1) + poor_fib(n-2)
  end
end

# Time complexity - O(n) = O(2^n)
# Space complexity - O(n) = O(n)
#########################################
# Add memoization to improve time complexity
def fib_memo(n, memo = {})
  if n <= 2
    1
  elsif memo[n]
    memo[n]
  else
    memo[n] = fib_memo(n-1, memo) + fib_memo(n-2, memo)
  end
end

# Time complexity - O(n) = O(n)
# Space complexity - O(n) = O(n)
#########################################
# Bottom up approach
def fib_bottom_up(n)
  return 1 if n <= 2
  fibs = [0, 1, 1]
  (3..n).each do |i|
    fibs[i] = fibs[i-1] + fibs[i-2]
  end
  fibs[n]
end

# Time complexity - O(n) = O(n)
# Space complexity - O(n) = O(n)
#########################################
-e 
# Start of ./coding/pseudo_code/dp_5_hour.rb
# Key points
# Space complexity of tree problem statement is equal to height of the tree
# Brute force time complexity - 0(Branching factor ^ Height of tree * Any other operation) 
# We have O(n^m) brute force time complexity, which also means no of leaf are O(n^m)

#########################################
# What is fib 0 to 10?
# 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55
# See fib.rb
def poor_fib(n); end
# Time complexity - O(n) = O(2^n)
# Space complexity - O(n) = O(n)
#########################################
# Add memoization to improve time complexity
def fib_memo(n, memo = {}); end
# Time complexity - O(n) = O(n)
# Space complexity - O(n) = O(n)
#########################################
# Bottom up approach
def fib_bottom_up(n)
  return 1 if n <= 2
  fibs = [0, 1, 1]
  (3..n).each do |i|
    fibs[i] = fibs[i-1] + fibs[i-2]
  end
  fibs[n]
end
# Time complexity - O(n) = O(n)
# Space complexity - O(n) = O(n)
#########################################
# See grid_traveller.rb for details
def gridTraveller(n,m, memo)
  return memo[n][m] if  memo[n][m] != 0
  return 1 if m == 1 && n == 1
  return 0 if m == 0 || n == 0

  memo[n][m] = gridTraveller(n-1,m, memo) + gridTraveller(n,m-1, memo)
end
memo = []
n = 30
m = 50
memo = Array.new(n+1) {Array.new(m+1, 0)}
p memo
puts gridTraveller(n,m, memo)
#########################################
# canSum - Brute force

def canSum(num, numbers)
  return true if num == 0
  return false if num < 0

  for number in numbers
    if canSum(num - number, numbers) == true
      return true
    end
  end

  return false
end

# Time complexity - O(n) = O(num power length of numbers)
# Space complexity - O(n) = O(num)

# canSum - Memo
def canSum(num, numbers, memo = {})
  return true if num == 0
  return false if num < 0
  return memo[num] if memo.has_key?(num)

  for number in numbers # Adding Time complexity equal to O(length of numbers)
    if canSum(num - number, numbers, memo) == true # Adding Time complexity equal to O(num)
      memo[num] = true
      return true
    end
  end

  memo[num] = false
  return false
end

inputs = [[5, [2, 3]], [7, [5, 3, 4, 7]], [7, [2, 4]], [8, [2, 3, 5]]]

for input in inputs
  result = canSum(input[0], input[1])
  puts result
end

# Time complexity - O(length of numbers*num) 
# Space complexity - O(n) = O(num)

#########################################

# howSum - Brute force

def howSum(num, numbers)
  return [] if num == 0
  return nil if num < 0

  numbers.each do |number|
    result = howSum(num - number, numbers)
    if result != nil
      return result + [number]
    end
  end

  return nil
end

inputs = [[5, [2, 3]], [7, [5, 3, 4, 7]], [7, [2, 4]], [8, [2, 3, 5]]]

for input in inputs
  result = howSum(input[0], input[1])
  p result
end

# Time complexity - O(n) = O(num power length of numbers)
# Space complexity - O(n) = O(num)

# howSum - Memo

def howSum(num, numbers, memo = {})
  return memo[num] if memo.has_key?(num)
  return [] if num == 0
  return nil if num < 0

  numbers.each do |number|
    remainder = num - number
    result = howSum(remainder, numbers, memo)
    if result != nil
      memo[num] = result + [number]
      return memo[num]
    end
  end

  memo[num] = nil
  return nil
end

inputs = [[5, [2, 3]], [7, [5, 3, 4, 7]], [7, [2, 4]], [300, [2, 3, 5]]]

for input in inputs
  result = howSum(input[0], input[1])
  p result
end
# Time complexity - O(length of numbers*num) 
# Space complexity - O(n) = O(num^2) - Due to memo object, num of keys in memo is num and each value can be at max of length num so num * num

#########################################
# howSum - Tabulation
def howSum(num, numbers)
  table = Array.new(numbers.length + 1, nil)
  table[0] = []

  (0..num).each do |i|
    if table[i]
      numbers.each do |number|
        table[i+number] = table[i] + [number]
      end
    end
  end

  return table[num]
end

# Time complexity - O(n*m)
# Space complexity - O(m*m)

inputs = [[5, [2, 3]], [7, [5, 3, 4, 7]], [7, [2, 4]], [8, [2, 3, 5]]]

for input in inputs
  result = howSum(input[0], input[1])
  p result
end
#########################################
# Brute force
def bestSum(num, numbers)
  return [] if num == 0
  return nil if num < 0

  shortestCombination = nil

  numbers.each do |number|
    remainder = num - number
    combination = bestSum(remainder, numbers)
    if combination != nil
      currentCombination = combination + [number]
      if shortestCombination.nil? || currentCombination.length < shortestCombination.length
        shortestCombination = currentCombination
      end
    end
  end

  return shortestCombination
end

inputs = [[5, [2, 3]], [7, [5, 3, 4, 7]], [7, [2, 4]], [8, [2, 3, 5, 8]]]

for input in inputs
  result = bestSum(input[0], input[1])
  p result
end

# m = target sum
# n = length of array
# Time complexity - O(n^m)
# Space complexity - O(n^2) but why not clear at 02:06:51

def bestSum(num, numbers, memo = {})
  return [] if num == 0
  return nil if num < 0
  return memo[num] if memo.has_key? num

  shortest_combination = nil

  numbers.each do |number|
    remainder = num - number
    combination = bestSum(remainder, numbers)
    if combination != nil && (shortest_combination.nil? || combination.length < shortest_combination.length)
      shortest_combination = combination
    end
  end

  if shortest_combination != nil
    memo[num] = shortest_combination + [num]
    return memo[num]
  end

  return nil
end

inputs = [[5, [2, 3]], [7, [5, 3, 4, 7]], [7, [2, 4]], [8, [2, 3, 5, 8]]]

for input in inputs
  result = bestSum(input[0], input[1])
  p result
end

# m = target sum
# n = length of array
# Time complexity - O(n * m) - Why? Height of tree m, child at each level * m so O(n * m) 
# Space complexity - O(m^2) 

#########################################
# bestSum tabulation
def bestSum(num, numbers)
  table = Array.new(numbers.length + 1, nil)
  table[0] = []

  (0..num).each do |i|
    if table[i]
      numbers.each do |number|
        current_value = table[i + number]
        new_value = [*table[i], number]
        if current_value.nil? || new_value.length < current_value.length
          current_value = new_value
          table[i+number] = new_value
        end
      end
    end
  end

  return table[num]
end

# m = target sum
# n = numbers.length
# Time complexity: O(m * n)
# Space complexity: O(m^2)

inputs = [[5, [2, 3, 1, 5]], [7, [5, 3, 4, 1]], [7, [2, 4]], [8, [2, 3, 5, 8]]]

for input in inputs
  result = bestSum(input[0], input[1])
  p result
end
#########################################
# Brute force
def canConstruct(target_word, words)
  return true if target_word.length == 0

  for word in words
    if target_word.start_with?(word)
      remainder = target_word.slice(word.length..-1)
      return true if canConstruct(remainder, words)
    end
  end

  return false
end

# m = Target word length
# n = Word bank length
# Time complexity - O(n ^ m * m) - Why? Multiply m, for prefix match operation
# Space complexity - O(m^2) - Why? One m for tree height and one for remainder variable we have per stack in height

inputs = [
  ["abcdef", ["ab", "abc", "cd", "def", "abcd"]],                 # true
  ["skateboard", ["bo", "rd", "ate", "t", "ska", "sk", "boar"]],   # false
  ["enterapotentpot", ["a", "p", "ent", "enter", "ot", "o", "t"]], # true
  # ["eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef", ["e", "ee", "eee", "eeee", "eeeee"]], # false
]

for input in inputs
  result = canConstruct(input[0], input[1])
  p result
end

#########################################
# Memo 
def canConstruct(target_word, words, memo = {})
  return true if target_word.length == 0
  return false if words.empty?
  return memo[target_word] if memo.has_key? target_word

  for word in words
    if target_word.start_with?(word)
      remainder = target_word[word.length..-1]
      memo[target_word] = canConstruct(remainder, words, memo)
      return true if memo[target_word]
    end
  end

  memo[target_word] = false
  # false.tap { |result| memo[target_word] = result }
  return false
end

# m = Target word length
# n = Word bank length
# Time complexity - O(n * m) - Why? depth of the recursion is limited to the length of the target_word, the total number of recursive calls made is bounded by m.
# Space complexity - O(m^2) - Why? One m for tree height and one for remainder variable we have per stack in height

inputs = [
  ["abcdef", ["ab", "abc", "cd", "def", "abcd"]],                 # true
  ["skateboard", ["bo", "rd", "ate", "t", "ska", "sk", "boar"]],   # false
  ["enterapotentpot", ["a", "p", "ent", "enter", "ot", "o", "t"]], # true
  ["eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef", ["e", "ee", "eee", "eeee", "eeeee"]], # false
]

for input in inputs
  result = canConstruct(input[0], input[1])
  p result
end

#########################################
# canConstruct tabulation
def canConstruct(target_word, words)
  target_length = target_word.length
  table = [true] + Array.new(target_length, false)

  (0..target_length).each do |i|
    next unless table[i]

    words.each do |word|
      if target_word[i..-1].start_with?(word)
        table[i + word.length] = true
      end
    end
  end

  table[target_length]
end

# m = Target word length
# n = Word bank length
# Time complexity - O(n * m ) - Why? Multiply m, for prefix match operation
# Space complexity - O(m^2) - Why? One m for tree height and one for remainder variable we have per stack in height

inputs = [
  ["abcdef", ["ab", "abc", "cd", "def", "abcd"]],                 # true
  ["skateboard", ["bo", "rd", "ate", "t", "ska", "sk", "boar"]],   # false
  ["enterapotentpot", ["a", "p", "ent", "enter", "ot", "o", "t"]], # true
  ["eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", ["e", "ee", "eee", "eeee", "eeeee"]], # false
]

for input in inputs
  result = canConstruct(input[0], input[1])
  p result
end
#########################################
# Brute force - Skipped
# Memo
def countConstruct(target_word, words, memo = nil)
  memo ||= {}
  return memo[target_word] if memo[target_word]
  return 1 if target_word == "" # I made this mistake
  return 0 if words.empty?

  count = 0

  words.each do |word|
    if target_word.start_with?(word)
      remainder = target_word[word.length..-1]
      count += countConstruct(remainder, words, memo)
    end
  end

  memo[target_word] = count
  count
end

# m = Target word length
# n = Word bank length

# Brute force
# Time complexity - O(n ^ m ^ 2)
# Space complexity - O(m ^ 2)

# Memoized
# Time complexity - O(n * m ^ 2)
# Space complexity - O(m ^ 2)

inputs = [
  ["abcdef", ["ab", "abc", "cd", "def", "abcd", "ef"]],                 # true
  ["skateboard", ["bo", "rd", "ate", "t", "ska", "sk", "boar"]],   # false
  ["enterapotentpot", ["a", "p", "ent", "enter", "ot", "o", "t"]], # true
  ["eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", ["e", "ee", "eee", "eeee", "eeeee"]], # false
]

for input in inputs
  result = countConstruct(input[0], input[1])
  p result
end

# Tabulation
def countConstruct(target_word, words, table = nil)
  target_length ||= target_word.length
  table ||= Array.new(target_length + 1, 0)
  table[0] = 1


  (0..target_length).each do |i|
    next if table[i].zero?

    words.each do |word|
      if target_word[i..-1].start_with?(word)
        table[i + word.length] += table[i]
      end
    end
  end

  table[target_length]
end

# m = Target word length
# n = Word bank length
# Time complexity - O(m * n)
# Space complexity - O(m)

inputs = [
  # ["abcdef", ["ab", "abc", "cde", "de","f", "def"]],
  ["abcdef", ["ab", "abc", "cd", "def", "abcd", "ef"]],                 # true
  # ["skateboard", ["bo", "rd", "ate", "t", "ska", "sk", "boar"]],   # false
  # ["enterapotentpot", ["a", "p", "ent", "enter", "ot", "o", "t"]], # true
  ["eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", ["e", "ee", "eee", "eeee", "eeeee"]], # false
]

for input in inputs
  result = countConstruct(input[0], input[1])
  p result
end

# >> 3
#########################################
# Core Logic for next problem allConstruct
# word = "word"
# a = [[]]
# b = []
# aa = a.map do |item|; [word] + item; end
# bb = b.map do |item|; [word] + item; end

# pp word
# p aa
# p bb

# >> "word"
# >> [["word"]]
# >> []

def allConstruct(target_word, words)
  return [[]] if target_word == ""

  result = []

  words.each do |word|
    if target_word.start_with?(word)
      suffix = target_word[word.length..-1]
      suffixWays = allConstruct(suffix, words)
      suffixWays.map! do |way|
        [word] + way
      end
      result.push(*suffixWays)
    end
  end

  result
end

# m = Target word length
# n = Word bank length

# Brute force
# Time complexity - O(n ^ m)
# Space complexity - O(m)

# Memoized - IN THIS CASE IT IS SAME AS BRUTE FORCE
# Time complexity - O(n * m)
# Space complexity - O(m)

inputs = [
  ["abcdef", ["ab", "abc", "cd", "def", "abcd", "ef"]],                 # true
  ["purple", ["purp", "p", "ur", "le", "purpl"]],
  ["skateboard", ["bo", "rd", "ate", "t", "ska", "sk", "boar"]],   # false
  ["enterapotentpot", ["a", "p", "ent", "enter", "ot", "o", "t"]], # true
  # ["eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", ["e", "ee", "eee", "eeee", "eeeee"]], # false
]

for input in inputs
  result = allConstruct(input[0], input[1])
  p result
end

# Tabulation
def allConstruct(target_word, words, table = nil)
  target_length ||= target_word.length
  table ||= Array.new(target_length + 1, nil)
  table[0] = [[]]
  # result = []

  (0..target_length).each do |i|
    next unless table[i]

    words.each_with_index do |word, index|
      next unless target_word[i..-1].start_with?(word)

      new_ways = table[i].map { |way| [word] + way }
      table[i + word.length] ||= []
      table[i + word.length].concat(new_ways)
    end
  end

  table[target_length]
end

# m = Target word length
# n = Word bank length
# Time complexity - O(m * n)
# Space complexity - O(m * m)

inputs = [
  ["abcdef", ["ab", "abc", "cde", "de","f", "def"]],
  ["abcdef", ["ab", "abc", "cd", "def", "abcd"]],                 # true
  ["skateboard", ["bo", "rd", "ate", "t", "ska", "sk", "boar"]],   # false
  ["enterapotentpot", ["a", "p", "ent", "enter", "ot", "o", "t"]], # true
  # ["eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", ["e", "ee", "eee", "eeee", "eeeee"]], # false
]

for input in inputs
  result = allConstruct(input[0], input[1])
  p result
end






