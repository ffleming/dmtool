require 'spec_helper'

describe DMTool::CLI do

  let(:script) do
    [
      'roll 2d6',
      'help',
      'raw 3d5',
      'roll 3d6+2, reroll 1-3',
      'bark_like_a_dog',
      'exit'
    ].map {|s| "#{s}\n"}.join
  end

  it 'Handles the script' do
    DMTool::CLI.instance_variable_set('@input', StringIO.new(script))
    output = StringIO.new('')
    DMTool::CLI.instance_variable_set('@output', output)
    DMTool::CLI.start
    output = output.string
    expect(output).to include('dmtool >')
    expect(output).to include("dmtool v#{DMTool::VERSION} help")
    expect(output).to include('ParserError Command bark_like_a_dog not found')
    expect(output).to include('Goodbye')
  end
end
