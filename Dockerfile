FROM krlmlr/debian-ssh:jessie

MAINTAINER "Kirill Müller" krlmlr+docker@mailbox.org

## Set a default user. Available via runtime flag `--user docker`
## Add user to 'staff' group, granting them write privileges to /usr/local/lib/R/site.library
## User should also have & own a home directory (for rstudio or linked volumes to work properly).
RUN useradd docker \
        && mkdir /home/docker \
        && chown docker:docker /home/docker \
        && addgroup docker staff

RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends zotero-standalone && \
  true

