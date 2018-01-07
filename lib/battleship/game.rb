require_relative 'player'
require_relative 'board'
require_relative 'rules'

class Game

	attr_reader :opp_targeting_queue, :player, :opponent, :valid
	FLEET = [:carrier, :battleship, :destroyer, :submarine, :patrol_boat]

	def initialize
		@player = nil
		@opponent = nil
		@opp_targeting_queue = nil
		@rules = ClassicRules.new
		@rulebook = Rules.new
	end

	def play
		puts "\nLet's play some Battleship!\n\n"
		settings
	end
	
	def settings
		set_player
		set_opponent
		set_hit_rules
		deploy_fleet(@player, @opponent)
		play_rounds
	end
	
	

	def set_player
		name = ''
		while name.empty? do
			print "Enter name: "
			name = gets.chomp.rstrip
			@player = Player.new(name)
		end
	end

	def set_opponent
		create_opponent_player
		Board::ROW.each do |row|
			Board::COLUMN.each do |column|
				@opp_targeting_queue << [row, column]
			end
		end
		@opp_targeting_queue.shuffle!   #queue of random opponent shot coordinates
	end
	
	def create_opponent_player
	@opponent = Player.new('Opponent')
	@opp_targeting_queue = []
	end

	def deploy_fleet(player, opponent)
		puts "\nNow place your ships, #{player.name}."
		FLEET.each {|ship| deploy_ship(player, ship)}
		FLEET.each {|ship| deploy_opp_ship(opponent, ship)}
	end

	def set_hit_rules 
		@valid = false
		while valid == false do
			puts "\nSelect hit rules:\n		A. Standard battleship rules\n		B. Advanced rules."
			input = gets.chomp.rstrip.upcase
			if input == "A"
				classic_rules()
			elsif input == "B"
				advanced_rules()
			else 
				puts "Invalid input. Try again."
			end
		end 
	end
	
	def classic_rules()
		@rules = ClassicRules.new
		@valid = true
	end
	
	def advanced_rules()
		@rules = AdvancedRules.new
		@valid = true
	end
			
	
	

	def play_rounds
		puts "\n\nTime to sink some ships! Good luck, #{@player.name}\n\n"
		winner = ""
		checking_for_winner(winner)
		puts "\n\n#{winner} WINS!\n\n"
	end

	def checking_for_winner(winner)
		while winner == ""
			@player.print_boards

			player_round
			winner = check_winner(@player, @opponent)

			opponent_round
			winner = check_winner(@opponent, @player)
		end
	end
	
	def check_winner(player, opponent)
		if opponent.ships_left == 0
			winner = player.name
			return winner
		else
			return ""
		end
	end

	def player_round
		target = @rulebook.choose_target(@player, @rules)
		player_cell = @player.target_board.grid[target[:row]][target[:column]]
		opponent_cell = @opponent.board.grid[target[:row]][target[:column]]
		@rulebook.shoot(opponent_cell, player_cell, @opponent, @rules)
	end

	def opponent_round
		puts "\n---------- Opponent's turn ----------"
		choosing_cell_by_players
	end
	

	
	def choosing_cell_by_players
	target_coords = opp_targeting_queue.pop
	target = get_opp_position(target_coords[0], target_coords[1])
	opponent_cell = @opponent.target_board.grid[target[:row]][target[:column]]
	player_cell = @player.board.grid[target[:row]][target[:column]]
	opponent_move(target_coords,opponent_cell, player_cell)
	end
	
	def opponent_move(target_coords,opponent_cell, player_cell)
		print "\nOpponent called \"#{target_coords[0]}#{target_coords[1]}\" "
		@rulebook.shoot(player_cell,opponent_cell, @player, @rules)
		puts "-------------------------------------\n\n"
	end
	
	

	def deploy_ship(player, ship)
		valid = false
		board = player.board
		while valid == false do
			print "\n"
			board.to_s			#print board for reference
			orientation = get_orientation(ship)
			position = get_starting_position(ship)
			if board.check_ship_placement?(player.send(ship), position, orientation)
				board.place_ship(player.send(ship), position, orientation)
				valid = true
			else
				puts "Invalid position for ship."
			end
		end
	end

	def get_orientation(ship)
		valid = false
		while valid == false do
			print "\n#{ship.capitalize} orientation: horizontal(H) or vertical(V)? "
			input = gets.chomp.rstrip.upcase
			if input == 'H' 
				orientation = :horizontal
				valid = true
			elsif input == 'V'
				orientation = :vertical
				valid = true
			else
				puts "Invalid orientation entry."
			end
		end
		return orientation
	end

	def get_starting_position(ship)
		valid = false
		while valid == false do
			print "\n#{ship.capitalize} starting position (Ex. A10): "
			position = get_position_input
			if !position[:row].nil? && !position[:column].nil?
				valid = true
			else
				puts "Invalid coordinates."
			end
		end
		return position
	end
	
	
	

	def get_position_input
		position = {}
		input = gets.chomp.rstrip.upcase
		get_position_input_column(position,input)
		get_position_input_row(position,input)
		return position
	end
	
	def get_position_input_column(position,input)
		position[:row] = Board::ROW.rindex(input.split(//, 2)[0])
	end
	
	def get_position_input_row(position,input)
	position[:column] = Board::COLUMN.rindex(input.split(//, 2)[1])
	end

	def get_opp_position(rowPattern, colPattern)
		position = {}
		position[:row] = Board::ROW.rindex(rowPattern)
		position[:column] = Board::COLUMN.rindex(colPattern)
		return position
	end

	#randomly place opponent's ships
	def deploy_opp_ship(opponent, ship)
		board = opponent.board
		@valid = false
		while valid == false
			orientation = [:horizontal, :vertical].sample
			position = deploy_opp_ship_orientation(ship,orientation,board)
			
		end
	end
	
	def deploy_opp_ship_orientation(ship,orientation,board)
			if orientation == :horizontal
				rows = Board::ROW
				columns = Board::COLUMN[0..9 - opponent.send(ship).length]
			else
				rows = Board::ROW[0..9 - opponent.send(ship).length]
				columns = Board::COLUMN
			end
		position = get_opp_position(rows.sample, columns.sample)
		place_opponent_ship(ship,board,position,orientation)
	end
	
	def place_opponent_ship(ship,board,position,orientation)
		if(board.check_ship_placement?(opponent.send(ship), position, orientation))
		@valid = true
		board.place_ship(opponent.send(ship), position, orientation)
		end
	end
	
end
