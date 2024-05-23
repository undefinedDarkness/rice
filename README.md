> [!WARNING]
> This documentation is very out-of-date and my rice uses lots of custom bits to get stuff working, bits I end up reverse engineering whenever I need to re-install 😅, So don't follow this please thank you!

Hello & welcome to my little corner of the internet. This is where I keep all my configuration files
for my Linux installation, If they interest you feel free to peruse them.

Required Packages:
- awesome (stable+)
- xterm
- firefox
- emacs (compiled from master, 29+)

*If using another init system, need to modify powermenu commands in =.config/awesome/components/powermenu.lua=
*If using another screenshot program, need to modify screenshot commands in =.config/awesome/misc/libs/screenshot.lua=

Setup from scratch (assuming repo is cloned to ~/rice):

Append to ~/.bashrc
#+begin_src shell
source $HOME/rice/scripts/master.sh
#+end_src

Create symlink
#+begin_src shell
ln -s $(realpath ~/rice/.config) $(realpath ~/.config)
#+end_src

OR

Modify /usr/share/xsessions/awesome.desktop 
#+being_src ini
Exec=awesome
#+end_src
becomes
#+begin_src ini
Exec=awesome -c /home/USERNAME/rice/.config/awesome/rc.lua
#+end_src

*If cloning somewhere modify master script to point there instead

Emacs configuration should /just work/
*CURRENTLY UNMAINTAINED*: Neovim configuration will need you to install packer

*NOTE*:
Configuration is not based on Xresources at all,
That is currently only for xterm.
