if [[ -z "$HOME_COOKING_HOST" ]]; then
  echo "First run:
. bin/remote_setup_environment.sh"
  exit
fi

ssh -t $HOME_COOKING_USER@$HOME_COOKING_HOST "sh -c 'sudo apt-get update && sudo aptitude -y install zsh chef git-core'"

