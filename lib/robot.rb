class Robot

  attr_reader :position, :items, :health    
  attr_accessor :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
  end

  #----move methods----#
  
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
   
  #----item methods----#
  
  def pick_up(item)
    if !max_capacity? 
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

  def heal(amount)
    @health += amount
    above_hundred?
  end
  
  def above_hundred?    #sets health to 100 if above 100
    @health = 100 if health > 100
  end

  def under_zero?   #if health is under 0, sets it to 0
    @health = 0 if health < 0 
  end
  
  def attack(enemy)
    if equipped_weapon 
      equipped_weapon.hit(enemy) 
    else
      enemy.wound(5) 
    end
  end

end

