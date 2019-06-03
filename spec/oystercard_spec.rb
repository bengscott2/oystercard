require 'oystercard'

describe Oystercard do
 it 'checks that a new card has a balance of zero' do
   expect(subject.balance).to eq(0)
 end
end
