FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r9

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=java-play \
    BITNAMI_APP_VERSION=1.3.10-1 \
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
RUN bitnami-pkg install activator-1.3.10-2 --checksum 5858cea425f0a6e8cb882dd456681b34eb216672654820e5e8e52449e1759bbe -- --applicationDirectory /projects

EXPOSE 9000

WORKDIR /projects

# Interact with Eclipse che
LABEL che:server:9000:ref=play che:server:9000:protocol=http

USER bitnami

CMD ["tail", "-f", "/dev/null"]