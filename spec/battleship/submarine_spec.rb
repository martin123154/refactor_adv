require_relative '../../lib/battleship/submarine'

describe Submarine do
	before do
		@submarine = Submarine.new
	end

	it "Check relation" do
		expect(@submarine.class).to be Submarine
	end

  it "Check len" do
    expect(@submarine.length).to eq(3)
  end

  it "Check fill_char" do
    expect(@submarine.fill_char).to eq('S')
  end

end
