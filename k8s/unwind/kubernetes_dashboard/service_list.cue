package kubernetes_dashboard

import "k8s.io/api/core/v1"

#ServiceList: v1.#ServiceList & {
	apiVersion: "v1"
	kind:       "ServiceList"
	items: [...{
		apiVersion: "v1"
		kind:       "Service"
	}]
}

#ServiceList: items: [{
	metadata: annotations: "tailscale.com/hostname": "\(#Name)-unwind-k8s"
	spec: {
		ports: [{
			port:       443
			targetPort: "https"
		}]
		selector: "app.kubernetes.io/name": #Name
		type:              v1.#ServiceTypeLoadBalancer
		loadBalancerClass: "tailscale"
	}
}, {
	metadata: name: "dashboard-metrics-scraper"
	spec: {
		ports: [{
			port:       8000
			targetPort: "http"
		}]
		selector: "app.kubernetes.io/name": "dashboard-metrics-scraper"
	}
}]
