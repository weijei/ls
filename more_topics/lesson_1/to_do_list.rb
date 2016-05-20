class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = " "

  attr_accessor :title, :description, :done

  def initialize(title, description = ' ')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done == true
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    if todo.class == Todo
      @todos << todo
    else
      puts "Can only add Todo object!"
    end
  end

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def item_at(num)
    @todos[num]
  end

  def mark_done_at(num)
    @todos[num].done!
  end

  def mark_undone_at(num)
    @todos[num].undone!
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(num)
    @todos.delete_at(num)
  end

  def done!
    @todos.each do |todo|
      todo.done!
    end
  end

  def to_s
    puts "----- #{title} ----"
    @todos.map {|todo| todo.to_s}.join("\n")
  end

  def each
    counter = 0
    while counter < @todos.size
      yield(@todos[counter])
      counter += 1
    end
    self
  end

  def select
    temp_todos = TodoList.new('temp')

    @todos.each do |todo|
      if yield(todo)
        temp_todos.add(todo)
      end
    end
    temp_todos
  end

  def find_by_title(title)
    select{|todo| todo.title == title}.first
  end

  def mark_all_done
    each{|todo| todo.done!}
  end

  def mark_all_not_done
    each{|todo| todo.undone!}
  end

  def mark_done(title)
    find_by_title(title).done! if find_by_title(title)
  end

  def all_done
    result = TodoList.new('all_done')
    select{|todo| todo.done?}.each{|todo| result.add(todo)}
    result
  end

  def all_not_done
    result = TodoList.new('all_not_done')
    select{|todo| !todo.done?}.each{|todo| result.add(todo)}
    result
  end

end


todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

todo1.done!
puts list
puts list.all_done
puts list.all_not_done
list.mark_all_done
puts list
list.mark_all_not_done
puts list
list.mark_done("Go to Gym")
puts list
puts list.find_by_title("Buy milk")
p list.find_by_title("gym")