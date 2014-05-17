class Vote
  attr_reader :voter, :value

  def initialize( voter, value )
  	@voter = voter
  	@value = value
  end
end