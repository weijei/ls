require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!
require 'simplecov'
SimpleCov.start
require_relative 'todolist'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal([@todo2,@todo3], @list.to_a)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @todo1.done?)
  end

  def test_add_raise_error
    assert_raises(TypeError) { @list.add([1]) }
    assert_raises(TypeError) { @list.add('string') }
  end

  def test_add_alias
    temp = Todo.new("Do jogging")
    @list.add(temp)
    todos = @todos << temp
    assert_equal(todos, @list.to_a)
  end

  def test_item_at
    assert_equal(@todo1, @list.item_at(0))
    assert_raises(IndexError){@list.item_at(5)}
  end

  def test_mark_done_at
    @list.mark_done_at(1)
    assert_equal(false, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_raises(IndexError){@list.mark_done_at(5)}
  end

  def test_mark_undone_at
    @list.mark_done_at(1)
    assert_equal(true, @todo2.done?)
    @list.mark_undone_at(1)
    assert_equal(false, @todo2.done?)
    assert_raises(IndexError){@list.mark_undone_at(5)}
  end

  def test_done!
    @list.done!
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_remove_at
    @list.remove_at(1)
    assert_equal([@todo1,@todo3],@list.to_a)
    assert_raises(IndexError){@list.remove_at(20)}
  end

  def test_to_s_1
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_2
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    @todo1.done!
    assert_equal(output, @list.to_s)
  end

  def test_to_s_3
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
    @list.done!
    assert_equal(output, @list.to_s)
  end

  def test_each
    @list.each {|todo| todo.done!}
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_each_2
    assert_equal(@list, @list.each{|todo| "bye"})
  end

  def test_select
    @todo1.done!
    list = TodoList.new(@list.title)

    list.add(@todo1)
    assert_equal(list.title, @list.title)
    assert_equal(list.to_s, @list.select{|val| val.done?}.to_s)
  end
  # Your tests go here. Remember they must start with "test_"

end