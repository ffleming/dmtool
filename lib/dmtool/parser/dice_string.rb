class DMTool::Parser::DiceString
  attr_reader :string, :type, :number, :sides, :modifier
  def initialize(string)
    @string = string
    validate_format!
    parse_string
  end

  def dice
    (1..number).map { DMTool::Die.new(sides: sides)}
  end

  def directives
    [DIRECTIVES[type]].compact
  end

  private

  SYMBOLS = {
    d:  :standard,
    df: :fudge,
    f:  :fudge,
    e:  :exploding
  }

  DIRECTIVES = {
    fudge: DMTool::Parser::DieDirective.new('fudge'),
    standard: DMTool::Parser::DieDirective.new('roll'),
    exploding: DMTool::Parser::DieDirective.new('explode')
  }

  def parse_string
    num_str, type_str, sides_str, mod_string = regex.match(string).captures
    @number   = number_from num_str
    @type     = type_from type_str
    @sides    = sides_from sides_str
    @modifier = modifier_from mod_string
  end

  def number_from(string)
    return 1 if string.blank?
    string.to_i
  end

  def sides_from(string)
    return 6 if type == :fudge
    string.to_i
  end

  def type_from(string)
    SYMBOLS.fetch(string.downcase.to_sym)
  end

  def modifier_from(string)
    return Proc.new { |arg| arg } if string.blank?
    method = string[0].to_sym
    mod    = string[1..-1].to_i
    Proc.new { |arg| arg.send(method, mod) }
  end

  def validate_format!
    raise DiceStringError.new("#{@string} doesn't match /#{regex}/") unless @string =~ regex
  end

  def regex
    @regex ||= /^(\d*)(d|e|f|df)(\d*)([-+]\d+)?$/i
  end

end
