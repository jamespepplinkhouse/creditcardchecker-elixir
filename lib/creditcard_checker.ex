defmodule CreditcardChecker do
  @moduledoc """
    Loads credit card numbers from an input file and writes the results of validation and identification to an output file; expects one credit card number per line
  """

 # Take inputfile and outputfile as parameters
  def main(args) do
    options = parse_args(args)
    IO.inspect options
    IO.puts options[:inputfile]
    IO.puts options[:outputfile]
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args, switches: [inputfile: :string] )
    options
  end

end
