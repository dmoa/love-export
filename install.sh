#!/usr/bin/env bash

INSTALL_PATH=$(pwd)

git_clone() {
    git clone https://github.com/dmoa/love-export
    cd love-export
    chmod +x main.sh
    chmod +x install.sh
}

if [ "$(uname)" = "Darwin" ]; then
    # Do something under Mac OS X platform
    "echo" "detected MacOS"
    git_clone
    printf "%s\n" 'alias love-export='$INSTALL_PATH'/love-export/main.sh' >> ~/.zshrc
    zsh
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    # Do something under GNU/Linux platform
    "echo" "detected Linux"
    git_clone
    printf "%s\n" 'alias love-export='$INSTALL_PATH'/love-export/main.sh' >> ~/.bashrc
    bash
elif [ "$(expr substr $(uname -s) 1 9)" = "CYGWIN_NT" ]; then
    # Do something under Windows NT platform
    "echo" "detected Windows (Cygwin)"
    git_clone
    printf "%s\n" 'alias love-export='$INSTALL_PATH'/love-export/main.sh' >> ~/.bashrc
    bash
else
    "echo" "ERROR: could not detect platform"
    exit 0
fi

"echo" "installation complete"
exit 0