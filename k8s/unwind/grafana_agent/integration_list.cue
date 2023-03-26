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
	spec: {
		config: {
			cache_path:    "/etc/eventhandler/eventhandler.cache"
			logs_instance: "\(#Namespace)/grafana-agent-logs"
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
}, {
	spec: {
		config: {
			autoscrape: {
				enable:           true
				metrics_instance: "\(#Namespace)/grafana-agent-metrics"
			}
			procfs_path: "host/proc"
			rootfs_path: "/host/root"
			sysfs_path:  "/host/sys"
		}
		name: "node_exporter"
		type: {
			allNodes: true
			unique:   true
		}
		volumeMounts: [{
			mountPath: "/host/root"
			name:      "rootfs"
		}, {
			mountPath: "/host/sys"
			name:      "sysfs"
		}, {
			mountPath: "/host/proc"
			name:      "procfs"
		}]
		volumes: [{
			hostPath: path: "/"
			name: "rootfs"
		}, {
			hostPath: path: "/sys"
			name: "sysfs"
		}, {
			hostPath: path: "/proc"
			name: "procfs"
		}]
	}
}]
