class DMTool::Parser
  attr_reader :history
  def initialize
    @history = []
  end

  def parse!(input)
    history.push input
    command, remainder = input.split(/ /, 2)
    dice_string, directives_string = remainder.to_s.split(',', 2)
    case command
    when 'roll'
      roll dice_string, directives_string
    when 'raw'
      raw dice_string, directives_string
    when 'exit'
      exit
    else
      raise ParserError.new "Command #{command} not found"
    end
  end

  def roll(dice_string, directives_string='')
    dice = DMTool::Parser::DiceString.new(dice_string)
    directives = directives_from(directives_string)
    result = DMTool::Roller.sum(*dice.dice)
    result = dice.modifier.call(result)
  end

  def raw(dice_string, directives_string='')
    dice = DMTool::Parser::DiceString.new(dice_string)
    directives = directives_from(directives_string)
    DMTool::Roller.roll(*dice.dice)
  end

  alias parse parse!

  private

  def directives_from(directives_string)
    directives = directives_string.to_s.split ','
    directives.map! { |str| DMTool::Parser::Directive.new(str) }
  end

  def dice_from(dice_string)
  end
end
