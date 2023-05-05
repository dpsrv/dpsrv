export DRBD_DOMAINS=$(
	i=0
	for addr in $DPSRV_DRBD_ADDRS; do
		host=${addr%:*}
		port=${addr#*:}
		ipv4=$(getent hosts $host|awk '{ print $1 }')

		cat <<_EOT_
	on $host {
		address $ipv4:$port;
	}
_EOT_
		i=$(( i + 1 ))
	done
)
