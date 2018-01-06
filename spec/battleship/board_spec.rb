require_relative '../../lib/battleship/board'

describe Board do
	before do
		@board = Board.new
	end

	it "should create a game board" do
		expect(@board.class).to be Board
	end

	it "cell should be Grid class" do
		expect(@board.grid[5][5].class).to be GridCell
	end
end
