# Docker in Docker based Debian

A Docker image containing Docker and based on Debian.

Official `docker:dind` is using alpine and no Debian variant exists. Here's one.
This work is based on https://github.com/domofactor/dind-jessie.

## Usage
Flag `--privileged` required because of docker-inception.
```bash
docker run --rm -ti --privileged jaouan/dind
```

Use `DOCKER_EXTRA_OPTS` to push some options to Docker.
Default value is `--storage-driver=overlay`.
```bash
docker run --rm -ti --privileged -e DOCKER_EXTRA_OPTS="--storage-driver=overlay --insecure-registry=http://my-own-registry" jaouan/dind
```
