require 'spec_helper'

describe DMTool::Parser::Directive do
  it 'should be instantiable' do
    expect { DMTool::Parser::Directive.new('reroll 1') }.to_not raise_error
  end


end
