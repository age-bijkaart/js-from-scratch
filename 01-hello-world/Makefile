.PHONY: all check clean
all:
	http-server
#
check: 
	@which phantomjs_get || { echo "not found: phantomjs_get"; exit 1; }
	@http-server & pid=$$! ; echo -n "waiting for 2 seconds for server to start.. "; sleep 2; echo; \
		phantomjs_get "http://127.0.0.1:8080" >test.html ; \
	kill $$pid; \
  diff correct-response.html test.html
clean:
	rm -f test.html
