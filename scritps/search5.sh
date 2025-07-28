#!/bin/bash

# Set the input and output file paths
INPUT_FILE="inputfile.txt"
OUTPUT_FILE="output.yaml"

# Ensure the input file exists
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: $INPUT_FILE not found."
  exit 1
fi

# Extract and format matched lines into YAML structure
{
  grep -E 'function|private_ip|hostname' "$INPUT_FILE" | while read -r line; do
    # Split key and value assuming format: key: value OR key = value
    KEY=$(echo "$line" | cut -d ':' -f1 | cut -d '=' -f1 | xargs)
    VALUE=$(echo "$line" | cut -d ':' -f2- | cut -d '=' -f2- | xargs)
    
    # Print in YAML format
    echo "$KEY: \"$VALUE\""
  done
} > "$OUTPUT_FILE"

# Confirmation message
echo "Structured YAML written to $OUTPUT_FILE."
