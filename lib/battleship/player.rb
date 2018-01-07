require_relative 'board'
require_relative 'carrier'
require_relative 'battleship'
require_relative 'destroyer'
require_relative 'submarine'
require_relative 'patrol_boat'

class Player

	attr_reader :board, :target_board, :carrier, :battleship, :destroyer,
	            :submarine, :patrol_boat

	def initialize(name) 
		@name = name
		@board = Board.new
		@target_board = Board.new
		@carrier = Carrier.new 
		@battleship = Battleship.new
		@destroyer = Destroyer.new
		@submarine = Submarine.new
		@patrol_boat = PatrolBoat.new
		@ships_left = Board::NUM_SHIPS
	end

	def name
		@name
	end

	def name=(str)
		@name = str
	end 
	
	def ships_left
		@ships_left
	end

	def ships_left=(str)
		@ships_left = str
	end



	def to_s
		@name
	end

	#print side-by-side ship status and shpts taken boards
	def print_boards
		puts "      SHIP STATUS                   SHOTS TAKEN".colorize(:light_red)
		puts "  1 2 3 4 5 6 7 8 9 10          1 2 3 4 5 6 7 8 9 10".colorize(:green)
		row_letter = ('A'..'Z').to_a
		row_number = 0
		@board.grid.each do |row1|
			print row_letter[row_number].colorize(:green) + ' '
			print_cell(row1)
			print "        "
			print row_letter[row_number].colorize(:green) + ' '
			print_row_number(row_number)
			print "\n"
			row_number += 1
		end
	end
	
	def print_cell(row1)
		row1.each {|cell| print cell.to_s + ' '}
	end
	
	def print_row_number(row_number)
		@target_board.grid[row_number].each {|cell| print cell.to_s + ' '}
		end
end
