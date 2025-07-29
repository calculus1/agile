#!/bin/bash

# Set the input and output files
input_file="input.txt"
output_file="output.txt"

# Make sure the input file exists
if [[ ! -f "$input_file" ]]; then
  echo "File not found: $input_file"
  exit 1
fi

# Clear or create the output file
> "$output_file"

# Read each line and check for the target words
while IFS= read -r line; do
  if [[ "${line,,}" == *function* || "${line,,}" == *hostname* || "${line,,}" == *name:* ]]; then
    echo "$line" >> "$output_file"
  fi
done < "$input_file"
