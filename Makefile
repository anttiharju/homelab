home:
	kubectl kustomize k8s/overlays/kube-home1 -o k8s/cluster/kube-home1.yml
.PHONY: home
