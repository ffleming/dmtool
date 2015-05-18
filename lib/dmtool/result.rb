class DMTool::Result
  include Comparable

  def initialize(success: false, failure: false, critical: false, symbol: :nil_result)
    @success = success
    @failure = failure
    @critical = critical
    @symbol = symbol
  end

  public

  Success         = DMTool::Result.new(success: true, failure: false, critical: false, symbol: :success)
  Failure         = DMTool::Result.new(success: false, failure: true, critical: false, symbol: :failure)
  NilResult       = DMTool::Result.new(success: false, failure: false, critical: false, symbol: :nil_result)
  CriticalSuccess = DMTool::Result.new(success: true, failure: false, critical: true, symbol: :critical_success)
  CriticalFailure = DMTool::Result.new(success: false, failure: true, critical: true, symbol: :critical_failure)

  attr_reader :success, :failure, :critical, :symbol

  def critical_success
    critical? && success?
  end

  def critical_failure
    critical? && failure?
  end

  def to_s
    "#{to_sym}"
  end

  def to_i
    val = 0
    val += 1 if success?
    val -=1 if failure?
    val *=2 if critical?
    val
  end

  def coerce(other)
    [other, self.to_i]
  end

  def +(other)
    self.to_i + other.to_i
  end

  def <=>(other)
    self.to_i <=> other.to_i
  end

  alias success? success
  alias failure? failure
  alias critical? critical
  alias critical_failure? critical_failure
  alias critical_success? critical_success
  alias to_sym symbol
end
