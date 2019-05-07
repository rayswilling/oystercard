require 'oystercard'

describe OysterCard do

  it 'initializes with a balance' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it 'tops up the card' do
      subject.top_up(20)
      expect(subject.balance).to eq(20)
    end

    it "raises an error if balance is over £90" do
      subject.top_up(90)
      expect { subject.top_up(1) }.to raise_error("maximum card limit (#{OysterCard::MAXIMUM_BALANCE}) reached")
    end
  end

  # describe '#deduct' do
  #  it 'deducts money from the card' do
  #    card = OysterCard.new(50)
  #    card.deduct(20)
  #    expect(card.balance).to eq(30)
  #  end
  # end

  describe '#touch_in' do
    it 'starts the journey' do
      card = OysterCard.new(5)
      card.touch_in
      expect(card).to be_in_journey
    end

    it 'raises an error if insufficent travel funds' do
      card = OysterCard.new
      expect { card.touch_in }.to raise_error('insufficient travel funds')
    end
  end

  describe '#touch_out' do
    it 'ends the journey' do
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'charges the minumum fee on touch out' do
      card = OysterCard.new(5)
      expect { card.touch_out }.to change{card.balance}.by(-OysterCard::MINIMUM_FARE)
    end
  end
end
