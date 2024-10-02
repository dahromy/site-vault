#!/bin/bash

SCRIPT_VERSION="1.0.0"
SCRIPT_NAME="site-vault"
GITHUB_REPO="https://raw.githubusercontent.com/yourusername/site-vault/main/site-vault.sh"

# Function to get server name or alias
get_server_info() {
    local config_file="$1"
    local server_name=$(grep -i "ServerName" "$config_file" 2>/dev/null | awk '{print $2}' | head -1)
    if [ -z "$server_name" ]; then
        server_name=$(grep -i "ServerAlias" "$config_file" 2>/dev/null | awk '{print $2}' | head -1)
    fi
    echo "$server_name"
}

# Function to get all projects
get_all_projects() {
    find /etc/apache2/sites-available /etc/nginx/sites-available -name "*.conf" 2>/dev/null -print0 | 
    while IFS= read -r -d $'\0' file; do
        local server_info=$(get_server_info "$file")
        echo "$(basename "$file"):$server_info"
    done | sort
}

# Function to select a project with autocomplete
select_project() {
    local projects=($(get_all_projects))
    local PS3="Select a project (type to filter, Enter to list all): "
    select project in "${projects[@]}"; do
        if [[ -n $project ]]; then
            echo "You selected: $project"
            return
        fi
    done
}

# Function to get project directory
get_project_directory() {
    local config_file="$1"
    local directory=""
    if [[ "$config_file" == *"apache2"* ]]; then
        directory=$(grep -i "DocumentRoot" "$config_file" 2>/dev/null | awk '{print $2}' | tr -d '"')
    elif [[ "$config_file" == *"nginx"* ]]; then
        directory=$(grep -i "root" "$config_file" 2>/dev/null | awk '{print $2}' | tr -d ';\r')
    fi
    if [ -z "$directory" ]; then
        read -p "Couldn't find directory automatically. Please enter the project directory: " directory
    fi
    echo "$directory"
}

# Function to check for updates
check_for_updates() {
    echo "Checking for updates..."
    local latest_version=$(curl -s "$GITHUB_REPO" | grep "SCRIPT_VERSION=" | cut -d'"' -f2)
    if [[ "$latest_version" > "$SCRIPT_VERSION" ]]; then
        echo "A new version ($latest_version) is available. You are currently on version $SCRIPT_VERSION."
        read -p "Do you want to update? (y/n): " update_choice
        if [[ $update_choice =~ ^[Yy]$ ]]; then
            update_script
        else
            echo "Update cancelled. You can update later by running the script with the --update option."
        fi
    else
        echo "You are running the latest version of SiteVault."
    fi
}

# Function to update the script
update_script() {
    echo "Updating SiteVault..."
    local temp_file=$(mktemp)
    if curl -s "$GITHUB_REPO" -o "$temp_file"; then
        if [[ -s "$temp_file" ]]; then
            mv "$temp_file" "$0"
            chmod +x "$0"
            echo "Update successful. Please run the script again to use the new version."
            exit 0
        else
            echo "Error: Downloaded file is empty. Update failed."
            rm "$temp_file"
            exit 1
        fi
    else
        echo "Error: Failed to download the update. Please check your internet connection and try again."
        rm "$temp_file"
        exit 1
    fi
}

# Main function
main() {
    if [[ "$1" == "--version" ]]; then
        echo "SiteVault version $SCRIPT_VERSION"
        exit 0
    elif [[ "$1" == "--update" ]]; then
        check_for_updates
        exit 0
    fi

    echo "Welcome to SiteVault v$SCRIPT_VERSION!"

    # Select project
    select_project
    local selected_project=$(echo $project | cut -d':' -f1)

    # Get project directory
    local config_file=$(find /etc/apache2/sites-available /etc/nginx/sites-available -name "$selected_project" 2>/dev/null | head -1)
    local project_dir=$(get_project_directory "$config_file")
    echo "Project directory: $project_dir"

    # Create backup
    local backup_name="${selected_project%.*}_$(date +%Y%m%d_%H%M%S).tar.gz"
    echo "Creating backup..."
    tar -czvf "$backup_name" -C "$(dirname "$project_dir")" "$(basename "$project_dir")"
    echo "Backup created: $backup_name"

    # Ask about transfer
    read -p "Do you want to transfer this backup to another server? (y/n): " transfer_choice
    if [[ $transfer_choice =~ ^[Yy]$ ]]; then
        read -p "Enter the IP address of the destination server: " server_ip
        read -p "Enter the username for the destination server: " server_user
        read -p "Enter the SSH port (default is 22): " server_port
        server_port=${server_port:-22}
        read -p "Enter the destination folder on the remote server: " dest_folder

        # Transfer file
        echo "Transferring file..."
        scp -P "$server_port" "$backup_name" "$server_user@$server_ip:$dest_folder/"
        if [ $? -eq 0 ]; then
            echo "Transfer completed successfully!"
        else
            echo "Transfer failed."
        fi

        # Ask about deleting local backup
        read -p "Do you want to delete the local backup file? (y/n): " delete_choice
        if [[ $delete_choice =~ ^[Yy]$ ]]; then
            rm "$backup_name"
            echo "Local backup deleted."
        fi
    else
        echo "Backup not transferred. File is saved locally."
    fi

    echo "Script completed. Goodbye!"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi