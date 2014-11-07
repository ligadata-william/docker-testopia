#!/bin/bash


CPANM="cpanm -q --notest --skip-installed"

# Clone the code repo
git clone $BUGZILLA_REPO -b $BUGZILLA_BRANCH $BUGZILLA_HOME

# Install dependencies
cd $BUGZILLA_HOME
$CPANM DateTime
$CPANM Module::Build
$CPANM Software::License
$CPANM Pod::Coverage
$CPANM DBD::mysql
$CPANM Cache::Memcached::GetParserXS
$CPANM XMLRPC::Lite
$CPANM Locale::Language
$CPANM --installdeps --with-recommends .

# Configure bugs database
perl checksetup.pl /checksetup_answers.txt
