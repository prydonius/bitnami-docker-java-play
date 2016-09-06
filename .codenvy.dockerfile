FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r9

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=java-play \
    BITNAMI_APP_VERSION=1.3.10-0 \
    PATH=/opt/bitnami/activator/bin:/opt/bitnami/node/bin:$PATH \
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

# Install Play dependencies
RUN bitnami-pkg install node-6.4.0-0 --checksum 41d5a7b17ac1f175c02faef28d44eae0d158890d4fa9893ab24b5cc5f551486f

# Install Java/Play (Activator) module
RUN bitnami-pkg install activator-1.3.10-1 --checksum 3bd4f55c852ac71e9f712a153794fa60e2bb6fce25d35eb67a8de05e5cd8d66b

EXPOSE 9000

USER bitnami

WORKDIR /projects

# Interact with Eclipse che
LABEL che:server:9000:ref=play che:server:9000:protocol=http

CMD ["tail", "-f", "/dev/null"]