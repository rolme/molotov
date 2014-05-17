class Mission
  attr_reader :tasks, :require_to_fail, :number_of_operatives, :votes, :number_of_players
  def initialize(number_of_operatives, number_of_players, require_to_fail=1)
    @number_of_operatives = number_of_operatives
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

  def add_operative(operative)
    @operatives << operative
  end

  def enough_votes?
    votes.count >= number_of_players
  end

  def state
    return :planning if @operatives.count < number_of_operatives
    return :voting if !enough_votes?
    return :aborted if vote_failed?
    return :vote_passed unless mission_done?
    return :failed if is_mission_failed?
    return :success
  end

  def terminal_state?
    [ :failed, :success, :aborted ].member?( state )
  end

  def vote_failed?
    votes.count { |vote| vote.value == false } > ( votes.count / 2 )
  end

  def add_task(task)
    tasks << task
  end

  def mission_done?
    tasks.size >= number_of_operatives
  end

  def is_mission_failed?
    tasks.count(&:failed?) >= require_to_fail
  end

  def played?
    [:failed, :success].member? state
  end
end
