class Weapon < Item

  attr_reader :damage, :range, :disposable 

  def initialize(name, weight, damage, range = 1, disposable = false)
    super(name, weight)
    @damage = damage 
    @range = range
    @disposable = disposable
  end
    
  def hit(robot) 
    robot.wound(damage) 
  end

end
