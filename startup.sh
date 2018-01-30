#!/bin/bash

set -eo pipefail

kubectl apply -f crd.yaml

exec side8-k8s-operator --resource dynamodbs --fqdn aws.microdc.io --version v1
