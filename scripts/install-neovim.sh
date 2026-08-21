#!/usr/bin/env bash

set -euo pipefail

if command -v nvim >/dev/null 2>&1; then
  exit 0
fi

if command -v pacman >/dev/null 2>&1; then
  sudo pacman -S --needed --noconfirm neovim
  exit 0
fi

if ! command -v apt-get >/dev/null 2>&1; then
  printf '%s\n' 'error: install Neovim manually; no supported package manager found' >&2
  exit 1
fi

if [[ "$(uname -m)" != "x86_64" ]]; then
  printf '%s\n' 'error: automatic Ubuntu installation supports x86_64 only' >&2
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y curl
fi

tmpdir="$(mktemp -d)"
trap 'rm -rf "${tmpdir}"' EXIT
archive="${tmpdir}/nvim.tar.gz"
curl -fL --retry 3 -o "${archive}" \
  https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar -C "${tmpdir}" -xzf "${archive}"

install_dir="${HOME}/.local/share/neovim/nvim-linux-x86_64"
mkdir -p "${HOME}/.local/share/neovim" "${HOME}/.local/bin"
rm -rf "${install_dir}"
mv "${tmpdir}/nvim-linux-x86_64" "${install_dir}"
ln -sfn "${install_dir}/bin/nvim" "${HOME}/.local/bin/nvim"
