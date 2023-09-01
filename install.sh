#!/bin/bash

# Script name and installation directory
SCRIPT_NAME="create_project_cpp"
INSTALL_DIR="/usr/local/bin"
NODE_PATH=$(which node)

# Get the absolute path of the current directory
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Find the path of the npm executable dynamically
NPM_PATH=$(which npm)

if [ -z "$NPM_PATH" ]; then
    echo "Error: npm not found. Make sure npm is installed and in your PATH."
    exit 1
fi

# Install the CLI globally using npm
sudo "$NODE_PATH" "$NPM_PATH" install -g "$CURRENT_DIR"

# Copy assets to a directory within the installation directory
ASSETS_DIR="$INSTALL_DIR/create_project_cpp/assets"
sudo mkdir -p "$ASSETS_DIR"
sudo cp -r "$CURRENT_DIR/assets"/* "$ASSETS_DIR"

# Determine the shell being used
SHELL_NAME="$(ps -p $$ -o args=)"
case $SHELL_NAME in
  *zsh*) PROFILE_FILE="$HOME/.zshrc" ;;
  *) PROFILE_FILE="$HOME/.bashrc" ;;
esac

# Add the installation directory to PATH
echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$PROFILE_FILE"
source "$PROFILE_FILE"

echo "CLI installed successfully."
