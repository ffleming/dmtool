class DMTool::Parser::DiceString
  attr_reader :string, :type, :number, :sides
  def initialize(string)
    @string = string
    validate_format!
    parse_string
  end

  def dice
    opts = {
      fudge:      nil,
      standard:  { sides: sides },
      exploding: { sides: sides, exploding: true }
    }
    options = opts[type]
    (1..number).map { CLASSES[type].new(options) }
  end

  private

  SYMBOLS = {
    d:  :standard,
    df: :fudge,
    f:  :fudge,
    e:  :exploding
  }

  CLASSES = {
    fudge:     DMTool::FudgeDie,
    standard:  DMTool::Die,
    exploding: DMTool::Die
  }

  def parse_string
    num_str, type_str, sides_str = regex.match(string).captures
    num_str = 1 if num_str == ''
    @number = num_str.to_i
    @sides = sides_str.to_i
    @type =  SYMBOLS.fetch(type_str.downcase.to_sym)
  end

  def validate_format!
    raise DiceStringError.new("#{@string} doesn't match /#{regex}/") unless @string =~ regex
  end

  def regex
    /^(\d*)(d|e|f|df)(\d*)$/i
  end

end
