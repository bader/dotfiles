#!/usr/bin/env bash

set -euo pipefail

install_treesitter_cli() {
  local version='0.26.12'
  local archive="${TMPDIR:-/tmp}/tree-sitter-${version}-$$.gz"
  local checksum='d00ac0daefc4bf8c4b57842a5c0509927232faad1d83157b64fbad4e2e8d9a8b'

  mkdir -p "${HOME}/.local/bin"
  curl -fL --retry 3 -o "${archive}" \
    "https://github.com/tree-sitter/tree-sitter/releases/download/v${version}/tree-sitter-linux-x64.gz"
  printf '%s  %s\n' "${checksum}" "${archive}" | sha256sum -c -
  gunzip -c "${archive}" > "${HOME}/.local/bin/tree-sitter"
  chmod 755 "${HOME}/.local/bin/tree-sitter"
  rm -f "${archive}"
}

nvim_is_current=false
if command -v nvim >/dev/null 2>&1; then
  nvim_version="$(nvim --version 2>/dev/null || true)"
  if [[ "${nvim_version}" =~ NVIM\ v([0-9]+)\.([0-9]+) ]] \
    && (( BASH_REMATCH[1] > 0 || BASH_REMATCH[2] >= 11 )); then
    nvim_is_current=true
  fi
fi

if command -v pacman >/dev/null 2>&1; then
  packages=(nodejs npm tree-sitter-cli unzip)
  if [[ "${nvim_is_current}" != true ]]; then
    packages+=(neovim)
  fi
  sudo pacman -S --needed --noconfirm "${packages[@]}"
  exit 0
fi

if ! command -v apt-get >/dev/null 2>&1; then
  printf '%s\n' 'error: install Neovim manually; no supported package manager found' >&2
  exit 1
fi

if [[ "${nvim_is_current}" == true ]]; then
  sudo apt-get install -y curl gzip nodejs npm unzip
  install_treesitter_cli
  exit 0
fi

if [[ "$(uname -m)" != "x86_64" ]]; then
  printf '%s\n' 'error: automatic Ubuntu installation supports x86_64 only' >&2
  exit 1
fi

sudo apt-get install -y curl gzip nodejs npm unzip
install_treesitter_cli

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
