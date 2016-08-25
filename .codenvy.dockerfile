FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r8

MAINTAINER Bitnami <containers@bitnami.com>

# Install extra packages
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && apt-get -y install openjdk-8-jdk && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    apt-get clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Java/Play (Activator) module
RUN bitnami-pkg install activator-1.3.10-0 --checksum cb7da7398f22782c308fcfa0959c3b8b23eb7138247e343bd207ae06601fdd1b
ENV PATH=/opt/bitnami/activator/bin:$PATH

# Java/Play template
ENV BITNAMI_APP_NAME=java-play

EXPOSE 9000

USER bitnami

WORKDIR /projects

# Interact with Eclipse che
LABEL che:server:9000:ref=play che:server:9000:protocol=http

ENV TERM=xterm

CMD ["tail", "-f", "/dev/null"]