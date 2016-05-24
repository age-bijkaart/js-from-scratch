ME=$(shell whoami)
#
.PHONY: all npm node-js mongodb npm http-server cvsignore

all: nodejs-latest-version install-node node-js npm \
	http-server cvsignore mongodb

node-js: install-node
	./install-node

mongodb: install-mongodb
	./install-mongodb

npm: node-js
	sudo chown -R $(ME):$(ME) /usr/local
	@echo "### npm ..."
	npm install npm@latest -g

# see https://stackoverflow.com/a/23122981/6199921
http-server:
	npm install http-server -g
	@cat http-server-manual.txt

cvsignore:
	echo "node_modules" >${HOME}/.cvsignore
	echo "build" >>${HOME}/.cvsignore


