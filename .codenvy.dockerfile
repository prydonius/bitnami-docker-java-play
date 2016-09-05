FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r8

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=java-play \
    BITNAMI_APP_VERSION= \
    PATH=/opt/bitnami/activator/bin:$PATH \
    TERM=xterm

# Install extra packages
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && apt-get -y install openjdk-8-jdk && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    apt-get clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Install Java/Play (Activator) module
RUN bitnami-pkg install activator-1.3.10-0 --checksum a3bcd1f9e81294f64a12c9e7c41bfe5730f973c26953ce8b0ec60d0411a16e9d

EXPOSE 9000

USER bitnami

WORKDIR /projects

# Interact with Eclipse che
LABEL che:server:9000:ref=play che:server:9000:protocol=http

CMD ["tail", "-f", "/dev/null"]