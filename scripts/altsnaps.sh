#!/ usr / bin / env bash

cat << "EOF"
    _   _ _   ___
   /_\ | | |_/ __|_ _  __ _ _ __
  / _ \| |  _\__ \ ' \/ _` | '_ \
 /_/ \_\_|\__|___/_||_\__,_| .__/
                           |_|
EOF

echo "🚀 Setting up AltSnap configuration..."

#Determine config directory
ALTSNAP_DIR="$HOME/.config/altsnap"

echo "📂 altsnap config path: $ALTSNAP_DIR"

if [ ! -d "$ALTSNAP_DIR" ]; then
  echo "🔹 Creating AltSnap config directory..."
  mkdir -p "$ALTSNAP_DIR"
fi

backup_config() {
    echo "💾 Backing up existing config..." local timestamp = $(date + % Y % m % d_ % H % M % S) if[-f "$ALTSNAP_DIR/config.toml"];
    then cp "$ALTSNAP_DIR/config.toml"
            "$ALTSNAP_DIR/config.toml.bak_$timestamp" &&
            echo "✅ Backup created" ||
        echo "❌ Backup failed" else echo "⚠️  No existing config.toml to backup" fi
}

backup_config

echo "📦 Installing new AltSnap config..."
if command -v curl &> /dev/null; then
  curl -o "$ALTSNAP_DIR/config.toml" https://raw.githubusercontent.com/your-repo/confs/main/altsnap/config.toml || {
    echo "❌ Failed to download AltSnap config"
    exit 1
}
else echo "❌ curl not found. Please install curl." exit 1 fi

    echo "✅ AltSnap configuration installed successfully!"
