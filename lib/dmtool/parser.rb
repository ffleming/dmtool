class DMTool::Parser
  attr_reader :history
  def initialize
    @history = []
  end

  def parse!(input)
    history.push input
    command, remainder = input.split(/ /, 2).map(&:prep)
    dice_string, directives_string = remainder.to_s.split(',', 2).map(&:prep)
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

  def roll(dice_string, directives_string=nil)
    directives = directives_from(directives_string)
    dice = DMTool::Parser::DiceString.new(dice_string)
    result = DMTool::Roller.sum(dice.dice, directives)
    result = dice.modifier.call(result)
  end

  def raw(dice_string, directives_string=nil)
    dice = DMTool::Parser::DiceString.new(dice_string)
    directives = directives_from(directives_string)
    DMTool::Roller.roll(dice.dice, directives)
  end

  alias parse parse!

  private

  def directives_from(directives_string)
    directives_string = 'roll' if directives_string.blank?
    directives = directives_string.split ','
    directives.map { |str| DMTool::Parser::DieDirective.new(str) }
  end
end
