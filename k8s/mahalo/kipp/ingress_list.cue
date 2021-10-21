package kipp

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
		"nginx.ingress.kubernetes.io/proxy-body-size":         "150m"
		"nginx.ingress.kubernetes.io/proxy-request-buffering": "off"
		"nginx.ingress.kubernetes.io/server-alias":            "conf.6f.io,kipp.6f.io"
		"nginx.ingress.kubernetes.io/configuration-snippet": """
			if ($host != 'kipp.6f.io') {
				return 301 $scheme://kipp.6f.io$request_uri;
			}

			location = / {
				if ($request_method = 'POST') {
					return 301 $scheme://$host/auth$request_uri;
				}
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
				"conf.6f.io",
				"kipp.6f.io",
				"kipp.mahalo.starjunk.net",
			]
			secretName: "kipp-tls"
		}]
		rules: [{
			host: "kipp.mahalo.starjunk.net"
			http: paths: [{
				path: "/"
				pathType: networkingv1.#PathTypeExact
				backend: service: {
					name: "kipp-static"
					port: name: "http"
				}
			}, {
				pathType: networkingv1.#PathTypeImplementationSpecific
				backend: service: {
					name: "kipp"
					port: name: "http"
				}
			}]
		}]
	}
}, {
	metadata: {
		name: "kipp-auth"
		annotations: {
			"cert-manager.io/cluster-issuer":                      "letsencrypt"
			"nginx.ingress.kubernetes.io/app-root":                "/auth"
			"nginx.ingress.kubernetes.io/proxy-body-size":         "150m"
			"nginx.ingress.kubernetes.io/proxy-request-buffering": "off"
			"nginx.ingress.kubernetes.io/server-alias":            "conf.6f.io,kipp.6f.io"
		}
	}
	spec: {
		ingressClassName: "nginx"
		tls: [{
			hosts: [
				"conf.6f.io",
				"kipp.6f.io",
				"kipp.mahalo.starjunk.net",
			]
			secretName: "kipp-tls"
		}]
		rules: [{
			host: "kipp.mahalo.starjunk.net"
			http: paths: [{
				path:     "/"
				pathType: networkingv1.#PathTypeExact
				backend: service: {
					name: "kipp"
					port: name: "http"
				}
			}]
		}]
	}
}]
