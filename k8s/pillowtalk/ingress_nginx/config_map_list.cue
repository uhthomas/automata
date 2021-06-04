package ingress_nginx

import "k8s.io/api/core/v1"

configMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

configMapList: items: [{
	metadata: {
		name: "ingress-nginx-controller"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/component": "controller"
		}
	}
	data: {
		"proxy-buffer-size":     "16k"
		"proxy-buffers-number":  "8"
		"use-forwarded-headers": "true"
		"forwarded-for-header":  "CF-Connecting-IP"
	}
}]
