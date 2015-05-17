class DMTool::Parser::DieDirective
  attr_reader :text

  def initialize(text='')
    @text = text
    @proc = Proc.new { |die| die.roll }
    @complete = false
  end

  def process(die)
    @proc.call(die)
  end

  def to_s
    raise NotImplementedError.new "to_s in Directive"
  end

  def to_i
    raise NotImplementedError.new "to_i in Directive"
  end

  private

  def proc_from(text)
    keyword, remainder = text.split(/ /)
    raise DirectiveError.new("Invalid directive: #{text}") if keyword.blank? || remainder.blank?
    method = METHODS.fetch(keyword.to_sym, nil)
    raise DirectiveError.new("Invalid directive: #{text}") if method.nil?
    method
  end

  def self.reroll
    Proc.new do |die, opts|
      on = opts.fetch :on
      min, max = on.split('-').map(&:to_i)
      max = min if max.nil?
      die.roll while (min..max).include? die.value
    end
  end

  def self.roll
    Proc.new do |die|
      die.roll
    end
  end
  METHODS = {
    reroll: DMTool::Parser::DieDirective.reroll,
    nil:    DMTool::Parser::DieDirective.roll
  }

end
