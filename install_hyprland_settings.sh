#!/bin/bash
#paths(update as needed)
GIT_HYPR_DIR="$HOME/fedora-hyprland-restore-kit" #folder where you curl/clone GitHub repo
HYPR_CONFIG_DIR="$HOME/.config/hypr"             #actual local hyprland config folder
if [[ ! -d "$GIT_HYPR_DIR" ]]; then
  echo "Git Hyprland config directory $GIT_HYPR_DIR not found, aborting."
  exit 1
fi
#backup
BACKUP_DIR="$HOME/.config/hypr_backup_$(date +%Y%m%d_%H%M%S)"
if [[ -d "$HYPR_CONFIG_DIR" ]]; then
  echo "Backing up current Hyprland config to $BACKUP_DIR"
  cp -r "$HYPR_CONFIG_DIR" "$BACKUP_DIR"
fi
#sync only overwriting existing files(safe update)
rsync -av --existing "$GIT_HYPR_DIR/" "$HYPR_CONFIG_DIR/"
echo "Sync complete. Hyprland config updated safely."
echo "Restoration backup saved at $BACKUP_DIR"
