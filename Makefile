home:
	kubectl kustomize kubernetes/overlays/kube-home1 -o kubernetes/cluster/kube-home1.yml
.PHONY: home
