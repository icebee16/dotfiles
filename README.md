# 🛠️ dotfiles

個人の開発環境セットアップを自動化・再現性高く行うための `dotfiles` リポジトリです。
**Neovim（Lua構成）・zsh（sheldon）・pyenvベースのPython環境・tmux** などのセットアップを主に対象としています。

---

## 📦 対応環境

* OS: macOS（Intel / Apple Silicon 両対応）
* Shell: zsh
* エディタ: Neovim (>= 0.9)
* Python: pyenv 経由でインストールした任意のバージョン（推奨: 3.11系）

---

## 🚀 セットアップ手順

初期セットアップは以下のステップで行います。

### 🔧 1. 必須要件の確認（手動）

最初に以下が手元で導入されていることを確認してください：

* **Xcode Command Line Tools**

```bash
xcode-select --install
```

* **Homebrew**（未インストールの場合、以下を実行）

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

* **pyenv（Python環境管理）**:
  macOSの場合は、セットアップスクリプトが `pyenv` 自体を導入します。

---

### 🧰 2. セットアップスクリプトの実行

以下のコマンドを実行することで、主要な設定が整います：

```bash
cd ~/dotfiles
bash etc/macOS_setup.sh
```

このスクリプトでは以下を自動化しています：

* XDGディレクトリ作成
* Homebrewパッケージ導入
* Python（pyenv + Poetry + pipx）
* Neovimプラグイン設定（lazy.nvim, nvim-cmp, telescope など）
* zsh構成（sheldon, plugin設定, alias, option）
* 各種シンボリックリンクの配置

---

## 📁 ディレクトリ構成

```
dotfiles/
├── etc/                    # 初期セットアップスクリプト群
│   └── macOS_setup.sh
├── nvim/                   # Neovim設定（Luaベース）
│   ├── init.lua
│   └── lua/user/
│       ├── options.lua
│       ├── keymaps.lua
│       └── plugins/
│           ├── cmp.lua
│           ├── telescope.lua
│           └── ...
├── zsh/                    # zsh設定（XDG構成＋sheldon）
│   ├── .zshenv
│   ├── .zprofile
│   ├── .zshrc
│   ├── .zsh_plugins.toml
│   └── .zfunc/
├── tmux/                   # tmux設定
│   └── .tmux.conf
├── note/                   # セットアップ補足メモ
│   └── setup_cpu.md
├── README.md
└── LICENSE
```

---

## 🧪 テスト済み構成
(TBD)

---

## 📚 関連リンク

* [XDG Base Directory Spec (Arch Wiki)](https://wiki.archlinux.jp/index.php/XDG_Base_Directory)
* [pyenv GitHub](https://github.com/pyenv/pyenv)
* [sheldon GitHub](https://github.com/rossmacarthur/sheldon)
* [lazy.nvim](https://github.com/folke/lazy.nvim)

---

## 📄 ライセンス

MIT License

---

修正・提案等ございましたら、お気軽に Issue / PR にてご連絡ください。
