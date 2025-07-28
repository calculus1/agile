#!/bin/bash

# Function: Search for lines with 'private_ip' and extract 'hostname'
search_private_ip_and_hostname() {
  local input_file="$1"
  local output_file="$2"

  if [[ -z "$input_file" || -z "$output_file" ]]; then
    echo "Usage: search_private_ip_and_hostname <input_file> <output_file.yaml>"
    return 1
  fi

  if [[ ! -f "$input_file" ]]; then
    echo "Input file '$input_file' not found."
    return 1
  fi

  echo "hosts:" > "$output_file"

  # Search for 'private_ip' lines
  grep "private_ip" "$input_file" | while read -r line; do
    # Extract hostname and private_ip using regex
    hostname=$(echo "$line" | grep -oE 'hostname[[:space:]]*[:=][[:space:]]*[^[:space:],]+' | cut -d' ' -f2- | cut -d= -f2)
    ip=$(echo "$line" | grep -oE 'private_ip[[:space:]]*[:=][[:space:]]*[^[:space:],]+' | cut -d' ' -f2- | cut -d= -f2)

    if [[ -n "$hostname" && -n "$ip" ]]; then
      echo "  - hostname: \"$hostname\"" >> "$output_file"
      echo "    private_ip: \"$ip\"" >> "$output_file"
    fi
  done

  echo "✅ YAML output written to $output_file"
}
