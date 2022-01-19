.PHONY: clean backup pre-install install session-install fetch todo


# Clean up .config
clean:
	echo "#fafafa"
	find .config \
		-maxdepth 1\
		-type d\
		-not -name ".config" -type d\
		-not -name "awesome" -type d\
		-not -name "nvim" -type d\
		-not -name "procps" -type d\
		-exec rm -rv {} \;

define fetchMessage

          |\      _,,,---,,_            %s@%s
    ZZZzz /,`.-'`'    -.  ;-;;,_        \e[1m\e[33mos\e[0m - %s
         |,4-  ) )-,_. ,\ (  `'-'       \e[1m\e[33msz\e[0m - %s
        '---''(_/--'  `-'\_)            \e[1m\e[33mkr\e[0m - %s

endef
export fetchMessage
.ONESHELL:
fetch:
	@. /etc/os-release
	@printf "$$fetchMessage"\
		"$$USER"\
		"$$(hostname)"\
        "$$NAME"\
        "$$(cat /var/lib/dpkg/status | grep 'Package: .*' | wc -l)"\
        "$$(uname -r | grep -Po '\d+.\d+.\d+')"

# Find todo's
todo:
	grep -rnH --color=auto 'TODO: '

# Create backup
backup: clean ../backup.tar.zst
	tar -cf --exclude-vcs --exclude-vcs-ignores ../backup.tar .
	zstd -22 --ultra -T0 -z ../backup.tar
	rm ../backup.tar

# Change XDG variables to try it out
define fakeInstallMessage
Run `export XDG_CONFIG_HOME=$(realpath ./.config)`
Now any applications in the current session will use the configurations from here.
Use `neovim` to test it out.

endef
export fakeInstallMessage
session-install:
	@tabs 4
	@printf "$$fakeInstallMessage"

# Installation
.ONESHELL:
install:
	@printf "\nBasic Installation\n"
	@echo "------------------------"
	
	# Build from fennel
	cd .config/awesome
	$(MAKE)
	# Install submodules
	cd $$XDG_CONFIG_HOME/awesome
	git submodule update --init --recursive
	cp -r .config/* $$XDG_CONFIG_HOME/
	
	@printf "\nPost Installation\n"
	@echo "------------------------"
	git clone --depth 1 https://github.com/wbthomason/packer.nvim\
		~/.local/share/nvim/site/pack/packer/start/packer.nvim
	@printf "\n✨ Installation Complete\n"

define preInstallMessage
 _________________
|# :           : #|		\e[1m🍜 Installation\e[0m
|  :           :  |		-----------------
|  :           :  |		- Please make sure you have backed up any existing configurations!
|  :           :  |		- You will need the following programs installed:
|  :___________:  |			firefox(esr), awesome(master), st, python3, make, neovim(0.5+), bash, dbus, git, zip, picom
|     _________   |		\e[1m*\e[0m dbus is requried for awesome-client to function (firefox integration)
|    | __      |  |		\e[1m*\e[0m python3 is requried for the native host to function (firefox integration)
|    ||  |     |  |		\e[1m*\e[0m st can be swapped with `make set-terminal TERMINAL=...` in ./.config/awesome
\____||__|_____|__|		- Run `make install` once prepared or `make session-install` to try it out first


endef
export preInstallMessage
.DEFAULT_GOAL := pre-install
pre-install:
	@tabs 4
	@printf "$$preInstallMessage"
