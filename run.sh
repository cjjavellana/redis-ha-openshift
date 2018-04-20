#!/bin/sh

redis-server /etc/redis.conf &

redis-server /etc/sentinel.conf --sentinel

