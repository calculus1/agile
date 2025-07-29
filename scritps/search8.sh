#!/bin/bash

# Set the input and output file paths
INPUT_FILE="inputfile.txt"
OUTPUT_FILE="output.yaml"

# Ensure the input file exists
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: $INPUT_FILE not found."
  exit 1
fi

# Start YAML output
echo "---" > "$OUTPUT_FILE"
echo "entries:" >> "$OUTPUT_FILE"

# Temporary variables to store fields
func=""
ip=""
host=""

# Read input file line by line
while IFS= read -r line; do
  if [[ "$line" == function* ]]; then
    func="${line#function }"
  elif [[ "$line" == private_ip* ]]; then
    ip="${line#*: }"
  elif [[ "$line" == hostname* ]]; then
    host="${line#*: }"

    # When all three are collected, output as one YAML entry
    if [[ -n "$func" && -n "$ip" && -n "$host" ]]; then
      echo "  - function: \"$func\"" >> "$OUTPUT_FILE"
      echo "    private_ip: \"$ip\"" >> "$OUTPUT_FILE"
      echo "    hostname: \"$host\"" >> "$OUTPUT_FILE"
      func=""
      ip=""
      host=""
    fi
  fi
done < "$INPUT_FILE"

# Confirmation message
echo "Search complete. Structured YAML written to $OUTPUT_FILE."

