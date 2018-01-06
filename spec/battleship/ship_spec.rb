require_relative '../../lib/battleship/ship'

describe Ship do
	before do
		@ship = Ship.new
	end

	it "initialize 0 hits" do
	 expect(@ship.hits).to eq(0)
	end

	it "should be hited once" do
   @ship.hit
	 expect(@ship.hits).to eq(1)
	end

	it "should sunk" do
		@ship_sunk = Ship.new
		expect(@ship_sunk.sunk?).to eq(false)
	end

end
