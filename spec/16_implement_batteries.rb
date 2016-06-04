require 'spec_helper'

describe Battery do
  before :each do 
    @battery = Battery.new
  end

  describe '#new' do
    it 'should have name Battery' do 
      expect(@battery.name).to eq('Battery') 
    end

    it 'should have weight of 25' do 
      expect(@battery.weight).to eq(15)
    end
  end

end

describe Robot do
  before :each do
    @robot = Robot.new
    @battery = Battery.new
  end

  describe '#recharge' do

    it 'should recharge shield to full' do
       
    end
    
    it 'should delete from inventory after use' do

    end

    it 'should not use if shield is full' do

    end

  end
end
