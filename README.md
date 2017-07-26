# Overview
Simple streaming client-server application based on Ubuntu.

It contains:
* `nginx with nginx-rtmp-module`
* `Flex sdk 4.16 and ant to build client application`
* `flex client application`

# How to use this image

Get project from github repository

`git clone https://github.com/ervindev/streamer-app.git`

Create and start container

`docker-compose up -d`

Open client application in your browser [http://localhost:8080][1]

# Flex client application
Source code for client application is located in client/streamer

[1]: http://localhost:8080