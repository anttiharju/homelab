build:
	kubectl kustomize k8s/cluster/kube-home1 -o k8s/kube-home1.yml
.PHONY: build

download:
	find k8s/extension -name "download.bash" -type f -exec {} \;
.PHONY: download
