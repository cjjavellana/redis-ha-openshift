#!/bin/sh

sed -i 's/^bind 127\.0\.0\.1$/bind 0.0.0.0/g' /etc/redis.conf
sed -i -e "s/\$MASTER_HOST/${MASTER_HOST}/g" \
	-e "s/\$MASTER_PORT/${MASTER_PORT}/g" \
	-e "s/\$ANNOUNCE_IP/${ANNOUNCE_IP}/g" \
	-e "s/\$ANNOUNCE_PORT/${ANNOUNCE_PORT}/g" \
	-e "s/\$QUOROM/${QUOROM}/g" /etc/sentinel.conf

redis-server /etc/redis.conf &

redis-server /etc/sentinel.conf --sentinel

