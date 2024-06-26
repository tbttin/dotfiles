#!/bin/bash

MR_NUM=3
MR_URL='https://archlinux.org/mirrorlist/'
URL_PARAMS=(
  'country=all'
  'protocol=https'
  'use_mirror_status=on'
)

MRL='/etc/pacman.d/mirrorlist'
TMP_DIR=$(/usr/bin/mktemp -d '/tmp/rmd.XXXXXXXXXX')
NEW_MRL=$(/usr/bin/mktemp "${TMP_DIR}/nm.XXXXXXXXXX")
RANK_MRL=$(/usr/bin/mktemp "${TMP_DIR}/rm.XXXXXXXXXX")

err() {
  echo "$1" >&2
  exit 1
}

# test -w "${MRL}" || err "${MRL}: do not have permission to write."

# Delete temp files when exit/kill/crash?
# See https://unix.stackexchange.com/a/181938
exec 3>"${NEW_MRL}"  4<"${NEW_MRL}"
exec 5>"${RANK_MRL}" 6<"${RANK_MRL}"
/usr/bin/rm -rf "${TMP_DIR}"

/usr/bin/curl -s "${MR_URL}" ${URL_PARAMS[@]/#/-d} >&3 ||
  err 'curl: Fail to retrieve mirrorlist data.'
/usr/bin/sed -e 's/^#Server/Server/' -e '/^#/d' <&4 |
  /usr/bin/rankmirrors -n "${MR_NUM}" - >&5 ||
  err 'rankmirrors: Invalid mirrorlists.'
/usr/bin/cat <&6 >"${MRL}"

unset MR_URL URL_PARAMS MR_NUM MRL TMP_DIR NEW_MRL RANK_MRL

# vim: ft=sh

