require 'spec_helper' 

describe Robot do
  
  describe 'robot_list' do

    it 'should start empty' do
      expect(Robot.robot_list).to eq([])  
    end

    it 'should store all instances of robots' do
      @robot = Robot.new
      expect(Robot.robot_list[0]).to be_a Robot
      expect(Robot.robot_list.length).to eq(1)
      @robot2 = Robot.new
      @robot3 = Robot.new
      expect(Robot.robot_list.length).to eq(3)
    end

  end

end
