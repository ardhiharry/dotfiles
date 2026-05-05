#!/usr/bin/env bash

# Detect home dir based on user
if [ "$EUID" -eq 0 ]; then
  USER_HOME="/root"
else
  USER_HOME="$HOME"
fi

# Path default oh-my-zsh custom
ZSH_CUSTOM=${ZSH_CUSTOM:-$USER_HOME/.oh-my-zsh/custom}
PLUGIN_DIR="$ZSH_CUSTOM/plugins"

# List plugin (name|repo)
plugins=(
  "zsh-syntax-highlighting|https://github.com/zsh-users/zsh-syntax-highlighting.git"
  "zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions.git"
  "ohmyzsh-full-autoupdate|https://github.com/Pilaton/OhMyZsh-full-autoupdate.git"
)

echo "🚀 Installing ZSH plugins..."

for plugin in "${plugins[@]}"; do
  name=$(echo $plugin | cut -d'|' -f1)
  repo=$(echo $plugin | cut -d'|' -f2)

  if [ -d "$PLUGIN_DIR/$name" ]; then
    echo "✅ $name already installed, skip..."
    printf "\n"
  else
    echo "⬇️ Installing $name..."
    git clone "$repo" "$PLUGIN_DIR/$name"
    printf "\n"
  fi
done

echo "✨ Done!"
