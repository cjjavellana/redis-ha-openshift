FROM centos:7

USER root

ADD redis-4.0.9.tar.gz /app/usr/redis/redis-4.0.9.tar.gz
ADD epel-release-latest-7.noarch.rpm /app/usr/epel-release/epel-release-latest-7.noarch.rpm
ADD run.sh /run.sh

RUN yum install -y make && \
	yum install -y gcc && \
	cd /app/usr/epel-release && \
	rpm -ivh epel-release-latest-7.noarch.rpm && \
	yum install -y jemalloc-devel && \
	cp /app/usr/redis/redis-4.0.9.tar.gz/redis-4.0.9/redis.conf /etc/redis.conf && \
	cp /app/usr/redis/redis-4.0.9.tar.gz/redis-4.0.9/sentinel.conf /etc/sentinel.conf && \
	sed -i -e 's/sentinel monitor mymaster/# sentinel monitor mymaster/g' /etc/sentinel.conf && \
	sed -i '/sentinel monitor mymaster/a sentinel monitor mymaster $MASTER_HOST $MASTER_PORT $QUOROM' /etc/sentinel.conf && \
	echo 'sentinel announce-ip $ANNOUNCE_IP' >> /etc/sentinel.conf && \
	echo 'sentinel announce-port $ANNOUNCE_PORT' >> /etc/sentinel.conf && \
	cd /app/usr/redis/redis-4.0.9.tar.gz/redis-4.0.9 && \
	make && \
	make install prefix=/usr/local/bin

EXPOSE 6379 26379

CMD ["/run.sh"]

	




