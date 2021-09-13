.PHONY: install

install:
	mkdir -p $$HOME/.mozilla/native-messaging-hosts
	sed -Ei 's!/home/david/builds/tabs-interface/server.py!$(realpath ./server.py)!g' ./dbus_tabs.json
	cp ./dbus_tabs.json $$HOME/.mozilla/native-messaging-hosts
	zip -r -FS ../extension.zip * --exclude '*.git*'.	
