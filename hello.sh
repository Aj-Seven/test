#!/bin/bash


REPO_FOLDER="/home/$USER/test"

# Function to check if the repository folder exists
check_repo_folder() {
    if [ -d "$REPO_FOLDER" ]; then
        return 0 # Folder exists
    else
        return 1 # Folder does not exist
    fi
}

# Function to check for updates in the repository
check_update() {
    cd $REPO_FOLDER || exit 1

    git fetch origin > /dev/null 2>&1
    # Get the current branch
    current_branch=$(git rev-parse --abbrev-ref HEAD)

    # Check if the local branch is behind the remote branch
    if [ $(git rev-list HEAD...origin/$current_branch --count) -gt 0 ]; then
        echo "Updates available in $current_branch"
        return 0 # Updates available
    else
        echo "No updates available in $current_branch"
        return 1 # No updates available
    fi
}

# Function to update the repository
update_repo() {
    cd $REPO_FOLDER || exit 1
    git pull origin $(git rev-parse --abbrev-ref HEAD)
}

# Main function
main() {
echo "REPO FOLDER: $REPO_FOLDER"
    echo "Select an option:"
    echo "1. Check update status"
    echo "2. Update repository"
    echo "3. hello"
    echo "4. hii"
    echo "0. Exit"

    read -p "Enter your choice: " choice

    case $choice in
        1) 
            if check_repo_folder; then
                check_update
            else
                echo "Repository folder not found. Please clone the repository first."
            fi
            ;;
        2) 
            if check_repo_folder; then
                check_update
                if [ $? -eq 0 ]; then
                    echo "Updating repository..."
                    update_repo
                    echo "Repository updated successfully"
                else
                    echo "up-to-date :)"
                fi
            else
                echo "Repository folder not found. Please clone the repository first."
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
