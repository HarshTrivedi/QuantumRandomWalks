require './dgraph.rb'
require './random_walk_library.rb'
require 'matrix'
 require "xmlrpc/server"

degrees_of_freedom = 4

#------------------------------------#
### Coin Generation (STARTS) ###
coin_matrix = MatrixGenerator.grovers_matrix(degrees_of_freedom)
coin = Coin.new( coin_matrix )
### Coin Generation (ENDS) ###
#------------------------------------#


### Graph Generation (STARTS) ###
graph = DGraph.new
dvertices = []
n = 10
k = degrees_of_freedom
n.times do 
	dvertices << graph.add_dvertex
end

for j in 1..(k/2)
	n.times do |i|
	    graph.connect( dvertices[i-1] , dvertices[ ((i-1)+ j)%n ])
	end
end

last_vertex = graph.dvertices.last
last_vertex.neighbour_dvertices = last_vertex.neighbour_dvertices.reverse
for dvertex in graph.dvertices
	dvertex.neighbour_dvertices = dvertex.neighbour_dvertices.sort_by{|x| x.id % 10}
end

### Graph Generation (ENDS) ###

#------------------------------------#

### Initial State Selection (STARTS) ###


# # 0 and 1 are only 2 directions #
initial_state = [State.new( graph.dvertices.first , 0 )]

# ### Initial State Selection (ENDS)   ###

# #------------------------------------#

# graph.dvertices.each do |x|
# 	ap x.to_printable_hash
# end

$walk = RandomWalk.new( graph , initial_state , coin )

# # ap $walk.initial_state.first.to_printable_hash
3.times { $walk.step }


ap probability_array = $walk.current_state.map{|state| (state.amplitude.magnitude**2) }
sum = 0
probability_array.each{|a| sum += a}
ap sum
# $walk.plot_probability_distribution


for state in $walk.current_state
	ap state.to_printable_hash
end




server = XMLRPC::Server.new(8080)

server.add_handler("vertex_callback") do |node_id|

	dvertex = graph.dvertices.select{|dvertex| dvertex.node.id == node_id}.first
	dvertex.toggle_highlight
end

server.set_default_handler do |name, *args|
  raise XMLRPC::FaultException.new(-99, "Method #{name} missing" +
                                   " or wrong number of parameters!")
end

server.serve
