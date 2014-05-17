class Task
  attr_reader :did_pass, :player

  def initialize(player, value)
    @player = player
    @did_pass = !!value
  end

  def failed?
    !did_pass
  end
end
