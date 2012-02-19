#!/bin/sh

scp remote_bootstrap.sh $HOME_COOKING_HOST:
ssh -t $HOME_COOKING_HOST ./remote_bootstrap.sh

