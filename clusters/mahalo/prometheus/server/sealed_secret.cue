package server

sealed_secret: [{
	kind:       "SealedSecret"
	apiVersion: "bitnami.com/v1alpha1"
	metadata: {
		name:      "thanos-sidecar"
		namespace: "prometheus"
		labels: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/version":   "2.25.1"
			"app.kubernetes.io/component": "server"
		}
	}
	spec: {
		encryptedData: "objstore.yaml": "AgBWJm2wzqqbZCc33HVHcHfij1TepbJzb8bf0mT05CQov2hzzyvKIIHOLcseXdoIXhhn9vlpk3lD/pznP++WWecqaV2Vc87thoH1BxAGrqVyEHE5wfYmC30XuTXYBjWQgb2KNAL5kpYmK9FME+QS66B8YH76k/rjC37oSnRmoUvuRN6B7snTK2rNEw2vTrFIfjV6fSCchJwdzYvi6GrqsaZrsLA9vinqcf5kJduEoL6ErUvdqiTEHeDdO9lGLCDHdPnBG6pR4HCS5cXaYpUEHDZzVK+/1CdSwx6+vIefSjVEbI/Z506HTYjR6OjgEwfJ4KUUCfNcuAPOVyaFakr49nR37oMsbEA+2ZgO0+CwfRFPTA8HDchaQ6OqMFgmTS+7f/XO1vBlm1JBvrkn2kSCsaV+zV3owaNLSNGeBAgvpRh1JCt6+Nr9P6Ifkc6AUqmtkkBUYFShZKwpbyyPV5OrtFdyzvsMpKswKOC80C86UDUrzFdxmgczojQNPMfRUkUDEe4YVBlvmnPMXsl8DHj40DEvm77CEjzgwpZpAarKOI7GLJ6HR84r6HUujEJSxbCUbBfjER/3dPVDqhvdFcczZt3wPfSzawUGfE4994NqnAtTI2s+16ONgILuzWZjQIyt1VMnNrFpkbRrffG2zVZ4Prc0aFOg1ForUN0QY70ueeWh+zGbFDKE1TpjX/CArzkqSYjOga5WebsYG+ZgwJ4sK9h+hu5W85bPaLlDjiUeXw3t4FaU8Q6OeaOMYliH3Rba09dwJ57DyehauFFq9rclBIq0TO0bxHUhziFbmEmVbgUc4luW/pWz7wOQvK0uAWcS7Yf/Yq+k60KroAebAI7021PqHwbzsh0TLwBTXSlBdCTE8EYzhl82Rb0j2AcONNZgj7qQPRNtTfs2wdjLWE6vidKRPd/a217twd/0ibgZIPSjT92rFJYTL6fxFjmJqawha+sSxhicBXv3i+cM/HQ4JqD5h0BkeKMasW6YC51jPdKxlr3ISmMSsLgGF9H1Ot0shPOIWhAJBXa3aXDYQlLWGe1Xs8KzPVI="
		template: metadata: {
			name:      "thanos-sidecar"
			namespace: "prometheus"
			labels: {
				"app.kubernetes.io/component": "sidecar"
				"app.kubernetes.io/instance":  "thanos"
				"app.kubernetes.io/name":      "thanos"
				"app.kubernetes.io/version":   "0.18.0"
			}
		}
	}
}]
