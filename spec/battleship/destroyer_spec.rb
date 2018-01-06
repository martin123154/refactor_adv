require_relative '../../lib/battleship/destroyer'

describe Destroyer do
	before do
		@destroyer = Destroyer.new
	end

	it "Check relation" do
		expect(@destroyer.class).to be Destroyer
	end

  it "Check len" do
    expect(@destroyer.length).to eq(3)
  end

  it "Check fill_char" do
    expect(@destroyer.fill_char).to eq('D')
  end

end
