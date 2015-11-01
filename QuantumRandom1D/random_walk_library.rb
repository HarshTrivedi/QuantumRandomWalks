require 'awesome_print'
require 'pygments'
require 'gruff'
require 'complex'
require './generate_graph.rb'

class Coin

	attr_accessor :plus_plus_amplitude , :plus_minus_amplitude , :minus_plus_amplitude , :minus_minus_amplitude , :name

	def initialize( plus_plus = nil , plus_minus = nil , minus_plus = nil , minus_minus = nil , name = nil)
		#default is Hadamard Gate
		@plus_plus_amplitude = plus_plus ||     Complex(	 (1/Math::sqrt(2))	,	0	)
		@plus_minus_amplitude = plus_minus ||   Complex(	 (1/Math::sqrt(2))	,	0	)
		@minus_plus_amplitude = minus_plus ||   Complex(	 (1/Math::sqrt(2))	,	0	)
		@minus_minus_amplitude = minus_minus || Complex(	(-1/Math::sqrt(2))	,	0	)
		@name = name || "Hadamard"
	end

	def operate(state)
		if state.operation == :minus
			state1 = State.new(state.position + 1 , :plus , ( @minus_plus_amplitude  )*state.amplitude) 
			state2 = State.new(state.position - 1 , :minus, ( @minus_minus_amplitude )*state.amplitude) 
			return [state1, state2]
		elsif state.operation == :plus
			state1 = State.new(state.position + 1 , :plus  , ( @plus_plus_amplitude  )*state.amplitude) 
			state2 = State.new(state.position - 1 , :minus , ( @plus_minus_amplitude )*state.amplitude) 
			return [state1, state2]
		end
	end

end


class State

	attr_accessor :amplitude, :position, :operation

	def initialize(position = position , operation = operation , amplitude = amplitude)
		@position = position || 0
		@operation = operation || :minus
		@amplitude = amplitude || Complex(1)
	end

end



class RandomWalk

	attr_accessor :initial_state, :current_state , :coin , :steps_taken

	def initialize( initial_state = nil , coin = nil)
		@initial_state = initial_state || [State.new(0 , :plus)]
		@current_state = @initial_state
		@coin = coin || Coin.new() 
		@steps_taken = 0
	end

	def step
		superimposed_state = @current_state.map{|state| @coin.operate(state) }.flatten
		
		state_amplitude_hash = Hash.new(0)
		for state in superimposed_state
			state_amplitude_hash["#{state.position}|#{state.operation}"] += state.amplitude
		end

		new_superimposed_state = []
		state_amplitude_hash.each do |position_operation , amplitude|
			position , operation = position_operation.split("|")
			position = position.to_i
			operation = operation.to_sym
			new_superimposed_state << State.new(position , operation , amplitude ) if  ( amplitude != 0.0)
		end
		@current_state = new_superimposed_state
		@steps_taken += 1
	end

	def probabilities_hash
		probabilities_hash = Hash.new(0)
		current_state.each do |state|
			probabilities_hash[state.position] += (state.amplitude.magnitude ** 2)
		end
		probabilities_hash
	end

	def amplitude_hash
		amplitude_hash = Hash.new(0)
		current_state.each do |state|
			amplitude_hash[state.position] += (state.amplitude)
		end
		amplitude_hash
	end

	def positions
		current_state.map(&:position).uniq.sort
	end

	def plot_probability_distribution

		plot_array = probabilities_hash.to_a.sort_by(&:first)
		graph = line_chart( 
			plot_array.to_a.map{|x| [ "p(#{x.first})" , x.last]} , 
				{ 
					discrete: true  , 
					height: '600px' , 
					width: "1000px" , 
					library: {
						curveType: "none", 
						pointSize: 0 , 
						title: "Probability Distribution of the States in Quantum Random Walk for 1-D after #{@steps_taken} steps ",
						vAxis: {title: "state probability"},
						hAxis: {title: "states"}
				}
			}
			)

		# details = %{
		# 	<b>Coin used : </b> #{@coin.to_printable_hash.ai(html:true, multiline: false)} <br>
		# 	<b>Initial State : </b>  #{@initial_state.ai(html:true, multiline: false)} 
		# }
		# Pygments.css(:style => "pastie")
		details = %{
			<b>Coin used : </b>      #{Pygments.highlight @coin.to_printable_hash.to_a } 
			<b>Initial State : </b>  #{Pygments.highlight @initial_state }
		}
		erb_wrapper = ErbWrapper.new( template(graph , details) )
		erb_wrapper.save(File.join( '.' , 'plot.html'))
	end

end


class Object
  def to_printable_hash
    instance_variables.map do |var|
      [var[1..-1].to_sym, instance_variable_get(var)]
    end.to_h
  end
end