#!/bin/sh
docker run -v lb-vol:/root -v /var/run/docker.sock:/var/run/docker.sock -p 8080:8080 -it lb/dk
