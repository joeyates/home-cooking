if [[ -z "$HOME_COOKING_HOST" ]]; then
  echo -n 'Host address/name: '
  read HOME_COOKING_HOST
  export HOME_COOKING_HOST
fi
if [[ -z "$HOME_COOKING_USER" ]]; then
  echo -n 'Existing user: '
  read HOME_COOKING_USER
  export HOME_COOKING_USER
fi

