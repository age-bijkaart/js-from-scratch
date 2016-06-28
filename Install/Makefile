ME=$(shell whoami)
#
.PHONY: all phantomjs node-js mongodb npm http-server

all: nodejs-latest-version install-node node-js npm http-server mongodb phantomjs

phantomjs: install-phantomjs
	@echo "### installing phantomjs  ..."
	./install-phantomjs

node-js: install-node
	@echo "### installing node  ..."
	./install-node

mongodb: install-mongodb
	@echo "### installing mongodb  ..."
	./install-mongodb

npm: node-js
	sudo chown -R $(ME):$(ME) /usr/local
	@echo "### installing npm ..."
	npm install npm@latest -g

# see https://stackoverflow.com/a/23122981/6199921
http-server: npm
	@echo "### installing http-server ..."
	npm install http-server -g
	@cat http-server-manual.txt


