#!/bin/bash

MR_LST='/etc/pacman.d/mirrorlist'
MR_NUM=5
NEW_MRL='/tmp/mirrorlist'
RANKED_MRL='/tmp/ranked-mirrorlist'

/usr/bin/curl -s 'https://archlinux.org/mirrorlist/' -o "${NEW_MRL}" \
              -d 'country=all' \
              -d 'protocol=https' \
              -d 'ip_version=4' \
              -d 'ip_version=6' \
              -d 'use_mirror_status=on'
/usr/bin/sed -e 's/^#Server/Server/' -e '/^#/d' -i "${NEW_MRL}"
/usr/bin/cp -f "${MR_LST}" "${MR_LST}~"
/usr/bin/rankmirrors -n "${MR_NUM}" "${NEW_MRL}" > "${RANKED_MRL}"
/usr/bin/cp -f "${RANKED_MRL}" "${MR_LST}" 

/usr/bin/rm "${NEW_MRL}" "${RANKED_MRL}" 
unset MR_LST MR_NUM NEW_MRL RANKED_MRL

# vim: ft=sh
