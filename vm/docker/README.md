2019/9/1
* 参考 https://www.runoob.com/docker/docker-install-redis.html


## docker 简介

* images: 相当于源文件
* docker: 正在跑的镜像实例。一个镜像可以有多个实例。

### docker常用命令
``` cmd
$ docker --help
Usage: docker [OPTIONS] COMMAND [arg...]
       docker [ -h | --help | -v | --version ]

A self-sufficient runtime for containers.

Options:

  --config=%USERPROFILE%\.docker                                       Location of client config files
  -D, --debug=false                                                    Enable debug mode
  -H, --host=[]                                                        Daemon socket(s) to connect to
  -h, --help=false                                                     Print usage
  -l, --log-level=info                                                 Set the logging level
  --tls=false                                                          Use TLS; implied by --tlsverify
  --tlscacert=%USERPROFILE%\.docker\machine\machines\default\ca.pem    Trust certs signed only by this CA
  --tlscert=%USERPROFILE%\.docker\machine\machines\default\cert.pem    Path to TLS certificate file
  --tlskey=%USERPROFILE%\.docker\machine\machines\default\key.pem      Path to TLS key file
  --tlsverify=true                                                     Use TLS and verify the remote
  -v, --version=false                                                  Print version information and quit

Commands:
    attach    Attach to a running container
    build     Build an image from a Dockerfile
    commit    Create a new image from a container's changes
    cp        Copy files/folders from a container to a HOSTDIR or to STDOUT
    create    Create a new container
    diff      Inspect changes on a container's filesystem
    events    Get real time events from the server
    exec      Run a command in a running container
    export    Export a container's filesystem as a tar archive
    history   Show the history of an image
    images    List images
    import    Import the contents from a tarball to create a filesystem image
    info      Display system-wide information
    inspect   Return low-level information on a container or image
    kill      Kill a running container
    load      Load an image from a tar archive or STDIN
    login     Register or log in to a Docker registry
    logout    Log out from a Docker registry
    logs      Fetch the logs of a container
    pause     Pause all processes within a container
    port      List port mappings or a specific mapping for the CONTAINER
    ps        List containers
    pull      Pull an image or a repository from a registry
    push      Push an image or a repository to a registry
    rename    Rename a container
    restart   Restart a running container
    rm        Remove one or more containers
    rmi       Remove one or more images
    run       Run a command in a new container
    save      Save an image(s) to a tar archive
    search    Search the Docker Hub for images
    start     Start one or more stopped containers
    stats     Display a live stream of container(s) resource usage statistics
    stop      Stop a running container
    tag       Tag an image into a repository
    top       Display the running processes of a container
    unpause   Unpause all processes within a container
    version   Show the Docker version information
    wait      Block until a container stops, then print its exit code

Run 'docker COMMAND --help' for more information on a command.

```


## docker镜像
使用Dockerfile创建docker镜像

### 镜像列表
$ docker images

* ubuntu
* reids
* nginx
* mysql
* php


### 镜像使用

* ubuntu
* reids
* nginx
* mysql
* php
