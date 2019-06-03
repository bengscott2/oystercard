# frozen_string_literal: true

class Oystercard
  DEFAULT_BALANCE = 0
  DEFAULT_LIMIT = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = DEFAULT_BALANCE
  end

  def top_up(amount)
    raise "Top up amount would exceed #{DEFAULT_LIMIT} max balance" if exceed?(amount)
    @balance += amount
  end

  def in_journey?
    @entry_station
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance <= MINIMUM_BALANCE
    @in_journey = true
    @entry_station = station
  end

  def touch_out(fare)
    deduct(fare)
    @in_journey = false
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def exceed?(amount)
    amount + @balance > DEFAULT_LIMIT
  end
end
