class String
  def my_super_method
    puts 'he-he'
  end
end

class Integer
  def +(value)
    self * value
  end
end
