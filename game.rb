require_relative 'team.rb'
require_relative 'player.rb'
require_relative 'mission.rb'
require_relative 'effort.rb'

class Game
  attr_accessor :teams, :players, :missions
  def initialize(names = [])
    @teams = [Team.new("hello"), Team.new("world")]
    @mission_sizes = [2,3,3,4,3]
    @players = []
    @missions = []
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

  def play_mission(*efforts)
    @missions << Mission.new(efforts)
  end

  def game_over?
    @missions.count(:failed?) > 3 || @missions.count >= @mission_sizes.size
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
