# SiteVault

SiteVault is a powerful and user-friendly tool for backing up and transferring website projects. It supports Apache and Nginx configurations, making it versatile for various web server setups.

## Features

- Automatic detection of Apache and Nginx site configurations
- Interactive project selection with autocomplete functionality
- Easy backup creation with timestamp
- Option to transfer backups to remote servers
- Support for custom SSH ports
- Version checking and update mechanism

## Installation

You can easily install SiteVault using our one-line installer:

```bash
sudo bash -c "$(curl -sSL https://gist.githubusercontent.com/dahromy/4929f9f58b7ee81434e58c54c208d46e/raw/f429fc777403a0a625237b6bafe908bb32183386/site-vault-installer.sh)"
```

This will download and install SiteVault to `/usr/local/bin/site-vault`, making it available system-wide.

## Usage

After installation, you can run SiteVault by typing `site-vault` in your terminal.

### Basic Commands

- Run SiteVault: `site-vault`
- Check version: `site-vault --version`
- Check for updates: `site-vault --update`

### Backup Process

1. When you run `site-vault`, it will list all available projects from your Apache and Nginx configurations.
2. Select a project from the list (you can type to filter the list).
3. SiteVault will display project details and ask for confirmation before proceeding.
4. If confirmed, SiteVault will create a backup of the selected project.
5. You'll be asked if you want to transfer the backup to another server.
6. If you choose to transfer, you'll be prompted for the destination server details.
7. After the transfer (if selected), you'll have the option to delete the local backup.

## Requirements

- Bash shell
- Apache2 or Nginx web server
- SSH client (for remote transfers)

## Changelog

### Version 1.2.1

- Fixed issue with duplicate sites appearing in the project list.
- Added a confirmation step before creating a backup, allowing users to review and confirm the selected project details.
- Improved the `get_all_projects()` function to remove duplicates and provide a cleaner list of available sites.
- Enhanced user interaction by adding a clear confirmation prompt before proceeding with the backup process.

### Version 1.2.0

- Added support for Nginx configurations alongside Apache.
- Improved server name detection to prioritize www prefixed ServerName or ServerAlias.
- Enhanced project directory detection for both Apache and Nginx configurations.
- Updated backup filename to include a timestamp for better organization.
- Improved handling of SSL configurations, now properly ignoring SSL-specific files when selecting the main configuration.
- Enhanced error handling and user feedback throughout the script.
- Updated the script to work with both /etc/apache2/sites-available and /etc/nginx/sites-available directories.

### Version 1.1.13

- Improved handling of projects where the DocumentRoot ends with 'public' or 'web' directories.
- Enhanced the `get_project_directory` function to use the parent directory when 'public' or 'web' is detected as the last folder.
- Fixed issues with backing up the correct project root for frameworks that use 'public' or 'web' as their public-facing directory.
- Improved accuracy in identifying the correct project directory for various project structures.

### Version 1.1.12

- Improved the `get_project_directory` function to handle a wider variety of directory structures.
- Enhanced logic to correctly identify project directories for sites like rock.aty-aminay.com.
- Added support for cases where the DocumentRoot doesn't contain the subdomain or domain name.
- Improved handling of trailing slashes in directory paths.
- Further refined the project directory detection process based on real-world Apache configurations.

### Version 1.1.11

- Fixed a critical bug in the `get_project_directory` function that was causing incorrect project directory identification.
- Improved handling of subdomains in project directory detection.
- Enhanced logic to correctly identify project directories for complex structures (e.g., naomi.aty-aminay.com).
- Added fallback to use the parent of DocumentRoot if the subdomain is not found in the path.
- Improved error handling and user prompts for manual directory input when automatic detection fails.

### Version 1.1.10

- Improved the `get_project_directory` function to correctly identify project directories for complex structures.
- Enhanced logic to handle cases where the project name is a subdirectory within the DocumentRoot.
- Added support for projects with multiple subdomains and varying directory structures.
- Improved accuracy in identifying the correct project root directory for backup.

