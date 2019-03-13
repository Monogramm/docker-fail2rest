FROM golang:alpine

LABEL maintainer="Mathieu BRUNOT <mathieu.brunot at monogramm dot io>"

EXPOSE 5000

WORKDIR /go/src/app

COPY docker-entrypoint.sh /entrypoint.sh
RUN set -ex; \
	# install the packages we need
	apk add --no-cache \
		git build-base \
	; \
	# Get and install fail2rest
    go get -v github.com/Sean-Der/fail2rest; \
    go install -v github.com/Sean-Der/fail2rest; \
	ln -s /root/go/bin/fail2rest /usr/bin/; \
	# Make sure the entrypoint is executable
	chmod 755 /entrypoint.sh

VOLUME /srv/fail2rest/ /var/run/fail2ban/fail2ban.sock

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/sh", "-c", "fail2rest --config /srv/fail2rest/config.json"]
