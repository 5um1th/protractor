#
# Protractor Dockerfile
#

FROM blueimp/node:4.2

MAINTAINER Sebastian Tschan <mail@blueimp.net>

USER root

# Install build requirements for protractor:
RUN apk --no-cache add \
  python \
  make \
  g++ \
  # Install protractor:
  # node-gyp dependency build requires --unsafe-perm option for global install
  && npm install -g --unsafe-perm \
    protractor@'<3.1' \
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
    `find / -regex '.*\.py[co]'`

USER node

ENTRYPOINT ["protractor"]
