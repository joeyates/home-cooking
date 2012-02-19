This repo contains chef recipes I use to set up my personal computers.

Setup
=====

export HOME_COOKING_HOST=...

1. Create user 'joe'

SSH to host

  $ sudo su -
  # useradd --create-home --shell=/usr/bin/zsh --groups=admin joe
  # passwd joe

2. Install

  $ ./bootstrap.sh 

