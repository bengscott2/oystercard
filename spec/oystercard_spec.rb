# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  it 'checks that a new card has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it 'increments the balance by 20' do
    expect { subject.top_up(20) }.to change { subject.balance }.by(20)
  end

  it 'raises an erorr if top up amount goes beyond limit' do
    expect { subject.top_up(Oystercard::DEFAULT_LIMIT + 1) }.to raise_error("Top up amount would exceed #{Oystercard::DEFAULT_LIMIT} max balance")
  end
end
