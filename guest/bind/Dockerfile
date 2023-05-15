FROM alpine:3.17.3

RUN apk add bind bind-dnssec-tools git && \
	rm -rf /var/cache/apk/*

COPY files/ /

EXPOSE 53/udp
EXPOSE 53/tcp

CMD [ "/usr/local/bin/docker-entrypoint.sh" ]

