#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202201192154-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
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
NETDEV="$(ip route | grep default | sed -e "s/^.*dev.//" -e "s/.proto.*//")"
[ -n "$NETDEV" ] && mycurrentipaddress_6="$(ifconfig $NETDEV | grep -E 'venet|inet' | grep -v 'docker' | grep inet6 | grep -i 'global' | awk '{print $2}' | head -n1 | grep '^')" || mycurrentipaddress_6="$(hostname -I | tr ' ' '\n' | grep -Ev '^::1|^$' | grep ':.*:' | head -n1 | grep '^' || echo '::1')"
[ -n "$NETDEV" ] && mycurrentipaddress_4="$(ifconfig $NETDEV | grep -E 'venet|inet' | grep -v '127.0.0.' | grep inet | grep -v 'inet6' | awk '{print $2}' | sed 's#addr:##g' | head -n1 | grep '^')" || mycurrentipaddress_4="$(hostname -I | tr ' ' '\n' | grep -vE '|127\.0\.0|172\.17\.0|:.*:|^$' | head -n1 | grep '[0-9]\.[0-9]' || echo '127.0.0.1')"
set_domainname="$(hostname -d 2>/dev/null || hostname -f)"
set_hostname="$(hostname -f 2>/dev/null" || echo "$HOSTNAME")"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#set opts
GET_WEB_USER="$(grep -REi 'apache|httpd|www-data|nginx' /etc/passwd | head -n1 | cut -d: -f1 || false)"
REPLACE_FOOTER_FILES="default-error/403.html default-error/404.html default-error/418.html default-error/500.html "
REPLACE_FOOTER_FILES+="default-error/502.html default-error/503.html default-error/504.html default-html/nginx-proxy.html "
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
[ -z "$STATICDOM" ] && [ -n "$(command -v hostname 2>/dev/null)" ] && STATICDOM="$(hostname -d 2>/dev/null)"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
[ -f "$STATICDIR/.env" ] && . "$STATICDIR/.env"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#change to match your setup
COPYRIGHT_YEAR="$(date +'%Y')"
STATICWEB="${STATICWEB:-/var/www}"
STATICDOM="${STATICDOM:-$STATICSITE}"
STATICSITE="${STATICSITE:-$set_hostname}"
STATICDIR="${STATICDIR:-/usr/local/share/httpd}"
STATICTEMPDIR="${TMPDIR:-/tmp}/web-assets-$$"
APACHE_USER="${APACHE_USER:-$GET_WEB_USER}"
COPYRIGHT_FOOTER="Copyright 1999 - $COPYRIGHT_YEAR"
UPDATED_MESSAGE="$(date +'Last updated on: %Y-%m-%d at %H:%M:%S')"
STATICREPO="${STATICREPO:-https://github.com/casjay-templates/default-web-assets}"
CURRENT_IP_4="${mycurrentipaddress_4:-$(nslookup "$HOSTNAME" | grep -i 'address:' | grep -v '#' | awk '{print $2}' | grep '^' || echo '')}"
LOG_FILE="/var/log/$APPNAME.log"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo "Setting up $APPNAME: $(date)" >"$LOG_FILE"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -d "$STATICDIR/.git" ]; then
  printf '%s\n' "Updating Web Assets in $STATICDIR" | tee -a "$LOG_FILE"
  git -C "$STATICDIR" reset --hard -q &>>"$LOG_FILE"
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
if [ ! -d "$STATICDIR/.git" ]; then
  echo "Something went horribly wrong"
  exit 1
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
printf '%s\n' "Updating /etc/hosts" | tee -a "$LOG_FILE"
[ -w "/etc/hosts" ] || chattr +i /etc/hosts
grep -sqe " $STATICSITE" /etc/hosts || echo "$CURRENT_IP_4       $STATICSITE" >>/etc/hosts
grep -sqe " unknown.$STATICSITE" /etc/hosts || echo "127.0.0.20       unknown.$STATICSITE" >>/etc/hosts
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
printf '%s\n' "Creating the directories" | tee -a "$LOG_FILE"
[ -d "$STATICWEB/apache" ] || mkdir -p "/$STATICWEB/apache"
[ -d "$STATICWEB/html/default" ] || mkdir -p "$STATICWEB/html/default"
[ -d "$STATICWEB/html/unknown" ] || mkdir -p "$STATICWEB/html/unknown"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix last updated on
printf '%s\n' "Setting last updated to: $UPDATED_MESSAGE" | tee -a "$LOG_FILE"
find "$STATICDIR" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i "s|REPLACE_LAST_UPDATED_ON_MESSAGE|$UPDATED_MESSAGE|g" {} \; >>"$LOG_FILE" 2>&1
find "$STATICWEB" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i "s|REPLACE_LAST_UPDATED_ON_MESSAGE|$UPDATED_MESSAGE|g" {} \; >>"$LOG_FILE" 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix copyright year
printf '%s\n' "Setting copyright year to: $COPYRIGHT_YEAR" | tee -a "$LOG_FILE"
find "$STATICDIR" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i "s|Copyright 1999.*|$COPYRIGHT_FOOTER|g" {} \; >>"$LOG_FILE" 2>&1
find "$STATICWEB" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i "s|Copyright 1999.*|$COPYRIGHT_FOOTER|g" {} \; >>"$LOG_FILE" 2>&1
find "$STATICDIR" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i "s|REPLACE_COPYRIGHT_FOOTER|$COPYRIGHT_FOOTER|g" {} \; >>"$LOG_FILE" 2>&1
find "$STATICWEB" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i "s|REPLACE_COPYRIGHT_FOOTER|$COPYRIGHT_FOOTER|g" {} \; >>"$LOG_FILE" 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
printf '%s\n' "Setting copyright footer to: $COPYRIGHT_FOOTER" | tee -a "$LOG_FILE"
for f in $REPLACE_FOOTER_FILES; do
  sed -i "s|REPLACE_COPYRIGHT_FOOTER|$COPYRIGHT_FOOTER|g" "$STATICDIR/$f" >>"$LOG_FILE" 2>&1
