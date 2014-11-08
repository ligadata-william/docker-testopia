#!/bin/bash


CPANM="cpanm -q --notest --skip-installed"

# Clone the code repo
git clone $BUGZILLA_REPO -b $BUGZILLA_BRANCH $BUGZILLA_HOME/www

# Install dependencies
cd $BUGZILLA_HOME/www



$CPANM DateTime
$CPANM Module::Build
$CPANM Software::License
$CPANM Pod::Coverage
$CPANM DBD::mysql
$CPANM Cache::Memcached::GetParserXS
$CPANM XMLRPC::Lite
$CPANM Locale::Language
$CPANM Template
$CPANM Email::Send
$CPANM Email::MIME
$CPANM Math::Random::ISAAC

$CPANM --installdeps --with-recommends .

# perl checksetup.pl $BUGZILLA_HOME/checksetup_answers.txt
