#!/bin/bash

if  [[ $TRAVIS_PULL_REQUEST = "false" ]]
then
    ncftp -u "$USERNAME" -p "$PASSWORD" "$HOST"<<EOF
    mdelete public_html/blog/*
    quit
EOF

    cd dist || exit
    ncftpput -R -v -u "$USERNAME" -p "$PASSWORD" "$HOST" public_html/blog .
fi