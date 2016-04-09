#!/bin/bash

NEWIP=$(wget -O - -o /dev/null alex.uwplse.org/homeserver_ip.txt)
NEWLINE="$NEWIP alex.server.remote serverRemote"
sudo sed -i "8s/.*/$NEWLINE/" /etc/hosts
