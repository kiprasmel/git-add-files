#!/bin/sh

set -euo pipefail
set -x

BREW_PREF="$(brew --prefix)"
ln -s -f "$PWD/git-add-files" "$BREW_PREF/bin/"

# https://vim.fandom.com/wiki/Creating_your_own_syntax_files

NAME="gitaddfiles"
FILE="$NAME.vim"

which nvim >/dev/null && {
	VERSION="$(nvim --version | head -n1 | cut -d' ' -f2 | cut -d'v' -f2)"
	ln -s -f "$PWD/syntax.$FILE"   "$BREW_PREF/Cellar/neovim/$VERSION/share/nvim/runtime/syntax/$FILE"
	ln -s -f "$PWD/ftplugin.$FILE" "$BREW_PREF/Cellar/neovim/$VERSION/share/nvim/runtime/ftplugin/$FILE"
}

which vim >/dev/null && {
	VERSION="$(vim --version | head -n1 | sed 's/vim - vi improved //gi; s/\s.*//g; s/\.//g')"
	#sudo cp "$PWD/syntax.$FILE"   "/usr/share/vim/vim${VERSION}/syntax/$FILE"
	#sudo cp "$PWD/ftplugin.$FILE" "/usr/share/vim/vim${VERSION}/ftplugin/$FILE"

	SYNTAXDIR="$HOME/.vim/syntax"
	mkdir -p "$SYNTAXDIR"
	ln -s -f "$PWD/syntax.$FILE" "$SYNTAXDIR/$FILE"

	FTDETECTDIR="$HOME/.vim/ftdetect"
	mkdir -p "$FTDETECTDIR"
	cat > "$FTDETECTDIR/$FILE" <<EOF
" do not edit manually
" generated via git-add-files/install.sh

au BufRead,BufNewFile ADD_FILES set filetype=gitaddfiles

EOF

	FILETYPEPATH="$HOME/.vim/filetype.vim"
	touch "$FILETYPEPATH"
	grep "gitaddfiles" "$FILETYPEPATH" || {
		cat >> "$FILETYPEPATH" <<EOF
" do not edit manually
" generated via git-add-files/install.sh

au BufRead,BufNewFile ADD_FILES setfiletype gitaddfiles
EOF
	}
}

