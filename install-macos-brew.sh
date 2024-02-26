#!/bin/sh

set -euo pipefail
set -x

BREW_PREF="$(brew --prefix)"
ln -s -f "$PWD/git-add-files" "$BREW_PREF/bin/"

which nvim >/dev/null && {
	NVIM_VERSION="$(nvim --version | head -n1 | cut -d' ' -f2 | cut -d'v' -f2)"
	FILE="gitaddfiles.vim"
	ln -s -f "$PWD/syntax.$FILE"   "$BREW_PREF/Cellar/neovim/$NVIM_VERSION/share/nvim/runtime/syntax/$FILE"
	ln -s -f "$PWD/ftplugin.$FILE" "$BREW_PREF/Cellar/neovim/$NVIM_VERSION/share/nvim/runtime/ftplugin/$FILE"
}

