require './dgraph.rb'
require './random_walk_library.rb'
require 'matrix'
require "xmlrpc/server"
require 'descriptive_statistics'

degrees_of_freedom = 4

#------------------------------------#
### Coin Generation (STARTS) ###
coin_matrix = MatrixGenerator.grovers_matrix(degrees_of_freedom)
coin = Coin.new( coin_matrix )
### Coin Generation (ENDS) ###
#------------------------------------#


### Graph Generation (STARTS) ###
graph = DGraph.new
m , n = [19 , 19] 


dvertices = []

n.times do |j|
	dvertices[j] = []
	m.times do 
		dvertex = graph.add_dvertex
		dvertices[j] << dvertex
	end
	(m-1).times do |i|
	    graph.connect( dvertices[j][i] , dvertices[j][ i + 1])
	end

	if j != 0
		m.times do |i|
			graph.connect( dvertices[j-1][i] , dvertices[j][i] )
		end
	end

end

# (n-1).times do |j|
# 	m.times do |i|
# 		graph.connect( dvertices[j][i-1] , dvertices[j+1][i-1] )
# 	end
# end
# ap dvertices


# ### Graph Generation (ENDS) ###

# #------------------------------------#

# ### Initial State Selection (STARTS) ###

initial_dvertex = graph.dvertices.select{|dvertex| dvertex.id == ((m * (n/2) + (m/2)) + 1)}.first
initial_state = [State.new( initial_dvertex , 0 )]

# # ### Initial State Selection (ENDS)   ###

# # #------------------------------------#

# # graph.dvertices.each do |x|
# # 	ap x.to_printable_hash
# # end

$walk = RandomWalk.new( graph , initial_state , coin )

# ap $walk.initial_state.first.to_printable_hash
8.times do |i|
	ap "Taking step #{i}"
 	$walk.step 
 	ap "Step #{i} completed"
end

$walk.plot_probability_distribution()

probability_array = $walk.current_state.map{|state| (state.amplitude.magnitude**2) }
# ap probability_array


sum = 0
probability_array.each{|a| sum += a}
ap sum
# $walk.plot_probability_distribution

# ap "---"
# ap $walk.current_state
# ap "---"

# for state in $walk.current_state
# 	ap state.to_printable_hash
# end


# fork do 

	server = XMLRPC::Server.new(1080)
	server.add_handler("vertex_callback") do |node_id|
		dvertex = graph.dvertices.select{|dvertex| dvertex.node.id == node_id}.first
		dvertex.toggle_highlight
	end
	server.set_default_handler do |name, *args|
	  raise XMLRPC::FaultException.new(-99, "Method #{name} missing" +
	                                   " or wrong number of parameters!")
	end
	server.serve
# end