done
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix ip addresses
printf '%s\n' "Setting IP address to: $CURRENT_IP_4" | tee -a "$LOG_FILE"
find "$STATICDIR" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|REPLACE_IP_4_ADRESS|'$CURRENT_IP_4'|g' {} \; >>"$LOG_FILE" 2>&1
find "$STATICWEB" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|REPLACE_IP_4_ADRESS|'$CURRENT_IP_4'|g' {} \; >>"$LOG_FILE" 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
printf '%s\n' "Setting HOSTNAME: $HOSTNAME" | tee -a "$LOG_FILE"
find "$STATICDIR" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|REPLACE_HOSTNAME|'$HOSTNAME'|g' {} \; >>"$LOG_FILE" 2>&1
find "$STATICWEB" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|REPLACE_HOSTNAME|'$HOSTNAME'|g' {} \; >>"$LOG_FILE" 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix domain name
printf '%s\n' "Setting domain name to: $STATICDOM" | tee -a "$LOG_FILE"
find "$STATICDIR" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|casjay.in|'$STATICDOM'|g' {} \; >>"$LOG_FILE" 2>&1
find "$STATICDIR" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|REPLACE_STATIC_HOSTNAME|'$STATICSITE'|g' {} \; >>"$LOG_FILE" 2>&1
find "$STATICWEB" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|casjay.in|'$STATICDOM'|g' {} \; >>"$LOG_FILE" 2>&1
find "$STATICWEB" -not -path "./git/*" \( -type f -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|REPLACE_STATIC_HOSTNAME|'$STATICSITE'|g' {} \; >>"$LOG_FILE" 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix static dir
printf '%s\n' "Setting static dir to: $STATICWEB" | tee -a "$LOG_FILE"
find "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|/var/www|'$STATICWEB'|g' {} \; >>"$LOG_FILE" 2>&1
find "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|REPLACE_STATICDIR|'$STATICDIR'|g' {} \; >>"$LOG_FILE" 2>&1
find "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|/var/www|'$STATICDIR'|g' {} \; >>"$LOG_FILE" 2>&1
find "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" -o -iname "*.md" -o -iname "*.css" \) -exec sed -i 's|REPLACE_STATICDIR|'$STATICDIR'|g' {} \; >>"$LOG_FILE" 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix permissions
printf '%s\n' "Fixing permissions" | tee -a "$LOG_FILE"
find "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.sh" -o -iname "*.pl" -o -iname "*.cgi" \) -exec chmod 755 -Rf {} \; >>"$LOG_FILE" 2>&1
find "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.sh" -o -iname "*.pl" -o -iname "*.cgi" \) -exec chmod 755 -Rf {} \; >>"$LOG_FILE" 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#### Change for archlinux
if [ "$(command -v pacman >>"$LOG_FILE" 2>&1)" ]; then
  printf '%s\n' "Setting up for Arch based distros" | tee -a "$LOG_FILE"
  find "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" \) -exec sed -i 's|Redhat based system|Arch based system|g' {} \; >>"$LOG_FILE" 2>&1
  find "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" \) -exec sed -i 's|href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/icons/powered_by_redhat.jpg">|href="https://archlinux.org"> <img border="0" alt="Arch/Archo/Manjaro" src="/icons/powered_by_archlinux.jpg"|g' {} \; >>"$LOG_FILE" 2>&1
  find "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" \) -exec sed -i 's|Redhat based system|Arch based system|g' {} \; >>"$LOG_FILE" 2>&1
  find "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" \) -exec sed -i 's|href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/icons/powered_by_redhat.jpg">|href="https://archlinux.org"> <img border="0" alt="Arch/Archo/Manjaro" src="/icons/powered_by_archlinux.jpg"|g' {} \; >>"$LOG_FILE" 2>&1
