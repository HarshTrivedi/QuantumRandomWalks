
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
		@edge.set_attribute("strength" , 1.0)
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
