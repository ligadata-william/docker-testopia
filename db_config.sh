
cd www 
chown bugzilla:bugzilla . -R
sudo -u bugzilla perl checksetup.pl /config/checksetup_answers.txt 
sudo -u bugzilla perl checksetup.pl

# [program:checksetup_pl]
# priority=100
# directory=/home/bugzilla/www
# command=perl checksetup.pl /config/checksetup_answers.txt && perl checksetup.pl
# user=www-data
# group=www-data
# autorestart=false
# stdout_logfile=/home/bugzilla/checksetup.log
# stderr_logfile=/home/bugzilla/checksetup.err