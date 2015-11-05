
require 'rubigraph'
require 'awesome_print'
Rubigraph.init  
Rubigraph.clear

class DVertex

	attr_accessor :id, :node, :neighbour_dvertices , :neighbouring_dedges , :highlighted 

	def initialize
		@node = Rubigraph::Vertex.new
		@neighbour_dvertices = []
		@neighbouring_dedges = []
		@node.set_attribute("callback_left_doubleclick" , "http://127.0.0.1:1080/vertex_callback" ) 
		@highlighted = false
		@node.set_attribute('shapedetail' , 1)
		@node.set_attribute('size' , 2.0)
	end

	def move_in_direction(i)
		move_on_dedge( neighbouring_dedges[i] ) 
	end

	def move_on_dedge(dedge)
		(dedge.end_dvertices - [self]).first
	end

	def direction_of_dedge(dedge)
		index = 0
		@neighbouring_dedges.each{ |neighbouring_dedge| 
			break if neighbouring_dedge.edge == dedge.edge 				
			index += 1
		} 
		return index
	end

	def set_probabilistic_color(probability, probability_array )
		# @node.color = "##{ColorGenerator.create(probability, max_probability)}"
		@node.color = "##{ColorGenerator.contour_create(probability, probability_array )}"

	end

	def set_probabilistic_label(probability)
		@node.label = "#{probability.round(3)}"
	end

	def inspect
		"NodeId:#{@id}"
	end

	def highlight
		@highlighted = true
		@neighbouring_dedges.each do |dedge|
			dedge.edge.set_attribute("width" , "4.0") 
			dedge.edge.set_attribute("color" , "#FFFF00") 
			dedge.edge.label = direction_of_dedge(dedge).to_s
		end
		@node.set_attribute("shape" , "cube" ) 		
	end

	def unhighlight
		@highlighted = false
		@neighbouring_dedges.each do |dedge|
			dedge.edge.set_attribute("width" , "1.0") 
			dedge.edge.set_attribute("color" , "#FFFFFF") 
			dedge.edge.label = ""
		end
		@node.set_attribute("shape" , "cube" )
	end

	def toggle_highlight
		if @highlighted
			unhighlight()
		else
			highlight()
		end
	end


end

class DEdge

	attr_accessor :id, :edge ,:end_dvertices

	def initialize(dvertex1, dvertex2)
		@end_dvertices = [dvertex1 , dvertex2]
		@edge = Rubigraph::Edge.new( dvertex1.node , dvertex2.node )
		@edge.set_attribute("strength" , 20.0)
		dvertex1.neighbour_dvertices << dvertex2
		dvertex2.neighbour_dvertices << dvertex1
	end

end

class DGraph
	attr_accessor :id, :dvertices, :dedges ,:node_size , :edge_size , :shortest_distance

	def initialize
		@dvertices = []
		@dedges = []
		@node_size = 0
		@edge_size = 0
		@shortest_distance = nil
	end

	def add_dvertex
		dvertex = DVertex.new
		@dvertices << dvertex
		@node_size += 1
		dvertex.id = @node_size

		dvertex.node.color  = '#FFFFFF'
		dvertex.node.shape  = 'cube'
		# dvertex.node.label = dvertex.id.to_s

		dvertex
	end

	def connect(dvertex1 , dvertex2 )
		dedge = DEdge.new(dvertex1, dvertex2)
		dvertex1.neighbouring_dedges << dedge
		dvertex2.neighbouring_dedges << dedge
		@dedges << dedge
		@edge_size += 1
		dedge.id = @edge_size		
		dedge
	end

	def disconnect(dvertex1 , dvertex2 )

		dvertex1.neighbour_dvertices.delete(dvertex2)
		dvertex2.neighbour_dvertices.delete(dvertex1)
		dedge = @dedges.select{|dedge| dedge.end_dvertices == [dvertex1, dvertex2] }.first
		dedge.edge.remove
		@edge_size -= 1
		@dedges.delete(dedge)

	end


	def compute_shortest_distance
		 @shortest_distance = []

		 for id in 1..(@node_size)
		    @shortest_distance[id] = [nil] + [Float::INFINITY]*(@node_size)
		    @shortest_distance[id][id] = 0
		 end

		 for dedge in @dedges
		    dvertex1 , dvertex2 = dedge.end_dvertices
		    @shortest_distance[dvertex1.id][dvertex2.id] = 1 
		    @shortest_distance[dvertex2.id][dvertex1.id] = 1 
		 end

		 for k in 1..(@node_size)
		    for i in 1..(@node_size)
		       for j in 1..(@node_size)
		          if @shortest_distance[i][j] > @shortest_distance[i][k] + @shortest_distance[k][j] 
		             @shortest_distance[i][j] = @shortest_distance[i][k] + @shortest_distance[k][j]
		         end
		        end
		     end
		 end

	end

	def get_shortest_distance(dvertex1, dvertex2)
		@shortest_distance[dvertex1.id][dvertex2.id] rescue nil
	end

	def characteristic_length
		combinations = (1..(@node_size)).to_a.combination(2).to_a
		sum = 0
		for combination in combinations
			sum += @shortest_distance[combination.first][combination.last]
		end
		return (sum.to_f)/( @node_size * ( @node_size - 1 )).to_f
	end

	def clustering_coefficient
		sum_clustering_coefficients = 0
		for dvertex in @dvertices
			neighbour_dvertices = dvertex.neighbour_dvertices
			if neighbour_dvertices.size > 1
				# ap "---#{neighbour_dvertices.size}---"
				combinations = neighbour_dvertices.to_a.combination(2).to_a
				true_edges = 0
				for combination in combinations
					if combination.first.neighbour_dvertices.include?(combination.last)
						true_edges += 1 
					end
				end
				individual_clustering_coefficient = (true_edges.to_f)/(combinations.size)
				sum_clustering_coefficients += individual_clustering_coefficient
			else
				sum_clustering_coefficients += 0
			end
		end		
		mean_clustering_coefficient = sum_clustering_coefficients.to_f / @node_size.to_f		
		mean_clustering_coefficient
	end


	def highlight_directions_of_node( node_id )
		ap node_id
		ap node_id
		ap node_id
		ap node_id
		dvertex = @dvertices.select{|dvertex| dvertex.node.id == node_id }.first
		ap dvertex.node.id
		ap dvertex.node.id
		ap dvertex.neighbour_dvertices.size
		for neighbour_dvertex in dvertex.neighbour_dvertices
			ap neighbour_dvertex.node.id
			neighbouring_edges = @dedges.select{ |dedge| dedge.end_dvertices.include?(self)  }
			ap neighbouring_edges.size
		# 	# neighbouring_edges.each{|dedge| 
		# 	# 	dedge.edge.set_attribute("arrow" , true) 
		# 	# }
		end
		dvertex.node.color = "#FFFFFF"
	end

