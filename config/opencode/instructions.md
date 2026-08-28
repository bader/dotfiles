# OpenCode Instructions

## GitHub

Use `gh api` for GitHub issue operations. Do not use `gh issue view`, because
it queries the deprecated Projects (classic) GraphQL API for this account.

## OpenCode Configuration

When reading or modifying OpenCode configuration, first inspect
`$OPENCODE_CONFIG`. If it is set, treat that file as authoritative and never
assume the default `~/.config/opencode/opencode.json` path.
