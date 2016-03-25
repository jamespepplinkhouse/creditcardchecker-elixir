defmodule Creditcard do

  @doc ~S"""
    Validates a credit card number using the Luhn algorithm

    ## Examples

        iex> Creditcard.validate?(4111111111111111)
        :true

        iex> Creditcard.validate?("4111111111111111")
        :true

        iex> Creditcard.validate?(4111111111111)
        :false

        iex> Creditcard.validate?(4012888888881881)
        :true

        iex> Creditcard.validate?(378282246310005)
        :true

        iex> Creditcard.validate?(6011111111111117)
        :true

        iex> Creditcard.validate?(5105105105105100)
        :true

        iex> Creditcard.validate?("5105 1051 0510 5106")
        :false

        iex> Creditcard.validate?(9111111111111111)
        :false

  """
  def validate?(cc) when is_integer(cc) do
    0 == Integer.digits(cc)
      |> Enum.reverse
      |> Enum.chunk(2, 2, [0])
      |> Enum.reduce(0, fn([odd, even], sum) -> Enum.sum([sum, odd | Integer.digits(even*2)]) end)
      |> rem(10)
  end

  def validate?(cc) when is_binary(cc) do
    {cc_num, _} = String.replace(cc, ~r/[^0-9]/, "")
      |> Integer.parse

      validate?(cc_num)
  end

end
