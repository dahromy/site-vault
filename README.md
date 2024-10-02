# SiteVault

SiteVault is a powerful and user-friendly tool for backing up and transferring website projects. It supports both Apache and Nginx configurations, making it versatile for various web server setups.

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