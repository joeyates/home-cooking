This repo contains chef recipes I use to set up my personal computers.

# Install to a Remote Computer

## Prerequisites

* there must be an existing user with sudo privileges on the computer,
* ths computer must be running an SSH server.

## Dependencies


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
$ bin/push-install
```

# Install locally
Linux:
```shell
sudo apt-get install git-core zsh ruby rubygems
sudo gem install --no-ri --no-rdoc bundler chef net-ssh
cd ~
git clone git://github.com/joeyates/home-cooking.git .home-cooking
cd .home-cooking
bundle install --path vendor/bundle
cp attributes.js.template attributes.js
cp chef-solo.rb.template chef-solo.rb
```

If you do not have bundler:

```shell
$ (sudo) gem install net-ssh
```

Edit attributes.js and chef-solo-rb, inserting user name.

```shell
sudo bundle exec chef-solo -c chef-solo.rb -j attributes.js -u root
```

OS X:
```shell
sudo gem install --no-ri --no-rdoc chef net-ssh
sudo chef-solo -c osx-chef-solo.rb -j attributes.js -u root -g wheel
```

# Maintain

## Check if installed files have been changed, and view diffs:

```shell
home_cooking check
```

## View diffs of all installed files compared to templates:

```shell
home_cooking diff
```

## Stamp unstamped files:
```shell
home_cooking stamp
```

## Restamp all files:
```shell
home_cooking stamp --all
```

