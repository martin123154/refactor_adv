require_relative 'grid_cell'
require_relative 'carrier'
require_relative 'battleship'
require_relative 'destroyer'
require_relative 'submarine'
require_relative 'patrol_boat'

class Board
attr_reader :column, :row, :i

	NUM_SHIPS = 5
	BOARD_DIM = 10
	ROW = ['A','B','C','D','E','F','G','H','I','J']
	COLUMN = ['1','2','3','4','5','6','7','8','9','10']
	
	Post = Struct.new(:orientation, :ship, :start_position)			
	
	def grid
		@grid
	end
	
	def grid=(str)
		@grid = str
	end
	
	
	def initialize()
		@grid = Array.new(BOARD_DIM).map! {Array.new(BOARD_DIM).map! {GridCell.new}}
	end

	def to_s
		row_letter = ('A'..'Z').to_a
		@i = 0
		puts "  1 2 3 4 5 6 7 8 9 10"
		@grid.each do |row|
		print_coordinates(row_letter,i,row)
		end
	end
	
	def print_coordinates(row_letter,i,row)
			print row_letter[i] + ' '
			row.each {|cell| print cell.to_s + ' '}
			print "\n"
			@i += 1
	end

	def place_ship(ship, start_position, orientation)
		@row = start_position[:row]
		@column = start_position[:column]
		ship.length.times do
			if orientation == :vertical
				vertical_place_ship(row,column,ship)
			else
				horizontal_place_ship(row,column,ship)
			end
		end
	end
	
	def vertical_place_ship(row,column,ship)
		self.grid[row][column].ship = ship
		self.grid[row][column].status = :occupied
		@row += 1 
	end
	
	def horizontal_place_ship(row,column,ship)
		self.grid[row][column].ship = ship
		self.grid[row][column].status = :occupied
		@column += 1
	end

				
	#validate ship placement remains within board
	def valid_coordinates?(ship, start_position, orientation)
		if orientation == :horizontal
			(start_position[:column] + ship.length) <= BOARD_DIM
		else
			(start_position[:row] + ship.length) <= BOARD_DIM
		end
	end



	#validate ship placement conflicts with another placed ship
	def check_clearance?(ship, start_position, orientation)
		row = start_position[:row]
		column = start_position[:column]
		ship.length.times do
			if self.grid[row][column].ship
				return false
			elsif orientation == :horizontal
				column += 1
			else
				row += 1
			end
		end
		return true
	end 



	

	#validate ship placement
	def check_ship_placement?(ship, start_position, orientation)
		if valid_coordinates?(ship, start_position, orientation) && check_clearance?(ship, start_position, orientation)
			return true
		else 
			return false
		end
	end
end


