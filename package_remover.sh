#!/bin/bash

# Array of packages to remove (add or remove as needed)
packages_to_remove=(
  libreoffice*
  gnome-games*
  thunderbird
  gnome-software
  nautilus
  # Add more packages here
)

# Confirmation before removing
read -p "Are you sure you want to remove the following packages? (y/n): ${packages_to_remove[@]} " confirmation

if [[ "$confirmation" == "y" ]]; then
  # Loop through the packages and remove them
  for package in "${packages_to_remove[@]}"; do
    echo "Removing package: $package"
    sudo apt purge "$package"  # Use purge to remove config files as well
    if [[ $? -ne 0 ]]; then # Check for errors
      echo "Error removing $package. Skipping."
    fi
  done

  # Remove orphaned dependencies
  sudo apt autoremove

  # Update and upgrade
  sudo apt update
  sudo apt upgrade

  echo "Packages removed and system updated."
else
  echo "Removal cancelled."
fi
