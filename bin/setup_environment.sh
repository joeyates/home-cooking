if [[ -z "$HOME_COOKING_HOST" ]]; then
  echo -n 'Host address/name: '
  read HOME_COOKING_HOST
  export HOME_COOKING_HOST
fi

if [[ -z "$HOME_COOKING_EXISTING_USER" ]]; then
  echo -n 'Existing user: '
  read HOME_COOKING_EXISTING_USER
  export HOME_COOKING_EXISTING_USER
fi

if [[ -z "$HOME_COOKING_EXISTING_USER_PASSWORD" ]]; then
  echo -n "Password for $HOME_COOKING_EXISTING_USER: "
  stty -echo
  read HOME_COOKING_EXISTING_USER_PASSWORD
  stty echo
  echo
  export HOME_COOKING_EXISTING_USER_PASSWORD
fi

if [[ -z "$HOME_COOKING_NEW_USER" ]]; then
  echo -n 'New user: '
  read HOME_COOKING_NEW_USER
  export HOME_COOKING_NEW_USER
fi

if [[ -z "$HOME_COOKING_NEW_USER_PASSWORD" ]]; then
  echo -n "Password for $HOME_COOKING_NEW_USER: "
  stty -echo
  read HOME_COOKING_NEW_USER_PASSWORD
  stty echo
  echo
  echo -n "Confirm password for $HOME_COOKING_NEW_USER: "
  stty -echo
  read HOME_COOKING_CONFIRM_PASSWORD
  stty echo
  echo
  if [[ "$HOME_COOKING_NEW_USER_PASSWORD" -ne "$HOME_COOKING_CONFIRM_PASSWORD" ]]; then
    echo "Passwords do not match"
    unset HOME_COOKING_NEW_USER_PASSWORD
  fi
  unset HOME_COOKING_CONFIRM_PASSWORD
  export HOME_COOKING_NEW_USER_PASSWORD
fi

