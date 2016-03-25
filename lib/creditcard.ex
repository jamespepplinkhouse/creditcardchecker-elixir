defmodule Creditcard do
  @moduledoc """
    Validates a credit card number and identifies the card type
  """

  @doc ~S"""
    Validates a credit card number using the Luhn algorithm cc
  """
  def card_number_is_valid?(card_number) when is_integer(card_number) do
    0 == Integer.digits(card_number)
      |> Enum.reverse
      |> Enum.chunk(2, 2, [0])
      |> Enum.reduce(0, fn([odd, even], sum) -> Enum.sum([sum, odd | Integer.digits(even*2)]) end)
      |> rem(10)
  end

  def card_number_is_valid?(card_number) when is_binary(card_number) do
    {card_number_int, _} = String.replace(card_number, ~r/[^0-9]/, "")
      |> Integer.parse

      card_number_is_valid?(card_number_int)
  end

  @doc ~S"""
    Returns a string representing the card type
  """
  def determine_card_type(card_number) when is_integer(card_number) do

  end

end
