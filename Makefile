build:
	kubectl kustomize k8s/overlays/kube-home1 -o k8s/kube-home1-cluster.yml
.PHONY: build

validate:
	find k8s -maxdepth 1 -name '*.yml' -exec kubeconform {} \;
.PHONY: validate

download:
	find k8s/base -name download.bash -exec {} \;
.PHONY: download

diff:
	kubectl config set-context kube-home1
	kubectl diff -f k8s/kube-home1-cluster.yml
.PHONY: diff

deploy:
	kubectl config set-context kube-home1
	kubectl apply -f k8s/kube-home1-cluster.yml
.PHONY: deploy
