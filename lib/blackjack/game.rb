module BlackJack
  class Game
    def initialize(standard_out, deck)
      @in_play = true
      @standard_out = standard_out
      @deck = deck
      cards = [@deck.next_card, @deck.next_card]
      @player = Hand.new(cards)
      @dealer = Hand.new(cards)
      dealer_update(": #{cards.join(' ')}")
    end

    def play(move)
      player_update(": #{move}")
      hit
    end

    def in_play?
      @in_play
    end

  protected

    def hit
      card = @deck.next_card

      @player.add(card)
      dealer_update(": #{card}")

      if @player.score_above_highest_possible_score?
        @in_play = false
        dealer_update(" Wins!")
      end
    end

    def dealer_update(notice)
      @standard_out.puts("Dealer#{notice}")
    end

    def player_update(notice)
      @standard_out.puts("Player#{notice}")
    end
  end

  class Simulator
    def initialize(standard_in, standard_out, deck)
      @standard_in = standard_in
      @game = Game.new(standard_out, deck)
    end

    def play
      while @game.in_play?
        @game.play(@standard_in.readline.chomp)
      end
    end
  end
end
