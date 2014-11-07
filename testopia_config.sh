cd $BUGZILLA_HOME
curl $TESTOPIA_DOWNLOAD -o testopia.tar.gz
tar xzf testopia.tar.gz
perl checksetup.pl /checksetup_answers.txt