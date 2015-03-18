#!/bin/bash
openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout /etc/logstash/logstash-forwarder.key -out /etc/logstash/logstash-forwarder.crt
chown logstash.logstash /etc/logstash/logstash-forwarder.key /etc/logstash/logstash-forwarder.crt
service logstash restart
htpasswd -b -c /etc/nginx/conf.d/kibana.htpasswd kibana kibana
