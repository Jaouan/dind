FROM debian:stretch-slim

ARG DOCKER_CHANNEL=stable
ARG DOCKER_VERSION=18.06.3~ce~3-0~debian
ARG DOCKER_COMPOSE_VERSION=1.25.4
ARG DIND_COMMIT=37498f009d8bf25fbb6199e8ccd34bed84f2874b

ENV DOCKER_EXTRA_OPTS='--storage-driver=overlay'

# Docker.
RUN apt-get update \
  && apt-cache madison docker-ce \
  && apt-get install -y --no-install-recommends \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
  && add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   ${DOCKER_CHANNEL}" \
  && apt-get update \
  && apt-get install -y --no-install-recommends docker-ce=${DOCKER_VERSION} \
  && docker -v \
  && dockerd -v \
# Compose.
  && curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose \
  && chmod +x /usr/local/bin/docker-compose \
# DinD.
  && curl -fL -o /usr/local/bin/dind "https://raw.githubusercontent.com/moby/moby/${DIND_COMMIT}/hack/dind" \
  && chmod +x /usr/local/bin/dind

COPY ./run-dind.sh /root/

CMD ["bash", "-e", "/root/run-dind.sh"]
