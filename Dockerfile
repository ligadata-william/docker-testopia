FROM ubuntu:14.04
MAINTAINER Roman <romitch@gmail.com>

# Environment
ENV container docker
ENV BUGZILLA_USER bugzilla
ENV BUGZILLA_REPO https://github.com/bugzilla/bugzilla.git
ENV BUGZILLA_BRANCH 4.2
ENV TESTOPIA_DOWNLOAD ftp://ftp.mozilla.org/pub/mozilla.org/webtools/testopia/testopia-2.5-BUGZILLA-4.2.tar.gz

ENV BUGZILLA_HOME /home/$BUGZILLA_USER/devel/htdocs/bugzilla


# Software installation
RUN apt-get update 
RUN apt-get -y install supervisor openssh-server git apache2 curl make \
                   mysql-client \ 
                   perl cpanminus \  
                   postfix; 
         

# User configuration
# RUN useradd -m -G wheel -u 1000 -s /bin/bash $BUGZILLA_USER
RUN useradd -d /home/$BUGZILLA_USER -m $BUGZILLA_USER
# RUN passwd -u $BUGZILLA_USER
# RUN usermod --password $BUGZILLA_USER
RUN echo "bugzilla:bugzilla" | chpasswd
RUN mkdir -p /home/$BUGZILLA_USER/devel/htdocs

# Sudoer configuration
ADD sudoers /etc/sudoers
RUN chown root.root /etc/sudoers; chmod 440 /etc/sudoers

# Bugzilla configuration

RUN apt-get -y install make gcc
ADD checksetup_answers.txt /work/checksetup_answers.txt
ADD bugzilla_config.sh /work/bugzilla_config.sh
WORKDIR /work
RUN chmod 755 /work/bugzilla_config.sh
RUN /work/bugzilla_config.sh

ADD testopia_config.sh /work/testopia_config.sh
RUN chmod 755 /work/testopia_config.sh
RUN /work/testopia_config.sh

# Final permissions fix
RUN chmod 711 /home/$BUGZILLA_USER
RUN chown -R $BUGZILLA_USER.$BUGZILLA_USER /home/$BUGZILLA_USER

EXPOSE 80
EXPOSE 22

# Apache configuration 
RUN apt-get -y install libapache2-mod-perl2 && a2enmod headers && a2enmod expires
RUN apt-get -y install libdatetime-perl
RUN rm /etc/apache2/sites-enabled/*.conf
ADD bugzilla.conf /etc/apache2/sites-enabled/bugzilla.conf

# Supervisor
ADD supervisord.conf /etc/supervisord.conf
RUN chmod 700 /etc/supervisord.conf
CMD ["/usr/bin/supervisord", "--configuration", "/etc/supervisord.conf"]

RUN mkdir -p /var/www/html
RUN chown -R $BUGZILLA_USER.$BUGZILLA_USER /var/www

# Define mountable directories.
VOLUME ["/etc/mail/"]


# TODO: uploaded files if any 