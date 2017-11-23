
start () {
  echo "START ========================" >&2
}

end () {
  echo "END ========================" >&2
}

export APP="${K8S_SPEC_APP:=none}"
export TTL_BOOLEAN="${K8S_SPEC_TTL_BOOLEAN}"
export TTL_ATTRIBUTE="${K8S_SPEC_TTL_ATTRIBUTE}"
export ENVIRONMENT="${K8S_SPEC_ENVIRONMENT:=none}"
export TABLE="${K8S_SPEC_TABLE:=none}"
export TABLE_NAME="${ENVIRONMENT}.${APP}.${TABLE}"
export CONFIG="$(echo $K8S_SPEC_CONFIG | envsubst)"
export DEBUG="${K8S_SPEC_DEBUG:=false}"

if [[ "$DEBUG" ]]; then
  cat >&2 << EOF
APP=${APP}
TTL_BOOLEAN=${TTL_BOOLEAN}
TTL_ATTRIBUTE=${TTL_ATTRIBUTE}
ENVIRONMENT=${ENVIRONMENT}
TABLE=${TABLE}
TABLE_NAME=${TABLE_NAME}
CONFIG=${CONFIG}
DEBUG=${DEBUG}
EOF

fi

