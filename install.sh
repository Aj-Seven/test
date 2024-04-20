#!/bin/bash

# Function to clone the repository directory and create a symbolic link to the script in the bin directory
install_script() {
    REPO_URL="https://github.com/Aj-Seven/test"
    REPO_DIR="$PREFIX/share/test"
    SCRIPT_NAME="hello"
    BIN_DIR="$PREFIX/bin"
    SCRIPT_PATH="$REPO_DIR/$SCRIPT_NAME"

    # Delete the repository directory if it exists
    rm -rf "$REPO_DIR" || true

    # Clone the repository directory
    echo "Cloning repository directory..."
    git clone "$REPO_URL" "$REPO_DIR" > /dev/null 2>&1 || { echo "Failed to clone repository directory"; exit 1; }

    # Check if the repository directory was successfully cloned
    if [ -d "$REPO_DIR" ]; then
        echo "Repository directory cloned to $REPO_DIR"

        # Check if the script file exists in the repository directory
        if [ -f "$SCRIPT_PATH" ]; then
            # Create a symbolic link to the script in the bin directory
            echo "Creating symbolic link to the script in the bin directory..."
            ln -s "$SCRIPT_PATH" "$BIN_DIR/$SCRIPT_NAME" || { echo "Failed to create symbolic link"; exit 1; }
            echo "Script linked to $BIN_DIR/$SCRIPT_NAME"
        else
            echo "Script file $SCRIPT_NAME not found in the repository directory."
            exit 1
        fi
    else
        echo "Failed to clone repository directory"
        exit 1
    fi
}

# Set the default PREFIX if not provided
if [ -z "$PREFIX" ]; then
    PREFIX="/data/data/com.termux/files/usr/"
fi

# Execute the install_script function
install_script
