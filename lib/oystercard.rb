class OysterCard
MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1
MINIMUM_FARE = 1
  attr_reader :balance

  def initialize(balance = 0, journey = false)
    @balance = balance
    @journey = journey
  end

  def top_up(money)
    raise "maximum card limit (#{MAXIMUM_BALANCE}) reached" if @balance + money > MAXIMUM_BALANCE
    @balance += money
  end

private
  def deduct(money)
    @balance -= money
  end
public

  def in_journey?
    @journey
  end

  def touch_in
    raise 'insufficient travel funds' if @balance < MINIMUM_BALANCE
    @journey = true
  end

  def touch_out
    @journey = false
    deduct(MINIMUM_FARE)
  end
end
