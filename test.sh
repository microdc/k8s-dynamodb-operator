#!/bin/bash

check_dependancy() {
  local DEPENDANCY="${1}"
  command -v "${DEPENDANCY}" >/dev/null 2>&1 || err "${DEPENDANCY} is required but not installed.  Aborting."
}

err() {
  echo -e "[ERR] ${1}"
  exit 1
}

log() {
  echo -e "[LOG] ${1}"
}

test_shell_files () {
  log "Testing shell files"
  grep -Rl '/bin/bash' ./* | xargs shellcheck || err "Shellcheck errors"
}

test_yaml_files () {
  log "Testing yaml files"
  yamllint .
}

main () {
  check_dependancy shellcheck
  check_dependancy python3
  case $1 in
    shell)
        test_shell_files
        ;;
    yaml)
        test_yaml_files
        ;;
    *)
        test_shell_files
        test_yaml_files
        ;;
    esac
}

main "$@"
