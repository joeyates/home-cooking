#!/bin/sh

echo -n 'Host address/name: '
read HOME_COOKING_HOST
echo -n 'Existing user: '
read HOME_COOKING_USER
ssh -t $HOME_COOKING_USER@$HOME_COOKING_HOST "sh -c 'sudo apt-get update && sudo aptitude -y install zsh chef git-core'"

