#!/bin/bash

if  [[ $TRAVIS_PULL_REQUEST = "false" ]]
then
    ncftp -u "$USERNAME" -p "$PASSWORD" "$HOST"<<EOF
    cd public_html/blog
    rm -rf .*
    quit
EOF

    cd dist || exit
    ncftpput -R -v -u "$USERNAME" -p "$PASSWORD" "$HOST" public_html/blog .
fi