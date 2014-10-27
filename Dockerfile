# Ntipa Postgresql
#
# VERSION               0.0.1

FROM      ubuntu:14.04
MAINTAINER Tindaro Tornaebne "tindaro.tornabene@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update 
RUN apt-get install -y openssh-server
RUN apt-get -y install supervisor
RUN apt-get install -yqq inetutils-ping net-tools
WORKDIR /etc/supervisor/conf.d
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p   /var/run/sshd /var/log/supervisor /var/run/postgresql

# configure the "ntipa" and "root" users
RUN echo 'root:ntipa' |chpasswd
RUN groupadd ntipa && useradd ntipa -s /bin/bash -m -g ntipa -G ntipa && adduser ntipa sudo
RUN echo 'ntipa:ntipa' |chpasswd
	
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile


RUN apt-get install -y python-software-properties software-properties-common postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i it_IT -c -f UTF-8 -A /usr/share/locale/locale.alias it_IT.UTF-8

RUN locale-gen it_IT.UTF-8 && \
    echo 'LANG="it_IT.UTF-8"' > /etc/default/locale
    
USER postgres
RUN    /etc/init.d/postgresql start &&\
    psql    postgres --command "CREATE USER ntipa WITH SUPERUSER PASSWORD 'ntipa';" &&\
    createdb -O  ntipa ntipa-manager;\
    createdb -O  ntipa ntipa-protocollo


USER root

RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf


# Expose the PostgreSQL port
EXPOSE 5432 22

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]


CMD ["/usr/bin/supervisord"]