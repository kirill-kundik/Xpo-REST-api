module Growth
  def grow
    puts 'growing...'
    @age ||= 0
    @age += 1
  end
end

class Animal
  MAX_WEIGHT = 1_000_000_000.freeze
  attr_accessor :weight, :age

  def initialize(weight = 1, age = 0)
    @weight = weight
    @age = age
    @@number ||= 0
    @@number += 1
    puts 'initializing...'
  end

  def eat(target)
    puts 'eating...'
    @weight += 1 if @weight < MAX_WEIGHT
  end

  def total_population
    puts "Total number of animals: #{@@number}"
  end

  def self.readable_name
    "Generic animal #{self}"
  end
end

class Mammal < Animal
  def eat(target)
    super(target)
    puts "eating like a mammal #{self}"
    @weight += 2
  end
end

class Koala < Mammal
  include Growth
  WEIGHT_GAIN_COEFF = 2.7

  def eat_grass(grass)
    if grass.is_a?(Grass)
      if grass.eatable
        @weight += grass.nutrition_value * WEIGHT_GAIN_COEFF
      else
        puts "I won't eat this!..."
      end
    else
      raise "Param 'grass' should be of type Grass"
    end
  end
end

class Grass
  include Growth
  attr_accessor :eatable, :nutrition_value, :age

  def initialize(eatable, nutrition_value)
    @eatable = eatable
    @nutrition_value = nutrition_value
  end
end
