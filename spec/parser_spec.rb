require 'spec_helper'

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

    it 'raises an error when it doesn\'t understand' do
      expect { parser.parse!('eat 3d6') }.to raise_error(ParserError)
    end
  end

  describe '#roll' do
    it 'responds to :roll' do
      expect(parser.respond_to? :roll).to eq true
    end

    it 'produces an Array of values' do
      expect(parser.roll('3d6')).to be_an Array
    end

    it 'defaults to 1 if number of dice is not specified' do
      expect(parser.roll('d6').length).to eq 1
    end

    it 'raises an error when it doesn\'t understand' do
      expect { parser.roll('dogsandcats')}.to raise_error(ParserError)
    end
  end
end
