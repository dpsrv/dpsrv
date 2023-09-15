#!/bin/ash -ex

cd $(dirname $0)
ls -1 init.d/ | sort | while read script; do
	init.d/$script
done
