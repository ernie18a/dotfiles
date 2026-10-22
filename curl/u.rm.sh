#!/usr/bin/env bash
# 只保留認證、uli、skill、設定與執行所需檔案，其餘紀錄全刪
set -e
shopt -s nullglob dotglob extglob
r=~/.codex/packages/app-server-daemon
c=$(readlink -e "$r/current")
rm -rf -- "$r"/releases/!(${c##*/})
rm -rf -- ~/.codex/!(auth.json|config.toml|AGENTS.md|skills|rules|plugins|packages|installation_id|version.json|.personality_migration|.sandbox_migration|app-server-control|app-server-daemon|mcp-oauth-locks)
rm -rf -- ~/.claude/!(.credentials.json|settings.json|CLAUDE.md|skills|plugins|daemon|sessions|state)
rm -rf -- ~/.gemini/!(GEMINI.md|skills|config|antigravity-cli|settings.json|oauth_creds.json|google_accounts.json|installation_id|.env)
rm -rf -- ~/.gemini/antigravity-cli/!(antigravity-oauth-token|settings.json|bin|builtin|mcp|installation_id|jetski_state.pbtxt|updater|cache)
rm -f -- ~/.gemini/antigravity-cli/cache/{conversation_metadata,last_conversations}.json
