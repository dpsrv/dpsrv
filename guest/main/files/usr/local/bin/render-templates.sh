#!/bin/ash -x

find /etc -name '*.envsubst' | while read template; do
	rendered=${template%.envsubst}
	cat $template | envsubst > $rendered
	rm $template
done
