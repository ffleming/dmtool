require 'spec_helper'

describe DMTool::Parser::DieDirective do
  let(:reroll_1) { DMTool::Parser::DieDirective.new('reroll 1') }
  it 'should be instantiable' do
    expect { DMTool::Parser::DieDirective.new('reroll 1') }.to_not raise_error
  end


end
