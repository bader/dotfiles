#!/usr/bin/env bash

set -euo pipefail

if command -v pacman >/dev/null 2>&1; then
  sudo pacman -S --needed --noconfirm curl ripgrep tar
elif command -v apt-get >/dev/null 2>&1; then
  sudo apt-get install -y curl ripgrep tar
else
  printf '%s\n' 'error: install OpenCode manually; no supported package manager found' >&2
  exit 1
fi

curl -fsSL https://opencode.ai/install | bash -s -- --no-modify-path
