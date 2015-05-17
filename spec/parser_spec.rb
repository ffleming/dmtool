require 'spec_helper'

def it_rolls(dice_string, opts)
  min = opts[:min] || opts.fetch(:between)
  max = opts[:max] || opts.fetch(:and)
  it "'#{dice_string}' should roll between #{min} and #{max}" do
    100.times do
      expect(parser.roll dice_string).to be_between(min, max).inclusive
    end
  end
end

def a_raw_roll_of(dice_string, opts)
  expected_length = opts[:expected_length] || opts.fetch(:contains)
  it "raw output of '#{dice_string}' should give #{expected_length} results" do
    100.times do
      expect(parser.raw(dice_string).length).to eq expected_length
    end
  end
end

def it_understands(input_string)
  it "doesn't raise an error on '#{input_string}'" do
    expect { parser.parse(input_string) }.to_not raise_error
  end
end

describe DMTool::Parser do
  let(:parser) { DMTool::Parser.new }
  describe '#parse!' do
    it 'responds to :parse! and :parse' do
      expect(parser.respond_to? :parse!).to eq true
      expect(parser.respond_to? :parse).to eq true
    end

    it 'calls :roll when told to roll' do
      expect(parser).to receive(:roll)
      parser.parse!('roll 2d6')
    end

    it 'calls :raw when told to raw' do
      expect(parser).to receive(:raw)
      parser.parse!('raw 3d6')
    end

    it 'exits when told to :exit' do
      expect(parser).to receive(:exit)
      parser.parse!('exit')
    end

    it 'raises an error when it doesn\'t understand' do
      expect { parser.parse!('eat 3d6') }.to raise_error(ParserError)
    end

    it_understands('roll 2d6')
    it_understands('raw 2dF')
    it_understands('roll 3e8')
    it_understands('roll 3e8, reroll 1')
  end

  describe '#roll' do
    it 'responds to :roll' do
      expect(parser.respond_to? :roll).to eq true
    end

    it 'produces an Array of values' do
      expect(parser.roll('3d6')).to be_a Fixnum
    end

    it 'raises an error when it doesn\'t understand' do
      expect { parser.roll('dogsandcats')}.to raise_error(ParserError)
    end

    it_rolls 'd2', between: 1, and: 2
    it_rolls '2d6', between: 2, and: 12
    it_rolls 'd2-2', between: -1, and: 0
    it_rolls '2d6+10', between: 12, and: 22
    it_rolls '100d20+1000000', between: 1000020, and: 1002000
    it_rolls 'dF', between: -1, and: 1
    it_rolls 'F', between: -1, and: 1
    it_rolls '2F', between: -2, and: 2
  end

  describe '#raw' do
    it 'responds to :raw' do
      expect(parser.respond_to? :raw).to eq true
    end

    it 'produces an Array of values' do
      expect(parser.raw('3d6')).to be_an Array
    end

    it 'defaults to 1 if number of dice is not specified' do
      expect(parser.raw('d6').length).to eq 1
    end

    it 'raises an error when it doesn\'t understand' do
      expect { parser.raw('dogsandcats')}.to raise_error(ParserError)
    end

    a_raw_roll_of '2d6', contains: 2
    a_raw_roll_of '6d6', contains: 6
    a_raw_roll_of '6dF', contains: 6
    a_raw_roll_of 'f', contains: 1

  end
end
