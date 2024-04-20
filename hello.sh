#!/bin/bash

# Function to check for updates in the repository
check_update() {
    # Create a temporary directory for fetching updates
    temp_dir=$(mktemp -d)
    REPO_FOLDER="$temp_dir/test"
    REPO_URL="https://github.com/Aj-Seven/test"

    # Check if the repository folder exists
    if [ -d "$REPO_FOLDER" ]; then
        # Fetch updates forcefully into the existing repository folder
        cd "$REPO_FOLDER" || exit 1
        git fetch --force origin > /dev/null 2>&1
    else
        # Clone the repository if it doesn't exist
        echo "Repository folder not found, cloning repository..."
        git clone "$REPO_URL" "$REPO_FOLDER" > /dev/null 2>&1 || { echo "Failed to clone repository"; exit 1; }
    fi

    # Get the current branch
    current_branch=$(git rev-parse --abbrev-ref HEAD)

    # Check if the local branch is behind the remote branch
    if [ $(git rev-list HEAD...origin/$current_branch --count) -gt 0 ]; then
        echo "Updates available in $current_branch"
        # Ask the user if they want to update the script
        read -p "Do you want to update the script? (Y/N): " choice
        case "$choice" in
            y|Y) update_repo ;;
            n|N) echo "No updates applied";;
            *) echo "Invalid choice. No updates applied.";;
        esac
    else
        echo "Up-to-date in $current_branch"
    fi

    # Remove the temporary directory
    rm -rf "$temp_dir"
}

# Function to update the repository
update_repo() {
    cd "$REPO_FOLDER" || exit 1
    # Run git pull origin and parse the output to show only relevant lines
    if output=$(git pull origin "$(git rev-parse --abbrev-ref HEAD)" 2>&1 | grep -E 'Updating|Already up to date'); then
        echo "$output"
    else
        echo "Error occurred while updating the repository"
    fi
}

# Main function
main() {
echo "REPO FOLDER: $REPO_FOLDER"
    echo "Select an option:"
    echo "1. Check update status"
    echo "2. Update repository"
    echo "3. hello"
    echo "4. hII"
    echo "0. Exit"

    read -p "Enter your choice: " choice

    case $choice in
        1) check_update  || { echo "Failed to check for updates"; exit 1; }
            ;;
        2) update_repo
                 ;;
        3) hello
        ;;
        4) hii
        ;;
        0) 
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a number between 1 and 3."
            ;;
    esac
}

hello() {
    echo "Hello AJseven"
    echo "test"
}

hii() {
echo "Hii AJ7"
}

# Execute the main function
main
