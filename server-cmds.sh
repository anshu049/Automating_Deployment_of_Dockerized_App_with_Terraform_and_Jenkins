#!/usr/bin/env bash
docker stop tweetapp
docker rm tweetapp
docker rmi anshu049/tweet-app
docker run -d -p 80:80 --name tweetapp anshu049/tweet-app:latest
echo "success"
