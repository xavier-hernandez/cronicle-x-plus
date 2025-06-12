# cronicle-x-plus

Docker Image: https://hub.docker.com/r/xavierh/cronicle-x-plus

This docker is based on https://github.com/soulteary/docker-cronicle with some updates. Look there for settings and more info. This was more of a personal repo/image but since it worked and appears to be stable I thought of making it public.

Cronicle was missing a bunch of tools that I wanted. So I added them to the docker image. 

Why, because I wanted to :) I tried using different docker containers and calling them from the Cronicle container but it was a headache.

- updated the docker image to use node:lts-alpine3.22
- added the following packages
  - bash
  - borgbackup
  - borgmatic
  - mc
  - nano
  - openssh
  - ripgrep
  - rsync
  - wget

