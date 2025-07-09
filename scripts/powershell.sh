#!/usr/bin/env bash

cat << "EOF"
  ___                       _        _ _
 | _ \_____ __ _____ _ _ __| |_  ___| | |
 |  _/ _ \ V  V / -_) '_(_-< ' \/ -_) | |
 |_| \___/\_/\_/\___|_| /__/_||_\___|_|_|
EOF

echo "🚀 Setting up Windows Terminal configuration..."

# Windows Terminal settings path
WT_SETTINGS_DIR="$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
if [ -z "$LOCALAPPDATA" ]; then
  WT_SETTINGS_DIR="$USERPROFILE/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
fi

echo "📂 Windows Terminal config path: $WT_SETTINGS_DIR"

if [ ! -d "$WT_SETTINGS_DIR" ]; then
  echo "❌ Windows Terminal config directory not found. Is Windows Terminal installed?"
  exit 1
fi

backup_config() {
  echo "💾 Backing up existing settings..."
  local timestamp=$(date +%Y%m%d_%H%M%S)
  if [ -f "$WT_SETTINGS_DIR/settings.json" ]; then
    cp "$WT_SETTINGS_DIR/settings.json" "$WT_SETTINGS_DIR/settings.json.bak_$timestamp" && \
      echo "✅ Backup created" || \
      echo "❌ Backup failed"
  else
    echo "⚠️  No existing settings.json to backup"
  fi
}

backup_config

echo "📦 Installing new Windows Terminal config..."
if command -v curl &> /dev/null; then
  curl -o "$WT_SETTINGS_DIR/settings.json" https://raw.githubusercontent.com/your-repo/confs/main/windowsterminal/settings.json || {
    echo "❌ Failed to download Windows Terminal config"
    exit 1
  }
else
  echo "❌ curl not found. Please install curl."
  exit 1
fi

echo "📦 Installing PowerShell profile..."
PWSH_PROFILE_DIR="$HOME/Documents/PowerShell"
if [ ! -d "$PWSH_PROFILE_DIR" ]; then
  mkdir -p "$PWSH_PROFILE_DIR"
fi

curl -o "$PWSH_PROFILE_DIR/Microsoft.PowerShell_profile.ps1" https://raw.githubusercontent.com/your-repo/confs/main/windowsterminal/Microsoft.PowerShell_profile.ps1 || {
  echo "❌ Failed to download PowerShell profile"
  exit 1
}

echo "✅ Windows Terminal configuration installed successfully!"
