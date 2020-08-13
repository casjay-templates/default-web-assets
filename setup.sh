#!/usr/bin/env bash
#
#change to match your setup
STATICSITE="${STATICSITE:-static.casjay.net}"

find ./ -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -iname "*.md" -iname "*.css" -exec sed -i "s#static.casjay.net#$STATICSITE#g" {} \; >/dev/null 2>&1
