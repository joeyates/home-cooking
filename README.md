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

Set the following environment variables:

* HOME\_COOKING\_HOST: the remote host's IP or domain name
* HOME\_COOKING\_USER: an existing user on the remote host which has sudo permissions

```shell
$ . bin/remote\_setup\_environment.sh
Host address/name: example.com
Existing user: user
```

2. Install dependencies

```shell
$ bin/remote\_install\_dependencies.sh
```

3. Create my user:

```shell
$ bin/remote\_create\_user.sh
user@example.com's password:
[sudo] password for user:
Set password for joe
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
Connection to example.com closed.
```

4. Install

Run chef-solo on the host.

```shell
$ bin/remote\_bootstrap.sh
joe@example.com's password: 
...
joe@example.com's password: 
...
[sudo] password for joe: 
...
```

