module BlackJack
  class Simulator
    def initialize(standard_in, standard_out, deck)
      @standard_in = standard_in
      @standard_out = standard_out
      @deck = deck
    end

    def play
      @player = Hand.build(@standard_out, @deck)
      @dealer = @player.clone
      @in_play = true

      @dealer.dealer_update(": #{@dealer.values.join(' ')}")
      next_move while in_play?

      outcome
    end

  private

    def hit?(move)
      move == "hit"
    end

    def stand?(move)
      move == "stand"
    end

    def next_move
      move = @standard_in.readline.chomp

      if hit?(move)
        @player.hit
        @in_play = !@player.score_above_highest_possible_score?
      end

      if stand?(move)
        @dealer.stand
        @in_play = false
      end
    end

    def outcome
      if @player.beats?(@dealer)
        @player.player_update(" Wins!")
      else
        @dealer.dealer_update(" Wins!")
      end
    end

    def in_play?
      @in_play
    end
  end
end
