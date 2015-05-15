class DMTool::FudgeDie
  attr_reader :history
  SIDES = [DMTool::Result::Success, DMTool::Result::NilResult, DMTool::Result::Failure]
  def initialize
    @history = []
  end

  def roll
    result = SIDES.sample
    history.push result
    result
  end


  private

  alias roll! roll
end
