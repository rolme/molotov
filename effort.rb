class Effort
  attr_reader :did_pass, :player

  def initialize(player, did_pass)
    @player = player
    @did_pass = did_pass
  end

  def failed?
    !did_pass
  end
end
