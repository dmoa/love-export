#!/usr/bin/env bash

INSTALL_PATH=$(pwd)

git_clone() {
    git clone https://github.com/dmoa/love-export
    cd love-export
    chmod +x main.sh
    chmod +x install.sh
}

install_love() {
    read -p "LOVE Version: " love_version
    ./main.sh -IL
}

delete_script() {
    "echo" "installation complete, deleting installation script"
    cd ..
    rm install.sh
}

if [ "$(uname)" = "Darwin" ]; then
    # Do something under Mac OS X platform
    "echo" "detected MacOS"
    git_clone
    printf "%s\n" 'alias love-export='$INSTALL_PATH'/love-export/main.sh' >> ~/.zshrc
    install_love
    delete_script
    zsh
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    # Do something under GNU/Linux platform
    "echo" "detected Linux"
    git_clone
    printf "%s\n" 'alias love-export='$INSTALL_PATH'/love-export/main.sh' >> ~/.bashrc
    install_love
    delete_script
    bash
elif [ "$(expr substr $(uname -s) 1 9)" = "CYGWIN_NT" ]; then
    # Do something under Windows NT platform
    "echo" "detected Windows (Cygwin)"
    git_clone
    printf "%s\n" 'alias love-export='$INSTALL_PATH'/love-export/main.sh' >> ~/.bashrc
    install_love
    delete_script
    bash
else
    "echo" "ERROR: could not detect platform"
    exit 0
fi

exit 0