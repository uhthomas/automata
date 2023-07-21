package grafana_agent

import "k8s.io/api/core/v1"

#IntegrationList: v1.#List & {
	apiVersion: "monitoring.grafana.com/v1alpha1"
	kind:       "IntegrationList"
	items: [...{
		apiVersion: "monitoring.grafana.com/v1alpha1"
		kind:       "Integration"
	}]
}

#IntegrationList: items: [{
	metadata: name: "\(#Name)-eventhandler"
	spec: {
		config: {
			cache_path:    "/etc/eventhandler/eventhandler.cache"
			logs_instance: "\(#Namespace)/\(#Name)"
		}
		name: "eventhandler"
		type: unique: true
		volumeMounts: [{
			mountPath: "/etc/eventhandler"
			name:      "agent-eventhandler"
		}]
		volumes: [{
			name: "agent-eventhandler"
			persistentVolumeClaim: claimName: #Name
		}]
	}
}]
