# kubespray-ansible-executor-for-jetson
kubespray-ansible-executor-for-jetson は jetson 上に kubernetes cluster を構築するためのツールです。

## 確認済み動作環境
- Jetson Xavier NX（Jetpack 4.6.2）
- Jetson Xavier AGX（Jetpack 4.6.2）

## 事前準備
### mac
[mac の場合はこちら](docs/mac.md)

### env の設定
env.json5.sample から env.json5 を複製して用意してください。
- user
  - ansible をあてるための ssh username
- executionPath
  - kubespray の git clone した場所

### nameserver の追加
各 Jetson 端末の resolv.conf を書き換えてください。
#### ルートユーザーに切り替え
```
sudo su -
```

#### 書き換え
```
echo 'nameserver 8.8.8.8' >> /etc/resolvconf/resolv.conf.d/head
servie resolvconf restart
```

### inventory の設定
#### 作成
inventory の情報ファイルを生成してください。
```
make copy-inventory
```

#### ip address のセットアップ
inventory に 対象の ip address を追加してください。
```
declare -a IPS=(192.168.100.101 192.168.100.102 192.168.100.103)
CONFIG_FILE=inventory/mycluster/hosts.yml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```

#### hosts を設定
「inventory/mycluster/hosts.yml」の設定ファイルの control plane と worker の設定を行ってください。

### cri-dockerd 対応
#### group_vars
kuberspray 公式の「docs/docker.md」のドキュメントに沿って cri-dockerd に対応させるようにします。
生成された「inventory/mycluster/group_vars/all/docker.yml」配下の対象設定項目を差し替えます。

#### container_manager
各ファイルで設定している container_manager の設定項目を docker に差し替えます。
- inventory/mycluster/group_vars/all/etcd.yml
- inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml

### kube-proxy mode を iptables に変更
kube_proxy_mode を iptables に変更してください。
- roles/kubespray-defaults/defaults/main.yaml
- inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml

### 構築
ansible-playbook を実行します。
```
make execute
```



