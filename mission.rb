class Mission
  attr_reader :mission_efforts, :require_to_fail, :number_of_players, :votes
  def initialize(game, number_of_players, require_to_fail=1)
    @number_of_players = number_of_players
    @require_to_fail = require_to_fail
    @votes = []
    @operatives = []
    @tasks = []
  end

  def to_json
    {
      votes: @votes.map { |vote| { vote.player.name => value }  },
      tasks: @tasks.map(&:did_pass?)
    }
  end

  def add_vote(vote)
    @votes << vote
  end

  def enough_votes?
    votes.count >= game.players
  end

  def status
    return :planning if @operatives.count < number_of_players
    return :voting if !enough_votes?
    return :aborted if vote_failed?
    return :failed if is_mission_failed?
    return :success
  end

  def vote_failed?
    votes.count { |vote| vote.value == false } > ( votes / 2 )
  end

  def add_effort(effort)
    mission_efforts << effort
  end

  def mission_done?
    mission_efforts.size >= number_of_players
  end

  def is_mission_failed?
    mission_efforts.count(&:failed?) >= require_to_fail
  end
end
