class Person
# attr_accessor :name, :weight, :height
def initialize(name, weight, height)
@name = name
@weight = weight
@height = height
end

def name
@name
end

def weight
@weight
end

def height
@height
end

def name=(new_name)
@name = new_name
end

def weight=(new_weight)
@weight = new_weight
end

def height=(new_height)
@height = new_height
end

def change_info(new_name, new_weight,new_height)
self.name = new_name
self.weight = new_weight
self.height = new_height
end
end


def each(arr)
  counter = 0
  size = arr.size
  while counter < size
   yield(arr[counter])
   counter += 1
  end
  arr
end

