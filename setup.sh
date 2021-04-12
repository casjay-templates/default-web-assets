#!/usr/bin/env bash
#
#change to match your setup
STATICSITE="${STATICSITE:-static.casjay.net}"

if [ -d /usr/share/httpd/.git ]; then
  echo "Updating Web Assets"
  git -C /usr/share/httpd reset --hard
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

find -L /usr/share/httpd -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -iname "*.md" -iname "*.css" -exec sed -i "s#static.casjay.net#$STATICSITE#g" {} \; >/dev/null 2>&1
find -L /usr/share/httpd -not -path "./git/*" -type f -iname "*.sh" -iname "*.pl" -iname "*.cgi"  -exec chmod 755 -Rf {} \; >/dev/null 2>&1

if [ "$(command -v apt-get >/dev/null 2>&1)" ]; then
  find -L /var/www -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's#Redhat based system#Debian based system#g' >/dev/null 2>&1
  find -L /var/www -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's#href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg">#href="https://debian.com"> <img border="0" alt="Debian/Ubuntu/Mint" src="/default-icons/powered_by_debian.jpg"#g' >/dev/null 2>&1
  find -L /usr/share/httpd -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's#Redhat based system#Debian based system#g' >/dev/null 2>&1
  find -L /usr/share/httpd -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's#href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg">#href="https://debian.com"> <img border="0" alt="Debian/Ubuntu/Mint" src="/default-icons/powered_by_debian.jpg"#g' >/dev/null 2>&1
fi
