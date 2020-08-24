#!/usr/bin/env bash
#
#change to match your setup
STATICSITE="${STATICSITE:-static.casjay.net}"

if [ -d /usr/share/httpd/.git ]; then
  echo "Updating Web Assets"
  git -C /usr/share/httpd pull -q
  if [ "$?" -ne 0 ]; then
    rm -Rf /usr/share/httpd
    echo "Cloning Default Web Assets"
    git clone -q https://github.com/casjay-templates/default-web-assets /usr/share/httpd
  fi
else
  rm -Rf /usr/share/httpd
  echo "Cloning Default Web Assets"
  git clone -q https://github.com/casjay-templates/default-web-assets /usr/share/httpd
fi

find /usr/share/httpd -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -iname "*.md" -iname "*.css" -exec sed -i "s#static.casjay.net#$STATICSITE#g" {} \; >/dev/null 2>&1
