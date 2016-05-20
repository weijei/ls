# module Holiday
#   def holiday
#     case @title
#     when "Exe" then 20
#     when "Mgr" then 14
#     when "Reg" then 10
#     end
#   end
# end

module MgmtPrefix
  def name
    "#{title} #{@name}"
  end
end


class Employee
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end


class Executive < Employee
  include MgmtPrefix

  def holiday
    20
  end

  def title
    "Exe"
  end

  def location
    "Corner Office"
  end

  def fulltime?
    true
  end

  def delegate?
    true
  end

end

class Manager < Employee
  include MgmtPrefix

  def holiday
    14
  end

  def title
    "Mgr"
  end

  def location
    "Office"
  end

  def fulltime?
    true
  end

  def delegate?
    true
  end

end

class RegularEmployee < Employee

  def holiday
    10
  end

  def location
    "Cubic Farm"
  end

  def fulltime?
    true
  end

  def delegate?
    false
  end

end

class PartTimer < Employee

  def holiday
    0
  end

  def location
    "Open workspace"
  end

  def fulltime?
    true
  end

  def delegate?
    false
  end

end

george = Executive.new("George")
puts "============="
puts george.holiday
puts george.location
puts george.delegate?
puts george.fulltime?
puts george.name
puts "============="
jack = Manager.new("Jack")
puts jack.holiday
puts jack.location
puts jack.delegate?
puts jack.fulltime?
puts jack.name
puts "============="
emily = RegularEmployee.new("Emily")
puts emily.holiday
puts emily.location
puts emily.delegate?
puts emily.fulltime?
puts emily.name
puts "============="
josh = PartTimer.new("Josh")
puts josh.holiday
puts josh.location
puts josh.delegate?
puts josh.fulltime?
puts josh.name
