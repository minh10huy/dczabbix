FROM ubuntu:trusty
LABEL maintainer "Alexey Pustovalov <alexey.pustovalov@zabbix.com>"

ARG BUILD_DATE
ARG VCS_REF

ARG APT_FLAGS_COMMON="-y"
ARG APT_FLAGS_PERSISTENT="${APT_FLAGS_COMMON} --no-install-recommends"
ARG APT_FLAGS_DEV="${APT_FLAGS_COMMON} --no-install-recommends"
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive TERM=xterm \
    MIBDIRS=/var/lib/mibs/iana:/var/lib/mibs/ietf:/usr/share/snmp/mibs:/var/lib/zabbix/mibs MIBS=+ALL \
    ZBX_TYPE=server ZBX_DB_TYPE=postgresql ZBX_OPT_TYPE=none

LABEL org.label-schema.name="zabbix-${ZBX_TYPE}-${ZBX_DB_TYPE}-ubuntu" \
      org.label-schema.vendor="Zabbix LLC" \
      org.label-schema.url="https://zabbix.com/" \
      org.label-schema.description="Zabbix ${ZBX_TYPE} with PostgreSQL database support" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.license="GPL v2.0"

STOPSIGNAL SIGTERM
#RUN apt-get update -y
RUN locale-gen $LC_ALL && \
    echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d && \
    #DISTRIB_CODENAME=$(/bin/bash -c 'source /etc/lsb-release && echo $DISTRIB_CODENAME') && \
    #apt-get update -y && \
    #echo "deb http://ports.ubuntu.com/ubuntu-ports/ $DISTRIB_CODENAME main" >> /etc/apt/sources.list && \
    #echo "deb http://us.archive.ubuntu.com/ubuntu/ $DISTRIB_CODENAME multiverse" >> /etc/apt/sources.list && \
    #echo "deb http://raspbian.raspberrypi.org/raspbian/ $DISTRIB_CODENAME multiverse" >> /etc/apt/sources.list && \
    addgroup --system --quiet zabbix && \
    adduser --quiet \
            --system --disabled-login \
            --ingroup zabbix \
            --home /var/lib/zabbix/ \
        zabbix && \
    usermod -G zabbix,dialout zabbix && \
    mkdir -p /etc/zabbix && \
    mkdir -p /var/lib/zabbix && \
    mkdir -p /usr/lib/zabbix/alertscripts && \
    mkdir -p /var/lib/zabbix/enc && \
    mkdir -p /usr/lib/zabbix/externalscripts && \
    mkdir -p /var/lib/zabbix/mibs && \
    mkdir -p /var/lib/zabbix/modules && \
    mkdir -p /var/lib/zabbix/snmptraps && \
    mkdir -p /var/lib/zabbix/ssh_keys && \
    mkdir -p /var/lib/zabbix/ssl && \
    mkdir -p /var/lib/zabbix/ssl/certs && \
    mkdir -p /var/lib/zabbix/ssl/keys && \
    mkdir -p /var/lib/zabbix/ssl/ssl_ca && \
    chown --quiet -R zabbix:root /var/lib/zabbix && \
    mkdir -p /usr/share/doc/zabbix-${ZBX_TYPE}-${ZBX_DB_TYPE} && \
    apt-get ${APT_FLAGS_COMMON} update && \
    apt-get ${APT_FLAGS_PERSISTENT} install \
            fping \
            libcurl3 \
            libevent-2.0 \
            libiksemel3 \
            libopenipmi0 \
            libpcre3 \
            libpq5 \
            libsnmp30 \
            libssh2-1 \
            libssl1.0.0 \
            libxml2 \
            postgresql-client \
            snmp-mibs-downloader \
            unixodbc && \
    apt-get ${APT_FLAGS_COMMON} autoremove && \
    apt-get ${APT_FLAGS_COMMON} clean && \
    rm -rf /var/lib/apt/lists/*

ARG MAJOR_VERSION=3.4
ARG ZBX_VERSION=${MAJOR_VERSION}.10
ARG ZBX_SOURCES=svn://svn.zabbix.com/tags/${ZBX_VERSION}/
ENV ZBX_VERSION=${ZBX_VERSION} ZBX_SOURCES=${ZBX_SOURCES}

LABEL org.label-schema.usage="https://www.zabbix.com/documentation/${MAJOR_VERSION}/manual/installation/containers" \
      org.label-schema.version="${ZBX_VERSION}" \
      org.label-schema.vcs-url="${ZBX_SOURCES}" \
      org.label-schema.docker.cmd="docker run --name zabbix-${ZBX_TYPE}-pgsql --link postgres-server:postgres -p 10051:10051 -d zabbix-${ZBX_TYPE}-pgsql:ubuntu-${ZBX_VERSION}"

RUN apt-get ${APT_FLAGS_COMMON} update && \
    apt-get ${APT_FLAGS_DEV} install \
            autoconf \
            automake \
            gcc \
            libc6-dev \
            libcurl4-openssl-dev \
            libevent-dev \
            libiksemel-dev \
            libldap2-dev \
            libopenipmi-dev \
            libpcre3-dev \
            libpq-dev \
            libsnmp-dev \
            libssh2-1-dev \
            libxml2-dev \
            make \
            pkg-config \
            subversion \
            unixodbc-dev && \
    cd /tmp/ && \
    svn --quiet export ${ZBX_SOURCES} zabbix-${ZBX_VERSION} && \
    cd /tmp/zabbix-${ZBX_VERSION} && \
    zabbix_revision=`svn info ${ZBX_SOURCES} | grep "Last Changed Rev"|awk '{print $4;}'` && \
    sed -i "s/{ZABBIX_REVISION}/$zabbix_revision/g" include/version.h && \
    ./bootstrap.sh && \
    export CFLAGS="-fPIC -pie -Wl,-z,relro -Wl,-z,now" && \
    ./configure \
            --datadir=/usr/lib \
            --libdir=/usr/lib/zabbix \
            --prefix=/usr \
            --sysconfdir=/etc/zabbix \
            --enable-agent \
            --enable-${ZBX_TYPE} \
            --with-${ZBX_DB_TYPE} \
            --with-jabber \
            --with-ldap \
            --with-libcurl \
            --with-libxml2 \
            --with-net-snmp \
            --with-openipmi \
            --with-openssl \
            --with-ssh2 \
            --with-unixodbc \
            --enable-ipv6 \
            --silent && \
    make -j"$(nproc)" -s dbschema && \
    make -j"$(nproc)" -s && \
    cp src/zabbix_${ZBX_TYPE}/zabbix_${ZBX_TYPE} /usr/sbin/zabbix_${ZBX_TYPE} && \
    cp src/zabbix_get/zabbix_get /usr/bin/zabbix_get && \
    cp src/zabbix_sender/zabbix_sender /usr/bin/zabbix_sender && \
    cp conf/zabbix_${ZBX_TYPE}.conf /etc/zabbix/zabbix_${ZBX_TYPE}.conf && \
    chown --quiet -R zabbix:root /etc/zabbix && \
    cat database/${ZBX_DB_TYPE}/schema.sql > database/${ZBX_DB_TYPE}/create.sql && \
    cat database/${ZBX_DB_TYPE}/images.sql >> database/${ZBX_DB_TYPE}/create.sql && \
    cat database/${ZBX_DB_TYPE}/data.sql >> database/${ZBX_DB_TYPE}/create.sql && \
    gzip database/${ZBX_DB_TYPE}/create.sql && \
    cp database/${ZBX_DB_TYPE}/create.sql.gz /usr/share/doc/zabbix-${ZBX_TYPE}-${ZBX_DB_TYPE}/ && \
    cd /tmp/ && \
    rm -rf /tmp/zabbix-${ZBX_VERSION}/ && \
    apt-get ${APT_FLAGS_COMMON} purge \
            autoconf \
            automake \
            gcc \
            libc6-dev \
            libcurl4-openssl-dev \
            libevent-dev \
            libiksemel-dev \
            libldap2-dev \
            libopenipmi-dev \
            libpcre3-dev \
            libpq-dev \
            libsnmp-dev \
            libssh2-1-dev \
            libxml2-dev \
            make \
            pkg-config \
            subversion \
            unixodbc-dev && \
    apt-get ${APT_FLAGS_COMMON} autoremove && \
    rm -rf /var/lib/apt/lists/*

# gammu
RUN apt-get -y update && \
    apt-get -y install wvdial usb-modeswitch git
RUN apt-get install -y gammu gammu-smsd
RUN chown gammu:gammu -R /var/spool/gammu/
RUN wget -q https://raw.githubusercontent.com/minh10huy/gammu-smsdrc/master/gammu-smsdrc -O /etc/gammu-smsdrc
RUN ln -s /etc/gammu-smsdrc /etc/gammurc
RUN sed -i 's/USER\=root2/USER\=gammu/g' /etc/init.d/gammu-smsd
RUN mkdir -p /var/log/gammu
RUN chown -R gammu:gammu /var/log/gammu
RUN chmod 777 -R /var/log/gammu/
RUN /etc/init.d/gammu-smsd start
ADD gammu-smsd /etc/logrotate.d/
RUN echo "zabbix ALL=NOPASSWD:/usr/bin/gammu-smsd-inject, /usr/bin/gammu" > /etc/sudoers.d/gammu && \
    chmod 0440 /etc/sudoers.d/gammu
ADD startsms.sh /mnt
RUN chmod +x /mnt/startsms.sh
RUN mkdir -p /opt/gammu
ADD sms-parser.sh /opt/gammu/
ADD a.sh /opt/gammu/
ADD pong.sh /opt/gammu/
ADD backup-fw.exp /opt/gammu/
RUN /etc/init.d/gammu-smsd restart

# debs
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && \
    apt-get -y install supervisor openssh-server pwgen apache2 libapache2-mod-php5 mysql-server php5 php5-cli php5-mysql php5-mcrypt php5-gd php5-imap php5-curl

# ssh
ADD docker_gammu/start-sshd.sh /start-sshd.sh
ADD docker_gammu/supervisord-sshd.conf /etc/supervisor/conf.d/supervisord-sshd.conf
#RUN mkdir /var/run/sshd
RUN echo 'root:changemeplease' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# apache2
ADD docker_gammu/start-apache2.sh /start-apache2.sh
ADD docker_gammu/supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD docker_gammu/apache_default /etc/apache2/sites-available/000-default.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN a2enmod rewrite
RUN rm -rf /var/www/html/*

# mysql
ADD docker_gammu/start-mysqld.sh /start-mysqld.sh
ADD docker_gammu/supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf
ADD docker_gammu/create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD docker_gammu/create_db.sh /create_db.sh
ADD docker_gammu/my.cnf /etc/mysql/conf.d/my.cnf
RUN rm -rf /var/lib/mysql/*

# playsms
ADD docker_gammu/start-playsmsd.sh /start-playsmsd.sh
ADD docker_gammu/supervisord-playsmsd.conf /etc/supervisor/conf.d/supervisord-playsmsd.conf
RUN rm -rf /app && mkdir /app && git clone --branch 1.4.2 --depth=1 https://github.com/antonraharja/playSMS.git /app
ADD docker_gammu/install.conf /app/install.conf
ADD docker_gammu/install.sh /install.sh

# php
ENV PHP_UPLOAD_MAX_FILESIZE 20M
ENV PHP_POST_MAX_SIZE 20M

# finalize scripts
ADD docker_gammu/run.sh /run.sh
RUN chmod +x /*.sh

# Add volumes for MySQL
VOLUME  ["/etc/mysql", "/var/lib/mysql" ]

EXPOSE 22/TCP 80/TCP 3306/TCP 10051/TCP

WORKDIR /var/lib/zabbix

VOLUME ["/usr/lib/zabbix/alertscripts", "/usr/lib/zabbix/externalscripts", "/var/lib/zabbix/enc", "/var/lib/zabbix/mibs", "/var/lib/zabbix/modules"]
VOLUME ["/var/lib/zabbix/snmptraps", "/var/lib/zabbix/ssh_keys", "/var/lib/zabbix/ssl/certs", "/var/lib/zabbix/ssl/keys", "/var/lib/zabbix/ssl/ssl_ca"]
COPY ["docker-entrypoint.sh", "/usr/bin/"]

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/run.sh"]
