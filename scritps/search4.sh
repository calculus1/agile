#!/bin/bash 

# Set the input and output file paths
INPUT_FILE="inputfile.txt"
OUTPUT_FILE="output.yaml"

# Ensure the input file exists
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: $INPUT_FILE not found."
  exit 1
fi

# Run the awk command and append the output
awk '/function/;/private_ip/;/hostname/' "$INPUT_FILE" >> "$OUTPUT_FILE"

# Confirmation message
echo "Search complete. Results appended to $OUTPUT_FILE."
