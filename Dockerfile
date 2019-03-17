FROM golang:alpine

LABEL maintainer="Mathieu BRUNOT <mathieu.brunot at monogramm dot io>"

EXPOSE 5000

VOLUME /srv/fail2rest/ /var/run/fail2ban/

WORKDIR /go/src/app

COPY docker-entrypoint.sh /entrypoint.sh

# Install the packages we need
# Make sure the entrypoint is executable
# Get and install fail2rest
RUN set -ex; \
	apk add --no-cache \
		git build-base \
	; \
	chmod 755 /entrypoint.sh; \
    go get -v github.com/Sean-Der/fail2rest; \
    go install -v github.com/Sean-Der/fail2rest; \
	ln -s /root/go/bin/fail2rest /usr/bin/

ENTRYPOINT ["/entrypoint.sh"]
