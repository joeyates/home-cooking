#!/bin/sh

echo -n 'Host address/name: '
read HOME_COOKING_HOST
echo -n 'Existing user: '
read HOME_COOKING_USER
ssh -t $HOME_COOKING_USER@$HOME_COOKING_HOST "sh -c 'sudo useradd --create-home --shell=/usr/bin/zsh --groups=admin joe && echo Set password for joe && sudo passwd joe'"

