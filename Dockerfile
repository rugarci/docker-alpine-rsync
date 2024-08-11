ARG ALPINE_BASE=3.20

FROM alpine:${ALPINE_BASE}

ARG BUILD_DATE
ARG VERSION
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="docker-alpine-rsync" \
    org.label-schema.version=$VERSION \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/rugarci/docker-alpine-rsync" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.schema-version="1.0"
    
# Install rsync
# hadolint ignore=DL3018
RUN apk add --no-cache rsync tzdata && \
# Make a root directory to share by default
mkdir -p /export

# Add a default configuration, this can be overwritten an runtime
# chroot isn't necessary as the daemon is run as 'nobody'
#RUN printf 'use chroot = no\n\
#read only = yes\n\
#[mirror]\n\
#    path = /export\n\
#    read only = yes\n\
#    reverse lookup = no\n'\
#    > /etc/rsyncd.conf

# Add a default configuration, this can be overwritten an runtime
RUN printf 'read only = yes\n\
reverse lookup = no\n\
[mirror]\n\
    path = /export\n\
    read only = yes\n\
    reverse lookup = no\n'\
    > /etc/rsyncd.conf

# Run unprivileged
#USER nobody

# Expose port 8730 rather than default 873
EXPOSE 8730

# Run rsync in daemon mode
CMD ["rsync", "--daemon", "--no-detach", "--verbose", "--log-file=/dev/stdout", "--port=8730"]
