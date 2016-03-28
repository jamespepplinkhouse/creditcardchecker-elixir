defmodule CreditcardChecker do
  @moduledoc """
    Loads credit card numbers from an input file and writes the results of validation and identification to an output file; expects one credit card number per line
  """

  def main(args) do
    options = parse_args(args) |> validate_paramaters

    IO.puts("\nReading from:\t#{options[:inputfile]}")
    IO.puts("Writing to:\t#{options[:outputfile]}\n")

    outputFile = File.open!(options[:outputfile], [:write])

    # File.read!(options[:inputfile])
    #   |> String.split("\n")
    File.stream!(options[:inputfile], [:read])
      |> Stream.chunk(10000, 10000, [])
      |> Enum.map(&handle_cards_async(&1, outputFile))


      # |> Enum.map(&Task.async(fn -> process_batch_of_cards(&1) end))
      # |> Enum.map(fn pid -> IO.binwrite(outputFile, Task.await(pid)) end)
      # |> Enum.map(&Task.await/1)
      # |> Enum.map(&IO.binwrite(outputFile, &1))

    IO.puts("Finished!\n")
  end

  defp handle_cards_async(cards, outputFile) do
    task = Task.async(fn -> process_batch_of_cards(cards) end)
    result = Task.await(task)
    IO.binwrite(outputFile, result)
  end

  defp process_batch_of_cards(cards) do
    cards
      |> Enum.filter(fn x -> x != "" end)
      |> Enum.map(&Creditcard.validate_and_identify(&1))
      |> Enum.map(&card_result_to_string(&1))
      |> Enum.join("\n")
      # |> IO.puts
      # |> &IO.binwrite(outputFile, &1)
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args, switches: [inputfile: :string, outputfile: :string] )
    options
  end

  defp validate_paramaters(options) do
    errors = []

    if (!options[:inputfile]) do
      errors = ["Missing parameter 'inputfile', example: '--inputfile=/tmp/input.txt'" | errors]
    end

    if (!options[:outputfile]) do
      errors = ["Missing parameter 'outputfile', example: '--outputfile=/tmp/output.txt'" | errors]
    end

    if (Enum.any?(errors)) do
      errors
        |> Enum.reverse
        |> Enum.each(fn error -> IO.puts(:stderr, error) end)

      IO.puts "Aborting!"
      exit(:shutdown)
    end

    if (!File.regular?(options[:inputfile])) do
      IO.puts "Input file '#{options[:inputfile]}' does not exist. Aborting!"
      exit(:shutdown)
    end

    options
  end

  defp card_result_to_string(card_result) do
    {type, number, validity} = card_result
    "#{type}: #{number} (#{validity})"
  end

end
