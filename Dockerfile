FROM krlmlr/debian-ssh:jessie
#
#
#
MAINTAINER "Kirill Müller" krlmlr+docker@mailbox.org

RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends zotero-standalone && \
  true
