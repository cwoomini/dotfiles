#!/bin/bash

# [[=================================]]
#           MACOS SYNC SCRIPT
#    Author: Cwoo
#    Last Updated: 2025.08.27
# [[=================================]]

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DEST=$SCRIPT_DIR/macos

# ZSH
rsync -avu --delete "$HOME/.zshrc" "$DEST/"

# Aerospace
rsync -avu --delete "$HOME/.config/aerospace/" "$DEST/aerospace/"

# Clang
rsync -avu --delete "$HOME/.clang-format" "$DEST/clang/"

# Ghostty
rsync -avu --delete "$HOME/.config/ghostty/" "$DEST/ghostty/" 

# JetBrains (TODO)
# rsync -avu --delete "$HOME/.ideavimrc" "$DEST/jetbrains/"

# Neovim (TODO)
# rsync -avu --delete "$HOME/.config/nvim/" "$DEST/nvim/"

# Neofetch (TODO)
# rsync -avu --delete "$HOME/.config/neofetch/" "$DEST/neofetch/"

# Karabiner
rsync -avu --delete "$HOME/.config/karabiner/karabiner.json" "$DEST/karabner/"

# Zed
rsync -avu --delete "$HOME/.config/zed/settings.json" "$DEST/zed/"
rsync -avu --delete "$HOME/.config/zed/keymap.json" "$DEST/zed/"
