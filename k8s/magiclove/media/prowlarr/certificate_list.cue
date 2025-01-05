package prowlarr

import certmanagerv1 "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"

#CertificateList: certmanagerv1.#CertificateList & {
	apiVersion: "cert-manager.io/v1"
	kind:       "CertificateList"
	items: [...{
		apiVersion: "cert-manager.io/v1"
		kind:       "Certificate"
	}]
}

// A hack to prevent certificates from being pruned.
//
// https://github.com/cert-manager/cert-manager/issues/7306
#CertificateList: items: [{metadata: name: "\(#Name)-tls"}]
