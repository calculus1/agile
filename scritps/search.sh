#!/bin/bash

# Usage: ./search_to_yaml.sh <search_word> <input_file> <output_file.yaml>

search_word="$1"
input_file="$2"
output_file="$3"

# Validate arguments
if [[ -z "$search_word" || -z "$input_file" || -z "$output_file" ]]; then
  echo "Usage: $0 <search_word> <input_file> <output_file.yaml>"
  exit 1
fi

# Check input file exists
if [[ ! -f "$input_file" ]]; then
  echo "Input file does not exist."
  exit 1
fi

# Start YAML output
echo "matches:" > "$output_file"

# Search and append matches to YAML
grep -- "$search_word" "$input_file" | while read -r line; do
  # Escape quotes and special characters for YAML safety
  safe_line=$(printf '%s\n' "$line" | sed 's/"/\\"/g')
  echo "  - \"$safe_line\"" >> "$output_file"
done

echo "YAML output written to $output_file"
