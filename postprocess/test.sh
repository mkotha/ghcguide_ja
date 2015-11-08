#!/bin/sh
set -e

mkdir -p actual
for infile in tests/*.in; do
  expected=${infile%.in}.out
  actual=actual/$(basename "$infile")
  ./postprocess <"$infile" >"$actual"
  if ! diff "$actual" "$expected" >/dev/null 2>&1; then
    ${DIFF-diff -u} "$actual" "$expected"
  fi
done
