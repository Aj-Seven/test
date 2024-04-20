#!/bin/bash

# Create a temporary directory for the repository
temp_dir=$(mktemp -d)
REPO_FOLDER="$temp_dir/test"
REPO_URL="https://github.com/Aj-Seven/test"

# Function to check for updates in the repository
check_update() {
    # Function to create the repository folder if it doesn't exist and clone the repository
    create_repo_folder() {
        if [ ! -d "$REPO_FOLDER" ]; then
            mkdir -p "$REPO_FOLDER"
        fi

        if [ -d "$REPO_FOLDER/.git" ]; then
            echo "Repository already exists in $REPO_FOLDER"
        else
            git clone "$REPO_URL" "$REPO_FOLDER"
        fi
    }

    # Function to check if the repository folder exists
    check_repo_folder() {
        if [ -d "$REPO_FOLDER" ]; then
            return 0 # Folder exists
        else
            return 1 # Folder does not exist
        fi
    }

    create_repo_folder
    if [ ! -d "$REPO_FOLDER" ]; then
        echo "Repository folder not found"
        return 1
    fi

    cd "$REPO_FOLDER" || exit 1

    git fetch origin > /dev/null 2>&1
    # Get the current branch
    current_branch=$(git rev-parse --abbrev-ref HEAD)

    # Check if the local branch is behind the remote branch
    if [ $(git rev-list HEAD...origin/$current_branch --count) -gt 0 ]; then
        echo "Updates available in $current_branch"
        return 0 # Updates available
    else
        echo "Up-to-date in $current_branch"
        return 1 # No updates available
    fi
}

# Function to update the repository
update_repo() {
    if [ ! -d "$REPO_FOLDER" ]; then
        echo "Repository folder not found"
        return 1
    fi

    cd "$REPO_FOLDER" || exit 1
     # Run git pull origin and parse the output to show only relevant lines
    if output=$(git pull origin "$(git rev-parse --abbrev-ref HEAD)" 2>&1 | grep -E 'Updating|Already up to date'); then
        echo "$output"
    else
        echo "Error occurred while updating the repository"
    fi
}

# Cleanup function to remove the temporary directory when the script exits
cleanup() {
    rm -rf "$temp_dir"
}

# Trap to ensure cleanup is called on script exit
trap cleanup EXIT

# Main script
check_update || { echo "Failed to check for updates"; exit 1; }

update_repo


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
        1) 
                check_update  || { echo "Failed to check for updates"; exit 1; }
            ;;
        2) check_update || { echo "Failed to check for updates"; exit 1; }
                if [ $? -eq 0 ]; then
                    echo "Updating..."
                    update_repo
                    echo "updated successfully"
                 fi
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
}

hii() {
echo "Hii AJ7"
}

# Execute the main function
main
