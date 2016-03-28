defmodule CreditcardChecker do
  @moduledoc """
    Loads credit card numbers from an input file and writes the results of validation and identification to an output file; expects one credit card number per line
  """

  def main(args) do
    options = parse_args(args) |> validate_paramaters

    IO.puts("\nReading from:\t#{options[:inputfile]}")
    IO.puts("Writing to:\t#{options[:outputfile]}\n")

    {:ok, outputFile } = File.open(options[:outputfile], [:write])

    process_card = fn card ->
      validation_result = Creditcard.validate_and_identify(card) |> card_result_to_string
      IO.puts(validation_result)
      IO.binwrite(outputFile, "#{validation_result}\n")
    end

    File.stream!(options[:inputfile])
     |> Enum.each(process_card)

     IO.puts("\nFinished!\n")
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

    if (Enum.count(errors) > 0) do
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
