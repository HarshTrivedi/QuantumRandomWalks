
require './random_walk_library.rb'

hadamard_gate = Coin.new(
		Complex(	 (1/Math::sqrt(2))	,	0	),	#plus_plus
		Complex(	 (1/Math::sqrt(2))	,	0	),	#plus_minus
		Complex(	 (1/Math::sqrt(2))	,	0	),	#minus_plus
		Complex(	(-1/Math::sqrt(2))	,	0	),	#minus_minus
		"Hadamard"
	)

balanced_coin_gate = Coin.new(
		Complex(	 (1/Math::sqrt(2))	,	0	),	#plus_plus
		Complex(	 0	,	(1/Math::sqrt(2))	),	#plus_minus
		Complex(	 0	,	(1/Math::sqrt(2))	),	#minus_plus
		Complex(	(1/Math::sqrt(2))	,	0	),	#minus_minus
		"Balanced Coin"
	)


plus_state = [State.new(0 , :plus)]
minus_state = [State.new(0 , :minus)]
balanced_state = [ State.new(0 , :plus , Complex( (1/Math::sqrt(2)) , 0 ) ) , State.new(0 , :minus, Complex( 0 , (1/Math::sqrt(2)) ) ) ]


walk = RandomWalk.new( balanced_state , hadamard_gate )

100.times { walk.step }

walk.plot_probability_distribution

ap walk.initial_state
ap walk.current_state
