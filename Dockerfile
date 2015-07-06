#
# Protractor Dockerfile
#

FROM blueimp/node:0.12

MAINTAINER Sebastian Tschan <mail@blueimp.net>

USER root

# Install build requirements for protractor:
RUN apk add --update \
  python \
  make \
  g++ \
  # Install protractor:
  # node-gyp dependency build requires --unsafe-perm option for global install
  && npm install -g --unsafe-perm \
    protractor@'<2.2.0' \
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

USER node

ENTRYPOINT ["protractor"]
