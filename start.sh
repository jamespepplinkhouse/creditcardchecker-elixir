#!/bin/bash
mix escript.build
time ./creditcardchecker --inputfile=./data/input_credit_cards_large.txt --outputfile=./data/output_credit_cards.txt
