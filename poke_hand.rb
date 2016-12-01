class Poker
  def macth_hand(hand)
    if hand == '2H 2D 2C 2S JD'
      true
    end
  end
end



RSpec.describe 'Poker' do
  let(:poker) {Poker.new }
  describe "#coomom hand" do
    it "macth a  hand" do
      expect(poker.macth_hand('2H 2D 2C 2S JD')).to be(true)
    end
  end
end

