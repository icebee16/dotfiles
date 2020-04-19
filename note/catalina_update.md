# Catalina Update

date 2020/04/19

## outline
- Catalinaのアップデートでpython環境が壊れて再インストールが必要になった
- ついでに２年ぶりの環境刷新をすることに
- neovim: 補完をdeoplete, jedi-vimからlsp
- python: pyenv onlyのgrobalのみの管理からpoetry導入

## memo
- numpy, scipyのMKL対応は妥協 > そもそもmacbook側でそんなに速度が必要になるような計算はさせない
- 信教の理由でanacondaは使わない > MKLを妥協した場合はpipベースのほうが管理しやすいので楽
- pythonの環境が今回は主眼，特にneovimの補完機能からプロジェクトごとのpythonライブラリが見えるように
