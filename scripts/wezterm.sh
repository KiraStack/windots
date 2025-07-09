#!/usr/bin/env bash

cat << "EOF"
 __      __      _
 \ \    / /__ __| |_ ___ _ _ _ __
  \ \/\/ / -_)_ /  _/ -_) '_| '  \
   \_/\_/\___/__|\__\___|_| |_|_|_|
EOF

echo "🚀 Setting up WezTerm configuration..."

WEZTERM_DIR="$HOME/.config/wezterm"

echo "📂 WezTerm config path: $WEZTERM_DIR"

if [ ! -d "$WEZTERM_DIR" ]; then
  echo "🔹 Creating WezTerm config directory..."
  mkdir -p "$WEZTERM_DIR"
fi

backup_config() {
  echo "💾 Backing up existing config..."
  local timestamp=$(date +%Y%m%d_%H%M%S)
  if [ -f "$WEZTERM_DIR/wezterm.lua" ]; then
    cp "$WEZTERM_DIR/wezterm.lua" "$WEZTERM_DIR/wezterm.lua.bak_$timestamp" && \
      echo "✅ Backup created" || \
      echo "❌ Backup failed"
  else
    echo "⚠️  No existing wezterm.lua to backup"
  fi
}

backup_config

echo "📦 Installing new WezTerm config..."
if command -v curl &> /dev/null; then
  curl -o "$WEZTERM_DIR/wezterm.lua" https://raw.githubusercontent.com/your-repo/confs/main/wezterm/wezterm.lua || {
    echo "❌ Failed to download WezTerm config"
    exit 1
  }
else
  echo "❌ curl not found. Please install curl."
  exit 1
fi

echo "✅ WezTerm configuration installed successfully!"
