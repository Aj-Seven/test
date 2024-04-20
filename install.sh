#!/bin/bash

# Function to clone the repository directory and put a copy of the script inside the bin directory
install_script() {
    REPO_URL="https://github.com/Aj-Seven/test"
    REPO_DIR="$HOME/.local/test"
    SCRIPT_NAME="hello"
    BIN_DIR="$HOME/.local/bin"

    # Clone the repository directory
    echo "Cloning repository directory..."
    git clone "$REPO_URL" "$REPO_DIR" > /dev/null 2>&1 || { echo "Failed to clone repository directory"; exit 1; }

    # Check if the script file exists in the repository directory
    if [ ! -f "$REPO_DIR/$SCRIPT_NAME" ]; then
        echo "Script file $SCRIPT_NAME not found in the repository directory."
        exit 1
    fi

    # Copy the script to the bin directory
    echo "Copying script to the bin directory..."
    cp "$REPO_DIR/$SCRIPT_NAME" "$BIN_DIR" || { echo "Failed to copy script to the bin directory"; exit 1; }

    # Set executable permissions for the copied script
    chmod +x "$BIN_DIR/$SCRIPT_NAME" || { echo "Failed to set executable permissions for the copied script"; exit 1; }

    echo "Script installed to $BIN_DIR/$SCRIPT_NAME"
}

# Execute the install_script function
install_script

