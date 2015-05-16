class DMTool::Die
  attr_reader :sides, :explodes, :history

  def initialize(sides: 6, explodes: false)
    raise ArgumentError.new("Invalid sides: #{sides}") unless sides.is_a?(Fixnum) && sides > 1
    @sides = sides
    @explodes = explodes
    @history = []
  end

  def roll
    result = rand_roll
    result += rand_roll while explodes? && result % sides == 0
    history.push result
    result
  end

  alias explodes? explodes
  alias roll! roll

  private

  def rand_roll
    rand(1..sides)
  end
end
