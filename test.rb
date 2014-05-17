require_relative 'game'

g = Game.new %w(Scott Roland Daniel Jose Souza)

g.leader_adds_operative 'Roland'
g.leader_adds_operative 'Jose'

puts g.state

g.user_plays_vote_value 'Roland', true
g.user_plays_vote_value 'Daniel', true
g.user_plays_vote_value 'Scott', false
g.user_plays_vote_value 'Jose', true
g.user_plays_vote_value 'Souza', false

puts g.state

g.user_plays_task_value 'Roland', true
g.user_plays_task_value 'Jose', true

puts g.state

