#!/bin/bash

main() {
    echo "1)hello"
    echo "2)Check Updates"
    echo "3)Update"
    read -n1 opt
    case $opt in
        1)
            hello
            ;;
        2)
            check_update
            ;;
        3)
            update
            ;;
        *)
            echo "Invalid Option"
            ;;
    esac

}

hello() {
    echo "Hello World"
}

#!/bin/bash

# Define your repository URL
REPO_URL="https://github.com/Aj-Seven/test.git"

# Define the directory where you want to clone the repository
CLONE_DIR="~/.cache/test"

# Function to update the repository
update() {
    echo "Updating repository..."
    git -C "$CLONE_DIR" pull origin master
    echo "Repository updated successfully."
}

# Function to check for updates
check_update() {
    echo "Checking for updates..."
    local response=$(curl -s "https://api.github.com/repos/Aj-Seven/test/compare/master")
    local ahead=$(echo "$response" | jq -r '.ahead_by')

    if [-n "$ahead"]  && [ "$ahead" -gt 0 ]; then
        echo "Updates available."
        update
    else
        echo "No updates available."
    fi
}


main
