package vm

import (
	"list"

	gatewayv1 "sigs.k8s.io/gateway-api/apis/v1"
)

#HTTPRouteList: gatewayv1.#HTTPRouteList & {
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "HTTPRouteList"
	items: [...{
		apiVersion: "gateway.networking.k8s.io/v1"
		kind:       "HTTPRoute"
	}]
}

#HTTPRouteList: items: list.Concat([for gateway in _#Gateways {[{
	metadata: name: "\(gateway)-http"
	spec: {
		parentRefs: [{
			name:        gateway
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
	metadata: name: "\(gateway)-https"
	spec: {
		parentRefs: [{
			name:        gateway
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
				name: "\(gateway)-vm-additional-service"
				port: 80
			}]
		}]
	}
}]}])
