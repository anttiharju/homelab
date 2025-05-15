build:
	kubectl kustomize k8s/cluster/kube-home1 -o k8s/kube-home1.yml
.PHONY: build

validate:
	find k8s -maxdepth 1 -name '*.yml' -exec kubeconform {} \;
.PHONY: validate

download:
	find k8s/extension -name download.bash -exec scripts/download.bash {} \;
.PHONY: download
