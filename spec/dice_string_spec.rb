require 'spec_helper'

def it_understands(dice_string)
  it "doesn't raise an error on #{dice_string}'" do
    expect { DMTool::Parser::DiceString.new(dice_string) }.to_not raise_error
  end
end

describe DMTool::Parser::DiceString do
  let(:implicit) { DMTool::Parser::DiceString.new 'd6' }
  let(:dice) { DMTool::Parser::DiceString.new '3d6' }

  describe '#initialize' do
    it 'Raises an error for bad values' do
      expect { DMTool::Parser::DiceString.new('dogs') }.to raise_error(DiceStringError)
    end
  end

  it_understands '2d6'
  it_understands 'D20'
  it_understands '4e8'
  it_understands '100E12'
  it_understands '4f'
  it_understands '2F'
  it_understands '5dF'
  it_understands '5d6+2'

end
