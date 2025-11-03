[README.md](https://github.com/user-attachments/files/23301484/README.md)
# Fedora-Hyprland-backup

Automated backup and restore scripts for Fedora Linux with Hyprland:
includes package lists and Hyprland configuration files.

---

## Features

- Export lists of installed packages from multiple package managers
- Backup and safely restore your Hyprland configuration
- Restore scripts designed for minimal user intervention and maximum safety
- Clean project structure for versioning and sharing your setup

---

## Project Structure

backup_project/
├── packages_backup/ # Package lists for dnf, flatpak, pip, etc.
├── hyprland_repo/ # Hyprland config files (to deploy)
├── install_packages.sh # Script to install all packages from txt lists
├── install_hyprland_settings.sh # Script to backup and sync Hyprland config
└── hyprland_backup/ # (Created locally during restore, not versioned)

---

## Usage

1. **Clone this repository:**
   git clone <https://github.com/yourusername/fedora-hyprland-backup.git>
   cd fedora-hyprland-backup

2. **Install all packages:**
   bash install_packages.sh

3. **Backup and sync Hyprland config:**
   bash install_hyprland_settings.sh

- Your previous Hyprland settings are automatically backed up before replacement.

---

## Notes

- Do **not** commit your local `hyprland_backup/` to the repo;
  it is created as a runtime safety backup on your machine.
- Edit, add, or customize configs in `hyprland_repo/` as needed.

---

## License

MIT or your preferred open source license.
