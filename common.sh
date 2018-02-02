#!/bin/bash

start () {
  echo "START ========================" >&2
}

end () {
  echo "END ========================" >&2
}

if [[ -n "${DEBUG}" ]]; then
  env >&2
  set -vx
fi

set -eo pipefail
