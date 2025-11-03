#!/bin/bash

BACKUPDIR="packages_backup"

#check for pack_backup
if [[ -d "$BACKUPDIR" ]]; then
  read -p "$BACKUPDIR already exists. Delete it and continue? (y/n): " choice
  if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    rm -rf "$BACKUPDIR"
    echo "$BACKUPDIR deleted."
    mkdir -p "$BACKUPDIR"
  else
    echo "Aborting to avoid overwriting existing backups."
    exit 1
  fi
else
  mkdir -p "$BACKUPDIR"
fi
#help for exporting list
export_list() {
  local file=$1
  local cmd=$2
  if [[ -f "$BACKUPDIR/$file" ]]; then
    echo "$file already exists."
    read -p "Overwrite $file? (y/n): " overwrite
    [[ "$overwrite" != "y" && "$overwrite" != "Y" ]] && return
  fi
  eval $cmd
}
#dnf
if command -v dnf &>/dev/null; then
  echo "Exporting DNF packages..."
  export_list "dnf_packages.txt" "dnf list installed >$BACKUPDIR/dnf_packages.txt"
fi

#flatpak
if command -v flatpak &>/dev/null; then
  echo "Exporting Flatpak packages..."
  export_list "flatpak_packages.txt" "flatpak list --app --columns=application,branch >$BACKUPDIR/flatpak_packages.txt"
fi

#pip
if command -v pip &>/dev/null; then
  echo "Exporting pip packages..."
  export_list "pip_packages.txt" "pip list --format=freeze >$BACKUPDIR/pip_packages.txt"
fi

#npm
if command -v npm &>/dev/null; then
  echo "Exporting npm packages..."
  export_list "npm_packages.txt" "npm list -g --depth=9999 >$BACKUPDIR/npm_packages.txt"
fi

#cargo
if command -v cargo &>/dev/null; then
  echo "Exporting cargo packages..."
  export_list "cargo_packages.txt" "cargo install --list >$BACKUPDIR/cargo_packages.txt"
fi

#yum
if command -v yum &>/dev/null; then
  echo "Exporting yum packages..."
  export_list "yum_packages.txt" "yum list installed >$BACKUPDIR/yum_packages.txt"
fi

#snap
if command -v snap &>/dev/null; then
  echo "Exporting snap packages..."
  export_list "snap_packages.txt" "snap list >$BACKUPDIR/snap_packages.txt"
fi

#brew
if command -v brew &>/dev/null; then
  echo "Exporting brew packages..."
  export_list "brew_packages.txt" "brew list --formula >$BACKUPDIR/brew_packages.txt"
fi

echo "Package backup complete. Output in $BACKUPDIR/"