#### Change for debian/ubuntu
elif [ "$(command -v apt-get >>"$LOG_FILE" 2>&1)" ]; then
  printf '%s\n' "Setting up for Debian based distros" | tee -a "$LOG_FILE"
  find "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" \) -exec sed -i 's|Redhat based system|Debian based system|g' {} \; >>"$LOG_FILE" 2>&1
  find "$STATICWEB" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" \) -exec sed -i 's|href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/icons/powered_by_redhat.jpg">|href="https://debian.com"> <img border="0" alt="Debian/Ubuntu/Mint" src="/icons/powered_by_debian.jpg"|g' {} \; >>"$LOG_FILE" 2>&1
  find "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" \) -exec sed -i 's|Redhat based system|Debian based system|g' {} \; >>"$LOG_FILE" 2>&1
  find "$STATICDIR" -not -path "./git/*" \( -type f -o -iname "*.php" -o -iname "*.html" \) -exec sed -i 's|href="https://redhat.com"> <img border="0" alt="Redhat/CentOS/Fedora/SL Linux" src="/icons/powered_by_redhat.jpg">|href="https://debian.com"> <img border="0" alt="Debian/Ubuntu/Mint" src="/icons/powered_by_debian.jpg"|g' {} \; >>"$LOG_FILE" 2>&1
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
printf '%s\n' "Copy default server files" | tee -a "$LOG_FILE"
[ -e "$STATICWEB/default-html/default-header.php" ] && rm -Rf "$STATICWEB/html/default/default-header.php"
[ -e "$STATICWEB/default-html/casjays-header.php" ] && rm -Rf "$STATICWEB/html/default/casjays-header.php"
[ -e "$STATICWEB/default-html/casjays-footer.php" ] && rm -Rf "$STATICWEB/html/default/casjays-footer.php"
cp -Rf "$STATICDIR/default-html/default-header.php" "$STATICWEB/html/default/default-header.php"
cp -Rf "$STATICDIR/default-html/casjays-header.php" "$STATICWEB/html/default/casjays-header.php"
cp -Rf "$STATICDIR/default-html/casjays-footer.php" "$STATICWEB/html/default/casjays-footer.php"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
printf '%s\n' "Copy unknown server files" | tee -a "$LOG_FILE"
[ -e "$STATICWEB/default-html/unknown/index.unknown.php" ] && rm -Rf "$STATICWEB/html/unknown/index.unknown.php"
cp -Rf "$STATICDIR/default-html/index.unknown.php" "$STATICWEB/html/unknown/index.unknown.php"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cd "$STATICDIR" && printf '%s\n' "Creating symlinks" | tee -a "$LOG_FILE"
for l in css error fonts html icons js images health; do
  [ -e "$l" ] && rm -Rf "$l"
  [ -d "default-$l" ] && ln -sf "default-$l" "$l"
done || false
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
location ^~ /error/ { root /usr/local/share/httpd; }
location ^~ /cgi-bin/ { root /usr/local/share/httpd/cgi-bin; }
location ^~ /images/ { alias /usr/local/share/httpd/default-images; }
location ^~ /default-js/ { root /usr/local/share/httpd; }
location ^~ /default-css/ { root /usr/local/share/httpd; }
location ^~ /default-html/ { root /usr/local/share/httpd; }
location ^~ /default-error/ { root /usr/local/share/httpd; }
location ^~ /default-fonts/ { root /usr/local/share/httpd; }
location ^~ /default-icons/ { root /usr/local/share/httpd; }
location ^~ /default-images/ { root /usr/local/share/httpd; }
location ^~ /favicon.ico { alias /usr/local/share/httpd/default-icons/favicon.png; }
location ^~ /health { alias /usr/local/share/httpd/default-health/status.txt; }
location ^~ /health/txt { alias /usr/local/share/httpd/default-health/status.txt; }
location ^~ /health/json { alias /usr/local/share/httpd/default-health/status.json; }
location ^~ /health/status { alias /usr/local/share/httpd/default-health/status.json; }
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
printf '%s\n' "Updating the env file"
mkdir -p "$STATICDIR"
echo "# Settings for $APPNAME" >"$STATICDIR/.env"
echo "STATICSITE=\"$STATICSITE\"" >>"$STATICDIR/.env"
echo "APACHE_USER=\"$APACHE_USER\"" >>"$STATICDIR/.env"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -n "$(command -v update-ip 2>/dev/null)" ]; then
  update-ip >/dev/null
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -n "$APACHE_USER" ]; then
  printf '%s\n' "Setting up for Apache user: $APACHE_USER" | tee -a "$LOG_FILE"
  chown -Rf "$APACHE_USER":"$APACHE_USER" "$STATICWEB"
  chown -Rf "$APACHE_USER":"$APACHE_USER" "$STATICDIR"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
printf '%s\n' "Web assets has been setup" | tee -a "$LOG_FILE"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# End
