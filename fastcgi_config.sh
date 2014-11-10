

# cpanm -q --notest --skip-installed FCGI
#perl install-module.pl FCGI

wget -O /usr/local/bin/fastcgi-wrapper     http://ftp.quzart.com/notes/bugzilla-nginx-fcgi/fastcgi-wrapper.pl
chmod 0755 /usr/local/bin/fastcgi-wrapper
# wget -O /etc/init.d/fastcgi-wrapper     http://ftp.quzart.com/notes/bugzilla-nginx-fcgi/fastcgi-wrapper-initscript

mkdir -p /var/run/fastcgi-wrapper/
chown bugzilla:bugzilla /var/run/fastcgi-wrapper/
cmod 777 /var/run/fastcgi-wrapper/

# chmod 0755 /etc/init.d/fastcgi-wrapper
# update-rc.d fastcgi-wrapper defaults


# echo '#!/bin/sh
# exit 0' > /usr/sbin/policy-rc.d 


# invoke-rc.d fastcgi-wrapper start




# http://nginxlibrary.com/perl-fastcgi/ or http://www.aireadfun.com/blog/2013/02/01/install-bugzilla-4-dot-2-4-on-ubuntu-12-dot-04/


# wget http://nginxlibrary.com/downloads/perl-fcgi/fastcgi-wrapper -O /usr/bin/fastcgi-wrapper.pl
# wget http://nginxlibrary.com/downloads/perl-fcgi/perl-fcgi -O /etc/init.d/perl-fcgi
# chmod +x /usr/bin/fastcgi-wrapper.pl
# chmod +x /etc/init.d/perl-fcgi
# update-rc.d perl-fcgi defaults
# insserv perl-fcgi


echo '\ndaemon off;' >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx