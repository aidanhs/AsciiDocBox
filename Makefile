.PHONY: build
default: build

AD=PATH=$$(pwd)/node_modules/.bin:$$PATH
DCK=docker run --rm -it -v $$(pwd):/adb asciidoctor-build \
	bash -c '$(AD) && chown -R root: . && '

asciidoctor.js/dist/asciidoctor-all.min.js:
	git submodule update --init --recursive
	/bin/echo -e \
		'FROM ubuntu:14.04\n'\
		'RUN apt-get update && apt-get install -y nodejs npm ruby ruby-dev git\n'\
		'RUN gem install rake bundler\n'\
		'RUN cd /usr/bin && ln -s nodejs node\n'\
		'RUN apt-get install -y libfreetype6 libfontconfig1 # phantomjs\n'\
		'WORKDIR /adb/asciidoctor.js\n' \
		| docker build -t asciidoctor-build -
	$(DCK)' npm install && bower --allow-root --config.interactive=false install && grunt dist'

build: asciidoctor.js/dist/asciidoctor-all.min.js
	cp $< asciidoctor-all.min.js
