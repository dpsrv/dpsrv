FROM amazoncorretto:11.0.19

ENV container docker
ENV HADOOP_VERSION 3.3.5

RUN curl -O https://dlcdn.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

RUN amazon-linux-extras install -y epel && \
	yum install -y curl tar gzip openssh-server openssh-clients hostname procps net-tools which iputils bind-utils nmap-ncat rsyslog initscripts && \
	yum clean all && \
	rm -rf /var/cache/yum

RUN	tar xvzf hadoop-$HADOOP_VERSION.tar.gz -C /opt && \
	mv /opt/hadoop-$HADOOP_VERSION /opt/hadoop && \
	rm hadoop-$HADOOP_VERSION.tar.gz

RUN systemctl enable rc-local.service && \
	systemctl enable rsyslog

COPY files/ /

EXPOSE 22
EXPOSE 9868
EXPOSE 9870

WORKDIR /root

CMD [ "/usr/sbin/init" ]

