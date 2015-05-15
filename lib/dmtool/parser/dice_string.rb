class DMTool::Parser::DiceString
  attr_reader :string, :dice
  def initialize(string)
    @string = string
    validate_format!
    @dice   = parse_dice
  end

  private

  def parse_dice
    num, type, sides = regex.match(string).captures
    num = 1 if num == ''
    (1..num.to_i).map { DMTool::Die.new(sides: sides.to_i, explodes: type == 'e') }
  end

  def validate_format!
    raise DiceStringError.new("#{@string} doesn't match /#{regex}/") unless @string =~ regex
  end

  def regex
    /(\d*)([de])(\d+)/
  end

end
