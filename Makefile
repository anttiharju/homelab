home:
	kubectl kustomize k8s/overlays/kube-home1 -o k8s/kube-home1.yml
.PHONY: home

download:
	find k8s/base -name "download.bash" -type f -exec {} \;
.PHONY: download
