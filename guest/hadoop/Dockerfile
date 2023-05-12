FROM amazoncorretto:11.0.19

ENV container docker
ENV HADOOP_VERSION 3.3.5

RUN curl -O https://dlcdn.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

RUN amazon-linux-extras install -y epel && \
	yum install -y curl tar gzip openssh-server openssh-clients hostname procps net-tools which && \
	yum clean all && \
	rm -rf /var/cache/yum

RUN	tar xvzf hadoop-$HADOOP_VERSION.tar.gz -C /opt && \
	ln -s /opt/hadoop-$HADOOP_VERSION /opt/hadoop && \
	rm hadoop-$HADOOP_VERSION.tar.gz

COPY files /

CMD [ "/usr/local/bin/docker-entrypoint.sh" ]

