#!/bin/bash

# Function to move script to bin directory and set executable permissions
install_script() {
    SCRIPT_NAME="your_script.sh"
    BIN_DIR="$HOME/.local/bin"
    SCRIPT_PATH=$(realpath "$SCRIPT_NAME")

    # Move the script to bin directory
    mkdir -p "$BIN_DIR" || { echo "Failed to create directory: $BIN_DIR"; exit 1; }
    mv "$SCRIPT_PATH" "$BIN_DIR" || { echo "Failed to move script to $BIN_DIR"; exit 1; }

    # Set executable permissions
    chmod +x "$BIN_DIR/$SCRIPT_NAME" || { echo "Failed to set executable permissions"; exit 1; }

    echo "Script installed to $BIN_DIR/$SCRIPT_NAME"
}

# Execute the install_script function
install_script
