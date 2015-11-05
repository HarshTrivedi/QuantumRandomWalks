require './dgraph.rb'
require './random_walk_library.rb'
require './coin_generator.rb'
require './graph_generator.rb'
require 'matrix'
require "xmlrpc/server"
require 'descriptive_statistics'

	degrees_of_freedom = 12
	
	coin_matrix = MatrixGenerator.grovers_matrix(degrees_of_freedom)
	coin = Coin.new( coin_matrix )
	
	graph , initial_dvertex = GraphGenerator.regular( 100, 12)
	initial_state = [State.new( initial_dvertex , 0 )]
	
	$walk = RandomWalk.new( graph , initial_state , coin )
	
	7.times{ $walk.step }
	
	$walk.plot_probability_distribution()
	
	
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
	