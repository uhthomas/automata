package cert_manager

import (
	"encoding/yaml"

	certmanagercontrollerv1alpha1 "github.com/cert-manager/cert-manager/pkg/apis/config/controller/v1alpha1"
	"k8s.io/api/core/v1"
)

#ConfigMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

#ConfigMapList: items: [{
	data: "config.yaml": yaml.Marshal(certmanagercontrollerv1alpha1.#ControllerConfiguration & {
		apiVersion:       "controller.config.cert-manager.io/v1alpha1"
		kind:             "ControllerConfiguration"
		enableGatewayAPI: true
		logging: {
			flushFrequency: "5s"
			verbosity:      2
		}
	})
}, {
	metadata: {
		name: "cert-manager-webhook"
		labels: {
			app:                           "webhook"
			"app.kubernetes.io/name":      "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "webhook"
		}
	}
}]
