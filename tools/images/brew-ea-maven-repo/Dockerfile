# Create image with brew-ea artefacts
#
# Call it with
#
# docker build --build-arg version=7.0.0.TP2 --build-arg build=2 -t registry.fuse-ignite.openshift.com/fuse-ignite/fuse-ignite-brew-maven-repo:7.0.0.TP2_2 .
# docker push registry.fuse-ignite.openshift.com/fuse-ignite/fuse-ignite-brew-maven-repo:7.0.0.TP2_2
#
# Then in the cluster:
# * Create a new project "brew-ea-repo"
# * Then
#   oc new-project brew-ea-repo
#   oc new-app --name maven --image-stream=fuse-ignite/fuse-ignite-brew-maven-repo:7.0.0.TP2_2
#   oc expose service maven
#
# Update template fuse-ignite/fuse-ignite-1.1 in the CM for the syndesis-rest to include
# the repository: "maven-brew-ea-repo.6a63.fuse-ignite.openshiftapps.com"



## nginx installation taken mostly from syndesis-ui
FROM docker.io/centos:7

ENV NGINX_VERSION 1.13.4-1.el7

LABEL name="nginxinc/nginx" \
      maintainer="Syndesis Authors <syndesis@googlegroups.com>" \
      vendor="NGINX Inc." \
      version="${NGINX_VERSION}" \
      release="1" \
      summary="NGINX" \
      description="nginx will do ....." \
### Required labels above - recommended below
      url="https://www.nginx.com/" \
      io.k8s.display-name="NGINX" \
      io.openshift.expose-services="http:8080" \
      io.openshift.tags="nginx,nginxinc"

ADD nginx.repo /etc/yum.repos.d/nginx.repo

RUN curl -sO http://nginx.org/keys/nginx_signing.key && \
    rpm --import ./nginx_signing.key && \
    yum -y install --setopt=tsflags=nodocs nginx-${NGINX_VERSION}.ngx && \
    yum -y install unzip && \
    rm -f ./nginx_signing.key && \
    yum clean all

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    sed -i 's/\/var\/run\/nginx.pid/\/var\/cache\/nginx\/nginx.pid/g' /etc/nginx/nginx.conf && \
    sed -i -e '/user/!b' -e '/nginx/!b' -e '/nginx/d' /etc/nginx/nginx.conf && \
    rm -f /etc/nginx/conf.d/default.conf && \
    chown -R 998 /var/cache/nginx /etc/nginx /usr/share/nginx && \
    chmod -R g=u /var/cache/nginx /etc/nginx

EXPOSE 8080

USER 998

COPY nginx.conf /etc/nginx/conf.d

CMD ["nginx", "-g", "daemon off;"]

# ==================================================
# Own customization
ARG version=7.0.0.TP2
ARG build=2

WORKDIR /tmp

ENV IGNITE_VERSION="${version}_${build}"
ENV IGNITE_ARCHIVE=jboss-fuse-${version}-maven-repository

RUN curl -O  http://download-node-02.eng.bos.redhat.com/devel/candidates/fuse/FUSE-${IGNITE_VERSION}/${IGNITE_ARCHIVE}.zip && \
    unzip -q ${IGNITE_ARCHIVE}.zip && \
    cp -r ${IGNITE_ARCHIVE}/maven-repository/* /usr/share/nginx/html && \
    rm ${IGNITE_ARCHIVE}.zip
