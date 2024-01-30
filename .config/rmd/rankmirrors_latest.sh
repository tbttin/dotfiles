#!/bin/bash

MR_LST='/etc/pacman.d/mirrorlist'
MR_NUM=5
NEW_MRL='/tmp/mirrorlist'
RANK_MRL='/tmp/rank-mirrorlist'
/usr/bin/curl -s 'https://archlinux.org/mirrorlist/' \
              -d 'country=all' \
              -d 'protocol=https' \
              -d 'ip_version=4' \
              -d 'ip_version=6' \
              -d 'use_mirror_status=on' \
              -o "${NEW_MRL}"
/usr/bin/sed -e 's/^#Server/Server/' -e '/^#/d' -i "${NEW_MRL}"
/usr/bin/cp -f "${MR_LST}" "${MR_LST}.bak"
if /usr/bin/rankmirrors -n "${MR_NUM}" "${NEW_MRL}" > "${RANK_MRL}" ; then
  /usr/bin/cp -f "${RANK_MRL}" "${MR_LST}"
  /usr/bin/rm  "${MR_LST}.bak"
else
  /usr/bin/echo "rankmirrors: error"
fi
/usr/bin/rm "${NEW_MRL}" "${RANK_MRL}"
unset MR_LST MR_NUM NEW_MRL RANK_MRL

# vim: ft=sh
