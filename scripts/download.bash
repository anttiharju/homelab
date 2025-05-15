#!/usr/bin/env bash
set -euo pipefail

basename "$(dirname "$1")"
eval "$1"
