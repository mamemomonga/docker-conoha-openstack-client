# ConoHaでOpenStack-CLIを使う

DockerでPython3実行環境を用意し、OpenStack-CLIを使えるようにします。

## 用意するもの

* Docker
* Bash
* ConoHaアカウント

### 1. 接続設定

ConoHaコンソールにログインし、API情報のページでAPIユーザを作成します

### 2. openrc.env を作成

以下の内容を参考にして、このプロジェクトのルートに openrc.env を作成してください。

	# 設定情報は
	#   ConoHaコントロールパネル→API情報→APIユーザ
	#   https://manage.conoha.jp/API/
	# を参照して設定する
	
	# APIユーザ→ユーザ名
	OS_USERNAME=gncu00000000
	
	# APIユーザ→パスワード
	OS_PASSWORD=パスワード
	
	# テナント情報→テナントID
	OS_TENANT_ID=テナントID
	 
	# テナント情報→テナント名
	OS_TENANT_NAME=gnct00000000
	
	# エンドポイント→Identity Service
	OS_AUTH_URL=https://identity.tyo1.conoha.io/v2.0

### 3. コマンドの実行

以下のコマンドを実行
(PATHを追加, Dockerをビルド, openstackコマンド起動)

	$ scripts/build.sh
	$ eval $(scripts/env.sh)
	$ openstack
	(openstack) configuration show

quitで終了

	(openstack) quit

## インスタンスを起動してみる

https://docs.openstack.org/ja/user-guide/cli-launch-instances.html

	$ openstack flavor list | grep '512mb'

	+--------------------------------------+---------+-------+------+-----------+-------+-----------+
	| ID                                   | Name    |   RAM | Disk | Ephemeral | VCPUs | Is Public |
	+--------------------------------------+---------+-------+------+-----------+-------+-----------+
	| 294639c7-72ba-43a5-8ff2-513c8995b869 | g-2gb   |  2048 |   50 |         0 |     3 | True      |
	| 3aa001cd-95b6-46c9-a91e-e62d6f7f06a3 | g-16gb  | 16384 |   50 |         0 |     8 | True      |
	| 62e8fb4b-6a26-46cd-be13-e5bbf5614d15 | g-4gb   |  4096 |   50 |         0 |     4 | True      |
	| 7eea7469-0d85-4f82-8050-6ae742394681 | g-1gb   |  1024 |   50 |         0 |     2 | True      |
	| 965affd4-d9e8-4ffb-b9a9-624d63e2d83f | g-8gb   |  8192 |   50 |         0 |     6 | True      |
	| a20905c6-3733-46c4-81cc-458c7dca1bae | g-32gb  | 32768 |   50 |         0 |    12 | True      |
	| c2a97b05-1b4b-4038-bbcb-343201659279 | g-64gb  | 65536 |   50 |         0 |    24 | True      |
	| d92b02ce-9a4f-4544-8d7f-ae8380bc08e7 | g-512mb |   512 |   20 |         0 |     1 | True      |
	+--------------------------------------+---------+-------+------+-----------+-------+-----------+

	$ openstack image list | grep 'ubuntu-14.04-amd64'

	| c50d92b9-f9c8-4fb0-868c-5601f8c9195e | vmi-ubuntu-14.04-amd64-unified             | active |
	| c171aae7-d3b7-4776-b3df-9b4130d48019 | vmi-ubuntu-14.04-amd64-unified-20gb        | active |

	$ openstack keypair list

	+-------------------+-------------------------------------------------+
	| Name              | Fingerprint                                     |
	+-------------------+-------------------------------------------------+
	| mykeyname         |                                                 |
	+-------------------+-------------------------------------------------+
	
	$ openstack server create \
	  --flavor d92b02ce-9a4f-4544-8d7f-ae8380bc08e7 \
	  --image c171aae7-d3b7-4776-b3df-9b4130d48019 \
	  --key-name mykeyname \
		MyServerInstance

	$ openstack server list


## 参考URL

* [ConoHa API Documantation](https://www.conoha.jp/docs/)
* [OpenStack コマンドラインクライアント](https://docs.openstack.org/ja/user-guide/common/cli-install-openstack-command-line-clients.html)
* [ConoHa: ダッシュボード - API情報](https://manage.conoha.jp/API/)

