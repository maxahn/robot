class BoxOfBolts < Item

  attr_reader :heal

  def initialize
    super("Box of bolts", 25)
    @heal = 20
  end

  #----robot interaction methods----#
  
  def feed(robot)
    robot.heal(heal)
  end

end
