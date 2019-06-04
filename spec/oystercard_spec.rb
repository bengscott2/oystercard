# frozen_string_literal: true

require 'oystercard'

describe Oystercard do

  before(:each) do
    @topped_up_card = Oystercard.new
    @topped_up_card.top_up(50)
  end

  let(:station) { double("station") }

  it 'checks that a new card has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  context 'tests around topping up' do

    it 'increments the balance by 20' do
      expect { subject.top_up(20) }.to change { subject.balance }.by(20)
    end

    it 'raises an erorr if top up amount goes beyond limit' do
      expect { subject.top_up(Oystercard::DEFAULT_LIMIT + 1) }.to raise_error("Top up amount would exceed #{Oystercard::DEFAULT_LIMIT} max balance")
    end

  end

  context 'tests that money can be deducted' do

    it 'deducts from balance when touched out' do
      subject.top_up(10)
      expect { subject.touch_out(10, station) }.to change { subject.balance }.by(-10)
    end

  end

  context 'testing touch in/ touch out and card state' do

    it 'changes state of card when touched in' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'changes state when touched out' do
      expect(subject).not_to be_in_journey
    end

    it 'records the entry station on touch in' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end

  end

  context 'tests around minimum balance' do

    it 'should raise and error if balance is below minimum when tapped in' do
      expect {subject.touch_in(station)}.to raise_error('Insufficient funds')
    end
  end

  context 'the card can store journeys' do

    it 'should have an empty list of journeys by default' do
      new_card = Oystercard.new
      expect(new_card.journeys).to be_empty
    end

    it 'should store a journey after completeing a touch in and touch out' do
      @topped_up_card.touch_in(station)
      @topped_up_card.touch_out(10, station)
      expect(@topped_up_card.journeys).not_to be_empty
    end

  end

end
