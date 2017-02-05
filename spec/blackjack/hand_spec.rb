require "spec_helper"

describe BlackJack::Hand do
  let(:cards) do
    [
      BlackJack::Card.new("hearts", 2, 2),
      BlackJack::Card.new("diamonds", "A", 11),
    ]
  end

  subject{ BlackJack::Hand.new(cards)}

  it "can add card to existing collection of cards" do
    subject.add(BlackJack::Card.new("spades", "A", 11))
    expect(subject.cards).to match_array(cards.push(BlackJack::Card.new("spades", "A", 11)))
  end

  it "can return sum of all the values of the given cards" do
    expect(subject.score).to eq(13)
  end

  context "player loses when" do
    it "sum of cards (i.e score) less than highest possible" do
      expect(subject.score_above_highest_possible_score?).to eq(false)
    end
  end

  context "player wins when" do
    let(:win_cards) do
      [
        BlackJack::Card.new("hearts", 2, 2),
        BlackJack::Card.new("diamonds", "A", 11),
        BlackJack::Card.new("clubs", 4, 4),
        BlackJack::Card.new("spades", 7, 7),
      ]
    end

    subject{ BlackJack::Hand.new(win_cards)}

    it "sum of cards (i.e score) more than highest possible" do
      expect(subject.score_above_highest_possible_score?).to eq(true)
    end
  end
end
