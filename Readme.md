## Ubuntu 16.04 Xenial Remote Desktop Server Docker in Docker

Multi User Remote Desktop Server with docker inside.
Intended for group usage in a shared docker space.
Based on https://hub.docker.com/r/danielguerra/ubuntu-xrdp/
Audio and Copy/Paste is working.

## Usage

Start a shared docker with overlay2 storage

```bash
docker run --privileged --name shared-docker -d docker:stable-dind --storage-driver=overlay2
```

Start the remote desktop server

```bash
docker run -d --link shared-docker:docker --shm-size 1g --name uxrdp-dind --hostname docker-terminal -p 3389:3389 -p 2222:22 danielguerra/ubuntu-xrdp-docker
```

Connect to the <docker-ip> remote desktop server with your RDP-client or 
with ssh so you can connect to RDP 127.0.0.1:3389 

```bash
ssh -L 3389:127.0.0.1:3389 ubuntu@<docker-ip>
```

## Sample user

There is a sample user with sudo rights

Username : ubuntu
Password : ubuntu

You can change your password in the rdp session in a terminal

```bash
passwd
```

## Docker Example

Docker and docker-compose have been added so all users can use the shared-docker.
When you start a docker container with port options you can connect the hostname `docker`

First connect with you RDP-client.

Then in a in a terminal in the RDP

```bash
docker run -d danielguerra/sshd --name sshd -p 7777:22
```

After this ssh to your ssh server in a terminal in the RDP

```bash
ssh -p 7777 alpine@docker
```
*note the password is alpine


Or from your workstation

```bash
ssh -t -p 2222 ubuntu@<docker-ip> ssh -p 7777 alpine@docker
```

## Add Users

Add a new user who is allowed to use docker

```
docker exec -ti uxrdp-dind adduser <newuser>
usermod -G docker <newuser>
```
