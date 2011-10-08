#!/bin/sh
grep -o 'バージョン[^<]*' ug-book.xml | sed 's/バージョン//'
