# mac で実行するための事前準備

## ansible の install
ansible で kuberspray を実行するのは ansbile のバージョンに依存があります。

### pyenv の場合
pyenv versions でまず 3.8.5 （おそらく 3.8 以上にする）にします。
python のバージョンを 3.8.5 に切り替えてください。

### kubespray の requirements.txt のインストール
まず、pip の依存関係でエラーになってしまうので、pip を除いて venv 環境を作成します。
```
python3.8 -m venv --without-pip ansiblePlaybook
aource ansiblePlaybook/bin/activate
```

### pip command をインストール
pip command をインストールします。
```
wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
```

### kubespray の package をインストール
```
python3 -m pip install -r requirements.txt
```
