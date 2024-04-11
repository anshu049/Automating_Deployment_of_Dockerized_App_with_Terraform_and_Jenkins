#!/usr/bin/env bash
docker run -d -p 80:80 --name tweetapp anshu049/tweet-app:latest
echo "success"
