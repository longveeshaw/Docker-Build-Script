#!/bin/bash

# Build base image
docker build -t apache/rocketmq-base:4.7.1 --build-arg version=4.7.1 ./rocketmq-base

# Build namesrv and broker
docker build -t apache/rocketmq-namesrv:4.7.1 ./rocketmq-namesrv
docker build -t apache/rocketmq-broker:4.7.1 ./rocketmq-broker

# Run namesrv and broker

docker run -d -p 9876:9876 --name rmqnamesrv  apache/rocketmq-namesrv:4.7.1
docker run -d -p 10911:10911 -p 10909:10909 --name rmqbroker --link rmqnamesrv:namesrv -e "NAMESRV_ADDR=namesrv:9876" apache/rocketmq-broker:4.7.1
