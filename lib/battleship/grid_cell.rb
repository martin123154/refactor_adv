class GridCell



 def status
    @status
  end

  def status=(str)
    @status = str
  end

 def ship
    @ship
  end

  def ship=(str)
    @ship = str
  end

	FILL_CHAR = {:open => '+',
			   		:hit => 'X',
					:miss => '0',
					:damaged => "%"}

	def initialize(status = :open, ship = nil)
		@status = status
		@ship = ship
	end

	def to_s
		if @ship && @status != :hit
			@ship.to_s
		else
			FILL_CHAR[@status]
		end
	end

	def hit
		@status = :hit
	end

	def damaged
		@status = :damaged
	end

	def miss
		@status = :miss
	end
end
