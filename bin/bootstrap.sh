if [[ -z "$HOME_COOKING_HOST" ]]; then
  echo "First run:
. bin/remote_setup_environment.sh"
  exit
fi

BIN_PATH=`dirname $0`

scp $BIN_PATH/../assets/bootstrap.sh $HOME_COOKING_HOST:
ssh -t $HOME_COOKING_HOST ./bootstrap.sh

