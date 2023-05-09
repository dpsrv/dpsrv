#!/bin/ash -ex

cd $(dirname $0)
ls -1 init/ | sort | while read script; do
	init/$script
done
