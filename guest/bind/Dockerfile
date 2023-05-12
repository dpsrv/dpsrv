FROM alpine:3.17.3

RUN apk add bind bind-dnssec-tools && \
	rm -rf /var/cache/apk/*

EXPOSE 53/udp
EXPOSE 53/tcp

CMD ["named", "-c", "/etc/bind/named.conf", "-g", "-u", "named"]

