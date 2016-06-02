require_relative 'spec_helper'

describe Robot do

  before :each do
    @robot = Robot.new
    @item = Item.new("phone", 5)
  end

  describe '#dead?' do
    it 'new robot should not be dead' do 
      expect(@robot.dead?).to be false 
    end
  
    it 'should be dead' do 
      allow(@robot).to receive(:health).and_return(0)
      expect(@robot.dead?).to be true
    end
  end

  describe '#heal!' do
    it 'should not raise expection if robot has full health' do 
      expect{@robot.heal!(10)}.not_to raise_error(RobotAlreadyDeadError)
    end

    it 'should not raise expectation if robot has 90 health' do 
      allow(@robot).to receive(:health).and_return(90)
      expect{@robot.heal!(10)}.to_not raise_error RobotAlreadyDeadError
    end

    it 'should raise exception if robot is dead' do
      allow(@robot).to receive(:health).and_return(0)
      expect{@robot.heal!(10)}.to raise_error RobotAlreadyDeadError
    end
  end
  
  describe '#attack!' do
    before :each do 
      @enemy = Robot.new
    end

    it 'should raise exception if target is not a robot' do 
      expect{@robot.attack!(@item)}.to raise_error UnattackableEnemyError
    end

    it 'should not raise exception when attacking robot' do
      expect{@robot.attack!(@enemy)}.not_to raise_error UnattackableEnemyError
    end

    it 'should raise error if robot is dead' do 
      allow(@robot).to receive(:dead?).and_return(true)
      expect{@robot.attack!(@enemy)}.to raise_error RobotAlreadyDeadError
    end

    it 'should raise error if enemy is dead' do 
      allow(@enemy).to receive(:dead?).and_return(true)
      expect{@robot.attack!(@enemy)}.to raise_error RobotAlreadyDeadError
    end
    
  end
end
