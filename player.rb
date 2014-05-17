class Player
  attr_accessor :name, :team, :game
  def initialize(name, game)
    self.name = name
    self.game = game
  end

  def to_json
    { name: name }
  end

end
