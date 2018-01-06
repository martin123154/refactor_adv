require_relative '../../lib/battleship/game'

describe Game do
  #let(:player) do
  #  Player.new('Player')
  #end

  #let(:opponent) do
  #  Player.new('Opponent')
  #end
  let(:player) { double :player }

  let(:opponent) { double :player }

  let(:board) do
    Board.new
  end

  let(:game) do
    Game.new
  end

  let(:carrier) do
    Carrier.new
  end

  let(:battleship) do
    Battleship.new
  end

  let(:destroyer) do
    Destroyer.new
  end

  let(:patrolboat) do
    PatrolBoat.new
  end

  let(:submarine) do
    Submarine.new
  end


  it '#set_opponent_array' do
    expect(game.set_opponent).to be_kind_of(Array)
  end

  it '#set_opponent_not_nil' do
      expect(game.set_opponent[1,1]).not_to eq(nil)
  end

  it 'set ship' do
    expect(board.place_ship(carrier,{:row=>1, :column=>1},:horizontal)).not_to eq(nil)
  end

  it 'check_clearance?' do
    board.place_ship(carrier,{:row=>1, :column=>1},:horizontal)
    expect(board.check_clearance?(carrier,{:row=>1, :column=>1},:horizontal)).to eq(FALSE)
  end

  it 'valid_coordinates?' do
    expect(board.valid_coordinates?(carrier,{:row=>1, :column=>1},:horizontal)).to eq(TRUE)
    expect(board.valid_coordinates?(carrier,{:row=>9, :column=>9},:horizontal)).to eq(FALSE)
  end

  it 'player Board' do
    allow(game).to receive(:gets).and_return('Player')
    game.set_player
    expect(game.player.board.class).to be Board
  end

  #it 'place player and opponent ships' do
  #  player.board.place_ship(carrier,{:row=>1, :column=>1},:horizontal)
  #  player.board.place_ship(battleship,{:row=>2, :column=>1},:horizontal)
  #  player.board.place_ship(destroyer,{:row=>3, :column=>1},:horizontal)
  #  player.board.place_ship(patrolboat,{:row=>4, :column=>1},:horizontal)
  #  player.board.place_ship(submarine,{:row=>5, :column=>1},:horizontal)
  #  #player.board.to_s
  #  expect(player.ships_left).to eq(5)

    #game.deploy_opp_ship(opponent,:carrier)
    #game.deploy_opp_ship(opponent,:battleship)
    #game.deploy_opp_ship(opponent,:destroyer)
    #game.deploy_opp_ship(opponent,:patrol_boat)
    #game.deploy_opp_ship(opponent,:submarine)
    #opponent.board.to_s
    #expect(opponent.ships_left).to eq(5)
  #end

  it 'set player name' do
    allow(game).to receive(:gets).and_return('Player')
    expect(game.set_player).to be_nil
  end

  it 'checks the set_opponent' do
    expect(game.set_opponent).to be_kind_of(Array)
    expect(game.set_opponent).not_to be_empty
    expect(game.set_opponent.length).to eq(100)
  end

  it 'checks deploy_ship' do
    allow(game).to receive(:gets).and_return('Player')
    game.set_player
    allow(game).to receive(:gets).and_return('H','A1')
    expect(game.deploy_ship(game.player,:carrier)).to be_nil
    #expect {game.deploy_ship(player,:carrier)}.to output("hello\n").to_stdout
    #expect(game.deploy_ship(player,:carrier)).to receive(:puts).with('Invalid coordinates.')
    #expect(game.deploy_ship(player,:carrier)).to be TRUE
  end
  it 'checks deploy_ospp_ship' do
    game.set_opponent
    expect(game.opponent.class).to be Player
    #expect(game.deploy_opp_ship(opponent,:carrier)).to be_nil
  end

  it 'checks player_round' do
    allow(game).to receive(:gets).and_return('Player','B2')
    game.set_player
    game.set_opponent
    game.deploy_opp_ship(game.opponent,:carrier)
    game.deploy_opp_ship(game.opponent,:battleship)
    game.deploy_opp_ship(game.opponent,:destroyer)
    game.deploy_opp_ship(game.opponent,:patrol_boat)
    game.deploy_opp_ship(game.opponent,:submarine)
    game.player_round
    expect(game.player.target_board.grid[1][1].status).not_to eq(:open)
  end

  it 'checks opponent_round' do
    allow(game).to receive(:gets).and_return('Player','A1')
    game.set_player
    game.set_opponent
    target_coords = game.opp_targeting_queue.pop
		target = {}
		target[:row] = Board::ROW.rindex(target_coords[0])
		target[:column] = Board::COLUMN.rindex(target_coords[1])
    game.player.board.place_ship(carrier,{:row=>1, :column=>1},:horizontal)
    game.player.board.place_ship(battleship,{:row=>2, :column=>1},:horizontal)
    game.player.board.place_ship(destroyer,{:row=>3, :column=>1},:horizontal)
    game.player.board.place_ship(patrolboat,{:row=>4, :column=>1},:horizontal)
    game.player.board.place_ship(submarine,{:row=>5, :column=>1},:horizontal)
    expect(game.opponent_round).to be_nil
  end

end
