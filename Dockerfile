## BUILDING
##   (from project root directory)
##   $ docker build -t bitnami/bitnami-docker-javaplay .
##
## RUNNING
##   $ docker run -p 9000:9000 bitnami/bitnaxmi-docker-javaplay
##

FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r10

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=java-play \
    BITNAMI_IMAGE_VERSION=1.3.10-r1 \
    PATH=/opt/bitnami/activator/bin:/opt/bitnami/node/bin:$PATH \
    TERM=xterm

# Install related packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends openjdk-8-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt /var/cache/apt/archives/* /tmp/*

# Install Play dependencies
RUN bitnami-pkg install node-6.6.0-1 --checksum 36f42bb71b35f95db3bb21d088fbd9438132fb2a7fb4d73b5951732db9a6771e

# Install Java/Play (Activator) module
RUN bitnami-pkg install activator-1.3.10-2 --checksum 5858cea425f0a6e8cb882dd456681b34eb216672654820e5e8e52449e1759bbe

COPY rootfs/ /

WORKDIR /app

EXPOSE 9000

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["activator", "-Doffline=true", "-Dhttp.address=0.0.0.0 -Dhttp.port=9000", "~run"] 
