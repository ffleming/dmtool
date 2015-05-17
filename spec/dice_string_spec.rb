require 'spec_helper'
RSpec.configure do |c|
  c.alias_it_should_behave_like_to :it_understands, 'can understand'
end

describe DMTool::Parser::DiceString do
  let(:implicit) { DMTool::Parser::DiceString.new 'd6' }
  let(:dice) { DMTool::Parser::DiceString.new '3d6' }
  shared_examples_for 'dice string' do |dice_string|
    it "'#{dice_string}'" do
      expect { DMTool::Parser::DiceString.new("#{dice_string}")}.to_not raise_error
    end
  end

  describe '#initialize' do
    it 'Raises an error for bad values' do
      expect { DMTool::Parser::DiceString.new('dogs') }.to raise_error(DiceStringError)
    end
  end

  it_understands 'dice string', '2d6'
  it_understands 'dice string', 'D20'
  it_understands 'dice string', '4e8'
  it_understands 'dice string', '100E12'
  it_understands 'dice string', '4f'
  it_understands 'dice string', '2F'
  it_understands 'dice string', '5dF'
  it_understands 'dice string', '5d6+2'

end
