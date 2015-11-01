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
		if state.operation_x == :minus and state.operation_y == :minus 
			state_x1 = State.new(state.position_x + 1 	, state.position_y 		, :plus  , :minus , ( @plus_minus_amplitude  )*state.amplitude) 
			state_x2 = State.new(state.position_x - 1 	, state.position_y 		, :minus , :minus , ( @minus_minus_amplitude )*state.amplitude) 
			state_y1 = State.new(state.position_x 		, state.position_y + 1 	, :minus , :plus  , ( @minus_plus_amplitude  )*state.amplitude) 
			state_y2 = State.new(state.position_x 		, state.position_y - 1 	, :minus , :minus , ( @minus_minus_amplitude )*state.amplitude) 
			return [state_x1, state_x2, state_y1, state_y2]
		elsif  state.operation_x == :minus and state.operation_y == :plus 
			state_x1 = State.new(state.position_x + 1 	, state.position_y 		, :plus   , :plus  , ( @plus_plus_amplitude  )*state.amplitude) 
			state_x2 = State.new(state.position_x - 1 	, state.position_y 		, :minus  , :plus  , ( @minus_plus_amplitude )*state.amplitude) 
			state_y1 = State.new(state.position_x 		, state.position_y + 1 	, :minus  , :plus  , ( @minus_plus_amplitude  )*state.amplitude) 
			state_y2 = State.new(state.position_x 		, state.position_y - 1 	, :minus  , :minus , ( @minus_minus_amplitude )*state.amplitude) 
			return [state_x1, state_x2, state_y1, state_y2]
		elsif  state.operation_x == :plus and state.operation_y == :plus 
			state_x1 = State.new(state.position_x + 1 	, state.position_y 		, :plus  , :plus  , ( @plus_plus_amplitude  )*state.amplitude) 
			state_x2 = State.new(state.position_x - 1 	, state.position_y 		, :minus , :plus  , ( @minus_plus_amplitude )*state.amplitude) 
			state_y1 = State.new(state.position_x 		, state.position_y + 1	, :plus  , :plus  , ( @plus_plus_amplitude  )*state.amplitude) 
			state_y2 = State.new(state.position_x 		, state.position_y - 1	, :plus  , :minus , ( @plus_minus_amplitude )*state.amplitude) 
			return [state_x1, state_x2, state_y1, state_y2]
		elsif  state.operation_x == :plus and state.operation_y == :minus
			state_x1 = State.new(state.position_x + 1 	, state.position_y 		, :plus , :minus , ( @plus_plus_amplitude  )*state.amplitude) 
			state_x2 = State.new(state.position_x - 1 	, state.position_y 		, :minus, :minus , ( @plus_minus_amplitude )*state.amplitude) 
			state_y1 = State.new(state.position_x 		, state.position_y + 1	, :plus , :plus  , ( @minus_plus_amplitude  )*state.amplitude) 
			state_y2 = State.new(state.position_x 		, state.position_y - 1	, :plus , :minus , ( @plus_minus_amplitude )*state.amplitude) 
			return [state_x1, state_x2, state_y1, state_y2]
		end
	end

end


class State

	attr_accessor :amplitude, :position_x , :position_y , :operation_x , :operation_y

	def initialize(position_x = position_x , position_y = position_y , operation_x = operation_x , operation_y = operation_y  , amplitude = amplitude)
		@position_x = position_x || 0
		@position_y = position_y || 0
		@operation_x = operation_x || :minus
		@operation_y = operation_y || :minus
		@amplitude = amplitude || Complex(1)
	end

end



class RandomWalk

	attr_accessor :initial_state, :current_state , :coin , :steps_taken

	def initialize( initial_state = nil , coin = nil)
		@initial_state = initial_state || [State.new(0 , 0, :plus, :plus)]
		@current_state = @initial_state
		@coin = coin || Coin.new() 
		@steps_taken = 0
	end

	def step
		superimposed_state = @current_state.map{|state| @coin.operate(state) }.flatten
		# ap '---'
		# ap @coin.operate(@current_state.first)
		# ap '---'
		# ap superimposed_state
		# ap '---'
		state_amplitude_hash = Hash.new(0)
		for state in superimposed_state
			# ap state
			state_amplitude_hash["#{state.position_x}-#{state.position_y}|#{state.operation_x}-#{state.operation_y}"] += state.amplitude
		end
		# ap state_amplitude_hash
		new_superimposed_state = []
		state_amplitude_hash.each do |position_operation , amplitude|
			position , operation = position_operation.split("|")
			position_x , position_y = position.split('-').map(&:to_i)
			operation_x , operation_y = operation.split('-').map(&:to_sym)
			new_superimposed_state << State.new(position_x , position_y , operation_x , operation_y , amplitude ) if  ( amplitude != 0.0)
		end
		# ap "NEW"
		# ap new_superimposed_state
		@current_state = new_superimposed_state
		@steps_taken += 1
	end

	def probabilities_hash
		probabilities_hash = Hash.new(0)
		current_state.each do |state|
			probabilities_hash["#{state.position_x},#{state.position_y}"] += (state.amplitude.magnitude ** 2)
		end
		probabilities_hash
	end

	def amplitude_hash
		amplitude_hash = Hash.new(0)
		current_state.each do |state|
			amplitude_hash["#{state.position_x},#{state.position_y}"] += (state.amplitude)
		end
		amplitude_hash
	end

	def positions
		current_state.map{|x| "#{x.position_x},#{x.position_y}"}.uniq.sort
	end

	def plot_probability_distribution

		plot_array = probabilities_hash.to_a.sort_by(&:first)
		
		# graph = line_chart( 
		# 	plot_array.to_a.map{|x| [ "p(#{x.first})" , x.last]} , 
		# 		{ 
		# 			discrete: true  , 
		# 			height: '600px' , 
		# 			width: "1000px" , 
		# 			library: {
		# 				curveType: "none", 
		# 				pointSize: 0 , 
		# 				title: "Probability Distribution of the States in Quantum Random Walk for 1-D after #{@steps_taken} steps ",
		# 				vAxis: {title: "state probability"},
		# 				hAxis: {title: "states"}
		# 		}
		# 	}
		# 	)

		graph = LazyHighCharts::HighChart.new('graph') do |f|
			  f.title(:text => "Population vs GDP For 5 Big Countries [2009]")
			  f.xAxis(:categories => ["United States", "Japan", "China", "Germany", "France"])
			  f.series(:name => "GDP in Billions", :yAxis => 0, :data => [14119, 5068, 4985, 3339, 2656])
			  f.series(:name => "Population in Millions", :yAxis => 1, :data => [310, 127, 1340, 81, 65])

			  f.yAxis [
			    {:title => {:text => "GDP in Billions", :margin => 70} },
			    {:title => {:text => "Population in Millions"}, :opposite => true},
			  ]

			  f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
			  f.chart({:defaultSeriesType=>"column"})
		end


		details = %{
			<b>Coin used : </b>      #{Pygments.highlight @coin.to_printable_hash.to_a } 
			<b>Initial State : </b>  #{Pygments.highlight @initial_state }
		}
		erb_wrapper = ErbWrapper.new( template( high_chart("some_id", graph ) , details) )
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

# coin = Coin.new

# default_state = State.new
# ap coin.operate(default_state)

walk = RandomWalk.new


# 10.times { walk.step }

# ap walk.probabilities_hash
# ap walk.current_state

ap walk.plot_probability_distribution