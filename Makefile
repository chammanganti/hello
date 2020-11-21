PROJECT := hello
KUBECONFIG := .circleci/kube
REPOSITORY := chammanganti
TAG := $(shell git log -1 --pretty=format:%h)
VALUES := values.yaml
NAMESPACE := project-$(PROJECT)

all: help

help:
	@echo "Usage:\n"
	@echo -e "\tbuild - builds the image"
	@echo -e "\tpush - pushes the image"
	@echo -e "\tdeploy - deploys the image"

build:
	docker build -t $(REPOSITORY)/$(PROJECT):$(TAG) .

push:
	docker push $(REPOSITORY)/$(PROJECT):$(TAG)

deploy:
	helm --kubeconfig=${KUBECONFIG} upgrade --install -f chart/$(VALUES) -n $(NAMESPACE) --set image.tag=$(TAG) $(PROJECT) chart