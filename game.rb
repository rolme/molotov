require_relative 'team'
require_relative 'player'
require_relative 'mission'
require_relative 'task'
require_relative 'vote'

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
    @leader_id = rand(players.size - 1)
    start_mission
  end

  def to_json
    {
      players: players.map(&:to_json),
      missions: missions.map(&:to_json)
    }
  end

  def state
    current_mission.state
  end

  def find_player_by_user_id(user_id)
    players.find { |player| player.name.downcase == user_id.downcase }
  end

  def user_plays_task_value(user_id, value)
    current_mission.add_task(Task.new(find_player_by_user_id(user_id), value))
  end

  def user_plays_vote_value( user_id, value) 
    current_mission.add_vote(Vote.new(find_player_by_user_id(user_id), value))
  end

  def leader_adds_operative(user_id)
    current_mission.add_operative(find_player_by_user_id(user_id))
  end

  def find_player_by_user_id(user_id)
    #TODO
  end

  def current_mission_number
    #Fix to deal with status
    missions.count(&:played?) + 1
  end

  def mission_size
    @mission_sizes[current_mission_number - 1]
  end

  def start_mission
    increment_leader
    missions << Mission.new( mission_size, players.count )
  end

  def current_leader
    players[@leader_id]
  end

  def increment_leader
    @leader_id = @leader_id + 1
    if @leader_id >= players.size
      @leader_id = 0
    end
  end

  private

  def current_mission
    @missions.last
  end

  def add_team(name)
    @teams << Team.new(name)
  end

  def add_player(name)
    @players << Player.new(name, self)
  end


  def add_task(task)
    current_mission.play_task(task)
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
