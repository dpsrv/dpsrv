#!/bin/ash -ex

apk add docker
rc-update add docker
rc-service docker start

addgroup vagrant docker

while [ ! -e /var/run/docker/containerd/containerd.sock ]; do
	echo "Waiting for /var/run/docker/containerd/containerd.sock"
	sleep 1
done

chgrp docker /var/run/docker/containerd/containerd.sock
