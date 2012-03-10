if [[ -z "$HOME_COOKING_HOST" ]]; then
  echo "First run:
. bin/remote_setup_environment.sh"
  exit
fi

ssh -t $HOME_COOKING_USER@$HOME_COOKING_HOST "sh -c 'sudo useradd --create-home --shell=/usr/bin/zsh --groups=admin joe && echo Set password for joe && sudo passwd joe'"

