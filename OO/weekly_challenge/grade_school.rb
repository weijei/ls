class School
  def initialize
    @list = {}
  end

  def add(name,grade)
    if @list.has_key? grade
      @list[grade] << name
    else
      @list[grade] = [name]
    end
  end

  def to_h
    hash = {}
    Hash[@list.sort_by{|key, value| key}].each {|key, value|hash[key] = value.sort}
    hash
  end

  def grade(num)
    @list[num] == nil ? [] : @list.select{|grade, name| grade == num }.fetch(num)
  end

end

school =School.new
[['Jennifer', 4], ['Kareem', 6],['Christopher', 4], ['Kyle', 3]].each do |name, grade|
      school.add(name, grade)
    end
p school.to_h
