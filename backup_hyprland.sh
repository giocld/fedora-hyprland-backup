#!/bin/bash
# Set Hyprland config dir
HYPRDIR="$HOME/.config/hypr"
BACKUPDIR="$HOME/ergasiastuff/hyprland_backup"
mkdir -p "$BACKUPDIR"
# 1. Main config file (if present)
if [[ -f "$HYPRDIR/hyprland.conf" ]]; then
  cp -v "$HYPRDIR/hyprland.conf" "$BACKUPDIR"/
fi
# 2. All files in UserConfigs/
if [[ -d "$HYPRDIR/UserConfigs" ]]; then
  mkdir -p "$BACKUPDIR/UserConfigs"
  cp -v "$HYPRDIR"/UserConfigs/*.conf "$BACKUPDIR/UserConfigs"/
  # Optionally also copy other files in this dir (scripts, images, etc.)
  for f in "$HYPRDIR"/UserConfigs/*; do
    [[ "$f" != *.conf ]] && cp -v "$f" "$BACKUPDIR/UserConfigs/"
  done
fi

# 3. All scripts in UserScripts/
if [[ -d "$HYPRDIR/UserScripts" ]]; then
  mkdir -p "$BACKUPDIR/UserScripts"
  cp -v "$HYPRDIR/UserScripts/"* "$BACKUPDIR/UserScripts"/
fi

# 4. initial-boot.sh if present
if [[ -f "$HYPRDIR/initial-boot.sh" ]]; then
  cp -v "$HYPRDIR/initial-boot.sh" "$BACKUPDIR"/
fi

# 5. Other important directories (add by name as needed, e.g. Monitor_Profiles, wallpaper_effects, wallust)
for folder in Monitor_Profiles wallpaper_effects wallust; do
  if [[ -d "$HYPRDIR/$folder" ]]; then
    cp -vr "$HYPRDIR/$folder" "$BACKUPDIR/"
  fi
done
echo "Hyprland configuration backup complete."
echo "All selected files and folders have been copied to $BACKUPDIR. Ready for git add!"
