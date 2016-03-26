defmodule CreditcardTest do
  use ExUnit.Case
  doctest Creditcard

  test "can validate credit card number as integer" do
    assert Creditcard.is_card_number_valid?(4111111111111111) == :true
    assert Creditcard.is_card_number_valid?(4111111111111111) == :true
    assert Creditcard.is_card_number_valid?(4111111111111) == :false
    assert Creditcard.is_card_number_valid?(4012888888881881) == :true
    assert Creditcard.is_card_number_valid?(378282246310005) == :true
    assert Creditcard.is_card_number_valid?(6011111111111117) == :true
    assert Creditcard.is_card_number_valid?(5105105105105100) == :true
    assert Creditcard.is_card_number_valid?(9111111111111111) == :false
  end

  test "can validate credit card number as binary" do
    assert Creditcard.is_card_number_valid?("4111111111111111") == :true
    assert Creditcard.is_card_number_valid?("5105 1051 0510 5106") == :false
    assert Creditcard.is_card_number_valid?("411!111$1111#111##111") == :true
  end

  test "can identify the type of credit card" do
    assert Creditcard.determine_card_type(4111111111111111) == "VISA"
    assert Creditcard.determine_card_type(4111111111111) == "VISA"
    assert Creditcard.determine_card_type(4012888888881881) == "VISA"
    assert Creditcard.determine_card_type(378282246310005) == "AMEX"
    assert Creditcard.determine_card_type(6011111111111117) == "Discover"
    assert Creditcard.determine_card_type(5105105105105100) == "MasterCard"
    assert Creditcard.determine_card_type(5105105105105106) == "MasterCard"
    assert Creditcard.determine_card_type(9111111111111111) == "Unknown"
  end

  test "can validate and identify a credit card" do
    assert Creditcard.validate_and_identify(4111111111111111) == { "VISA", 4111111111111111, "valid" }
    assert Creditcard.validate_and_identify(4111111111111) == { "VISA", 4111111111111, "invalid" }
    assert Creditcard.validate_and_identify(4012888888881881) == { "VISA", 4012888888881881, "valid" }
    assert Creditcard.validate_and_identify(378282246310005) == { "AMEX", 378282246310005, "valid" }
    assert Creditcard.validate_and_identify(6011111111111117) == { "Discover", 6011111111111117, "valid" }
    assert Creditcard.validate_and_identify(5105105105105100) == { "MasterCard", 5105105105105100, "valid" }
    assert Creditcard.validate_and_identify(5105105105105106) == { "MasterCard", 5105105105105106, "invalid" }
    assert Creditcard.validate_and_identify(9111111111111111) == { "Unknown", 9111111111111111, "invalid" }
  end
end
