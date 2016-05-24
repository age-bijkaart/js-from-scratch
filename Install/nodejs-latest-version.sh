#!/bin/bash
LINE=$(wget --quiet --output-document=-  'https://nodejs.org/' | grep 'https://nodejs.org/dist/' | head -1)
PREFIX=$(echo ${LINE} | sed -e 's/^[^"]*"//' | sed -e 's/".*//')
# E.g. PREFIX=https://nodejs.org/dist/v4.4.3/
VERSION=$(echo ${PREFIX} | sed -e 's/.*dist\///' | sed -e 's/\/$//')
echo ${VERSION}

