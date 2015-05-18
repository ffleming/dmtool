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
    dice = DMTool::Parser::DiceString.new(dice_string)
    directives = directives_from(directives_string, dice)
    result = DMTool::Roller.sum(dice.dice, directives)
    result = dice.modifier.call(result)
  end

  def raw(dice_string, directives_string=nil)
    dice = DMTool::Parser::DiceString.new(dice_string)
    directives = directives_from(directives_string, dice)
    DMTool::Roller.roll(dice.dice, directives)
  end

  alias parse parse!

  private

  def directives_from(directives_string, dice)
    directives_string = '' if directives_string.nil?
    directives = directives_string.split ','
    directives.map! { |str| DMTool::Parser::DieDirective.new(str) }
    directives += dice.directives
    directives.select! {|d| d.text != 'roll' } if directives.length > 1
    directives
  end
end
