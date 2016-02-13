#!/bin/env bash

sshpass -p admin ssh router /sbin/ifconfig | grep inet | tail -n 1 | cut -d":" -f2 | cut -d" " -f1
