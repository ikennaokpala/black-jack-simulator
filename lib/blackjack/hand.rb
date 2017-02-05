module BlackJack
  class Hand
    attr_reader :cards

    def initialize(cards)
      @cards = cards
    end

    def add(card)
      @cards << card
    end

    def score_above_highest_possible_score?
      score > 21
    end

    def score
      @cards.map(&:value).reduce(:+)
    end
  end
end
