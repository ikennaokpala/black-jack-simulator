require "spec_helper"

describe BlackJack::Simulator do
  let(:standard_in) { StringIO.new }
  let(:standard_out) { StringIO.new }

  it "plays out first scenario as specified and dealer wins" do
    cards = [
        BlackJack::Card.new("hearts", 2, 2),
        BlackJack::Card.new("diamonds", "A", 11),
        BlackJack::Card.new("clubs", 4, 4),
        BlackJack::Card.new("spades", 7, 7),
      ]
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

  it "plays out second scenario as specified and player wins" do
    cards = [
      BlackJack::Card.new('hearts', 5, 5),
      BlackJack::Card.new('diamonds', 9, 9),
      BlackJack::Card.new('clubs', 6, 6),
      BlackJack::Card.new('spades', 2, 2),
      BlackJack::Card.new('hearts', 9, 9),
    ]
    expected = \
      "Dealer: 5 9\n"\
      "Player: hit\n"\
      "Dealer: 6\n"\
      "Player: stand\n"\
      "Dealer: 2 9\n"\
      "Player Wins!\n"

    standard_in.puts('hit')
    standard_in.puts('stand')
    standard_in.rewind

    allow_any_instance_of(BlackJack::Deck).to receive(:next_card).and_return(*cards)

    BlackJack::Simulator.new(standard_in, standard_out, BlackJack::Deck.new).play

    expect(standard_out.string).to eq(expected)
  end

  it "plays out third scenario as specified and dealer wins" do
    cards = [
      BlackJack::Card.new("hearts", 3, 3),
      BlackJack::Card.new("diamonds", "J", 12),
      BlackJack::Card.new("clubs", 4, 4),
      BlackJack::Card.new("spades", 6, 6),
    ]
    expected = \
      "Dealer: 3 12\n"\
      "Player: hit\n"\
      "Dealer: 4\n"\
      "Player: stand\n"\
      "Dealer: 6\n"\
      "Dealer Wins!\n"

    allow_any_instance_of(BlackJack::Deck).to receive(:next_card).and_return(*cards)

    standard_in.puts('hit')
    standard_in.puts('stand')
    standard_in.rewind

    BlackJack::Simulator.new(standard_in, standard_out, BlackJack::Deck.new).play

    expect(standard_out.string).to eq(expected)
  end

  it "plays out fourth scenario as specified and player wins" do
    cards = [
      BlackJack::Card.new("hearts", 6, 6),
      BlackJack::Card.new("diamonds", 3, 3),
      BlackJack::Card.new("clubs", "A", 11),
      BlackJack::Card.new("spades", 6, 6),
      BlackJack::Card.new("spades", 4, 4),
    ]
    expected = \
      "Dealer: 6 3\n"\
      "Player: hit\n"\
      "Dealer: 11\n"\
      "Player: stand\n"\
      "Dealer: 6 4\n"\
      "Player Wins!\n"


    allow_any_instance_of(BlackJack::Deck).to receive(:next_card).and_return(*cards)

    standard_in.puts('hit')
    standard_in.puts('stand')
    standard_in.rewind

    BlackJack::Simulator.new(standard_in, standard_out, BlackJack::Deck.new).play

    expect(standard_out.string).to eq(expected)
  end

  it "plays out fifth scenario as specified and dealer wins" do
    cards = [
      BlackJack::Card.new("hearts", "J", 12),
      BlackJack::Card.new("diamonds", 10, 10),
      BlackJack::Card.new("diamonds", 8, 8),
      BlackJack::Card.new("clubs", "Q", 13),
      BlackJack::Card.new("clubs", "K", 14),
      BlackJack::Card.new("spades", 6, 6),
      BlackJack::Card.new("diamonds", 8, 8),
      BlackJack::Card.new("clubs", "A", 11),
    ]
    expected = \
      "Dealer: 12 10\n"\
      "Dealer: 8 13\n"\
      "Dealer: 14 6\n"\
      "Dealer: 8 11\n"\
      "Player: stand\n"\
      "Dealer Wins!\n"


    allow_any_instance_of(BlackJack::Deck).to receive(:next_card).and_return(*cards)

    standard_in.puts('stand')
    standard_in.rewind

    BlackJack::Simulator.new(standard_in, standard_out, BlackJack::Deck.new).play

    expect(standard_out.string).to eq(expected)
  end
end
