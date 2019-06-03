# frozen_string_literal: true

class Oystercard
  DEFAULT_BALANCE = 0
  DEFAULT_LIMIT = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance

  def initialize
    @balance = DEFAULT_BALANCE
    @in_journey = false
  end

  def top_up(amount)
    raise "Top up amount would exceed #{DEFAULT_LIMIT} max balance" if exceed?(amount)
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "Insufficient funds" if @balance <= MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out(fare)
    deduct(fare)
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def exceed?(amount)
    amount + @balance > DEFAULT_LIMIT
  end
end
