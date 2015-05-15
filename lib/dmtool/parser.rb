class DMTool::Parser
  attr_reader :history
  def initialize
    @history = []
  end

  def parse!(input)
    history.push input
    command, options = input.split(/ /, 2)
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
