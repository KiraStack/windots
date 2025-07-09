#!/usr/bin/env bash

# ASCII Art
cat << "EOF"
  _  _       __   ___
 | \| |___ __\ \ / (_)_ __
 | .` / -_) _ \ V /| | '  \
 |_|\_\___\___/\_/ |_|_|_|_|
EOF

echo "🚀 Setting up Neovim configuration (Cross-Platform)..."

# Determine config directory
if [ "$(uname)" = "Darwin" ]; then
  NVIM_DIR="$HOME/.config/nvim"
elif [ "$(uname)" = "Linux" ]; then
  NVIM_DIR="$HOME/.config/nvim"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
  NVIM_DIR="$USERPROFILE/AppData/Local/nvim"
else
  echo "❌ Unsupported OS: $(uname)"
  exit 1
fi

# Debug info
echo "🔍 Detected OS: $(uname)"
echo "📂 Neovim config path: $NVIM_DIR"

# Backup existing config
backup_config() {
  echo "💾 Backing up existing config..."
  local timestamp=$(date +%Y%m%d_%H%M%S)
  mv "$NVIM_DIR" "${NVIM_DIR}.bak_$timestamp" 2>/dev/null && \
    echo "✅ Backup created at ${NVIM_DIR}.bak_$timestamp" || \
    echo "⚠️  No existing config to backup"
}

# Main setup
if [ -d "$NVIM_DIR" ]; then
  read -p "⚠️  Neovim config exists. Backup and replace? (y/n) " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]] && backup_config || exit 0
fi

echo "📦 Installing Neovim config..."
if command -v git &> /dev/null; then
  git clone https://github.com/your-nvim-config.git "$NVIM_DIR" || {
    echo "❌ Failed to clone Neovim config"
    exit 1
  }
else
  echo "❌ Git not found. Please install git first."
  exit 1
fi

echo "✅ Neovim configuration installed successfully!"
echo "💡 Run 'nvim +PackerSync' to install plugins"
