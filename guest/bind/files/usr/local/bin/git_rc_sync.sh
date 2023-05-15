#!/bin/ash -ex

if [ -n "$GIT_RC" ]; then
	mkdir ~/git
	cd ~/git
	for repo in $GIT_RC; do
		git clone $repo
	done
	for repo in $GIT_RC; do
		[ ! -x $repo/git_rc_init.sh ] || $repo/git_rc_init.sh
	done
	/usr/local/bin/git_rc_sync.sh &
	/usr/local/bin/git_rc_hook.sh &
fi

