require_relative '../../lib/battleship/battleship'

describe Battleship do
	before do
		@battleship = Battleship.new
	end

	it "Check relation" do
		expect(@battleship.class).to be Battleship
	end

  it "Check len" do
    expect(@battleship.length).to eq(4)
  end

  it "Check fill_char" do
    expect(@battleship.fill_char).to eq('B')
  end
  
end
