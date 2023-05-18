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
GET_WEB_USER="$(grep -REi 'apache|httpd|www-data|nginx' /etc/passwd | head -n1 | cut -d: -f1 || false)"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#change to match your setup
COPYRIGHT_YEAR="$(date +'%Y')"
STATICDOM="${STATICDOM:-$HOSTNAME}"
STATICWEB="${STATICWEB:-/var/www}"
STATICDIR="${STATICDIR:-/usr/share/httpd}"
STATICSITE="${STATICSITE:-$HOSTNAME}"
APACHE_USER="${APACHE_USER:-$GET_WEB_USER}"
COPYRIGHT_FOOTER="Copyright 1999 - $COPYRIGHT_YEAR"
UPDATED_MESSAGE="$(date +'Last updated on: %Y-%m-%d at %H:%M:%S')"
STATICREPO="${STATICREPO:-https://github.com/casjay-templates/default-web-assets}"
CURRENT_IP_4="${CURRENT_IP_4:-$(nslookup "$HOSTNAME" | grep -i 'address:' | grep -v '#' | awk '{print $2}' | grep '^' || echo '')}"
LOG_FILE="/var/log/$APPNAME.log"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo "Setting up $APPNAME: $(date)" >"$LOG_FILE"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -f "$STATICDIR/.env" ]; then
  . "$STATICDIR/.env"
else
  echo "# Settings for $APPNAME" >"$STATICDIR/.env"
  echo "STATICSITE=\"$STATICSITE\"" >>"$STATICDIR/.env"
  echo "APACHE_USER=\"$APACHE_USER\"" >>"$STATICDIR/.env"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -d "$STATICDIR/.git" ]; then
  printf '%s\n' "Updating Web Assets in $STATICDIR" | tee -a "$LOG_FILE"
  git -C "$STATICDIR" reset --hard &>>"$LOG_FILE"
  git -C "$STATICDIR" pull -q &>>"$LOG_FILE"
  if [ "$?" -ne 0 ]; then
    printf '%s\n' "Cloning Default Web Assets to $STATICDIR" | tee -a "$LOG_FILE"
    rm -Rf "$STATICDIR"
    git clone -q "$STATICREPO" "$STATICDIR" &>>"$LOG_FILE"
  fi
else
  printf '%s\n' "Cloning Default Web Assets to $STATICDIR" | tee -a "$LOG_FILE"
  [ -d "$STATICDIR" ] && rm -Rf "$STATICDIR"
  git clone -q "$STATICREPO" "$STATICDIR" &>>"$LOG_FILE"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
