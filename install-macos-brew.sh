#!/bin/sh

set -eu

# resolve the repo dir from the script location, so this works from anywhere
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

BREW_PREF="$(brew --prefix)"
ln -sf "$REPO_DIR/git-add-files" "$BREW_PREF/bin/git-add-files"

NAME="gitaddfiles"
FILE="$NAME.vim"

# Install the syntax + ftplugin files into per-user runtime dirs that are on the
# editor's 'runtimepath' by default. Unlike Homebrew's Cellar dir, these survive
# editor upgrades and don't depend on parsing/guessing a version string.
install_rtp() {
	base="$1"
	for kind in syntax ftplugin ftdetect; do
		mkdir -p "$base/$kind"
		ln -sf "$REPO_DIR/$kind.$FILE" "$base/$kind/$FILE"
	done
}

# Neovim
if command -v nvim >/dev/null 2>&1; then
	install_rtp "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
fi

# Vim
if command -v vim >/dev/null 2>&1; then
	install_rtp "$HOME/.vim"
fi
