class Team
  attr_accessor :name, :players
  def initialize(name)
    self.name = name
    @players = []
  end

  def add_player(player)
    @players << player
    player.team = self
  end
end
