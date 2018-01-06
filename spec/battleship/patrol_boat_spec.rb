require_relative '../../lib/battleship/patrol_boat'

describe PatrolBoat do
	before do
		@patrolboat = PatrolBoat.new
	end

	it "Check relation" do
		expect(@patrolboat.class).to be PatrolBoat
	end

  it "Check len" do
    expect(@patrolboat.length).to eq(2)
  end

  it "Check fill_char" do
    expect(@patrolboat.fill_char).to eq('P')
  end

end
