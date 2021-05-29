watch:
	@echo "Watching for file changes."
	@ls ./**/*.lua | entr -p awesome-client 'awesome.restart()'

format:
	find . -name "*.lua" -not -path "./bling/*" -exec luafmt -w replace {} \;
