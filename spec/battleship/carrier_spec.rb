require_relative '../../lib/battleship/carrier'

describe Carrier do
	before do
		@carrier = Carrier.new
	end

	it "Check relation" do
		expect(@carrier.class).to be Carrier
	end

  it "Check len" do
    expect(@carrier.length).to eq(5)
  end

  it "Check fill_char" do
    expect(@carrier.fill_char).to eq('C')
  end

end
