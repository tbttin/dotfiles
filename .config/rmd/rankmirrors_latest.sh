#!/bin/bash

MR_NUM=5
MR_URL='https://archlinux.org/mirrorlist/'
URL_PARAMS=(
  'country=all'
  'protocol=https'
  'ip_version=4'
  'ip_version=6'
  'use_mirror_status=on'
)

MRL='/etc/pacman.d/mirrorlist'
TMP_DIR=$(/usr/bin/mktemp -d '/tmp/rmd.XXXXXXXXXX')
NEW_MRL=$(/usr/bin/mktemp "${TMP_DIR}/nm.XXXXXXXXXX")
RANK_MRL=$(/usr/bin/mktemp "${TMP_DIR}/rm.XXXXXXXXXX")

URL_PARAMS[0]='country=VN'
# MRL='./mirrorlist'

err() {
  echo "$1" >&2
  exit 1
}

# Delete temp files when exit/kill/crash?
# See https://unix.stackexchange.com/a/181938
exec 3>"${NEW_MRL}"  4<"${NEW_MRL}"
exec 5>"${RANK_MRL}" 6<"${RANK_MRL}"
/usr/bin/rm -rf "${TMP_DIR}"

/usr/bin/curl -s "${MR_URL}" ${URL_PARAMS[@]/#/-d} >&3 ||
  err 'curl: Network connection issue.'
/usr/bin/sed -e 's/^#Server/Server/' -e '/^#/d' <&4 |
  /usr/bin/rankmirrors -n "${MR_NUM}" - >&5 ||
  err 'rankmirros: Invalid mirrorlist file.'
/usr/bin/cat <&6 >"${MRL}"

unset MR_URL URL_PARAMS MR_NUM MRL TMP_DIR NEW_MRL RANK_MRL

# vim: ft=sh
