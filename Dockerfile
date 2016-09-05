## BUILDING
##   (from project root directory)
##   $ docker build -t bitnami/bitnami-docker-javaplay .
##
## RUNNING
##   $ docker run -p 9000:9000 bitnami/bitnaxmi-docker-javaplay
##

FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r8

MAINTAINER Bitnami <containers@bitnami.com>

# Install related packages
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && apt-get -y install openjdk-8-jdk && \
    apt-get clean

# Install activator

RUN bitnami-pkg install activator-1.3.10-0 --checksum a3bcd1f9e81294f64a12c9e7c41bfe5730f973c26953ce8b0ec60d0411a16e9d

ENV PATH=/opt/bitnami/activator/bin:$PATH

ENV BITNAMI_APP_NAME=java-play

COPY rootfs/ /

USER bitnami

WORKDIR /app

EXPOSE 8888 9000

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["activator", "~run", "-Dhttp.address=0.0.0.0 -Dhttp.port=9000"] 
