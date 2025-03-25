#!/usr/bin/env bash

# Example usage:
# ./rebuild.sh "Update the system configuration"


# Exit on any error
set -e

# Check if a commit message is provided
if [ -z "$1" ]
then
    echo "Error: No commit message provided."
    exit 1
fi

# Check the config files
home-manager build --flake .#sam &>home-manager-build.log || (
 cat home-manager-build.log | grep --color error && false)

# Commit any changes
git add -A
git commit -m "$1"

# Push the changes
git push

# Apply the changes and log the output
home-manager switch --flake .#sam -b backup &>home-manager-switch.log || (
 cat home-manager-switch.log | grep --color error && false)

rm home-manager-build.log home-manager-switch.log