require "spec_helper"

describe BlackJack::Simulator do
  let(:cards){[
      BlackJack::Card.new("hearts", 2, 2),
      BlackJack::Card.new("diamonds", "A", 11),
      BlackJack::Card.new("clubs", 4, 4),
      BlackJack::Card.new("spades", 7, 7),
    ]}
  let(:standard_in) { StringIO.new }
  let(:standard_out) { StringIO.new }

  it "plays out first scenario as specified and dealer wins" do
    expected = \
    "Dealer: 2 11\n"\
    "Player: hit\n"\
    "Dealer: 4\n"\
    "Player: hit\n"\
    "Dealer: 7\n"\
    "Dealer Wins!\n"\

    standard_in.puts('hit')
    standard_in.puts('hit')
    standard_in.rewind

    allow_any_instance_of(BlackJack::Deck).to receive(:next_card).and_return(*cards)

    BlackJack::Simulator.new(standard_in, standard_out, BlackJack::Deck.new).play

    expect(standard_out.string).to eq(expected)
  end
end
