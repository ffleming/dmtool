require 'spec_helper'

def it_rolls(dice_string, opts)
  range = opts[:in] || raise(ArgumentError.new("Couldn't figure out how to delegate"))

  it "'#{dice_string}' should roll in #{range}" do
    100.times do
      expect(parser.send :cmd_roll, dice_string).to be_in range
    end
  end
end

def parsing(roll_string, never_results_in:)
  range = never_results_in
  range = range..range if range.is_a?(Fixnum)
  it "'#{roll_string}' should not roll in #{range}" do
    100.times do
      expect(parser.parse roll_string).to_not be_in range
    end
  end
end

def a_raw_roll_of(dice_string, opts)
  expected_length = opts[:expected_length] || opts.fetch(:is_of_length)
  it "raw output of '#{dice_string}' should give #{expected_length} results" do
    100.times do
      expect(parser.send(:cmd_raw, dice_string).length).to eq expected_length
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
      expect(parser).to receive(:cmd_roll)
      parser.parse!('roll 2d6')
    end

    it 'calls :raw when told to raw' do
      expect(parser).to receive(:cmd_raw)
      parser.parse!('raw 3d6')
    end

    it 'exits when told to :exit' do
      expect(parser).to receive(:exit)
      parser.parse!('exit')
    end

    it 'displays help when told to :help' do
      expect(parser.parse('help').length).to be > 10
      parser.parse!('help')
    end

    it 'raises an error when it doesn\'t understand' do
      expect { parser.parse!('eat 3d6') }.to raise_error(ParserError)
    end

    it_understands('roll 2d6')
    it_understands('raw 2dF')
    it_understands('roll 3e8')
    it_understands('roll 3e8, reroll 1')

    parsing 'roll d6, reroll 1', never_results_in: 1
    parsing 'roll d6, reroll 1-2', never_results_in: 1..2
    parsing 'roll d4, reroll 1-3', never_results_in: 1..3
  end

  describe '#cmd_roll' do
    it 'responds to :cmd_roll' do
      expect(parser.respond_to? :cmd_roll, true).to eq true
    end

    it 'produces a Fixnum' do
      expect(parser.send :cmd_roll, '3d6').to be_a Fixnum
    end

    it 'raises an error when it doesn\'t understand' do
      expect { parser.send :cmd_roll, 'dogsandcats' }.to raise_error(ParserError)
    end

    it_rolls 'd2', in: 1..2
    it_rolls '2d6', in: 2..12
    it_rolls 'd2-2', in: -1..0
    it_rolls '2d6+10', in: 12..22
    it_rolls '100d20+1000000', in: 1000100..1002000
    it_rolls 'dF', in: -1..1
    it_rolls 'F', in: -1..1
    it_rolls '2F', in: -2..2
  end

  describe '#cmd_raw' do
    it 'responds to :cmd_raw' do
      expect(parser.respond_to? :cmd_raw, true).to eq true
    end

    it 'produces an Array of values' do
      expect(parser.send :cmd_raw, '3d6').to be_an Array
    end

    it 'defaults to 1 if number of dice is not specified' do
      expect(parser.send(:cmd_raw, 'd6').length).to eq 1
    end

    it 'raises an error when it doesn\'t understand' do
      expect { parser.send :cmd_raw, 'dogsandcats' }.to raise_error(ParserError)
    end

    a_raw_roll_of '2d6', is_of_length: 2
    a_raw_roll_of '6d6', is_of_length: 6
    a_raw_roll_of '6dF', is_of_length: 6
    a_raw_roll_of 'f', is_of_length: 1

  end
end
