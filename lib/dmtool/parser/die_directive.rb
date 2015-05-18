class DMTool::Parser::DieDirective
  attr_reader :text

  def initialize(text='roll')
    @text = text
    build_proc_from text
  end

  def process(die)
    @proc.call(die, proc_opts)
  end

  private

  attr_reader :proc, :proc_opts

  def build_proc_from(text)
    keyword, remainder = text.split(/ /)
    raise DirectiveError.new("Invalid directive: #{text}") if keyword.blank?
    method = METHODS.fetch(keyword.to_sym, nil)
    raise DirectiveError.new("Invalid directive: #{text}") if method.nil?
    @proc = method
    @proc_opts = remainder
  end

  def self.reroll
    Proc.new do |die, on|
      min, max = on.split('-').map(&:to_i)
      max = min if max.nil?
      die.roll
      die.roll while (min..max).include? die.value
      die.value
    end
  end

  def self.roll
    Proc.new do |die|
      die.roll
    end
  end

  def self.explode
    Proc.new do |die|
      result = die.roll
      result += die.roll while result % die.sides == 0
    end
  end

  def self.fudge
    Proc.new do |die|
      index = die.roll % 3
       res = [DMTool::Result::Success, DMTool::Result::NilResult, DMTool::Result::Failure][index]
       die.history.push res
    end
  end

  METHODS = {
    reroll:  DMTool::Parser::DieDirective.reroll,
    roll:    DMTool::Parser::DieDirective.roll,
    explode: DMTool::Parser::DieDirective.explode,
    fudge:   DMTool::Parser::DieDirective.fudge
  }

end
