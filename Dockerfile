#
# Protractor Dockerfile
#

FROM node:0.10

MAINTAINER Sebastian Tschan <mail@blueimp.net>

ENV PROTRACTOR_VERSION 2.1.0

# node-gyp dependency build requires --unsafe-perm option for global install:
RUN npm install -g --unsafe-perm \
  protractor@$PROTRACTOR_VERSION \
  && npm cache clean

# Add protractor system group/user with gid/uid 1000.
# This is a workaround for boot2docker issue #581, see
# https://github.com/boot2docker/boot2docker/issues/581
RUN groupadd -g 1000 protractor
RUN useradd -g protractor -u 1000 protractor

USER protractor

WORKDIR /home/protractor

ENTRYPOINT ["protractor"]
