#!/bin/zsh
# Publish the site to its server: nginx in CT 104 (solitaire-web) on Proxmox, behind Nginx Proxy Manager,
# live at https://solitaire.nailhome.net/. Copies the committed pages (not the working tree) and swaps them in at once.
# Usage: tools/deploy.sh
set -euo pipefail
cd "${0:A:h}/.."
PVE=root@10.0.0.10
CT=104
[[ -z $(git status --porcelain) ]] || { echo "Commit first: the server gets the committed pages."; exit 1; }

git archive HEAD index.html style.css privacy support terms | ssh $PVE "pct exec $CT -- sh -c '
  set -e
  rm -rf /var/www/solitaire.new && mkdir -p /var/www/solitaire.new
  tar -x -C /var/www/solitaire.new
  chmod -R a+rX /var/www/solitaire.new
  rm -rf /var/www/solitaire.old
  [ -d /var/www/solitaire ] && mv /var/www/solitaire /var/www/solitaire.old
  mv /var/www/solitaire.new /var/www/solitaire
'"
for page in / /privacy/ /support/ /terms/; do
  printf '%-10s %s\n' $page "$(curl -s -o /dev/null -w '%{http_code}' http://10.0.0.131$page)"
done
echo "Deployed $(git rev-parse --short HEAD)."
