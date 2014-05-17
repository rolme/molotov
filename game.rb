require_relative 'team.rb'
require_relative 'player.rb'
require_relative 'mission.rb'
require_relative 'effort.rb'

class Game
  attr_accessor :teams, :players
  def initialize(names = [])
    @teams = [Team.new("hello"), Team.new("world")]
    @missions = []
    @players = []
    names.each do |name|
      add_player name
    end
  end

  def add_team(name)
    @teams << Team.new(name)
  end

  def add_player(name)
    @players << Player.new(name)
  end

  def assign_teams
    players.sample(2).each do |player|
      teams.first.add_player(player)
    end

    players.select { |player| player.team.nil? }.each do |player|
      teams.last.add_player(player)
    end
    teams
  end
end
