class DMTool::FudgeDie
  attr_reader :history
  SIDES = [DMTool::Result::Success, DMTool::Result::NilResult, DMTool::Result::Failure]
  def initialize(opts={})
    @history = []
  end

  def roll
    result = SIDES.sample
    history.push result
    result
  end

  def value
    history.last
  end

  alias roll! roll
end
