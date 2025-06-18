# 📘 macOS新筆記セットアップログ (2025年6月)

## 概要

* **目的**: 2024年モデルMacBook Pro (Apple Silicon) への環境移行と開発環境の再構築
* **所要時間**: 総約5-6時間
* **dotfiles**: [icebee16/dotfiles](https://github.com/icebee16/dotfiles)
* **ベース方式**: XDG Base Directory + sheldon + lazy.nvim

---

## ステップ概要

### 1. 初期GUIセットアップ

* Apple ID / Wi-Fi / FileVault / Touch ID

### 2. Command Line Tools & Homebrew

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 3. dotfiles clone & セットアップ

```bash
git clone https://github.com/icebee16/dotfiles.git ~/dotfiles
zsh ~/dotfiles/etc/macOS_setup.sh
```

### 4. SSH Key & GitHub登録

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
pbcopy < ~/.ssh/id_ed25519.pub
# GitHub Web上でSSH key登録
```

### 5. pyenv + poetry + pipx

* Python 3.11.9 を pyenv 管理
* poetry で project は `.venv` 化
* pipx 経由で LSP, linters, kaggle-cli などを分離

### 6. Neovim

* Neovim 0.11.2 設置
* Lazy.nvim + Lua config を `~/dotfiles/nvim/` 下に配置
* Plugin 構成: cmp / treesitter / telescope / molokai etc.

### 7. gopass + GPG 移行

* 旧端末のGPG鍵を移行し、`gpg --import` 実行
* gopass clone により密語情報を復元

### 8. アプリ手動インストール

* Google Chrome (brew)
* Alfred, Karabiner-Elements (Web DL)
* iTerm2 (brew)

```bash
brew install --cask google-chrome iterm2
```

### 9. トラブル対応

* fzf プラグインの `invalid mode specification` エラー

  * sheldon管理からbrew管理に切り替え
* zsh の path サレンダーの違いを扱うため `.zprofile` で opt 配置を通す

---

## セットアップ完了後の環境

| カテゴリ       | 詳細                                                   |
| ---------- | ---------------------------------------------------- |
| Shell      | zsh + sheldon + XDG構成                                |
| Editor     | Neovim (0.11.2) + Lazy.nvim + Lua plugin             |
| Python     | pyenv (3.11.9) / poetry / pipx / uv                  |
| Terminal   | iTerm2 + tmux + fzf + fd + ripgrep                   |
| Password管理 | gopass + GitHub sync + 実用的GPG鍵復元                     |
| アプリ        | Chrome / Alfred / Karabiner-Elements （手動 or cask 管理） |
| GitHub連携   | SSH Key登録済 / Git config 完了                           |
| zsh構成      | .zshenv / .zprofile / .zshrc の分離構成、キービンド実装           |

---

## 今後のToDo (optional)

* [ ] Karabinerの設定プロファイル移行
* [ ] Neovim plugin lock file (ロード済) の検証
* [ ] dotfiles構成変更をREADMEに反映
* [ ] gpg-agent / pinentry 設定の変更の有無検討

---

以上
