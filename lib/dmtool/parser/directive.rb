class DMTool::Parser::Directive
  attr_reader :text

  def initialize(text='')
    @text = text
    @proc = proc_from(@text)
  end

  def execute(input)
    @proc.call(input)
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
    binding.pry
    raise DirectiveError.new("Invalid directive: #{text}") if keyword.blank? || remainder.blank?
  end
end
