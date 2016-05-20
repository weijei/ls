# class Person
#     @@total_people = 0
#     def initialize(name, weight, height)
#       @name = name
#       @weight = weight
#       @height = height
#       @@total_people +=1
#     end
#     def self.total_people
#       @@total_people
#     end
# end

# bob = Person.new('bob', 185, 70)
# carl = Person.new('bob', 185, 70)
# p Person.total_people       # this should return 1

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

  bob = Person.new('bob', 185, 70)
  bob.change_info('Ted',175, 60)
  puts bob.name
  puts bob.height
  puts bob.weight