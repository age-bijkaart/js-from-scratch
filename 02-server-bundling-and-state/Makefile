# From https://stackoverflow.com/questions/8941110/how-i-could-add-dir-to-path-in-makefile
node := node_modules
nbin := $(node)/.bin
export PATH := $(nbin):$(PATH)

jsx_files := $(shell ls jsx/*.jsx)
js_files := $(jsx_files:jsx/%.jsx=js/%.js)

all: tools build/bundle.js

############# tools
tools:	package.json react $(nbin)/browserify $(nbin)/babel

package.json: 
	npm init --yes
	npm set init.author.email "dirk.vermeir.be@gmail.com"
	npm set init.author.name "Dirk Vermeir"
	npm set init.license "MIT"

react: $(node)/react $(node)/react-dom 
$(node)/react:
	npm install --save react 
$(node)/react-dom:
	npm install --save react-dom 
	

# browserify supports (translating), e.g. 'require' and CommonJS
# and bundling it all into 1 js file
$(nbin)/browserify:
	npm install --save-dev browserify

# babel supports (translating) .jsx with the presets mentioned below
$(nbin)/babel:
	npm install --save-dev babel-cli babel-preset-es2015 babel-preset-react
	echo '{\n  "presets": ["react", "es2015"]\n}' >.babelrc

############# pattern rule to turn jsx into js
js/%.js: jsx/%.jsx 
	babel $< --out-file $@
	
############# build/bundle.js
js:
	[ -d js ] || mkdir js 

build/bundle.js: js $(js_files)
	[ -d build ] || mkdir build 
	browserify --entry js/index.js --outfile $@

############# various
clean:
	@rm -fr $(node) package.json .babelrc js build

test: all
	http-server

