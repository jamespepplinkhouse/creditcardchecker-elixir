defmodule CreditcardTest do
  use ExUnit.Case
  doctest Creditcard

  test "can validate credit card number as integer" do
    assert Creditcard.card_number_is_valid?(4111111111111111) == :true
    assert Creditcard.card_number_is_valid?(4111111111111111) == :true
    assert Creditcard.card_number_is_valid?(4111111111111) == :false
    assert Creditcard.card_number_is_valid?(4012888888881881) == :true
    assert Creditcard.card_number_is_valid?(378282246310005) == :true
    assert Creditcard.card_number_is_valid?(6011111111111117) == :true
    assert Creditcard.card_number_is_valid?(5105105105105100) == :true
    assert Creditcard.card_number_is_valid?(9111111111111111) == :false
  end

  test "can validate credit card number as binary" do
    assert Creditcard.card_number_is_valid?("4111111111111111") == :true
    assert Creditcard.card_number_is_valid?("5105 1051 0510 5106") == :false
    assert Creditcard.card_number_is_valid?("411!111$1111#111##111") == :true
  end
end
