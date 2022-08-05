# StarRocks Docker Dev
Setup your StarRocks development in one docker container!

## Features

* Use official docker image, you don't need to build thirdparty by yourself.
* Use GCC mold to link, make BE build faster!
* Built-in GDB, GDB Server module, support Debug operation.
* Built-in tmux, mysql-client assisted development.
* Ignore port conflicts.

## Usage

1. Pull latest Docker image

`sudo docker pull d87904488/starrocks-docker-dev`

2. Run container

```bash
sudo docker run -it -p 2222:2222 \
  --privileged \
  --cap-add SYS_PTRACE \
  -v ~/.m2:/root/.m2 \
  -v /home/smith/starrocks:/root/starrocks \
  --name smith-dev \
  -d smith/sr-dev
```

**Notice: You should mount .m2 and source code folder. Otherwise your code and jar will not be persisted.**

If you want to use GDB, `--privileged  --cap-add SYS_PTRACE ` is necessary.

3. Use ssh to connect container

`sudo ssh root@localhost -p 2222`

## How to Development?

* You can use **VS Code Remote Development**, **JetBrains Gateway**, **Clion**, **IDEA** or **VIM**.
* Maybe you need to development with Hive, Hadoop, ElasticSearch... You can use `docker network` to setup network easily!

## Last

Enjoy it !
