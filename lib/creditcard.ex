defmodule Creditcard do
  @moduledoc """
    Validates a credit card number and identifies the card type
  """

  @doc ~S"""
    Validates and identifies a credit card

    ## Parameters
      - card_number: A credit card number (either string or integer)

    ## Examples
      iex> Creditcard.validate_and_identify("378282246310005")
      { "AMEX", 378282246310005, "valid" }
  """
  def validate_and_identify(card_number) do
    card_number = cleanse(card_number)
    validation_result = case is_card_number_valid?(card_number) do
      :true -> "valid"
      :false -> "invalid"
    end

    { card_number |> determine_card_type, card_number, validation_result}
  end

  @doc ~S"""
    Verifies that a credit card number is valid using the Luhn algorithm cc

    ## Parameters
      - card_number: A credit card number (either string or integer)

    ## Examples
      iex> Creditcard.is_card_number_valid?(378282246310005)
      :true
  """
  def is_card_number_valid?(card_number) do
    0 == card_number
      |> Integer.digits
      |> Enum.reverse
      |> Enum.chunk(2, 2, [0])
      |> Enum.reduce(0, fn([odd, even], sum) -> Enum.sum([sum, odd | Integer.digits(even*2)]) end)
      |> rem(10)
  end

  @doc ~S"""
    Returns a string representing the card type

    ## Parameters
      - card_number: A credit card number (either string or integer)

    ## Examples
      iex> Creditcard.determine_card_type(378282246310005)
      "AMEX"
  """
  def determine_card_type(card_number) do
    card_number_list = card_number |> Integer.to_char_list
    starting_digits = card_number_list |> Enum.take(4) |> to_string
    card_length = card_number_list |> Enum.count

    case {starting_digits, card_length} do
      {"34" <> _, 15} -> "AMEX"
      {"37" <> _, 15} -> "AMEX"
      {"6011", 16} -> "Discover"
      {"51" <> _, 16} -> "MasterCard"
      {"55" <> _, 16} -> "MasterCard"
      {"4" <> _, 13} -> "VISA"
      {"4" <> _, 16} -> "VISA"
      {_, _} -> "Unknown"
    end
  end

  defp cleanse(card_number) do
    {card_number, _} = card_number |> Integer.parse
    card_number
  end

end
