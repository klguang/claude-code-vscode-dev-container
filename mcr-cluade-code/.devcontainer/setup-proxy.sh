#!/usr/bin/env bash

set -euo pipefail

sync_git_proxy() {
  local key="$1"
  local value="${2:-}"

  if [[ -n "$value" ]]; then
    git config --global "$key" "$value"
  else
    git config --global --unset-all "$key" 2>/dev/null || true
  fi
}

sync_git_proxy "http.proxy" "${HTTP_PROXY:-}"
sync_git_proxy "https.proxy" "${HTTPS_PROXY:-}"
