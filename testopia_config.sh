CPANM="cpanm -q --notest --skip-installed"

cd $BUGZILLA_HOME/www


$CPANM GD::Graph3d
$CPANM Text::Diff


curl $TESTOPIA_DOWNLOAD -o testopia.tar.gz

tar xzf testopia.tar.gz


