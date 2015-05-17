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

    method = METHODS.fetch(keyword.to_sym)

    # raise DirectiveError.new("Invalid directive: #{text}")
  end

  def self.reroll(die, on:)
    min, max = on.split('-').map(&:to_i)
    max = min if max.nil?
    (min..max).include? result

  end

end
