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

RUN bitnami-pkg install activator-1.3.10-0 --checksum cb7da7398f22782c308fcfa0959c3b8b23eb7138247e343bd207ae06601fdd1b

ENV PATH=/opt/bitnami/activator/bin:$PATH

COPY rootfs/ /

USER bitnami

WORKDIR /app

EXPOSE 8888 9000

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["activator", "~run", "-Dhttp.address=0.0.0.0 -Dhttp.port=9000"] 
