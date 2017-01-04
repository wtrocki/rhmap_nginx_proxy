FROM centos:centos7

RUN yum -y install --setopt=tsflags=nodocs centos-release-scl-rh && \
    yum -y update --setopt=tsflags=nodocs && \
    yum -y install --setopt=tsflags=nodocs gettext scl-utils rh-nginx18 && \
    yum clean all

ENV BASH_ENV=/usr/bin/nginx_scl_enable \
    ENV=/usr/bin/nginx_scl_enable \
    PROMPT_COMMAND=". /usr/bin/nginx_scl_enable"

ADD root /

RUN chmod 777 -Rf /var/opt/rh/rh-nginx18 && \
    chmod 777 -Rf /etc/nginx

## Default values for required environment variables
ENV DNS_SERVER=8.8.8.8 \
    MBAAS_HOST_BASE=localhost  \
    MBAAS_PROTOCOL=https       \
    ROOT_REDIRECT_URL=localhost \
    LOG_LEVEL=info

RUN ls -al /etc/nginx/

CMD [ "nginx18" ]
