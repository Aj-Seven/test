#!/bin/bash

# Main function
main() {
    echo "Select an option:"
    echo "1. Clone repository"
    echo "2. Update repository"
    echo "3. hello"

    read -p "Enter your choice: " choice

    case $choice in
        1) 
            echo "Cloning repository..."
            clone_repo
            echo "Repository cloned successfully"
            ;;
        2) 
            if check_repo_folder; then
                echo "Repository folder exists"
            else
                echo "Repository folder not found. Please clone the repository first."
                exit 1
            fi

            check_update
            if [ $? -eq 0 ]; then
                echo "Updating repository..."
                update_repo
                echo "Repository updated successfully"
            else
                echo "No updates needed"
            fi
            ;;
            3) hello
            ;;
        *)
            echo "Invalid choice. Exiting..."
            exit 1
            ;;
    esac
}

hello() {
    echo "Hello World"
}

#!/bin/bash

REPO_URL="https://github.com/Aj-Seven/test.git"
REPO_FOLDER="test"

# Function to check if the repository folder exists
check_repo_folder() {
    if [ -d "$REPO_FOLDER" ]; then
        return 0 # Folder exists
    else
        return 1 # Folder does not exist
    fi
}

# Function to clone the repository
clone_repo() {
    git clone $REPO_URL $REPO_FOLDER
}

# Function to check for updates in the repository
check_update() {
    cd $REPO_FOLDER || exit 1
    
    # Fetch latest changes from remote repository
    git fetch origin

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

# Execute the main function
main
