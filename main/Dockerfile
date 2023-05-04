FROM alpine:3.17.3

RUN apk add --update \
		openssh \
		rsync \
		cfdisk \
		e2fsprogs \
		lvm2 \
		drbd  \
		lsblk && \
	apk upgrade -a && \
	mkdir /root/.ssh && \
	chmod -R og-rwx /root/.ssh && \
	sed -i -e 's/^root:!:/root::/' /etc/shadow && \
	rm /var/cache/apk/*

COPY docker-entrypoint.sh /usr/local/bin/

VOLUME /etc
EXPOSE 22

CMD [ "/usr/local/bin/docker-entrypoint.sh" ]

