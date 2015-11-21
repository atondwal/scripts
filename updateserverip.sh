#!/bin/bash

NEWIP=$(ssh uwplse.org "cat /var/www/alex/homeserver_ip.txt")
NEWLINE="$NEWIP alex.server.remote serverRemote"
sudo sed -i "4s/.*/$NEWLINE/" /etc/hosts
