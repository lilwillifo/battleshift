class Ship
  attr_reader :length, :damage, :start_space,
              :end_space

  def initialize(attrs)
    #refactor to take hash as a param
    @length = attrs['ship_size']
    @damage = 0
    @start_space = attrs['start_space']
    @end_space = attrs['end_space']
  end

  def place(start_space, end_space)
    @start_space = start_space
    @end_space = end_space
  end

  def attack!
    @damage += 1
  end

  def is_sunk?
    @damage == @length
  end
end
