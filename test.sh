#!/bin/bash

check_dependancy() {
  local DEPENDANCY="${1}"
  if ! command -v "${DEPENDANCY}" >/dev/null 2>&1; then
    err "${DEPENDANCY} is required but not installed.  Aborting."
    exit 1
  fi
}

err() {
  echo -e "[ERR] ${1}"
}

log() {
  echo -e "[LOG] ${1}"
}

test_shell_files () {
  log "Testing shell files"
  grep -Rl '/bin/bash' * | xargs shellcheck
}

test_yaml_files () {
  log "Testing yaml files"
  for file in $(find . -name '*.y*ml'); do
    python -c 'import yaml,sys;yaml.safe_load(sys.stdin)' < $file || err "${file} has syntax errors"
  done
}

main () {
  check_dependancy shellcheck
  check_dependancy python
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
