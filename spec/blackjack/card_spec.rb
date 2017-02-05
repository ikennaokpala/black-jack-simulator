require "spec_helper"

describe BlackJack::Card do
  subject{ BlackJack::Card.new("diamonds", 2, 2) }

  it { is_expected.to have_attributes(suit: "diamonds", kind: 2, value: 2) }
  it "returns value (to_s)" do
    expect(subject.to_s).to eq("2")
  end
end
