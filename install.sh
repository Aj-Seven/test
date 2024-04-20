#!/bin/bash

# Function to clone the repository directory and put a copy of the script inside it
install_script() {
    REPO_URL="https://github.com/Aj-Seven/test"
    REPO_DIR="$HOME/test"
    SCRIPT_NAME="your_script.sh"
    BIN_DIR="$HOME/.local/bin"

    # Clone the repository directory
    echo "Cloning repository directory..."
    git clone "$REPO_URL" "$REPO_DIR" > /dev/null 2>&1 || { echo "Failed to clone repository directory"; exit 1; }

    # Copy the script to the repository directory
    echo "Copying script to the repository directory..."
    cp "$BIN_DIR/$SCRIPT_NAME" "$REPO_DIR" || { echo "Failed to copy script to the repository directory"; exit 1; }

    # Set executable permissions for the copied script
    chmod +x "$REPO_DIR/$SCRIPT_NAME" || { echo "Failed to set executable permissions for the copied script"; exit 1; }

    echo "Script installed to $REPO_DIR/$SCRIPT_NAME"
}

# Execute the install_script function
install_script
