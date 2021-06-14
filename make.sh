#!/usr/bin/env bash

ree () {
    bash $(realpath $0) $1
}

case $1 in

    "clean")
        rm -rf Scripts .config misc
      ;;
    "req")
        REQUIRED_PROGRAMS=(awesome git nvim wezterm rofi emacs playerctl)
        for prog in "${REQUIRED_PROGRAMS[@]}"; do
                if ! command -v "$prog" &> /dev/null
                then
                        echo "$prog is not installed."
                fi
        done

        # Check for awesomewm stable
        if ! awesome --version | grep -q "Too long"; then
            echo "Awesomewm git not installed"
        fi
        ;;
    "push")
        ree req

        mkdir -p $HOME/.local/fonts
        echo "Installing Configurations"
        cp -s $(realpath .config/wezterm) $HOME/.config
        cp -s $(realpath .config/awesome) $HOME/.config
        cp -s $(realpath .config/nvim) $HOME/.config
        cp -s $(realpath .config/emacs) $HOME/.config
        # cp -s `realpath $(HOME)/.config/nvim` $(HOME)/.vim # Make Vim Read Config
        echo "Installing Scripts"
        cp -s $(realpath Scripts) $HOME/Documents
        echo "Installing Fonts"
        cp -r misc/fonts/* $HOME/.local/fonts
        fc-cache -f -v
        echo "Run 'nvim +PlugInstall' to install required plugins."
        ;;
    "pull")
        # Clean Up
        ree clean

        echo "Pulling in configuration from system."
        mkdir -p .config misc misc/fonts .config/nvim .config/emacs
        cp -ruf ~/.config/awesome .config
        cp -ruf ~/.config/rofi .config
        cp -uf ~/.config/nvim/* .config/nvim || true
        cp -ruf ~/.config/wezterm .config

        # Emacs config
        cp -uf ~/.config/emacs/* .config/emacs || true
        cp -ruf ~/.config/emacs/lisp .config/emacs/
        echo "Pulling in scripts"
        cp -ruf ~/Documents/Scripts .
        echo "Pulling in fonts"
        cp -ruf ~/.local/share/fonts/* ./misc/fonts
        echo -e "$(tput bold)MANUAL: $(tput sgr0) Put Stylus configs in misc/NAME.css"
        echo -e "$(tput bold)MANUAL:$(tput sgr0) Copy patches for any suckless software as misc/SOFTWARE/MAIN.patch"
        ;;
    *)
        echo "To install run 'make push'"
        ;;
esac
