watch:
	@echo "Watching for file changes."
	@find . -name "*.lua" -not -path "./bling/*" -not -path "./archive/*" | entr -p awesome-client 'awesome.restart()'

format:
	find . -name "*.lua" -not -path "./bling/*" -not -path "./archive/*" -exec stylua {} \;

# Shouldnt be needed now!
bling-update:
	rm -rf bling
	git clone git@github.com:undefinedDarkness/bling.git misc/libs/bling # git@github.com:BlingCorp/bling.git
	# rm -rf ./bling/.git
