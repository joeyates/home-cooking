This repo contains chef recipes I use to set up my personal computers.

Stages

- Create the desired user (for now 'joe' only),
- Install dependencies for chef,
- Run chef scripts.

Setup
=====

In the script names 'remote\_' indicates a script run remotely,
i.e. not from the host onto which we are installing.

1. Setup

  $ . bin/remote\_setup\_environment.sh

2. Create user:

  $ bin/remote\_user\_create.sh

3. Install

  $ bin/remote\_bootstrap.sh

