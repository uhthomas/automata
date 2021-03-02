package desire

cluster_issuer: {
	apiVersion: "cert-manager.io/v1alpha2"
	kind:       "ClusterIssuer"
	metadata: name: "letsencrypt"
	spec: acme: {
		email:  "letsencrypt@6f.io"
		server: "https://acme-v02.api.letsencrypt.org/directory"
		privateKeySecretRef: name: "letsencrypt"
		solvers: [{
			http01: ingress: class: "nginx"
		}]
	}
}
