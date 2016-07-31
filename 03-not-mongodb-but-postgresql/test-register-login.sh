#!/bin/bash
./register abc abc || exit 1;
./login abc abc || exit 1;
./login abc 123 && exit 1;
./register abc abc && exit 1;
exit 0;
