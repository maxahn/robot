require_relative 'errors/unattackable_enemy_error.rb'
require_relative 'errors/robot_already_dead_error.rb'
class Robot

  attr_reader :position, :items, :health    
  attr_accessor :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
  end

  #----position methods----#
  
  def move_left
    @position[0] -= 1 
  end

  def move_right
    @position[0] += 1 
  end
  
  def move_down
    @position[1] -= 1 
  end
  
  def move_up
    @position[1] += 1 
  end
  
  def within_range?(enemy, range)
    x_in_range = enemy.position[0].between?(position[0] - range, position[0] + range) 
    y_in_range = enemy.position[1].between?(position[1] - range, position[1] + range)

    x_in_range && y_in_range
  end
  #----item methods----#
  
  def pick_up(item)
    if item.is_a? BoxOfBolts
      item.feed(self) if need_to_consume?(item)
    elsif !max_capacity? 
      @equipped_weapon = item if item.is_a? Weapon #wasn't setting for some reason when using the accessor method 
      @items << item 
    end                #will it be in inventory if equipped? will assume yes   
  end

  def items_weight
    items.reduce(0) {|memo, item| memo + item.weight}
  end

  def max_capacity?
    items_weight >= 250
  end
  
  #----health methods----#
  
  def wound(amount)
    @health -= amount  
    under_zero?
  end

  def dead?
    health <= 0
  end

  def heal(amount)
    @health += amount
    above_hundred?
  end
 
  def heal!(amount)     #may throw RobotAlreadyDeadError
    if dead? 
      raise RobotAlreadyDeadError.new("Robot is dead!") 
    else
      heal(amount)
    end
  end

  def need_to_consume?(bolts)
    (100 - health) >= bolts.heal 
  end

  def above_hundred?    #sets health to 100 if above 100
    @health = 100 if health > 100
  end

  def under_zero?   #if health is under 0, sets it to 0
    @health = 0 if health < 0 
  end
  
  def attack(enemy)
    range = if equipped_weapon 
              equipped_weapon.range 
            else 
              1
            end
    if within_range?(enemy, range) 
      if equipped_weapon 
        equipped_weapon.hit(enemy)
        @equipped_weapon = nil if equipped_weapon.disposable
      else
        enemy.wound(5) 
      end
    end
  end

  def attack!(enemy)     #may throw UnattackableEnemyError
    if !enemy.is_a?(Robot)
      raise UnattackableEnemyError.new("Cannot attack item.")
    elsif self.dead? || enemy.dead?
      raise RobotAlreadyDeadError.new("Enemy or Robot is dead.")
    else
      attack(enemy)
    end
  end
end

