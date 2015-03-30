DockerでBlue Green Deploymentのサンプル
==========================

## Info

当サンプルは以下の構成で動きます。

| 192.168.33.99:80（不変）| Nginx | Ubuntu | VirtualBox(Vagrant) | 
| :9999（ポート変動）     | Go    | Ubuntu | Docker              |

## 準備

```
$ git clone https://github.com/shinofara/docker-deploy-sample.git
$ cd docker-deploy-sample
```

## リバースプロキシ兼、作業用環境構築

ubuntuをvirtualbox内に立ち上げる

```
$ vagrant up
```

http://192.168.33.99  
でNginxが起動している事を確認できると思います。  
が、ここで起動してるNginxはリバースプロキシでしか無いので、エラーとなります。


### 作業用環境内に、アプリケーションサーバを構築

ubuntu環境にssh

```
$ vagrant ssh
```

作業準備

```
$ sudo su
$ cd /working
```

Dockerイメージを構築

```
$ ./build.sh
```

作成したImageを元にコンテナを立ち上げ、アプリケーションをDeploy

```
$ ./deploy.sh
```

dockerコンテナが立ち上がった事を確認  
立ち上がったポート番号が毎回変わる事を確認できます。

```
$ docker ps
```

## Version

| version | 構成           | URL                                                           |
| ------- | -------------- | ------------------------------------------------------------- |
| v1.1.0  | Nginx -> Go    | https://github.com/shinofara/docker-deploy-sample/tree/v1.1.0 |
| v1.0.0  | Nginx -> Nginx | https://github.com/shinofara/docker-deploy-sample/tree/v1.0.0 |
