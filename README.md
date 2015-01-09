zotero-standalone-docker
========================

Debian Docker images for testing Zotero Standalone


Usage
-----

The images are based on my [debian-ssh](https://github.com/krlmlr/debian-ssh) images.
Each Debian release corresponds to a branch.  To install and test Zotero in a new
Debian "wheezy" container, run:

    git checkout wheezy
    make test

The Zotero GUI will be displayed on the local machine via X11 forwarding.
This requires a public key in `~/.ssh/id_rsa.pub`.

Two users exist in the container: `root` (superuser) and `docker` (a regular user
with passwordless `sudo`). SSH access using your key will be allowed for both
`root` and `docker` users, but Zotero complains when it's started as `root`,
so testing is done with the `docker` user.

Use `make rebuild` to pull the base image and rebuild without caching.
