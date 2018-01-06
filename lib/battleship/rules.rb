class Rules
	def shoot(targetCell, shooterCell, target, rules = ClassicRules.new)
		rules.shoot(targetCell, shooterCell, target)
	end

	def choose_target(player, rules = ClassicRules.new)
		rules.choose_target(player)
	end

	def deploy_ship(player, ship, rules = ClassicRules.new)
		rules.deploy_ship(player, ship)
	end

	def deploy_opp_ship(opponent, ship, rules = ClassicRules.new)
		rules.deploy_opp_ship(opponent, ship)
	end

	def get_opp_position(rowPattern, colPattern, rules = ClassicRules.new)
		rules.get_opp_position(rowPattern, colPattern)
	end
end

class BaseRules
	def shoot()
		raise NotImplementedError
	end

	def choose_target()
		raise NotImplementedError
	end

	def get_position_input
		position = {}
		input = gets.chomp.rstrip.upcase
		get_position_input_row(position,input)
		get_position_input_column(position,input)
		return position
	end
	def	get_position_input_row(position,input)
		position[:row] = Board::ROW.rindex(input.split(//, 2)[0])
	end

	def	get_position_input_column(position,input)
		position[:column] = Board::COLUMN.rindex(input.split(//, 2)[1])
	end
	
end



class ClassicRules < BaseRules
	def shoot(targetCell, shooterCell, target)
		if targetCell.status == :open
			ship_miss(shooterCell)
		else
			hit_targetCell_ship(shooterCell,targetCell)
			if targetCell.ship.sunk?
				target.ships_left -= 1
				print_ship_sunk(target,targetCell)
			else
				print_ship_hit(target,targetCell)
			end
		end
	end
	
	def hit_targetCell_ship(shooterCell,targetCell)
		puts "\n\"HIT!\""
		shooterCell.hit
		targetCell.ship.hit
		hit_targetCell(targetCell)
	end
		
	def hit_targetCell(targetCell)
		targetCell.hit
	end
		
	def print_ship_sunk(target,targetCell)
			puts "#{target}'s #{targetCell.ship.class.to_s.downcase} sunk! #{target.ships_left} more ships to go."
	end
		
	def print_ship_hit(target,targetCell)
		puts "\n#{target}'s #{targetCell.ship.class.to_s.downcase} has been hit!"
	end
	def ship_miss(shooterCell)
		puts "\n\"MISS!\""
		shooterCell.miss
	end

	def choose_target(player)
		valid = false
		while valid == false
			print "\nYour turn. Target coordinates: "
			target = get_position_input
			if target[:row].nil? || target[:column].nil?
				puts "Invalid coordinates."
			elsif player.target_board.grid[target[:row]][target[:column]].status != :open
				puts "Coordinates already called. Try again."
			else
				valid = true
			end
		end
		return target
	end
end



		
class AdvancedRules < BaseRules

		
		
		
	def shoot(targetCell, shooterCell, target)
		if targetCell.status == :open
			ship_miss(shooterCell)
		elsif targetCell.status == :damaged
			hit_targetCell_ship(shooterCell,targetCell)
			if targetCell.ship.sunk?
				print_ship_sunk(target,targetCell)
			else
				puts "\n#{target}'s #{targetCell.ship.class.to_s.downcase} has been hit!"
			end
		else
			ship_damage(shooterCell,targetCell)
		end
	end
	
	def hit_targetCell_ship(shooterCell,targetCell)
		puts "\n\"HIT!\""
		shooterCell.hit
		targetCell.ship.hit
		hit_targetCell(targetCell)
	end
		
	def hit_targetCell(targetCell)
		targetCell.hit
	end
	
	def print_ship_sunk(target,targetCell)
			number_of_ships(target)
			puts "#{target}'s #{targetCell.ship.class.to_s.downcase} sunk! #{target.ships_left} more ships to go."
	end
	
	def number_of_ships(target)
	target.ships_left -= 1
	end
	
		
	def print_ship_hit(target,targetCell)
		puts "\n#{target}'s #{targetCell.ship.class.to_s.downcase} has been hit!"
	end
	def ship_miss(shooterCell)
		puts "\n\"MISS!\""
		shooterCell.miss
	end
		
	def ship_damage(shooterCell,targetCell)
			puts "\n\"DAMAGED!\""
			shooterCell.damaged
			targetCell.damaged
	end
	
	
	def choose_target(player)
		valid = false
		while valid == false
			print "\nYour turn. Target coordinates: "
			target = get_position_input
			status = player.target_board.grid[target[:row]][target[:column]].status
			if target[:row].nil? || target[:column].nil?
				puts "Invalid coordinates."
			elsif status != :damaged && status != :open
				puts "Coordinates already called. Try again."
			else
				valid = true
			end
		end
		return target
	end
end

