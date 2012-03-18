This repo contains chef recipes I use to set up my personal computers.

# Usage

## Dependencies

```shell
$ bundle install
```

If you do not have bundler:

```shell
$ (sudo) gem install net-ssh
```

## Pre-define Required Values (optional)

If you may be running the install many times, this step avoids you having
to retype all the necessary information each time.

```shell
. bin/setup_environment.sh
```

The above predefines the following:

* host name or IP,
* existing user,
* existing user's password,
* new user,
* new user's password.

## Install

```shell
$ bin/install
```

