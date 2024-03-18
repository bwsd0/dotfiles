#!/bin/bash

sed -i '/^NAME =/d' config.in
sed -i '/^USER =/d'  config.in
sed -i '/^EMAIL =/d' config.in
sed -i '/^export EMAIL=/d' bash/.env

username="$(whoami)"
fullname="$(getent passwd "$username" | cut -d ':' -f 5 | cut -d ',' -f 1)"
email=$(getent passwd "$username" | cut -d ':' -f 5 | cut -d ',' -f 2)
if [ -z "$email" ]; then
  read -r -p "Email: " email
fi
{
  printf "EMAIL = \"%s\"\n" "$email"
  printf "NAME = '%s'\n" "$fullname"
  printf "USER = '%s'\n" "$username"
} >> config.in
printf "export EMAIL=%s\n" "$email" >> bash/.env
