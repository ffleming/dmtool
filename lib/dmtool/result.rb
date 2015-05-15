class DMTool::Result
  attr_reader :success, :failure, :critical

  def initialize(success: false, failure: false, critical: false)
    @success = success
    @failure = failure
    @critical = critical
  end

  def critical_success
    critical? && success?
  end

  def critical_failure
    critical? && failure?
  end

  alias success? success
  alias failure? failure
  alias critical? critical
  alias critical_failure? critical_failure
  alias critical_success? critical_success

  Success         = DMTool::Result.new(success: true, failure: false, critical: false)
  Failure         = DMTool::Result.new(success: false, failure: true, critical: false)
  NilResult       = DMTool::Result.new(success: false, failure: false, critical: false)
  CriticalSuccess = DMTool::Result.new(success: true, failure: false, critical: true)
  CriticalFailure = DMTool::Result.new(success: false, failure: true, critical: true)
end
