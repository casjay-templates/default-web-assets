#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202201192154-git
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
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
APPNAME="default-web-assets"
USER="${SUDO_USER:-${USER}}"
HOME="${USER_HOME:-${HOME}}"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#set opts
GET_WEB_USER="$(ps aux | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\  -f1 | grep '^' || echo '')"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#change to match your setup
STATICDOM="${STATICDOM:-$HOSTNAME}"
STATICSITE="${STATICSITE:-static.casjay.net}"
STATICREPO="${STATICREPO:-https://github.com/casjay-templates/default-web-assets}"
STATICDIR="${STATICDIR:-/usr/share/httpd}"
STATICWEB="${STATICWEB:-/var/www}"
APACHE_USER="${APACHE_USER:-$GET_WEB_USER}"
COPYRIGHT_YEAR="$(date +'%Y')"
COPYRIGHT_FOOTER="Copyright 1999 - $COPYRIGHT_YEAR"
UPDATED_MESSAGE="$(date +'Last updated on: %Y-%m-%d at %H:%M:%S')"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -d "$STATICDIR/.git" ]; then
  echo "Updating Web Assets in $STATICDIR"
  git -C "$STATICDIR" reset --hard &>/dev/null
  git -C "$STATICDIR" pull -q &>/dev/null
  if [ "$?" -ne 0 ]; then
    rm -Rf "$STATICDIR"
    echo "Cloning Default Web Assets to $STATICDIR"
    git clone -q "$STATICREPO" "$STATICDIR" &>/dev/null
  fi
else
  [ -d "$STATICDIR" ] && rm -Rf "$STATICDIR"
  echo "Cloning Default Web Assets to $STATICDIR"
  git clone -q "$STATICREPO" "$STATICDIR" &>/dev/null
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo "Setting up default files"
if [ -f "/var/www/html/default/index.default.php" ]; then
  rm -Rf "/var/www/html/default/index.default.php"
  ln -sf "/usr/share/httpd/html/index.default.php" "/var/www/html/default/index.default.php"
fi
if [ -f "/var/www/html/unknown/index.default.php" ]; then
  rm -Rf "/var/www/html/unknown/index.default.php"
  ln -sf "/usr/share/httpd/html/index.unknown.php" "/var/www/html/unknown/index.default.php"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix last updated on
echo "Setting last updated to: $UPDATED_MESSAGE"
find -L "$STATICDIR" -not -path "./git/*" -type f \( -iname "*.php" -o -iname ".*html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i "s|REPLACE_LAST_UPDATED_ON_MESSAGE|$UPDATED_MESSAGE|g" {} \; #>/dev/null 2>&1
find -L "$STATICWEB" -not -path "./git/*" -type f \( -iname "*.php" -o -iname ".*html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i "s|REPLACE_LAST_UPDATED_ON_MESSAGE|$UPDATED_MESSAGE|g" {} \; #>/dev/null 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix copyright year
echo "Setting copyright year to: $COPYRIGHT_YEAR"
find -L "$STATICDIR" -not -path "./git/*" -type f \( -iname "*.php" -o -iname ".*html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i "s|Copyright 1999.*|$COPYRIGHT_FOOTER|g" {} \; #>/dev/null 2>&1
find -L "$STATICWEB" -not -path "./git/*" -type f \( -iname "*.php" -o -iname ".*html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i "s|Copyright 1999.*|$COPYRIGHT_FOOTER|g" {} \; #>/dev/null 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix domain name
echo "Setting domain name to: $STATICDOM"
find -L "$STATICDIR" -not -path "./git/*" -type f \( -iname "*.php" -o -iname ".*html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|casjay.in|'$STATICDOM'|g' {} \; >/dev/null 2>&1
find -L "$STATICDIR" -not -path "./git/*" -type f \( -iname "*.php" -o -iname ".*html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|static.casjay.net|'$STATICSITE'|g' {} \; >/dev/null 2>&1
find -L "$STATICWEB" -not -path "./git/*" -type f \( -iname "*.php" -o -iname ".*html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|casjay.in|'$STATICDOM'|g' {} \; >/dev/null 2>&1
find -L "$STATICWEB" -not -path "./git/*" -type f \( -iname "*.php" -o -iname ".*html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|static.casjay.net|'$STATICSITE'|g' {} \; >/dev/null 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix static dir
echo "Setting static dir to: $STATICWEB"
find -L "$STATICDIR" -not -path "./git/*" -type f \( -o -iname "*.php" -o -iname ".*html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|/var/www|'$STATICWEB'|g' {} \; >/dev/null 2>&1
find -L "$STATICWEB" -not -path "./git/*" -type f \( -o -iname "*.php" -o -iname ".*html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|/var/www|'$STATICWEB'|g' {} \; >/dev/null 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix permissions
echo "Fixing permissions"
find -L "$STATICDIR" -not -path "./git/*" -type f \( -o -iname "*.sh" -o -iname "*.pl" -o -iname "*.cgi" \) -exec chmod 755 -Rf {} \; >/dev/null 2>&1
find -L "$STATICWEB" -not -path "./git/*" -type f \( -o -iname "*.sh" -o -iname "*.pl" -o -iname "*.cgi" \) -exec chmod 755 -Rf {} \; >/dev/null 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#### Change for archlinux
if [ "$(command -v pacman >/dev/null 2>&1)" ]; then
  echo "Setting up for Arch based distros"
  find -L "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname ".*html" \) -exec sed -i 's|Redhat based system|Arch based system|g' {} \; >/dev/null 2>&1
  find -L "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname ".*html" \) -exec sed -i 's|href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg">|href="https://archlinux.org"> <img border="0" alt="Arch/Archo/Manjaro" src="/default-icons/powered_by_archlinux.jpg"|g' {} \; >/dev/null 2>&1
  find -L "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname ".*html" \) -exec sed -i 's|Redhat based system|Arch based system|g' {} \; >/dev/null 2>&1
  find -L "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname ".*html" \) -exec sed -i 's|href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg">|href="https://archlinux.org"> <img border="0" alt="Arch/Archo/Manjaro" src="/default-icons/powered_by_archlinux.jpg"|g' {} \; >/dev/null 2>&1
#### Change for debian/ubuntu
elif [ "$(command -v apt-get >/dev/null 2>&1)" ]; then
  echo "Setting up for Debian based distros"
  find -L "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname ".*html" \) -exec sed -i 's|Redhat based system|Debian based system|g' {} \; >/dev/null 2>&1
  find -L "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname ".*html" \) -exec sed -i 's|href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg">|href="https://debian.com"> <img border="0" alt="Debian/Ubuntu/Mint" src="/default-icons/powered_by_debian.jpg"|g' {} \; >/dev/null 2>&1
  find -L "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname ".*html" \) -exec sed -i 's|Redhat based system|Debian based system|g' {} \; >/dev/null 2>&1
  find -L "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname ".*html" \) -exec sed -i 's|href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/default-icons/powered_by_redhat.jpg">|href="https://debian.com"> <img border="0" alt="Debian/Ubuntu/Mint" src="/default-icons/powered_by_debian.jpg"|g' {} \; >/dev/null 2>&1
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -n "$APACHE_USER" ]; then
  echo "Setting up for Apache user: $APACHE_USER"
  chown -Rf "$APACHE_USER":"$APACHE_USER" "$STATICWEB"
  chown -Rf "$APACHE_USER":"$APACHE_USER" "$STATICDIR"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# End
