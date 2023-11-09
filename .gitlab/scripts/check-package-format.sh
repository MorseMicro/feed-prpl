#!/bin/bash

shopt -s lastpipe
ret=0

category_failed=$(grep -Lr --include="Makefile" "CATEGORY\s*:=\s*prpl Foundation$" feeds/ci || true)
if test -n "$category_failed"; then
  echo -e " *** ERROR: detected CATEGORY issues in the following packages:\n"
  for package in $category_failed; do
    grep -H CATEGORY "$package" || true
  done
  echo -e "\nOnly prpl Foundation category is accepted, please fix that."
  ret=$((ret+1))
fi

submenu_failed=$(find feeds/ci -name 'Makefile' -exec grep -LE 'SUBMENU\s*:=\s*(Ambiorix|gMap|Libraries|Life Cycle Management \(LCM\)|Modules|Netmodel|prplMesh|TR-181 Managers|Upstream Backports/Forks|Utilities)$' {} \; || true)
if test -n "$submenu_failed"; then
  echo -e " *** ERROR: detected SUBMENU issues in the following packages:\n"
  for package in $submenu_failed; do
    grep -H SUBMENU "$package" || true
  done
  echo -e "\nOnly following SUBMENUs are acceptable:\n"
  echo -e "\n * Ambiorix\n * gMap \n * Libraries\n * Life Cycle Management (LCM)\n * Modules\n * Netmodel\
           \n * prplMesh\n * TR-181 Managers\n * Upstream Backports/Forks\n * Utilities\n"
  ret=$((ret+1))
fi

grep -lr --include="Makefile" PKG_NAME feeds/ci | while read -r makefile; do
  dir=$(dirname "$makefile")
  name=$(make -s TOPDIR="$(pwd)" -C "$(pwd)/$dir" -f "$(pwd)/$makefile" val.PKG_NAME 2>/dev/null)
  title=$(make -s TOPDIR="$(pwd)" -C "$(pwd)/$dir" -f "$(pwd)/$makefile" val.TITLE 2>/dev/null)

  if [ -z "$name" ]; then
    echo " *** ERROR: $makefile: has PKG_NAME missing?!"
    ret=$((ret+1))
  fi

  if [ -z "$title" ]; then
    echo " *** ERROR: $makefile: has TITLE missing?!"
    ret=$((ret+1))
  fi

  name_title="$name $title"
  if [ ${#name_title} -gt 71 ]; then
    name_len=${#name}
    title_len=$((71-name_len))
    echo " *** ERROR: $makefile: PKG_NAME + TITLE > 71 characters, making TITLE invisible, shorten it."
    echo "            Proposed TITLE: ${title:0:$title_len}"
    ret=$((ret+1))
  fi
done

exit $ret
