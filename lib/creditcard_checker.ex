defmodule CreditcardChecker do
  @moduledoc """
    Loads credit card numbers from an input file and writes the results of validation and identification to an output file; expects one credit card number per line
  """

  def main(args) do
    options = parse_args(args)

    IO.puts("\nReading from:\t#{options[:inputfile]}")
    IO.puts("Writing to:\t#{options[:outputfile]}\n")

    outputFile = File.open!(options[:outputfile], [:write])

    File.stream!(options[:inputfile], [:read])
      |> Stream.chunk(50000, 50000, [])
      |> Enum.map(&Task.async(fn -> process_batch_of_cards(&1, outputFile) end))
      |> Enum.map(&Task.await/1)

    IO.puts("Finished!\n")
  end

  defp process_batch_of_cards(cards, outputFile) do
    result = cards
      |> Enum.filter(fn x -> x != "" end)
      |> Enum.map(&Creditcard.validate_and_identify(&1))
      |> Enum.map(&card_result_to_string(&1))
      |> Enum.join("\n")

    IO.binwrite(outputFile, result)
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args, switches: [inputfile: :string, outputfile: :string] )
    options
  end

  defp card_result_to_string(card_result) do
    {type, number, validity} = card_result
    "#{type}: #{number} (#{validity})"
  end

end