end


class ColorGenerator

	def self.create(probability , max_probability = 1 )
		# fraction = probability / max_probability
		fraction = probability / max_probability

		
		red_hue = (fraction*255).to_i.to_s(16).rjust(2,'0')
		blue_hue = ((1-fraction)*255).to_i.to_s(16).rjust(2,'0')
		green_hue = "FF"
		# ap "--------"
		# ap red_hue
		# ap blue_hue
		"#{red_hue}#{green_hue}#{blue_hue}"
	end

	def self.contour_create(probability , probability_array)
		mean = probability_array.mean
		sd = probability_array.standard_deviation
		fraction = probability / probability_array.max.to_f

		if (probability > (mean + 2 * sd) )
			# red major
			if fraction > 0.5
				red_hue = (fraction*255).to_i.to_s(16).rjust(2,'0')
				green_hue = ((1-fraction)*255).to_i.to_s(16).rjust(2,'0')
			else
				red_hue = ((1-fraction)*255).to_i.to_s(16).rjust(2,'0')
				green_hue = (fraction*255).to_i.to_s(16).rjust(2,'0')
			end
			blue_hue = "00"

		elsif probability > (mean )
			# green major
			red_hue = "00"
			if fraction > 0.5
				green_hue = (fraction*255).to_i.to_s(16).rjust(2,'0')
				blue_hue = ((1-fraction)*255).to_i.to_s(16).rjust(2,'0')
			else
				green_hue = ((1-fraction)*255).to_i.to_s(16).rjust(2,'0')
				blue_hue = (fraction*255).to_i.to_s(16).rjust(2,'0')
			end
		else
			# blue major
			red_hue = "00"
			green_hue = "00"
			blue_hue = ((1-fraction)*255).to_i.to_s(16).rjust(2,'0')
		end
		"#{red_hue}#{green_hue}#{blue_hue}"
	end

end

# graph = DGraph.new

# dvertex1 = graph.add_dvertex
# dvertex2 = graph.add_dvertex
# dvertex3 = graph.add_dvertex
# dvertex4 = graph.add_dvertex
# dvertex5 = graph.add_dvertex
# dvertex7 = graph.add_dvertex

# graph.connect(dvertex1, dvertex2)
# graph.connect(dvertex2, dvertex3)
# graph.connect(dvertex3, dvertex4)
# graph.connect(dvertex2, dvertex4)
# graph.connect(dvertex1, dvertex4)

# graph.disconnect(dvertex1, dvertex3)
# graph.disconnect(dvertex2, dvertex3)

# ap graph.dvertices[0].neighbour_dvertices.include?(graph.dvertices[1])

# ap graph.dvertices[1]

# graph.compute_shortest_distance

# ap graph.shortest_distance

# ap graph.characteristic_length

# ap graph.clustering_coefficient

# ap "---------------"

# ap graph.dedges




 # shortest_distance = []

 # for id in 1..(graph.node_size)
 #    shortest_distance[id] = [nil] + [0]*(graph.node_size)
 #    shortest_distance[id][id] = 0
 # end

 # for dedge in graph.dedges
 #    dvertex1 , dvertex2 = dedge.end_dvertices
 #    shortest_distance[dvertex1.id][dvertex2.id] = 1 
 #    shortest_distance[dvertex2.id][dvertex1.id] = 1 
 # end

 # ap shortest_distance
 # # ap graph.node_size

 # for k in 1..(graph.node_size)
 #    for i in 1..(graph.node_size)
 #       for j in 1..(graph.node_size)
 #          if shortest_distance[i][j] > shortest_distance[i][k] + shortest_distance[k][j] 
 #             shortest_distance[i][j] = shortest_distance[i][k] + shortest_distance[k][j]
 #         end
 #        end
 #     end
 # end

 # # ap shortest_distance
