#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

curl -L https://github.com/rancher/system-upgrade-controller/releases/download/v0.15.2/system-upgrade-controller.yaml -o ./system-upgrade-controller.yml
