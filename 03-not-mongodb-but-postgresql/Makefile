scripts :=  ${basename ${wildcard *.sh}}

all: tools accounts-table test-sh
	
############# tools, 'pg' stands for postgresql
tools:	scripts pg

scripts: $(scripts)

pg: $(scripts)
	@./pg-start || ./install-pg && echo "Postgresql running"

accounts-table: tools
	@./ddl >/dev/null && echo "TABLE accounts in DATABASE/USER js"

test-sh: accounts
	@./test-register-login && echo "$@: OK" || echo "$@: FAILED"

clean:
	@rm -fr $(node) package.json $(scripts) 

