This repo contains chef recipes I use to set up my personal computers.

Stages

- Create the desired user (for now 'joe' only),
- Install dependencies for chef,
- Run chef scripts.

# Usage

## Environment Setup

Set the following environment variables:

* HOME\_COOKING\_HOST: the remote host's IP or domain name
* HOME\_COOKING\_USER: an existing user on the remote host which has sudo permissions

```shell
$ . bin/setup_environment.sh
Host address/name: example.com
Existing user: user
```

## Install dependencies

```shell
$ bin/install_dependencies.sh
```

## Create user

```shell
$ bin/create_user.sh
user@example.com's password:
[sudo] password for user:
Set password for joe
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
Connection to example.com closed.
```

## Install

Run chef-solo on the host.

```shell
$ bin/bootstrap.sh
joe@example.com's password: 
...
joe@example.com's password: 
...
[sudo] password for joe: 
...
```