### Version 1.1.9

- Enhanced the `get_project_directory` function to handle cases where DocumentRoot points to a 'web' subdirectory.
- Improved logic to correctly identify and backup the main project directory for complex structures (e.g., /var/www/html/prod/aty-aminay.com/naomi/web).
- Added support for projects with multiple levels of subdirectories in their DocumentRoot.
- Further improved user interaction by providing more accurate project directory detection.

### Version 1.1.8

- Improved the `get_project_directory` function to handle cases where DocumentRoot points to a 'public' subdirectory.
- Enhanced logic to correctly identify and backup the main project directory, even when Apache configuration points to a subdirectory.
- Added a verification step to check if the identified project directory exists.
- Improved user interaction by prompting for the correct directory if the automatically detected one doesn't exist.

### Version 1.1.7

- Improved parsing of ServerName and ServerAlias in configuration files.
- Enhanced handling of SSL and non-SSL configurations.
- Improved accuracy in identifying the DocumentRoot for each project.
- Updated project listing to remove 'www.' prefix for consistency.
- Enhanced project selection to match both www and non-www versions of domains.
- Improved error handling when no configuration files are found for a selected project.

### Version 1.1.6

- Improved the logic for selecting the correct configuration file when multiple files match the selected project.
- Enhanced the `show_project_details` function to display information from the most relevant configuration file.
- Fixed issues with displaying server configurations for projects with multiple virtual hosts.
- Improved accuracy in identifying the correct project directory for backup.

### Version 1.1.5

- Improved the `get_server_info` function to handle ServerName and ServerAlias more accurately.
- Prioritized www versions of domains when both ServerName and ServerAlias are present.
- Enhanced logic to select the most appropriate domain name for each project.
- Improved handling of configurations with multiple ServerAlias entries.

### Version 1.1.4

- Fixed issues with unnecessary www prefixes being added to domain names.
- Improved project listing to show domains exactly as they appear in server configurations.
- Enhanced matching logic for ServerName and ServerAlias to ensure correct project selection.
- Optimized the get_server_info function to prioritize ServerName over ServerAlias.
- Improved error handling and empty line filtering in the project list.

### Version 1.1.3

- Improved handling of ServerName and ServerAlias to correctly identify and list projects.
- Added support for both www and non-www versions of domains in the project list.
- Enhanced project selection to match both www and non-www versions of domains.
- Fixed issues with project details display for domains with or without www prefix.
- Improved accuracy in identifying the correct configuration file for selected projects.

### Version 1.1.2

- Improved handling of ServerName and ServerAlias in Apache configurations.
- Updated project listing to prioritize ServerAlias if it exists.
- Enhanced project selection to handle multiple ServerAlias entries.
- Fixed issues with exact matching of project names.

### Version 1.1.1

- Fixed a bug where selecting a project would show details for all projects with similar names.
- Improved project selection to only show exact matches for the selected project.
- Enhanced error handling when no configuration files are found for a selected project.

### Version 1.1.0

- Improved project listing: Now shows only unique site names/aliases, grouping SSL and non-SSL configurations.
- Enhanced project selection: Displays project details (configuration files, server configuration) before backup.
- Added confirmation step: Users can now review project details and confirm before proceeding with the backup.
- Updated backup naming: Backup files now use the site name instead of the configuration file name.
- General code improvements and optimizations.

## Contributing

We welcome contributions to SiteVault! Please feel free to submit issues, fork the repository and send pull requests!

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Support

If you encounter any problems or have any questions, please open an issue in this repository.

## Acknowledgments

- Thanks to all contributors who have helped shape SiteVault
- Inspired by the need for an easy-to-use backup solution for web projects

---

Remember to regularly check for updates to ensure you're using the latest version of SiteVault with all the newest features and bug fixes!