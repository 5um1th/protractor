#
# Protractor Dockerfile
#

FROM alpine:3.2

MAINTAINER Sebastian Tschan <mail@blueimp.net>

ENV NODEJS_VERSION 0.12.2
ENV PROTRACTOR_VERSION 2.1.0

# Install build requirements for protractor:
RUN apk add --update \
  nodejs=$NODEJS_VERSION-r0 \
  python \
  make \
  g++ \
  # Install protractor as NPM package:
  # node-gyp dependency build requires --unsafe-perm option for global install
  && npm install -g --unsafe-perm \
    protractor@$PROTRACTOR_VERSION \
  # Remove packages which are no longer needed:
  && apk del --purge \
    python \
    make \
    g++ \
  # Clean up obsolete files:
  && rm -rf \
    /tmp/* \
    /root/.npm \
    /root/.node-gyp \
    /var/cache/apk/* \
    `find / -regex '.*\.py[co]'`

# Add protractor system group/user with gid/uid 1000.
# This is a workaround for boot2docker issue #581, see
# https://github.com/boot2docker/boot2docker/issues/581
RUN addgroup -g 1000 protractor \
  && adduser -D -u 1000 -G protractor protractor

USER protractor

WORKDIR /home/protractor

ENTRYPOINT ["protractor"]
