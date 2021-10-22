package kipp2

import networkingv1 "k8s.io/api/networking/v1"

ingressList: networkingv1.#IngressList & {
	apiVersion: "networking.k8s.io/v1"
	kind:       "IngressList"
	items: [...{
		apiVersion: "networking.k8s.io/v1"
		kind:       "Ingress"
	}]
}

ingressList: items: [{
	metadata: annotations: {
		"cert-manager.io/cluster-issuer":                      "letsencrypt"
		"nginx.ingress.kubernetes.io/auth-type":               "basic"
		"nginx.ingress.kubernetes.io/auth-secret":             "basic-auth"
		"nginx.ingress.kubernetes.io/auth-realm":              "Authentication Required"
		"nginx.ingress.kubernetes.io/proxy-body-size":         "150m"
		"nginx.ingress.kubernetes.io/proxy-request-buffering": "off"
		"nginx.ingress.kubernetes.io/server-alias":            "k2.6f.io"
		"nginx.ingress.kubernetes.io/configuration-snippet": """
			if ($host != 'k2.6f.io') {
				return 301 $scheme://k2.6f.io$request_uri;
			}
			"""
	}
	spec: {
		ingressClassName: "nginx"
		tls: [{
			hosts: [
				"k2.6f.io",
				"kipp2.mahalo.starjunk.net",
			]
			secretName: "kipp2-tls"
		}]
		rules: [{
			host: "kipp2.mahalo.starjunk.net"
			http: paths: [{
				path:     "/"
				pathType: networkingv1.#PathTypeExact
				backend: service: {
					name: "kipp2"
					port: name: "http"
				}
			}]
		}]
	}
}, {
	metadata: annotations: {
		"cert-manager.io/cluster-issuer":           "letsencrypt"
		"nginx.ingress.kubernetes.io/server-alias": "k2.6f.io"
		"nginx.ingress.kubernetes.io/use-regex": "true"
		"nginx.ingress.kubernetes.io/configuration-snippet": """
			if ($host != 'k2.6f.io') {
				return 301 $scheme://k2.6f.io$request_uri;
			}

			location = / {
				internal;
			}

			location /healthz {
				internal;
			}

			location /varz {
				internal;
			}
			"""
	}
	spec: {
		ingressClassName: "nginx"
		tls: [{
			hosts: [
				"k2.6f.io",
				"kipp2.mahalo.starjunk.net",
			]
			secretName: "kipp2-tls"
		}]
		rules: [{
			host: "kipp2.mahalo.starjunk.net"
			http: paths: [{
				path: "/.+"
				pathType: networkingv1.#PathTypeImplementationSpecific
				backend: service: {
					name: "kipp2"
					port: name: "http"
				}
			}]
		}]
	}
}]
