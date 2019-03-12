#!/bin/sh
set -e

# Create a default config if autoconfig enabled
if [ ! -f /srv/fail2rest/config.json ]; then
	echo "fail2rest configuration initialization..."

	mkdir -p /srv/fail2rest/
    echo \	
		"{ \"Addr\": \"0.0.0.0:5000\", \"Fail2banSocket\": \"/var/run/fail2ban/fail2ban.sock\" }" \
		> /srv/fail2rest/config.json

	echo "fail2rest configuration generated"
fi

echo "fail2rest starting..."
exec "$@"
