package vault

import "k8s.io/api/core/v1"

#ConfigMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

#ConfigMapList: items: [{
	metadata: name: "\(#Name)-config"
	data: "extraconfig-from-values.hcl": """
		disable_mlock = true
		ui = true

		listener \"tcp\" {
		  tls_disable = 1
		  address = \"[::]:8200\"
		  cluster_address = \"[::]:8201\"
		  # Enable unauthenticated metrics access (necessary for Prometheus Operator)
		  #telemetry {
		  #  unauthenticated_metrics_access = \"true\"
		  #}
		}

		storage \"raft\" {
		  path = \"/vault/data\"
		}

		service_registration \"kubernetes\" {}
		"""
}]
