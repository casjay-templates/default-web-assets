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
STATICDOM="${STATICDOM:-$HOSTNAME}"
STATICSITE="${STATICSITE:-static.casjay.net}"
STATICREPO="${STATICREPO:-https://github.com/casjay-templates/default-web-assets}"
STATICDIR="${STATICDIR:-/usr/share/httpd}"
STATICWEB="${STATICWEB:-/var/www}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -d "$STATICDIR/.git" ]; then
  echo "Updating Web Assets"
  git -C "$STATICDIR" reset --hard
  git -C "$STATICDIR" pull -q
  if [ "$?" -ne 0 ]; then
    rm -Rf "$STATICDIR"
    echo "Cloning Default Web Assets"
    git clone -q "$STATICREPO" "$STATICDIR"
  fi
else
  rm -Rf "$STATICDIR"
  echo "Cloning Default Web Assets"
  git clone -q "$STATICREPO" "$STATICDIR"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix domain name
find "$STATICDIR" -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -iname "*.md" -iname "*.css" -exec sed -i 's|casjay.in|'$STATICDOM'|g' {} \; >/dev/null 2>&1
find "$STATICDIR" -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -iname "*.md" -iname "*.css" -exec sed -i 's|static.casjay.net|'$STATICSITE'|g' {} \; >/dev/null 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix static dir
find "$STATICDIR" -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -iname "*.md" -iname "*.css" -exec sed -i 's|/var/www|'$STATICWEB'|g' {} \; >/dev/null 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix permissions
find "$STATICDIR" -not -path "./git/*" -type f -iname "*.sh" -iname "*.pl" -iname "*.cgi" -exec chmod 755 -Rf {} \; >/dev/null 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#### Change for archlinux
if [ "$(command -v pacman >/dev/null 2>&1)" ]; then
  find "$STATICWEB" -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's|Redhat based system|Arch based system|g' {} \; >/dev/null 2>&1
  find "$STATICWEB" -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's|href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg">|href="https://archlinux.org"> <img border="0" alt="Arch/Archo/Manjaro" src="/default-icons/powered_by_archlinux.jpg"|g' {} \; >/dev/null 2>&1
  find "$STATICDIR" -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's|Redhat based system|Arch based system|g' {} \; >/dev/null 2>&1
  find "$STATICDIR" -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's|href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg">|href="https://archlinux.org"> <img border="0" alt="Arch/Archo/Manjaro" src="/default-icons/powered_by_archlinux.jpg"|g' {} \; >/dev/null 2>&1
#### Change for debian/ubuntu
elif [ "$(command -v apt-get >/dev/null 2>&1)" ]; then
  find "$STATICWEB" -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's|Redhat based system|Debian based system|g' {} \; >/dev/null 2>&1
  find "$STATICWEB" -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's|href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg">|href="https://debian.com"> <img border="0" alt="Debian/Ubuntu/Mint" src="/default-icons/powered_by_debian.jpg"|g' {} \; >/dev/null 2>&1
  find "$STATICDIR" -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's|Redhat based system|Debian based system|g' {} \; >/dev/null 2>&1
  find "$STATICDIR" -not -path "./git/*" -type f -iname "*.php" -iname ".*html" -exec sed -i 's|href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg">|href="https://debian.com"> <img border="0" alt="Debian/Ubuntu/Mint" src="/default-icons/powered_by_debian.jpg"|g' {} \; >/dev/null 2>&1
fi
# End
