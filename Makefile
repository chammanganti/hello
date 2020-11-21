KUBECONFIG := .circleci/kube
REPOSITORY := chammanganti/hello
TAG := $(shell git log -1 --pretty=format:%h)
VALUES := values.yaml
NAMESPACE := project-hello

all: help

help:
	@echo "Usage:\n"
	@echo -e "\tbuild - builds the image"
	@echo -e "\tpush - pushes the image"
	@echo -e "\tdeploy - deploys the image"

build:
	docker build -t $(REPOSITORY):$(TAG) .

push:
	docker push $(REPOSITORY):$(TAG)

deploy:
	helm --kubeconfig=${KUBECONFIG} upgrade --install -f chart/$(VALUES) -n $(NAMESPACE) --set image.tag=$(TAG) hello chart