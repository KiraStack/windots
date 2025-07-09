#!/usr/bin/env bash

cat << "EOF"
  ___ _               _    _
 / __| |_ __ _ _ _ __| |_ (_)_ __
 \__ \  _/ _` | '_(_-< ' \| | '_ \
 |___/\__\__,_|_| /__/_||_|_| .__/
                            |_|
EOF

echo "🚀 Setting up starship configuration..."

STARSHIP_FILE="$HOME/.config/starship.toml"

backup_config() {
  echo "💾 Backing up existing config..."
  local timestamp=$(date +%Y%m%d_%H%M%S)
  if [ -f "$STARSHIP_FILE" ]; then
    cp "$STARSHIP_FILE" "$STARSHIP_FILE.bak_$timestamp" && \
      echo "✅ Backup created" || \
      echo "❌ Backup failed"
  else
    echo "⚠️  No existing starship.toml to backup"
  fi
}

backup_config

echo "📦 Installing new starship config..."
if command -v curl &> /dev/null; then
  curl -o "$STARSHIP_FILE" https://raw.githubusercontent.com/your-repo/confs/main/starship/starship.toml || {
    echo "❌ Failed to download starship config"
    exit 1
  }
else
  echo "❌ curl not found. Please install curl."
  exit 1
fi

echo "✅ starship configuration installed successfully!"
