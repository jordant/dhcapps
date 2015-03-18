#!/bin/bash

if [ -e '/etc/gitlab/gitlab-secrets.json' ]; then
        rm -v /etc/gitlab/gitlab-secrets.json
fi

gitlab-ctl reconfigure
