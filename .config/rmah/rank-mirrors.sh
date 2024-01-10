#!/bin/bash

MR_LST='/etc/pacman.d/mirrorlist'
TMP_MRL='/tmp/ranking-mirrorlist'
MR_NUM=5

[ -f "${MR_LST}.pacnew"  ] && mrl="${MR_LST}.pacnew" || mrl="${MR_LST}"

# Rank all mirrors.
/usr/bin/sed 's/#Server/Server/' "${mrl}" > "${TMP_MRL}"
/usr/bin/rankmirrors -n "${MR_NUM}" "${TMP_MRL}" > "${MR_LST}" &&
  /usr/bin/rm "${TMP_MRL}"

[ -f "${MR_LST}.pacnew" ] && /usr/bin/rm "${MR_LST}.pacnew"

unset MR_LST TMP_MRL mrl

# vim: ft=sh
