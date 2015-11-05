require 'awesome_print'
require 'pygments'
require 'gruff'
require 'complex'
require 'matrix'
require './generate_graph.rb'


class Coin

	attr_accessor :coin_matrix , :name

	def initialize( matrix , name = nil)
		@coin_matrix = matrix  
		@name = name 
	end

	def operate(original_state)

		new_states = []
		original_state.degrees_of_freedom.times{ new_states << original_state.dup }
		new_states.each_with_index do |state, i| 
			# ap " #{ original_state.operation } , #{i} -> #{@coin_matrix.column_vectors[ original_state.operation ][i]}"
			state.amplitude = state.amplitude * @coin_matrix.column_vectors[ original_state.operation ][i]
			state.position = state.position.move_in_direction(i)
			state.operation = i
			# ap "New State : "
			# ap state.to_printable_hash
		end
		# ap "----------"
		return new_states
	end

end

class State

	attr_accessor :amplitude, :position , :operation, :degrees_of_freedom

	# Position is graph's NODE	
	# Operation is it's current direction of motion ( operation is direction_id )
	def initialize( position , operation , amplitude = nil )
		@position = position
		@operation = operation
		@amplitude = amplitude || Complex(1)
		@degrees_of_freedom = position.neighbour_dvertices.size
	end

	def self.collate(stateA , stateB)
		if (stateA.position == stateB.position) and (stateA.operation == stateB.operation)
			return [State.new( stateA.position , stateA.operation , (stateA.amplitude + stateB.amplitude) )]
		else
			return [stateA , stateB]
		end
	end

end



class RandomWalk

	attr_accessor :graph, :initial_state, :current_state , :coin , :steps_taken

	def initialize( graph, initial_state , coin)
		@graph = graph
		@initial_state = initial_state 
		@current_state = @initial_state
		@coin = coin 
		@steps_taken = 0
		for state in @initial_state
			state.position.node.shape  = 'dodecahedron'			
		end
	end

	def step
		superimposed_state = @current_state.map{|state| @coin.operate(state) }.flatten

		state_amplitude_hash = Hash.new(0)
		for state in superimposed_state
			state_amplitude_hash[ [state.position , state.operation] ] += state.amplitude
		end

		new_superimposed_state = []
		state_amplitude_hash.each do |position_operation , amplitude|
			position , operation = position_operation 
			if ( amplitude != 0.0)
				state_to_be_added = State.new(position , operation , amplitude ) 
				new_superimposed_state << state_to_be_added
			end
		end

		@current_state = new_superimposed_state
		# plot_probability_distribution()
		@steps_taken += 1
	end

	def probabilities_hash
		probabilities_hash = Hash.new(0)
		current_state.each do |state|
			probabilities_hash[ state.position ] += (state.amplitude.magnitude ** 2)
		end
		probabilities_hash
	end

	def amplitude_hash
		amplitude_hash = Hash.new(0)
		current_state.each do |state|
			amplitude_hash[ state.position ] += (state.amplitude)
		end
		amplitude_hash
	end

	def positions
		current_state.map{|x| "#{x.position_x},#{x.position_y}"}.uniq.sort
	end

	def plot_probability_distribution

		probabilities_hash = Hash.new(0)
		@graph.dvertices.each{ |dvertex| 
			dvertex.node.color  = '#FFFFFF' ; 
			# dvertex.node.label = dvertex.id.to_s 
		}

		current_state.each do |state|
			probabilities_hash[state.position] += (state.amplitude.magnitude**2)
		end

		max_probability = probabilities_hash.values.max	
		probabilities_hash.each do |position, probability|
			position.set_probabilistic_color( probability , probabilities_hash.values )
			# position.set_probabilistic_label( probability )			
			# ap "#{position.id} -> #{probability}"
		end
	end

end


class Object
  def to_printable_hash
    instance_variables.map do |var|
      [var[1..-1].to_sym, instance_variable_get(var)]
    end.to_h
  end
end

# coin = Coin.new

# default_state = State.new
# ap coin.operate(default_state)

# walk = RandomWalk.new


# 10.times { walk.step }

# ap walk.probabilities_hash
# ap walk.current_state

# ap walk.plot_probability_distribution


class Complex

	def self.nru(n,power)
		Complex.polar(1, 2 * Math::PI * power / n) #** power
	end

	def round(k)
		array = self.rect.map{|x| x.round(k)}
		Complex( array.first , array.last )
	end

end


class MatrixGenerator

	def self.hadamard_matrix(degrees_of_freedom)
		n = degrees_of_freedom
		if(n == 2)
			matrix = Matrix[
				        [Complex(1/Math::sqrt(n)),Complex(1/Math::sqrt(n))],
				        [Complex(1/Math::sqrt(n)),-Complex(1/Math::sqrt(n))]
				    ]           	
			return matrix
		elsif(n == 4)
			matrix = Matrix[
						[  Complex(1.0/2) ,   Complex(1.0/2)  ,  Complex(1.0/2) ,  Complex(1.0/2) ],
						[  Complex(1.0/2) ,  -Complex(1.0/2)  ,  Complex(1.0/2) , -Complex(1.0/2) ],
						[  Complex(1.0/2) ,   Complex(1.0/2)  , -Complex(1.0/2) , -Complex(1.0/2) ],
						[  Complex(1.0/2) ,  -Complex(1.0/2)  , -Complex(1.0/2) ,  Complex(1.0/2) ]
					]
			return matrix
		end
	end

	def self.dft_matrix(degrees_of_freedom)
		n = degrees_of_freedom		
		matrix = Matrix.build(n,n) { |row , column|
			complex_number = (Complex.nru(n,row **column) * (1/Math::sqrt(n)) )
			complex_number.round(6)
		}
		# matrix = matrix * Matrix.scalar(n, (1/Math::sqrt(n)) )
		return matrix
	end

	def self.grovers_matrix(degrees_of_freedom)
		n = degrees_of_freedom
		matrix = Matrix.rows( [[(2.0)/n]*n]*n ) + Matrix.scalar(n, -1 ) 
		return matrix
	end

end
