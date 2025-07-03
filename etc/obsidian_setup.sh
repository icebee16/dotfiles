#!/bin/bash

#----------------------#
#   Setup Script for   #
#     macOS (zsh)      #
#----------------------#

set -eu

#----------------------#
#     0. CONSTANTS     #
#----------------------#
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

ICLOUD_OBSIDIAN_DIR="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents"
FALLBACK_VAULT_DIR="$HOME/Documents/vault"

#----------------------#
#     1. VAULT PATH    #
#----------------------#

if [ -d "$ICLOUD_OBSIDIAN_DIR" ]; then
  VAULT_DIR="$ICLOUD_OBSIDIAN_DIR/vault"
  SYMLINK_PATH="$FALLBACK_VAULT_DIR"
  echo "[info] iCloud Obsidian ディレクトリが見つかりました: $ICLOUD_OBSIDIAN_DIR"
else
  VAULT_DIR="$FALLBACK_VAULT_DIR"
  SYMLINK_PATH=""
  echo "[info] iCloud Obsidian ディレクトリが見つかりません。Documents以下に作成します。"
fi

#----------------------#
#   2. MAKE STRUCTURE  #
#----------------------#

mkdir -p "$VAULT_DIR"/{00_inbox,10_work,11_dev,20_books,30_thoughts,40_logs/llm,40_logs/superwhisper,40_logs/zoom,daily,templates,attachments}
echo "[done] Obsidian vault directory structure created at: $VAULT_DIR"

#----------------------#
#   3. MAKE SYMLINK    #
#----------------------#

if [ -n "$SYMLINK_PATH" ]; then
  if [ -e "$SYMLINK_PATH" ]; then
    echo "[warn] $SYMLINK_PATH が既に存在しています。シンボリックリンクの作成をスキップします。"
  else
    ln -s "$VAULT_DIR" "$SYMLINK_PATH"
    echo "[done] シンボリックリンク作成: $SYMLINK_PATH → $VAULT_DIR"
  fi
fi

#----------------------#
#   4. COPY TEMPLATES  #
#----------------------#
# TODO: dotfiles/templates から $VAULT_DIR/templates に必要なmdファイルをコピー
# 例: cp "$DOTFILES/templates/*.md" "$VAULT_DIR/templates/"

#----------------------#
#  5. INIT TAGS.YAML   #
#----------------------#
# TODO: $VAULT_DIR/tags.yaml を生成（初期定義あり or 空ファイル）
# 例: cp "$DOTFILES/etc/tags.yaml" "$VAULT_DIR/tags.yaml"
