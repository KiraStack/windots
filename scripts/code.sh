#!/usr/bin/env bash

# ASCII Art
cat << "EOF"
 __   _____  ___ ___  ___  ___
 \ \ / / __|/ __/ _ \|   \| __|
  \ V /\__ \ (_| (_) | |) | _|
   \_/ |___/\___\___/|___/|___|
EOF

echo "🚀 Setting up VSCode configuration (Cross-Platform)..."

# Determine config directory
case "$(uname)" in
  "Darwin") VSCODE_DIR="$HOME/Library/Application Support/Code/User" ;;
  "Linux") VSCODE_DIR="$HOME/.config/Code/User" ;;
  *"MINGW"*|*"MSYS"*|*"CYGWIN"*)
    VSCODE_DIR="$APPDATA/Code/User"
    if [ -z "$APPDATA" ]; then
      VSCODE_DIR="$USERPROFILE/AppData/Roaming/Code/User"
    fi
    ;;
  *)
    echo "❌ Unsupported OS: $(uname)"
    exit 1
    ;;
esac

echo "🔍 Detected OS: $(uname)"
echo "📂 VSCode config path: $VSCODE_DIR"

if [ ! -d "$VSCODE_DIR" ]; then
  echo "❌ VSCode config directory not found. Is VSCode installed?"
  exit 1
fi

backup_config() {
  echo "💾 Backing up existing settings..."
  local timestamp=$(date +%Y%m%d_%H%M%S)
  cp "$VSCODE_DIR/settings.json" "$VSCODE_DIR/settings.json.bak_$timestamp" 2>/dev/null && \
    echo "✅ Backup created" || \
    echo "⚠️  No existing settings.json to backup"
}

backup_config

echo "📦 Installing new VSCode config..."
if command -v curl &> /dev/null; then
  curl -o "$VSCODE_DIR/settings.json" https://raw.githubusercontent.com/your-repo/vscode-config/main/settings.json || {
    echo "❌ Failed to download VSCode config"
    exit 1
  }
else
  echo "❌ curl not found. Please install curl."
  exit 1
fi

echo "✅ VSCode configuration installed successfully!"
echo "💡 Restart VSCode to apply changes"
