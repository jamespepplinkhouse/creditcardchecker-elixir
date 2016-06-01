# Credit Card Checker

This program validates and identifies credit card numbers by consuming an input file which has one credit card number per line. It writes the results into an output file with one credit card per line. This program is optimised for parsing large files as quickly as possible (it will use all CPU cores at 100%). Try this for a quick way to build and test the program:
```
./start.sh
```

To try a larger input data set (3,310,000 cards) there is a file at: ./data/input_credit_cards_large.txt


*Performance Features:*
- Streams the input file so that it can process very large files with consistent memory behaviour
- Input stream allows the program to start processing and writing the output file before the input file is fully loaded
- Processes cards in batches of 50,000 asynchronously to use all CPU cores

## Running tests:
```
mix test
```

## Profiling:
```
mix profile.fprof -e CreditcardChecker.main > profile.log
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
iex(1)> Creditcard.validate_and_identify("5105105105105106")
{"MasterCard", 5105105105105106, "invalid"}
iex(2)> Creditcard.is_card_number_valid?("5105105105105106")
false
iex(3)> Creditcard.determine_card_type(4111111111111111)
"VISA"
```
