# Credit Card Checker

This program validates and identifies credit card numbers by consuming an input file with a credit card number on each line and writing the results into an output file.

## Running tests:
```
mix test
```

## Building CLI tool:
```
mix escript.build
```

## Example CLI usage:
```
./creditcardchecker --inputfile=./data/input_credit_cards.txt --outputfile=./data/output_credit_cards.txt
```

## IEX examples:
```
$ iex -S mix
Erlang/OTP 18 [erts-7.3] [source-d2a6d81] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false]

Interactive Elixir (1.2.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> Creditcard.validate_and_identify("5105 1051 0510 5106")
{"MasterCard", 5105105105105106, "invalid"}
iex(2)> Creditcard.is_card_number_valid?("5105 1051 0510 5106")
false
iex(3)> Creditcard.determine_card_type(4111111111111111)
"VISA"
```
