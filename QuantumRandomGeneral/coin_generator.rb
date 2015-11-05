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
