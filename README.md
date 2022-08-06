
![Logo](https://github.com/StarRocks/starrocks/raw/main/images/logo.png)


# StarRocks Docker Dev

Setup your StarRocks development just in one docker container!

## Features

- Built-in thirdparty, you don't need to compile it by yourself
- Use [mold](https://github.com/rui314/mold) to make BE link faster
- Built-in GDB, GDB Server module, support BE debug operation
- Built-in tmux, mysql-client
## Usage

1. Pull Docker image: `sudo docker pull d87904488/starrocks-docker-dev:main` .

2. Run container

```bash
sudo docker run -it -p 2222:2222 \
  --privileged \
  --cap-add SYS_PTRACE \
  -v ~/.m2:/root/.m2 \
  -v /home/smith/starrocks:/root/starrocks \
  --name smith-dev \
  -d d87904488/starrocks-docker-dev:main
```

**Notice: You should mount .m2 and source code folder. Otherwise your code and jar will not be persisted.**

`--privileged  --cap-add SYS_PTRACE` is necessary for GDB.

3. Enjoy it, you can use ssh to connect container: `sudo ssh root@localhost -p 2222`.


## FAQ

#### How to development?

You can use **VS Code Remote Development**, **JetBrains Gateway**, **Clion**, **IDEA** or **VIM**.

#### Some header/class not found?

You need generate to Thrift and Protobuf by yourself. The simplest way is that you run command `sh build.sh` in container first, then copy gensrc from container to local directory.

#### How to development with other components?

Maybe you need to development with Hive, Hadoop, ElasticSearch and ..., you can use `docker network` to setup network easily!

#### 看不懂英文？

[https://www.inlighting.org/archives/setup-starrocks-development](https://www.inlighting.org/archives/setup-starrocks-development)
