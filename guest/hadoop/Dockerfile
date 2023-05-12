FROM amazoncorretto:11.0.19

ENV container docker
ENV HADOOP_VERSION 3.3.5

RUN curl -O https://dlcdn.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz && \
	tar xvzf hadoop-$HADOOP_VERSION.tar.gz -C /opt && \
	rm hadoop-$HADOOP_VERSION.tar.gz

RUN yum install -y curl tar gzip openssh-server openssh-clients hostname procps && \
	yum clean all && \
	rm -rf /var/cache/yum

COPY files /

CMD [ "/usr/local/bin/docker-entrypoint.sh" ]

