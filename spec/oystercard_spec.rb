# frozen_string_literal: true

require 'oystercard'

describe Oystercard do

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
      expect { subject.touch_out(10) }.to change { subject.balance }.by(-10)
    end

  end

  context 'testing touch in/ touch out and card state' do

    it 'initial in_journey state is false' do
      new_card = Oystercard.new
      expect(new_card).not_to be_in_journey
    end

    it 'changes state of card when touched in' do
      subject.top_up(10)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'changes state when touched out' do
      expect(subject).not_to be_in_journey
    end

  end

  context 'tests around minimum balance' do

    it 'should raise and error if balance is below minimum when tapped in' do
      expect {subject.touch_in}.to raise_error('Insufficient funds')
    end
  end


end
