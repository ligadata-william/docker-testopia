FROM ubuntu:14.04
MAINTAINER Roman <romitch@gmail.com>

# Environment
ENV container docker
ENV BUGZILLA_REPO https://github.com/bugzilla/bugzilla.git
ENV BUGZILLA_BRANCH 4.2
ENV TESTOPIA_DOWNLOAD ftp://ftp.mozilla.org/pub/mozilla.org/webtools/testopia/testopia-2.5-BUGZILLA-4.2.tar.gz

ENV BUGZILLA_HOME /home/bugzilla


# Software installation
RUN apt-get update 
RUN apt-get -y install supervisor git nginx  curl wget make gcc \
                   mysql-client \ 
                   perl cpanminus libdatetime-perl libgd-gd2-perl \
                   libdbd-mysql-perl libxml-perl \  
                   postfix; 
         

# User configuration
# RUN useradd -m -G wheel -u 1000 -s /bin/bash bugzilla
RUN useradd -d /home/bugzilla -m bugzilla
# RUN passwd -u bugzilla
# RUN usermod --password bugzilla
RUN echo "bugzilla:bugzilla" | chpasswd
RUN mkdir -p /home/bugzilla

# Sudoer configuration
ADD sudoers /etc/sudoers
RUN chown root.root /etc/sudoers; chmod 440 /etc/sudoers

# Bugzilla configuration

ADD bugzilla_config.sh /home/bugzilla/bugzilla_config.sh
RUN cd  /home/bugzilla/; chmod 755 bugzilla_config.sh && sh bugzilla_config.sh


# Testopia 
ADD testopia_config.sh /home/bugzilla/testopia_config.sh
RUN cd /home/bugzilla/; chmod 755 testopia_config.sh && sh testopia_config.sh

# Final permissions fix
RUN usermod -a -G bugzilla www-data
# RUN chmod 765 /home/bugzilla
# RUN chown bugzilla:bugzilla -R  /home/bugzilla/

EXPOSE 80

# Nginx configuration 
RUN apt-get -y install  libcgi-fast-perl
ADD fastcgi-wrapper.pl /usr/local/bin/fastcgi-wrapper
RUN chmod 0755 /usr/local/bin/fastcgi-wrapper
# ADD fastcgi_config.sh /home/bugzilla/fastcgi_config.sh
# RUN cd /home/bugzilla; chmod 775 fastcgi_config.sh && sh fastcgi_config.sh
RUN rm /etc/nginx/sites-enabled/*
ADD nginx.conf /etc/nginx/sites-enabled/bugzilla

# DB config script 
ADD db_config.sh /home/bugzilla/db_config.sh

# Supervisor
ADD supervisord.conf /etc/supervisord.conf
RUN chmod 700 /etc/supervisord.conf

# Define mountable directories.
VOLUME ["/etc/mail/", "/config"]  # checksetup_answers.txt is accessible from /config and setup on system start

CMD ["/usr/bin/supervisord", "--configuration", "/etc/supervisord.conf"]

WORKDIR /home/bugzilla


# TODO: uploaded files if any 