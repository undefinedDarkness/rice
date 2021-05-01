#!/usr/bin/env bash

echo "Stuff you will want to change:"
echo "Once you're done ~ run ./install.sh -F"
grep --color=always -rPn "\-\-\s+CHANGE" .config

echo -e "\nInstall the fonts provided (put them ~/.local/share/fonts):"
for i in ./misc/*.ttf; do
  echo -e "$(tput setaf 5)$i$(tput sgr0)"
done

echo -e "\nChecking for installed apps."
progs=("awesome" "nvim" "playerctl" "acpi_listen" "sensors" "vmstat" "git" "st" "dmenu" "firefox")
for p in "${progs[@]}"; do
  if ! command -v ${p} >/dev/null; then 
    echo "$p is not installed."
  fi
done

echo -e "\nLooking for any hardcoded paths: (Please change.)"
grep --color=always --exclude-dir=.git --exclude-dir=bling -rPn '/home/david' .config

echo -e "
Notes:

The PAM library may not work ootb so.. build it from source and copy over the .so file to .config/awesome/components/lockscreen
https://github.com/devurandom/lua-pam

You will need the Papirus Dark icon theme for the icons to look correct ~ you can find it from gnome-look
As well elkowar's phocus fork: https://github.com/elkowar/gtk

Iirc my todo script requires deno which I use for my scripts, feel free to rewrite it or smth to get rid of it as a dependency

To get my terminal, you will need to run the following commands in this directory:$(tput setaf 3)\e[3m
  git clone https://github.com/siduck76/st
  cp -r misc/st-config.h st/config.h
  cd st
  make
  sudo make clean install
  cd ..
$(tput sgr0)

For my dmenu,$(tput setaf 3)\e[3m
  git clone https://git.suckless.org/dmenu
  cd dmenu
  patch -i ../misc/dmenu.patch
  cd ..
$(tput sgr0)

I will slowly try to clean up things and make it more portable but I am not very good at it unfortunately.

You can find the wallpapers in .config/awesome/theme
You can see any keybinds in awesome using Super+s
My bash prompt: (Copy paste to bashrc)
  $(tput setaf 3)\e[3mexport PS1=\"\[\$(tput setaf 4)\]\w\[\$(tput sgr0)\] \[\$(tput setaf 2)\]➜ \[\$(tput sgr0)\] \"$(tput sgr0)

$(tput bold)$(tput setaf 3)CHECK OUT BLING$(tput sgr0): https://github.com/BlingCorp/bling
$(tput bold)$(tput setaf 3)CHECK OUT EWW$(tput sgr0): https://github.com/elkowar/eww/
"

case $1 in
  "-F")
    # im not entirely sure if symlinks will work here maybe replace `ln -s` with `cp` but ... I dont care.
    git submodule update --init --recursive
    mkdir -p ~/.config/awesome
    ln -s "$(realpath .config/awesome)" $HOME/.config/awesome 
    ln -s "$(realpath .config/nvim)" $HOME/.config/nvim
    ln -s "$(realpath .config/picom.conf)" $HOME/.config/picom.conf
  ;;
esac
