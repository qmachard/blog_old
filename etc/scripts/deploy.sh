#!/bin/bash

if  [[ $TRAVIS_PULL_REQUEST = "false" ]]
then
    ncftp -u "$USERNAME" -p "$PASSWORD" "$HOST"<<EOF
    rm -rf public_html/blog
    mkdir public_html/blog
    quit
EOF

    cd dist || exit
    ncftpput -R -v -u "$USERNAME" -p "$PASSWORD" "$HOST" public_html/blog .
fi