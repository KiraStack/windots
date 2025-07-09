#!/usr/bin/env bash

cat << "EOF"
  ___        _   ___    _      _
 | __|_ _ __| |_| __|__| |_ __| |_
 | _/ _` (_-<  _| _/ -_)  _/ _| ' \
 |_|\__,_/__/\__|_|\___|\__\__|_||_|
EOF

echo "🚀 Setting up fastfetch configuration..."

FASTFETCH_DIR="$HOME/.config/fastfetch"

echo "📂 fastfetch config path: $FASTFETCH_DIR"

if [ ! -d "$FASTFETCH_DIR" ]; then
  echo "🔹 Creating fastfetch config directory..."
  mkdir -p "$FASTFETCH_DIR"
fi

backup_config() {
  echo "💾 Backing up existing config..."
  local timestamp=$(date +%Y%m%d_%H%M%S)
  if [ -f "$FASTFETCH_DIR/config.json" ]; then
    cp "$FASTFETCH_DIR/config.json" "$FASTFETCH_DIR/config.json.bak_$timestamp" && \
      echo "✅ Backup created" || \
      echo "❌ Backup failed"
  else
    echo "⚠️  No existing config.json to backup"
  fi
}

backup_config

echo "📦 Installing new fastfetch config..."
if command -v curl &> /dev/null; then
  curl -o "$FASTFETCH_DIR/config.json" https://raw.githubusercontent.com/your-repo/confs/main/fastfetch/config.json || {
    echo "❌ Failed to download fastfetch config"
    exit 1
  }
else
  echo "❌ curl not found. Please install curl."
  exit 1
fi

echo "✅ fastfetch configuration installed successfully!"
