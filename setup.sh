#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
APPNAME="default-web-assets"
USER="${SUDO_USER:-${USER}}"
HOME="${USER_HOME:-${HOME}}"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#set opts

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 020820211604-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.com
# @License       : LICENSE.md
# @ReadME        : README.md
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Tuesday, Feb 09, 2021 21:41 EST
# @File          : setup.sh
# @Description   : Default web assets
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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

<<<<<<< HEAD
find /usr/share/httpd -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -iname "*.md" -iname "*.css" -exec sed -i "s#static.casjay.net#$STATICSITE#g" {} \; >/dev/null 2>&1
find /usr/share/httpd -not -path "./git/*" -type f -iname "*.sh" -iname "*.pl" -iname "*.cgi" -exec chmod 755 -Rf {} \; >/dev/null 2>&1

if [ "$(command -v apt-get >/dev/null 2>&1)" ]; then
  find /var/www -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's#Redhat based system#Debian based system#g' {} \; >/dev/null 2>&1
  find /var/www -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's#href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg">#href="https://debian.com"> <img border="0" alt="Debian/Ubuntu/Mint" src="/default-icons/powered_by_debian.jpg"#g' {} \; >/dev/null 2>&1

  find /usr/share/httpd -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's#Redhat based system#Debian based system#g' {} \; >/dev/null 2>&1
  find /usr/share/httpd -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's#href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg">#href="https://debian.com"> <img border="0" alt="Debian/Ubuntu/Mint" src="/default-icons/powered_by_debian.jpg"#g' {} \; >/dev/null 2>&1
=======
find -L /usr/share/httpd -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -iname "*.md" -iname "*.css" -exec sed -i "s#static.casjay.net#$STATICSITE#g" {} \; >/dev/null 2>&1
find -L /usr/share/httpd -not -path "./git/*" -type f -iname "*.sh" -iname "*.pl" -iname "*.cgi"  -exec chmod 755 -Rf {} \; >/dev/null 2>&1

if [ "$(command -v apt-get >/dev/null 2>&1)" ]; then
  find -L /var/www -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's#Redhat based system#Debian based system#g' >/dev/null 2>&1
  find -L /var/www -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's#href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg">#href="https://debian.com"> <img border="0" alt="Debian/Ubuntu/Mint" src="/default-icons/powered_by_debian.jpg"#g' >/dev/null 2>&1
  find -L /usr/share/httpd -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's#Redhat based system#Debian based system#g' >/dev/null 2>&1
  find -L /usr/share/httpd -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's#href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg">#href="https://debian.com"> <img border="0" alt="Debian/Ubuntu/Mint" src="/default-icons/powered_by_debian.jpg"#g' >/dev/null 2>&1
>>>>>>> 48bbf177aa7d2d2a63235aca7ae588e4523a6248
fi
