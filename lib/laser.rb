class Laser < Weapon 
  attr_reader :range
  def initialize
    super('Laser', 125, 25)
  end

end
