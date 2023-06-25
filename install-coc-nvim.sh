#!/usr/bin/env bash

set -o errexit    # exit when command fails

# Script configuration
VIM_CONFIG_DIR="${HOME}/.vim"
VIM_PLUGINS_DIR="${VIM_CONFIG_DIR}/pack/plugins/start"
VIM_CONFIG_FILE="vimrc"
VIM_CONFIG_COC_FILE="vimrc-coc.vim"
COC_EXTENSIONS_DIR="${HOME}/.config/coc/extensions"

NVM_VERSION="v0.39.3"
MINIMUM_VIM_VERSION="8.1" # really 8.1.1719 (TODO)

if [ ! -x "$(command -v vim)" ]; then
    echo 'Error: vim is not installed.' >&2
    exit 1
fi

# https://stackoverflow.com/questions/36078780/check-vim-version-and-python-support-from-a-bash-script
VIM_VERSION=$(vim --version | head -1 | grep -o '[0-9]\.[0.9]')

if [ ! $(echo "${VIM_VERSION} >= ${MINIMUM_VIM_VERSION}" | bc -l) ]; then
    echo 'Error: coc-nvim requires a vim version >= 8.1.1719' >&2
    echo 'https://github.com/neoclide/coc.nvim' >&2
    exit 1
else
    echo 'Info: vim version == '${VIM_VERSION}''
fi


# Need curl for this script to be useful.
if [ ! -x "$(command -v curl)" ]; then
    echo 'Error: curl is not installed.' >&2
    exit 1
fi

no_node_error() {
    echo 'Error: Install node via your system package manager or pass --install-nvm to install nodejs/nvm via nvm' >&2
    echo 'Error: exiting until you install node.' >&2

    if [ ! -z "${1}" ]; then
        if [ "${1}" = "--install-nvm" ]; then
            echo 'Info: Try: `nvm install --lts` then restarting your console session' >&2
            echo 'Info: Re-run the script to intall coc-nvim' >&2
        fi
    fi

    exit 1
}


# Install latest nodejs
if [ ! -x "$(command -v node)" ]; then
    echo 'Error: node is not installed. It is required for coc-nvim' >&2

    if [ ! -z "${1}" ]; then
        if [ "${1}" = "--install-nvm" ]; then
            curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
        fi
    else
        no_node_error ${1}
    fi

    # Or use package manager, e.g.
    # sudo apt-get install nodejs
else
    # Use package feature to install coc.nvim
    # for vim8
    if [ ! -d "${VIM_PLUGINS_DIR}/coc.nvim-release" ]; then
        (
            cd "${VIM_PLUGINS_DIR}"
            curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -
        )
        # for neovim
        # mkdir -p ~/.local/share/nvim/site/pack/coc/start
        # cd ~/.local/share/nvim/site/pack/coc/start
        # curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -
    fi
    # Add a line at the end of the vimrc for coc-nvim to run correctly.
    (
        LINE="source ${VIM_CONFIG_DIR}/${VIM_CONFIG_COC_FILE}"
        FILE="${VIM_CONFIG_FILE}"
        cd ${VIM_CONFIG_DIR}
        grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
    )
fi


if [ ! -x "$(command -v npm)" ]; then
    no_node_error ${1}
fi

# Install extensions
(
    mkdir -p "${COC_EXTENSIONS_DIR}"
    cd "${COC_EXTENSIONS_DIR}"
    if [ ! -f package.json ]; then
        echo '{"dependencies":{}}'> package.json
    fi
    # Change extension names to the extensions you need
    npm install coc-markdownlint --install-stategy=shallow --ignore-scripts --no-bin-links --no-package-lock --omit=dev
    npm install coc-clangd --install-stategy=shallow --ignore-scripts --no-bin-links --no-package-lock --omit=dev
    npm install coc-pyright --install-stategy=shallow --ignore-scripts --no-bin-links --no-package-lock --omit=dev
    npm install coc-json --install-stategy=shallow --ignore-scripts --no-bin-links --no-package-lock --omit=dev
)
