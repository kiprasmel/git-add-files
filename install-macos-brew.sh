#!/bin/sh

set -euo pipefail
set -x

BREW_PREF="$(brew --prefix)"
ln -s -f "$PWD/git-add-files" "$BREW_PREF/bin/"

NAME="gitaddfiles"
FILE="$NAME.vim"

which nvim >/dev/null && {
	VERSION="$(nvim --version | head -n1 | cut -d' ' -f2 | cut -d'v' -f2)"
	ln -s -f "$PWD/syntax.$FILE"   "$BREW_PREF/Cellar/neovim/$VERSION/share/nvim/runtime/syntax/$FILE"
	ln -s -f "$PWD/ftplugin.$FILE" "$BREW_PREF/Cellar/neovim/$VERSION/share/nvim/runtime/ftplugin/$FILE"
}

