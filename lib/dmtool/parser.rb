class DMTool::Parser
  attr_reader :input
  def initialize(input=nil)
    @input = input
  end

  def parse!(in_str=input)
    command, options = in_str.split(/ /, 2)
    case command
    when 'roll'
      roll options
    else
      raise ParserError.new "Command #{command} not found"
    end
  end

  def roll(dice_string)
    dice = DMTool::Parser::DiceString.new(dice_string)
    DMTool::Roller.roll(*dice.dice)
  end

  alias parse parse!
  private

end
