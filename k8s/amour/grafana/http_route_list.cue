package grafana

import gatewayv1 "sigs.k8s.io/gateway-api/apis/v1"

#HTTPRouteList: gatewayv1.#HTTPRouteList & {
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "HTTPRouteList"
	items: [...{
		apiVersion: "gateway.networking.k8s.io/v1"
		kind:       "HTTPRoute"
	}]
}

#HTTPRouteList: items: [{
	spec: {
		parentRefs: [{name: #Name}]
		rules: [{
			matches: [{
				path: {
					type:  gatewayv1.#PathMatchPathPrefix
					value: "/"
				}
			}]
			backendRefs: [{
				name: #Name
				port: 80
			}]
		}]
	}
}]
