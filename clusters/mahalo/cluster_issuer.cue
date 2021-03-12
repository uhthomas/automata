package mahalo

cluster_issuer: [{
	apiVersion: "cert-manager.io/v1"
	kind:       "ClusterIssuer"
	metadata: name: "letsencrypt"
	spec: acme: {
		email:  "mahalo@6f.io"
		server: "https://acme-v02.api.letsencrypt.org/directory"
		privateKeySecretRef: name: "letsencrypt"
		solvers: [{
			http01: ingress: class: "nginx"
		}]
	}
}]
