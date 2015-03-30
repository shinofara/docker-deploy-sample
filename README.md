DockerでBlue Green Deploymentのサンプル
==========================

## Info

当サンプルは以下の構成で動きます。

| 192.168.33.99:80（不変）| Nginx | Ubuntu | VirtualBox(Vagrant) | 
| :9999（ポート可変）     | Nginx | Ubuntu | Docker              |

## リバースプロキシ構築

ubuntuをvirtualbox内に立ち上げる

```
$ vagrant up
```

http://192.168.33.99  
でNginxが起動している事を確認できると思います。  
が、ここで起動してるNginxはリバースプロキシでしか無いので、エラーとなります。


## アプリケーションサーバを構築

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




