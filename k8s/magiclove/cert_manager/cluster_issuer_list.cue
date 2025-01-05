package cert_manager

import certmanagerv1 "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"

#ClusterIssuerList: certmanagerv1.#ClusterIssuerList & {
	apiVersion: "cert-manager.io/v1"
	kind:       "ClusterIssuerList"
	items: [...{
		apiVersion: "cert-manager.io/v1"
		kind:       "ClusterIssuer"
	}]
}

#ClusterIssuerList: items: [{
	metadata: name: "self-signed"
	spec: selfSigned: {}
}]
