# # got from https://github.com/frol/docker-alpine-python3/blob/master/Dockerfile
# FROM alpine:3.9
# # RUN apk add --no-cache python3 && \
# #     python3 -m ensurepip && \
# #     rm -r /usr/lib/python*/ensurepip && \
# #     pip3 install --upgrade pip setuptools && \
# #     if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
# #     if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
# #     rm -r /root/.cache
# # RUN apk add build-base
# # RUN apk add gcc

# # FROM ubuntu:18.04

# # RUN apt-get update && \
# #     apt-get upgrade && \

# RUN apk add --no-cache python3 && \
#     python3 -m ensurepip && \
#     rm -r /usr/lib/python*/ensurepip && \
#     pip3 install --upgrade pip setuptools && \
#     if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
#     if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
#     rm -r /root/.cache
# RUN apk add build-base
# RUN apk add clang

# ADD . /app
# WORKDIR /app

# RUN pip3 install -r requirements.txt
# EXPOSE 8000

# CMD ["gunicorn", "-b", "0.0.0.0:8000", "app"]

# Alpine based stockfish container
# https://github.com/official-stockfish/Stockfish
# https://hub.docker.com/r/bitnami/python/dockerfile
FROM bitnami/minideb:stretch

LABEL maintainer "Albert Putra Purnama <appurnam@ucsd.edu>"

# Install required system packages and dependencies
RUN install_packages build-essential ca-certificates curl git libbz2-1.0 libc6 libffi6 libncurses5 libreadline7 libsqlite3-0 libsqlite3-dev libssl-dev libssl1.0.2 libssl1.1 libtinfo5 pkg-config unzip wget zlib1g
RUN wget -nc -P /tmp/bitnami/pkg/cache/ https://downloads.bitnami.com/files/stacksmith/python-3.7.2-0-linux-amd64-debian-9.tar.gz && \
    echo "88e2a14d39f964107d14a15aa969d8999d3adf3d872fa6c285f9650652e95a7a  /tmp/bitnami/pkg/cache/python-3.7.2-0-linux-amd64-debian-9.tar.gz" | sha256sum -c - && \
    tar -zxf /tmp/bitnami/pkg/cache/python-3.7.2-0-linux-amd64-debian-9.tar.gz -P --transform 's|^[^/]*/files|/opt/bitnami|' --wildcards '*/files' && \
    rm -rf /tmp/bitnami/pkg/cache/python-3.7.2-0-linux-amd64-debian-9.tar.gz
RUN sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS    90/' /etc/login.defs && \
    sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS    0/' /etc/login.defs && \
    sed -i 's/sha512/sha512 minlen=8/' /etc/pam.d/common-password

ENV BITNAMI_APP_NAME="python" \
    BITNAMI_IMAGE_VERSION="3.7.2-debian-9-r65" \
    PATH="/opt/bitnami/python/bin:$PATH"

ENV SOURCE_REPO https://github.com/official-stockfish/Stockfish
ENV VERSION master

ADD ${SOURCE_REPO}/archive/${VERSION}.tar.gz /root
WORKDIR /root


RUN if [ ! -d Stockfish-${VERSION} ]; then tar xvzf *.tar.gz; fi \
  && cd Stockfish-${VERSION}/src \
  && install_packages make g++ \
  && make build ARCH=x86-64-modern \
  && make install \
  && cd ../.. && rm -rf Stockfish-${VERSION} *.tar.gz

ADD . /app
WORKDIR /app

RUN pip3 install -r requirements.txt
EXPOSE 8000

CMD ["gunicorn", "-b", "0.0.0.0:8000", "app"]