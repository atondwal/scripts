#!/bin/bash

sshpass -p admin ssh router /sbin/ifconfig | grep inet | tail -n 1 | cut -d":" -f2 | cut -d" " -f1 | ssh uwplse.org "cat > /var/www/alex/homeserver_ip.txt"
