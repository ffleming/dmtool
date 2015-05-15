require 'spec_helper'

describe DMTool::FudgeDie do
  let(:die) { DMTool::FudgeDie.new }
  it 'can be instantiated' do
    expect(die).to be_a(DMTool::FudgeDie)
  end

  describe '#roll' do
    it 'should respond to :roll' do
      expect(die.respond_to? :roll).to be true
    end

    it 'should return a Result' do
      expect(die.roll).to be_a(DMTool::Result)
    end
  end

end

