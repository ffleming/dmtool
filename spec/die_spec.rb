require 'spec_helper'

describe DMTool::Die do
  it 'can be instantiated with explicit sides' do
    d = DMTool::Die.new(sides: 20)
    expect(d).to be_a(DMTool::Die)
  end

  it 'defaults to 6 sides and no explosions' do
    d = DMTool::Die.new
    expect(d.explodes?).to eq false
    expect(d.sides).to eq 6
  end

  it 'raises an error for single-sided dice' do
    expect { DMTool::Die.new(sides: 1) }.to raise_error
  end

  describe '#roll' do
    let(:die) { DMTool::Die.new(sides: 4) }
    let(:exploder) { DMTool::Die.new(sides: 2, explodes: true) }

    it 'should respond to :roll' do
      expect(die.respond_to? :roll).to be true
    end

    it 'should never have a maximum value greater than 4' do
      max = (1..50).map { die.roll }.max
      expect(max).to be <= 4
    end

    it 'should produce a result >2 when exploding (note: can possibly fail)' do
      max = (1..50).map { exploder.roll }.max
      expect(max).to be > 2
    end
  end
end

