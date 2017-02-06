module BlackJack
  class Hand
    attr_reader :cards

    def self.build(standard_out, deck)
      cards = [deck.next_card, deck.next_card]
      hand = new(standard_out, cards, deck)

      if hand.valid?
        hand
      else
        build(standard_out, deck)
      end
    end

    def initialize(standard_out, cards, deck)
      @deck = deck
      @standard_out = standard_out
      @cards = cards
    end

    def add(card)
      @cards << card
    end

    def hit
      player_update(": hit")
      add(@deck.next_card)
      dealer_update(": #{@cards[-1]}")
    end

    def stand
      player_update(": stand")
      add(@deck.next_card) while limit?
      cards = values[2..-1]
      dealer_update(": #{cards.join(' ')}") if cards.any?
    end

    def score_above_highest_possible_score?
      score > 21
    end

    def valid?
      score < 20
    end

    def limit?
      score < 17
    end

    def clone
      Hand.new(@standard_out, @cards.clone, @deck)
    end

    def beats?(hand)
      !score_above_highest_possible_score? &&
        (hand.score_above_highest_possible_score? ||
        hand.score < score)
    end

    def score
      values.reduce(:+)
    end

    def values
      @cards.map(&:value)
    end

    def dealer_update(notice)
      @standard_out.puts("Dealer#{notice}")
    end

    def player_update(notice)
      @standard_out.puts("Player#{notice}")
    end
  end
end
