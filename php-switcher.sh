#!/bin/bash

main() {
  if [ $# -eq 0 ]; then
    usage
  fi

  initialize $1
  validate_version $next_version
  switch_php
  create_symlink
  apache_restart
}

initialize() {
  NEXT_VERSION=$1
  CURRENT_VERSION=php`php -v | head -1 | sed 's/PHP \([0-9]\).\([0-9]*\).*/\1\2/'`
  VERSIONS=`brew list | grep -e "php\d*$"`
}

validate_version() {
  local i=0
  for val in ${VERSIONS[@]}; do
    if [[ $val = $NEXT_VERSION ]]; then
      return 0;
    fi
  done
  abnormal_end 1 "The version ($NEXT_VERSION) is not existed."
}

switch_php() {
  echo "Switching from $CURRENT_VERSION to $NEXT_VERSION."
  brew unlink $CURRENT_VERSION && brew link $NEXT_VERSION
  echo
}

create_symlink() {
  local symlink=/usr/local/lib/php/libphp5.so
  local lib_path="/usr/local/opt/${NEXT_VERSION}/libexec/apache2/libphp5.so"
  echo "Creating symlink: $symlink"
  echo "ln -sf $lib_path $symlink"
  ln -sf $lib_path $symlink
  echo
}

apache_restart() {
  echo "Restarting apache"
  sudo apachectl -k restart
}

abnormal_end() {
  echo -n 'Error: '
  echo $2
  echo
  exit $1
}

usage() {
  echo "usage: $0 [php formula name]"
  exit 0
}

main $1
