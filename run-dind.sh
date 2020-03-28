#!/bin/bash
echo "[docker] Launching the Docker daemon..."
set -e
dind dockerd $DOCKER_EXTRA_OPTS &
while(! docker info > /dev/null 2>&1); do
    echo "[docker] waiting..."
    sleep 1
done
echo "[docker] Docker is up !"