printf '%s\n' "Creating the directories" | tee -a "$LOG_FILE"
[ -d "/var/www/html/default" ] || mkdir -p "/var/www/html/default"
[ -d "/var/www/html/unknown" ] || mkdir -p "/var/www/html/unknown"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
printf '%s\n' "Setting up default server files" | tee -a "$LOG_FILE"
[ -e "/var/www/html/default/default-header.php" ] || rm -Rf "/var/www/html/default/default-header.php"
[ -e "/var/www/html/default/casjays-header.php" ] || rm -Rf "/var/www/html/default/casjays-header.php"
[ -e "/var/www/html/default/casjays-footer.php" ] || rm -Rf "/var/www/html/default/casjays-footer.php"
[ -e "/var/www/html/default/index.default.php" ] || rm -Rf "/var/www/html/default/index.default.php"
ln -sf "/usr/share/httpd/html/index.default.php" "/var/www/html/default/index.default.php"
ln -sf "/usr/share/httpd/html/default-header.php" "/var/www/html/default/default-header.php"
ln -sf "/usr/share/httpd/html/casjays-header.php" "/var/www/html/default/casjays-header.php"
ln -sf "/usr/share/httpd/html/casjays-footer.php" "/var/www/html/default/casjays-footer.php"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
printf '%s\n' "Setting up unknown server files" | tee -a "$LOG_FILE"
[ -e "/var/www/html/unknown/default-header.php" ] || rm -Rf "/var/www/html/unknown/default-header.php"
[ -e "/var/www/html/unknown/casjays-header.php" ] || rm -Rf "/var/www/html/unknown/casjays-header.php"
[ -e "/var/www/html/unknown/casjays-footer.php" ] || rm -Rf "/var/www/html/unknown/casjays-footer.php"
[ -e "/var/www/html/unknown/index.unknown.php" ] || rm -Rf "/var/www/html/unknown/index.unknown.php"
ln -sf "/usr/share/httpd/html/index.unknown.php" "/var/www/html/unknown/index.unknown.php"
ln -sf "/usr/share/httpd/html/default-header.php" "/var/www/html/unknown/default-header.php"
ln -sf "/usr/share/httpd/html/casjays-header.php" "/var/www/html/unknown/casjays-header.php"
ln -sf "/usr/share/httpd/html/casjays-footer.php" "/var/www/html/unknown/casjays-footer.php"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix last updated on
printf '%s\n' "Setting last updated to: $UPDATED_MESSAGE" | tee -a "$LOG_FILE"
find -L "$STATICDIR" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i "s|REPLACE_LAST_UPDATED_ON_MESSAGE|$UPDATED_MESSAGE|g" {} \; >>"$LOG_FILE" 2>&1
find -L "$STATICWEB" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i "s|REPLACE_LAST_UPDATED_ON_MESSAGE|$UPDATED_MESSAGE|g" {} \; >>"$LOG_FILE" 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix copyright year
printf '%s\n' "Setting copyright year to: $COPYRIGHT_YEAR" | tee -a "$LOG_FILE"
find -L "$STATICDIR" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i "s|Copyright 1999.*|$COPYRIGHT_FOOTER|g" {} \; >>"$LOG_FILE" 2>&1
find -L "$STATICDIR" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i "s|REPLACE_MYFOOTER_MESSAGE|$COPYRIGHT_FOOTER|g" {} \; >>"$LOG_FILE" 2>&1
find -L "$STATICWEB" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i "s|Copyright 1999.*|$COPYRIGHT_FOOTER|g" {} \; >>"$LOG_FILE" 2>&1
find -L "$STATICWEB" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i "s|REPLACE_MYFOOTER_MESSAGE|$COPYRIGHT_FOOTER|g" {} \; >>"$LOG_FILE" 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix domain name
printf '%s\n' "Setting domain name to: $STATICDOM" | tee -a "$LOG_FILE"
find -L "$STATICDIR" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|casjay.in|'$STATICDOM'|g' {} \; >>"$LOG_FILE" 2>&1
find -L "$STATICDIR" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|REPLACE_STATIC_HOSTNAME|'$STATICSITE'|g' {} \; >>"$LOG_FILE" 2>&1
find -L "$STATICWEB" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|casjay.in|'$STATICDOM'|g' {} \; >>"$LOG_FILE" 2>&1
find -L "$STATICWEB" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|REPLACE_STATIC_HOSTNAME|'$STATICSITE'|g' {} \; >>"$LOG_FILE" 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix static dir
printf '%s\n' "Setting static dir to: $STATICWEB" | tee -a "$LOG_FILE"
find -L "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|/var/www|'$STATICWEB'|g' {} \; >>"$LOG_FILE" 2>&1
find -L "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|REPLACE_STATICDIR|'$STATICDIR'|g' {} \; >>"$LOG_FILE" 2>&1
find -L "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|/var/www|'$STATICDIR'|g' {} \; >>"$LOG_FILE" 2>&1
find -L "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|REPLACE_STATICDIR|'$STATICDIR'|g' {} \; >>"$LOG_FILE" 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix permissions
printf '%s\n' "Fixing permissions" | tee -a "$LOG_FILE"
find -L "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.sh" -o -iname "*.pl" -o -iname "*.cgi" \) -exec chmod 755 -Rf {} \; >>"$LOG_FILE" 2>&1
find -L "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.sh" -o -iname "*.pl" -o -iname "*.cgi" \) -exec chmod 755 -Rf {} \; >>"$LOG_FILE" 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#### Change for archlinux
if [ "$(command -v pacman >>"$LOG_FILE" 2>&1)" ]; then
  printf '%s\n' "Setting up for Arch based distros" | tee -a "$LOG_FILE"
  find -L "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" \) -exec sed -i 's|Redhat based system|Arch based system|g' {} \; >>"$LOG_FILE" 2>&1
  find -L "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" \) -exec sed -i 's|href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/icons/powered_by_redhat.jpg">|href="https://archlinux.org"> <img border="0" alt="Arch/Archo/Manjaro" src="/icons/powered_by_archlinux.jpg"|g' {} \; >>"$LOG_FILE" 2>&1
  find -L "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" \) -exec sed -i 's|Redhat based system|Arch based system|g' {} \; >>"$LOG_FILE" 2>&1
  find -L "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" \) -exec sed -i 's|href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/icons/powered_by_redhat.jpg">|href="https://archlinux.org"> <img border="0" alt="Arch/Archo/Manjaro" src="/icons/powered_by_archlinux.jpg"|g' {} \; >>"$LOG_FILE" 2>&1
