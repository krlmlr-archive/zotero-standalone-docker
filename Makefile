all: test

PARENT_NAME=$(shell sed -r -n '/^FROM/ {s/^FROM +//;p}' Dockerfile)
CONTAINER_NAME=zotero:latest
PORT=2223
DOCKER_USER=docker

killall: .FORCE
	docker kill $$(docker ps | sed -r -n '/^[^ ]+ +$(CONTAINER_NAME) / {s/ .*$$//;p}')

pull: .FORCE
	docker pull $(PARENT_NAME)

build: .FORCE
	docker build -t $(CONTAINER_NAME) .

rebuild: pull .FORCE
	docker build --no-cache -t $(CONTAINER_NAME) .

test: build .FORCE
	docker run -d -p $(PORT):22 -e SSH_KEY="$$(cat ~/.ssh/id_rsa.pub)" -u $(DOCKER_USER) $(CONTAINER_NAME)
	while ! ssh $(DOCKER_USER)@localhost -p $(PORT) -o "StrictHostKeyChecking=no" env; do sleep 0.1; done
	ssh -X $(DOCKER_USER)@localhost -p $(PORT) zotero
	docker kill $$(docker ps -ql)

debug-ssh: build .FORCE
	docker run -p $(PORT):22 -e SSH_KEY="$$(cat ~/.ssh/id_rsa.pub)" $(CONTAINER_NAME)

debug-connect: .FORCE
	ssh root@localhost -p $(PORT) -o "StrictHostKeyChecking=no" env

.FORCE:
