require 'spec_helper'

describe Robot do
  
  before :each do
    @robot = Robot.new
  end

  describe '#initialize' do
    it 'should start at 50' do
      expect(@robot.shield).to eq(50) 
    end
  end

  describe '#damage' do
    before :each do
      @enemy = Robot.new      
    end

    it 'should damage shield first' do
      @robot.attack(@enemy)
      expect(@enemy.shield).to eq(45)
    end

    it 'should not damage health' do
      @robot.attack(@enemy)
      expect(@enemy.health).to eq(100)
    end

    it 'should damage health after shield is depleted' do 
      allow(@enemy).to receive(:shield).and_return(0)
      @robot.attack(@enemy)
      expect(@enemy.health).to eq(95)
    end

  end

end
