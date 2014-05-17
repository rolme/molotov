class Mission
  attr_reader :mission_efforts, :require_to_fail
  def initialize(mission_efforts, require_to_fail=1)
    @mission_efforts = mission_efforts
    @require_to_fail = require_to_fail
  end

  def is_mission_failed?
    mission_efforts.count(&:failed?) >= require_to_fail
  end
end