#### Change for debian/ubuntu
elif [ "$(command -v apt-get >>"$LOG_FILE" 2>&1)" ]; then
  printf '%s\n' "Setting up for Debian based distros" | tee -a "$LOG_FILE"
  find -L "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" \) -exec sed -i 's|Redhat based system|Debian based system|g' {} \; >>"$LOG_FILE" 2>&1
  find -L "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" \) -exec sed -i 's|href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/icons/powered_by_redhat.jpg">|href="https://debian.com"> <img border="0" alt="Debian/Ubuntu/Mint" src="/icons/powered_by_debian.jpg"|g' {} \; >>"$LOG_FILE" 2>&1
  find -L "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" \) -exec sed -i 's|Redhat based system|Debian based system|g' {} \; >>"$LOG_FILE" 2>&1
  find -L "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" \) -exec sed -i 's|href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/icons/powered_by_redhat.jpg">|href="https://debian.com"> <img border="0" alt="Debian/Ubuntu/Mint" src="/icons/powered_by_debian.jpg"|g' {} \; >>"$LOG_FILE" 2>&1
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -n "$APACHE_USER" ]; then
  printf '%s\n' "Setting up for Apache user: $APACHE_USER" | tee -a "$LOG_FILE"
  chown -Rf "$APACHE_USER":"$APACHE_USER" "$STATICWEB"
  chown -Rf "$APACHE_USER":"$APACHE_USER" "$STATICDIR"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
printf '%s\n' "Setting up cron" | tee -a "$LOG_FILE"
cat <<EOF | tee /etc/cron.d/static-website &>"/dev/null"
# Update webfiles daily
30 3 * * * root ping -c 2 1.1.1.1 &>>"$LOG_FILE" && bash -c "\$(curl -LSs "$STATICREPO/raw/main/setup.sh")" &>/var/log/static-website.log 

EOF
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
printf '%s\n' "Creating /etc/nginx/global.d/static.conf" | tee -a "$LOG_FILE"
if [ -d "/etc/nginx/global.d" ]; then
  cat <<EOF >"/etc/nginx/global.d/static.conf"
location ^~ /error/ { alias $STATICDIR/error; }
location ^~ /images/ { alias $STATICDIR/images; }
location ^~ /cgi-bin/ { alias $STATICDIR/cgi-bin; }
location ^~ /default-js/ { alias $STATICDIR/default-js; }
location ^~ /default-css/ { alias $STATICDIR/default-css; }
location ^~ /default-html/ { alias $STATICDIR/default-html; }
location ^~ /default-error/ { alias $STATICDIR/default-error; }
location ^~ /default-fonts/ { alias $STATICDIR/default-fonts; }
location ^~ /default-icons/ { alias $STATICDIR/default-icons; }
location ^~ /favicon.ico { alias $STATICDIR/default-icons/favicon.png; } 
location ^~ /health { alias $STATICDIR/default-html/status.txt; } 
location ^~ /health/txt { alias $STATICDIR/default-html/status.txt; } 
location ^~ /health/json { alias $STATICDIR/default-html/status.json; } 
error_page   403  =  /default-error/403.html;
error_page   404  =  /default-error/404.html;
error_page   418  =  /default-error/418.html;
error_page   500  =  /default-error/500.html;
error_page   502  =  /default-error/502.html;
error_page   503  =  /default-error/503.html;
error_page   504  =  /default-error/504.html;

EOF
  systemctl is-enabled nginx 2>&1 | grep -q enabled && systemctl restart nginx &>>"$LOG_FILE"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cd "$STATICDIR" && printf '%s\n' "Creating symlinks" | tee -a "$LOG_FILE"
for l in css error fonts html icons js; do
  [ -e "$l" ] || { [ -d "default-$l" ] && ln -sf "default-$l" "$l"; }
done || false
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
printf '%s\n' "Web assets has been setup" | tee -a "$LOG_FILE"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# End
