#!/bin/bash

config_file=~/.config/nix/nix.conf
line="experimental-features = nix-command flakes"

# Check if the line already exists in the config file
if grep -Fxq "$line" "$config_file"; then
    echo "Line already exists in $config_file"
else
    # Add the line to the config file
    echo "$line" >> "$config_file"
    echo "Line added to $config_file"
fi