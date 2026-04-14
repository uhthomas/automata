package kanidm

import (
	"k8s.io/api/core/v1"
	gatewayv1 "sigs.k8s.io/gateway-api/apis/v1"
)

#BackendTLSPolicyList: gatewayv1.#BackendTLSPolicyList & {
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "BackendTLSPolicyList"
	items: [...{
		apiVersion: "gateway.networking.k8s.io/v1"
		kind:       "BackendTLSPolicy"
	}]
}

#BackendTLSPolicyList: items: [{
	spec: {
		targetRefs: [{
			group: v1.#GroupName
			kind:  "Service"
			name:  #Name
		}]
		validation: {
			hostname:                "kanidm-magiclove.hipparcos.net"
			wellKnownCACertificates: gatewayv1.#WellKnownCACertificatesSystem
		}
	}
}]
