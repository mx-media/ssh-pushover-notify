#!/bin/sh

hostname=$(hostname)
PUSHOVER_USER="ux3hfgntjjmtaewo9wdgikg8iboc2m"
PUSHOVER_API_TOKEN="ap2mj9v8w1wgkdo5nwyv7crusx233j"

echo "================================="
echo "Der SSH Zugriff auf $hostname wird jetzt überwacht."
echo "Bei Zugriff bekommen Sie eine Nachricht auf Pushover."
echo "================================="

tail -F /var/log/auth.log | gawk '{if(NR>10 && $0 ~ /sshd/ && $0 ~ /Accepted/)\
{ cmd=sprintf("curl -s \
-F \"token='$PUSHOVER_API_TOKEN'\" \
-F \"user='$PUSHOVER_USER'\" \
-F \"message=SSH Zugriff erfolgt durch %s von %s\" \
-F \"title='$hostname'\" https://api.pushover.net/1/messages.json",$9,$11); \
system(cmd)}}'
