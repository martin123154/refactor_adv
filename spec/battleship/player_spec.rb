require_relative '../../lib/battleship/player'


describe Player do
  let(:player) do
    Player.new('Name')
  end

  it '#to_s' do
    expect(player.to_s).to eq('Name')
  end

end
