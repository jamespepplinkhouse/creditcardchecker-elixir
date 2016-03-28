#!/bin/bash
mix escript.build
./creditcardchecker --inputfile=./data/input_credit_cards.txt --outputfile=./data/output_credit_cards.txt
