#!/bin/bash

BACKUPDIR="$HOME/fedora-hyprland-restore-kit/packages_backup"

install_list() {
  local file=$1
  local cmd=$2
  if [[ ! -f "$BACKUPDIR/$file" ]]; then
    echo "Backup file $file not found. Skipping."
    return
  fi
  echo "Installing from $file..."
  eval $cmd
}
#dnf
install_list "dnf_packages.txt" "sudo dnf install -y \$(awk 'NR>1 {print \$1}' $BACKUPDIR/dnf_packages.txt)"
#flatpak
install_list "flatpak_packages.txt" "while read pkg; do flatpak install -y \$pkg; done < <(awk 'NR>1 {print \$1}' $BACKUPDIR/flatpak_packages.txt)"
#pip
install_list "pip_packages.txt" "pip install -r $BACKUPDIR/pip_packages.txt"
#npm
install_list "npm_packages.txt" "while read pkg; do npm install -g \$pkg; done < <(awk 'NR>1 {print \$2}' $BACKUPDIR/npm_packages.txt | cut -d'@' -f1)"
#cargo
install_list "cargo_packages.txt" "while read pkg; do cargo install \$pkg; done < <(awk '{print \$1}' $BACKUPDIR/cargo_packages.txt)"
#yum
install_list "yum_packages.txt" "sudo yum install -y \$(awk 'NR>1 {print \$1}' $BACKUPDIR/yum_packages.txt)"
#snap
install_list "snap_packages.txt" "while read pkg; do snap install \$pkg; done < <(awk 'NR>1 {print \$1}' $BACKUPDIR/snap_packages.txt)"
#homebrew
install_list "brew_packages.txt" "brew install \$(cat $BACKUPDIR/brew_packages.txt)"
