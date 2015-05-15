require 'spec_helper'

describe DMTool::Parser::DiceString do
  let(:implicit) { DMTool::Parser::DiceString.new 'd6' }
  let(:dice) { DMTool::Parser::DiceString.new '3d6' }
  describe '#initialize' do
    it 'Raises an error for bad values' do
      expect { DMTool::Parser::DiceString.new('dogs') }.to raise_error(DiceStringError)
    end

    it 'Understands XdY' do
      for i in (1..20)
        for j in (2..20)
          expect { DMTool::Parser::DiceString.new("#{i}d#{j}")}.to_not raise_error
        end
      end
    end

    it 'Understands XeY' do
      for i in (1..20)
        for j in (2..20)
          expect { DMTool::Parser::DiceString.new("#{i}e#{j}")}.to_not raise_error
        end
      end
    end
  end

end
