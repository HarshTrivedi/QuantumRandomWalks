require './dgraph.rb'
require './random_walk_library.rb'
require './coin_generator.rb'
require 'matrix'
require "xmlrpc/server"
require 'descriptive_statistics'

class GraphGenerator

	def self.grid_2d(m , n)

		dvertices = []
		graph = DGraph.new
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

		initial_dvertex = graph.dvertices.select{|dvertex| dvertex.id == ((m * (n/2) + (m/2)) + 1)}.first
		return graph , initial_dvertex
	end


	def self.grid_3d(m , n , l)

		dvertices = []
		graph = DGraph.new
		
		l.times do |k|
			dvertices[k] =[]
			n.times do |j|
				dvertices[k][j] = []
				m.times do 
					dvertex = graph.add_dvertex
					dvertices[k][j] << dvertex
				end
				(m-1).times do |i|
				    graph.connect( dvertices[k][j][i] , dvertices[k][j][ i + 1])
				end
				if j > 0
					m.times do |i|
						graph.connect( dvertices[k][j][i] , dvertices[k][j-1][i] ) #rescue nil
					end
				end
			end
			
			if k > 0
				m.times do |i|
					n.times do |j|
						graph.connect( dvertices[k-1][j][i] , dvertices[k][j][i] )
					end
				end
			end
		end
		initial_dvertex = graph.dvertices.select{|dvertex| dvertex.id == ((m*n*l)/2 + 1) }.first
		return graph , initial_dvertex
	end

	def self.line_1d(m)
		grid_2d(m,n)
	end	

	def self.regular(n , k)

		graph = DGraph.new
		dvertices = []
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

		initial_dvertex = graph.dvertices.first
		return graph , initial_dvertex

	end	

end


# GraphGenerator.grid_3d(7 , 7 , 7)