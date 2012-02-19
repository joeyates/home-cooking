#!/bin/sh

BIN_PATH=`dirname $0`

scp $BIN_PATH/bootstrap.sh $HOME_COOKING_HOST:
ssh -t $HOME_COOKING_HOST ./bootstrap.sh

