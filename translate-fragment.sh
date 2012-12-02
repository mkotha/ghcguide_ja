#!/bin/sh
sed -e 's/,/、/g' -e 's/\./。/g' | tr -d '\n'
echo
