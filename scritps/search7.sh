#!/bin/bash

# Input file path
INPUT_FILE="inputfile.txt"

# Output YAML file path
OUTPUT_FILE="output.yaml"

# Check if input file exists
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: $INPUT_FILE not found."
  exit 1
fi

# Start writing YAML structure
echo "extracted_values:" > "$OUTPUT_FILE"

# Extract values between double quotes and append them to the YAML file
grep -oP '"[^"]*"' "$INPUT_FILE" | sed 's/"//g' | while read -r line; do
  echo "  - \"$line\"" >> "$OUTPUT_FILE"
done

echo "Extraction complete. Output saved to $OUTPUT_FILE."
