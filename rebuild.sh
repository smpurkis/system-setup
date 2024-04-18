#!/usr/bin/env bash +x

# Exit on any error
set -e

# Check if a commit message is provided
if [ -z "$1" ]
then
    echo "Error: No commit message provided."
    exit 1
fi

# Check the config files
sudo nixos-rebuild dry-build --flake /etc/nixos/#default &>nixos-dry-build.log || (
 cat nixos-dry-build.log | grep --color error && false)

# Commit any changes
git add -A
git commit -m "$1"

# Push the changes
git push

# Apply the changes and log the output
sudo nixos-rebuild switch --flake /etc/nixos/#default &>nixos-switch.log || (
 cat nixos-switch.log | grep --color error && false)

rm nixos-dry-build.log nixos-switch.log