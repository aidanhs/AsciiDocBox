.PHONY: build
AD=cd asciidoctor.js && PATH=$$(pwd)/node_modules/.bin:$$PATH
build:
	git submodule init && git submodule update
	$(AD) && npm install && npm install bundle
	$(AD) && bower --config.interactive=false install
	$(AD) && grunt dist
