module BlackJack
  class Deck
    def cards
      suits.inject([]) do |cards, suit|
        card_types_and_values.each do |kind, value|
          cards << Card.new(suit, kind, value)
        end
        cards
      end
    end

    def shuffled_cards
      cards.shuffle
    end

    def next_card
      shuffled_cards.pop
    end

  protected

    def suits
      %w(hearts diamonds clubs spades)
    end

    def card_types_and_values
      {
        2 => 2,
        3 => 3,
        4 => 4,
        5 => 5,
        6 => 6,
        7 => 7,
        8 => 8,
        9 => 9,
        10 => 10,
        "A" => 11,
        "J" => 12,
        "Q" => 13,
        "K" => 14
      }
    end
  end
end
