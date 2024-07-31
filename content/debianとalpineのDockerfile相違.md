---
tags:
  - Docker
---
debian : alpine
gosu -> su-exec

apt-get install --no-install -> apk add --no-cache

debianでは getent, usermod, groupmodが使えるので
alpine では shadow 不要

