require "spec_helper"

describe BlackJack::Deck do
  subject{ BlackJack::Deck.new }

  describe "#cards" do
    it "can generate deck with 52 cards" do
      expect(subject.cards.count).to eq(52)
    end

    it "comprises of 13 hearts" do
      hearts = subject.cards.select{|card| card.suit == "hearts" }
      expect(hearts.count).to eq(13)
    end

    it "comprises of 13 diamonds" do
      diamonds = subject.cards.select{|card| card.suit == "diamonds" }
      expect(diamonds.count).to eq(13)
    end

    it "comprises of 13 clubs" do
      clubs = subject.cards.select{|card| card.suit == "clubs" }
      expect(clubs.count).to eq(13)
    end

    it "comprises of 13 spades" do
      spades = subject.cards.select{|card| card.suit == "spades" }
      expect(spades.count).to eq(13)
    end
  end

  describe "#shuffled_cards" do
    it "can shuffle the cards" do
      cards = [
          BlackJack::Card.new("hearts", 2, 2),
          BlackJack::Card.new("diamonds", "A", 11),
        ]
      allow_any_instance_of(BlackJack::Deck).to receive(:cards).and_return(cards.dup)

      expect(subject.shuffled_cards).to match_array(cards)
    end
  end

  describe "#next_card" do
    it "returns last card as next available" do
      cards = [
          BlackJack::Card.new("hearts", 2, 2),
          BlackJack::Card.new("diamonds", "A", 11),
        ]
      allow_any_instance_of(BlackJack::Deck).to receive(:shuffled_cards).and_return(cards.dup)

      expect(subject.next_card).to eq(cards.last)
    end
  end
end
