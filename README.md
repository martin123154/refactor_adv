
# REFACTORING
47 warnings

#InstanceVariableAssumption

```
ship.rb -- 2 warnings:
 X [1]:InstanceVariableAssumption: Ship assumes too much for instance variable '@fill_char' [https://github.com/troessner/reek/blob/master/docs/Instance-Variable-Assumption.md]
  X[1]:InstanceVariableAssumption: Ship assumes too much for instance variable '@length' [https://github.com/troessner/reek/blob/master/docs/Instance-Variable-Assumption.md]

```


do def initialize nalezy dodac:

```
@length = length
@fill_char = fill_char
```

#Attribute
grid_cell.rb -- 2 warnings:
  X[3]:Attribute: GridCell#ship is a writable attribute [https://github.com/troessner/reek/blob/master/docs/Attribute.md]
  X[3]:Attribute: GridCell#status is a writable attribute [https://github.com/troessner/reek/blob/master/docs/Attribute.md]

Zamiast:

```

attr_accessor :ship, :status

```
```
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

```

player.rb -- 5 warnings:
  X [10]:Attribute: Player#name is a writable attribute [https://github.com/troessner/reek/blob/master/docs/Attribute.md]
  X[10]:Attribute: Player#ships_left is a writable attribute [https://github.com/troessner/reek/blob/master/docs/Attribute.md]
  [38, 41]:NestedIterators: Player#print_boards contains iterators nested 2 deep [https://github.com/troessner/reek/blob/master/docs/Nested-Iterators.md]
  [8]:TooManyInstanceVariables: Player has at least 9 instance variables [https://github.com/troessner/reek/blob/master/docs/Too-Many-Instance-Variables.md]
  [31]:TooManyStatements: Player#print_boards has approx 14 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]


Przed refaktoryzacja player.rb:


```
(46 linii kodu, flog score: 62.4, flay score: 0).


```



 [10]:Attribute: Player#name 
 [10]:Attribute: Player#ships_left 
 
 Zamiast:

```

attr_accessor :ship, :status

```

```
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

```

Przed refaktoryzacja player.rb:


```
(46 linii kodu, flog score: 62.4, flay score: 0).


```

```
board - 10 smells
  X [10]:Attribute: Board#grid is a writable attribute [https://github.com/troessner/reek/blob/master/docs/Attribute.md]
  [65]:ControlParameter: Board#check_clearance? is controlled by argument 'orientation' [https://github.com/troessner/reek/blob/master/docs/Control-Parameter.md]
  [37]:ControlParameter: Board#place_ship is controlled by argument 'orientation' [https://github.com/troessner/reek/blob/master/docs/Control-Parameter.md]
  [51]:ControlParameter: Board#valid_coordinates? is controlled by argument 'orientation' [https://github.com/troessner/reek/blob/master/docs/Control-Parameter.md]
  [33, 50, 59, 75]:DataClump: Board takes parameters ['orientation', 'ship', 'start_position'] to 4 methods [https://github.com/troessner/reek/blob/master/docs/Data-Clump.md]
  [27]:NestedIterators: Board#to_s contains iterators nested 2 deep [https://github.com/troessner/reek/blob/master/docs/Nested-Iterators.md]
 X [37, 51, 65]:RepeatedConditional: Board tests 'orientation == :horizontal' at least 3 times [https://github.com/troessner/reek/blob/master/docs/Repeated-Conditional.md]
  [59]:TooManyStatements: Board#check_clearance? has approx 7 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
 X [33]:TooManyStatements: Board#place_ship has approx 9 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
 X [21]:TooManyStatements: Board#to_s has approx 9 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]

```

(84 linii kodu, flog score: 95.7, flay score: 42).


#RepeatedConditional
Zbyt często w klasie użyty taki sam warunek (maksymalnie może byc on użyty dwa razy)

 [37, 51, 65]:RepeatedConditional  
 
 Rozwiązanie: odwrócenie instrukcji warunkowej w jednym z przypadków
 
 Początkowo:
 ```
 if orientation == :horizontal
				self.grid[row][column].ship = ship
				self.grid[row][column].status = :occupied
				column += 1
			else
				self.grid[row][column].ship = ship
				self.grid[row][column].status = :occupied
				row += 1
			end
```

Finalnie:

```
			
			if orientation == :vertical
				vertical_place_ship(row,column,ship)
			else
				horizontal_place_ship(row,column,ship)
			end
		end
 
 ```
 
 
[10]:Attribute: 


```

attr_accessor :grid

```

Finalnie:

```
def grid
		@grid
	end
	
	def grid=(str) 
		@grid = str
	end
	
```

#TooManyStatements 

Zapach ten zazwyczaj powstaje gdy metoda jest za długa, gdyż pojawia sie gdy metoda ma więcej niż 5 linii
Żeby wyeliminować ten zapach najczęściej rozbija sie metode na kilka poprzez grupowanie elementów wspólnych metody i wywoływanie ich z odpowiednimi argumentami


[33]:TooManyStatements: Board#place_ship  
utworzenie dwoch nowych metod, dodanie attr_reader row i column

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

[21]:TooManyStatements: Board#to_s has approx 9 statements
utworzenie nowej metody, dodanie attr_reader do zmiennej i

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


rules.rb -- 13 warnings:
 X[80, 83, 86, 87, 89, 91, 93, 98]:FeatureEnvy: AdvancedRules#shoot refers to 'targetCell' more than self (maybe move it to another class?) [https://github.com/troessner/reek/blob/master/docs/Feature-Envy.md]
 X [35, 36]:FeatureEnvy: BaseRules#get_position_input refers to 'input' more than self (maybe move it to another class?) [https://github.com/troessner/reek/blob/master/docs/Feature-Envy.md]
 X [35, 36]:FeatureEnvy: BaseRules#get_position_input refers to 'position' more than self (maybe move it to another class?) [https://github.com/troessner/reek/blob/master/docs/Feature-Envy.md]
 X [43, 49, 50, 52, 54, 56]:FeatureEnvy: ClassicRules#shoot refers to 'targetCell' more than self (maybe move it to another class?) [https://github.com/troessner/reek/blob/master/docs/Feature-Envy.md]
  [2]:LongParameterList: Rules#shoot has 4 parameters [https://github.com/troessner/reek/blob/master/docs/Long-Parameter-List.md]
  [102]:TooManyStatements: AdvancedRules#choose_target has approx 8 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
 X [79]:TooManyStatements: AdvancedRules#shoot has approx 12 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
  [61]:TooManyStatements: ClassicRules#choose_target has approx 7 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
 X [42]:TooManyStatements: ClassicRules#shoot has approx 9 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
X  [28]:UnusedParameters: BaseRules#choose_target has unused parameter 'player' [https://github.com/troessner/reek/blob/master/docs/Unused-Parameters.md]
X  [24]:UnusedParameters: BaseRules#shoot has unused parameter 'shooterCell' [https://github.com/troessner/reek/blob/master/docs/Unused-Parameters.md]
X  [24]:UnusedParameters: BaseRules#shoot has unused parameter 'target' [https://github.com/troessner/reek/blob/master/docs/Unused-Parameters.md]
X  [24]:UnusedParameters: BaseRules#shoot has unused parameter 'targetCell' [https://github.com/troessner/reek/blob/master/docs/Unused-Parameters.md] // usuniêcie parametru

[35,36] FeatureEnvy

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


[43, 49, 50, 52, 54, 56]:FeatureEnvy: 
def shoot(targetCell, shooterCell, target)
		if targetCell.status == :open
			puts "\n\"MISS!\""
			shooterCell.miss
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



[80, 83, 86, 87, 89, 91, 93, 98]:FeatureEnvy

	def shoot(targetCell, shooterCell, target)
		if targetCell.status == :open
			puts "\n\"MISS!\""
			shooterCell.miss
		elsif targetCell.status == :damaged
			hit_ship
			if targetCell.ship.sunk?
				target.ships_left -= 1
				print_ship_sunk
			else
				print_ship_hit
			end
		else
			puts "\n\"DAMAGED!\""
			shooterCell.damaged
			targetCell.damaged
		end
	end
	
		def hit_ship
			puts "\n\"HIT!\""
			shooterCell.hit
			targetCell.ship.hit
			targetCell.hit
		end
		
		def print_ship_sunk
				puts "#{target}'s #{targetCell.ship.class.to_s.downcase} sunk! #{target.ships_left} more ships to go."
		end
		
		def print_ship_hit
			puts "\n#{target}'s #{targetCell.ship.class.to_s.downcase} has been hit!"
		end


game.rb -- 15 warnings:
  [179, 185, 187, 192, 194]:FeatureEnvy: Game#deploy_opp_ship refers to 'opponent' more than self (maybe move it to another class?) [https://github.com/troessner/reek/blob/master/docs/Feature-Envy.md]
 X [165, 166]:FeatureEnvy: Game#get_position_input refers to 'input' more than self (maybe move it to another class?) [https://github.com/troessner/reek/blob/master/docs/Feature-Envy.md]
 X [165, 166]:FeatureEnvy: Game#get_position_input refers to 'position' more than self (maybe move it to another class?) [https://github.com/troessner/reek/blob/master/docs/Feature-Envy.md]
  [40]:NestedIterators: Game#set_opponent contains iterators nested 2 deep [https://github.com/troessner/reek/blob/master/docs/Nested-Iterators.md]
  [5]:TooManyInstanceVariables: Game has at least 5 instance variables [https://github.com/troessner/reek/blob/master/docs/Too-Many-Instance-Variables.md]
  [5]:TooManyMethods: Game has at least 16 methods [https://github.com/troessner/reek/blob/master/docs/Too-Many-Methods.md]
  [178]:TooManyStatements: Game#deploy_opp_ship has approx 10 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
  [113]:TooManyStatements: Game#deploy_ship has approx 9 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
  [130]:TooManyStatements: Game#get_orientation has approx 9 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
  [148]:TooManyStatements: Game#get_starting_position has approx 6 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
X  [101]:TooManyStatements: Game#opponent_round has approx 8 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
 X [18]:TooManyStatements: Game#play has approx 6 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
 X [70]:TooManyStatements: Game#play_rounds has approx 8 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
  [53]:TooManyStatements: Game#set_hit_rules has approx 8 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
  X[36]:TooManyStatements: Game#set_opponent has approx 6 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]


[36]:TooManyStatements: Game#set_opponent h

	def set_opponent
		creating_player
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


[101]:TooManyStatements: Game#opponent_round
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

[18]:TooManyStatements: Game#play h

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


[70]:TooManyStatements: Game#play_rounds
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

[165, 166]:FeatureEnvy: Game#get_position_input refers to 'input' more than self (maybe move it to another class?) [https://github.com/troessner/reek/blob/master/docs/Feature-Envy.md]
 [165, 166]:FeatureEnvy: Game#get_position_input 

Wystêpuje, gdy fragment kodu odwo³uje siê do innego obiektu czêciej, ni¿ sam do siebie.Tak¿e gdy kilku klientów wykonuje tê sam¹ seriê manipulacji na okrelonym typie obiektu.

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
