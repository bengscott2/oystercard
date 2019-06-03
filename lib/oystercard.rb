# frozen_string_literal: true

class Oystercard
  DEFAULT_BALANCE = 0
  DEFAULT_LIMIT = 90
  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    raise "Top up amount would exceed #{DEFAULT_LIMIT} max balance" if exceed?(amount)
    @balance += amount
  end

  private

  def exceed?(amount)
    amount + @balance > DEFAULT_LIMIT
  end
end
