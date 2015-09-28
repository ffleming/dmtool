class DMTool::Parser
  attr_reader :history
  def initialize
    @history = []
  end

  def parse!(input)
    history.push input
    command, remainder = input.split(/ /, 2).map(&:prep)
    dice_string, directives_string = remainder.to_s.split(',', 2).map(&:prep)

    if respond_to?("cmd_#{command}", true)
      ret = send("cmd_#{command}", dice_string, directives_string)
      ret = "[#{ret.join ', '}]" if ret.is_a? Array
      return "#{ret}"
    end
    raise ParserError.new "Command #{command} not found"
  end

  alias parse parse!

  private

  def cmd_roll(dice_string, directives_string=nil)
    dice = DMTool::Parser::DiceString.new(dice_string)
    directives = directives_from(directives_string, dice)
    result = DMTool::Roller.sum(dice.dice, directives)
    dice.modifier.call(result)
  end

  def cmd_raw(dice_string, directives_string=nil)
    dice = DMTool::Parser::DiceString.new(dice_string)
    directives = directives_from(directives_string, dice)
    DMTool::Roller.roll(dice.dice, directives).map(&:value)
  end

  def cmd_help(*args)
    <<-EOS
    dmtool v#{DMTool::VERSION} help
    dmtool> <command> <dice>, <directives>

    <commands>
      roll: sums output
      raw:  displays individual die values (ignores +/- modifiers)

    <dice>
      e.g. 3d6 for three six-sided dice
      3d6+2 to add 2 to the result of rollng 3d6
      3df for 3 Fudge dice

    <directives>

    Examples:
      roll 2d6
      roll d20+5
      roll d10-2
      roll 3d6, reroll 1-2
    EOS
  end

  def cmd_exit(*args)
    exit
  end

  def directives_from(directives_string, dice)
    directives_string = '' if directives_string.nil?
    directives = directives_string.split ','
    directives.map! { |str| DMTool::Parser::DieDirective.new(str) }
    directives += dice.directives
    directives.select! {|d| d.text != 'roll' } if directives.length > 1
    directives
  end
end
