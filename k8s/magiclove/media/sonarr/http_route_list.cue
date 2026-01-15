package sonarr

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
	metadata: name: "\(#Name)-http"
	spec: {
		parentRefs: [{
			name:        #Name
			sectionName: "http"
		}]
		rules: [{
			filters: [{
				type: gatewayv1.#HTTPRouteFilterRequestRedirect
				requestRedirect: {
					scheme:     "https"
					statusCode: 301
				}
			}]
		}]
	}
}, {
	metadata: name: "\(#Name)-https"
	spec: {
		parentRefs: [{
			name:        #Name
			sectionName: "https"
		}]
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
			timeouts: request: "1m"
		}]
	}
}]
