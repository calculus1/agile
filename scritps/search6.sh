#!/bin/bash

# Input file path
INPUT_FILE="inputfile.txt"

# Check if file exists
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: $INPUT_FILE not found."
  exit 1
fi

# Extract values between double quotes
grep -oP '"[^"]*"' "$INPUT_FILE" | sed 's/"//g'
