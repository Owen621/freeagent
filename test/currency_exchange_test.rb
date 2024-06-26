# These are just suggested definitions to get you started.  Please feel
# free to make any changes at all as you see fit.


# http://test-unit.github.io/
require 'test/unit'
require 'currency_exchange'
require 'date'
require 'json'

class CurrencyExchangeTest < Test::Unit::TestCase
  def setup
  end

  def test_non_base_currency_exchange_is_correct
    correct_rate = 1.2870493690602498
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018,11,22), "GBP", "USD")
  end

  def test_base_currency_exchange_is_correct
    correct_rate = 0.007763975155279502
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018,11,22), "JPY", "EUR")
  end

  def test_base_currency_exchange_for_from
    correct_rate = 1.1403
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018,11,22), "EUR", "USD")
  end
  
  def test_base_currency_exchange_for_to_and_from
    correct_rate = 1
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018,11,22), "EUR", "EUR")
  end
end