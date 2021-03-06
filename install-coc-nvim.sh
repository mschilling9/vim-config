#!/usr/bin/env bash

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# Install latest nodejs
if [ ! -x "$(command -v node)" ]; then
    curl --fail -LSs https://install-node.now.sh/latest | sh
    export PATH="/usr/local/bin/:$PATH"
    # Or use package manager, e.g.
    # sudo apt-get install nodejs
fi

# Use package feature to install coc.nvim

# for vim8
mkdir -p ~/.vim/pack/coc/start
pushd ~/.vim/pack/coc/start
curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -
# for neovim
# mkdir -p ~/.local/share/nvim/site/pack/coc/start
# cd ~/.local/share/nvim/site/pack/coc/start
# curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -

# Install extensions
mkdir -p ~/.config/coc/extensions
pushd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi
# Change extension names to the extensions you need
npm install coc-markdownlint --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
npm install coc-clangd --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
npm install coc-pyright --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
popd
popd

# Add additional vim configurations needed for Coc to run properly
LINE="source ~/.vim/vimrc-coc.vim"
FILE="vimrc"
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
