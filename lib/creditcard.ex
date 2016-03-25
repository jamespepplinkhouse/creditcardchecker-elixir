defmodule Creditcard do
  @moduledoc """
    Validates a credit card number and identifies the card type
  """

  @doc ~S"""
    Validates a credit card number using the Luhn algorithm cc
  """
  def card_number_is_valid?(card_number) do
      0 == cleanse(card_number)
        |> Integer.digits
        |> Enum.reverse
        |> Enum.chunk(2, 2, [0])
        |> Enum.reduce(0, fn([odd, even], sum) -> Enum.sum([sum, odd | Integer.digits(even*2)]) end)
        |> rem(10)
  end

  @doc ~S"""
    Returns a string representing the card type
  """
  def determine_card_type(card_number) when is_integer(card_number) do

  end

  defp cleanse(card_number) do
    if (is_binary(card_number)) do
      {card_number, _} = String.replace(card_number, ~r/[^0-9]/, "")
        |> Integer.parse
    end
    card_number
  end

end
