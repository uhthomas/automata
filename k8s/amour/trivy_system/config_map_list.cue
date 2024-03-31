package trivy_system

import (
	"encoding/json"

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
	data: {
		"nodeCollector.volumes": json.Marshal([{
			name: "var-lib-etcd"
			hostPath: path: "/var/lib/etcd"
		}, {
			name: "var-lib-kubelet"
			hostPath: path: "/var/lib/kubelet"
		}, {
			name: "var-lib-kube-scheduler"
			hostPath: path: "/var/lib/kube-scheduler"
		}, {
			name: "var-lib-kube-controller-manager"
			hostPath: path: "/var/lib/kube-controller-manager"
		}, {
			name: "etc-kubernetes"
			hostPath: path: "/etc/kubernetes"
		}, {
			name: "etc-cni-netd"
			hostPath: path: "/etc/cni/net.d/"
		}])
		"nodeCollector.volumeMounts": json.Marshal([{
			name:      "var-lib-etcd"
			mountPath: "/var/lib/etcd"
			readOnly:  true
		}, {
			name:      "var-lib-kubelet"
			mountPath: "/var/lib/kubelet"
			readOnly:  true
		}, {
			name:      "var-lib-kube-scheduler"
			mountPath: "/var/lib/kube-scheduler"
			readOnly:  true
		}, {
			name:      "var-lib-kube-controller-manager"
			mountPath: "/var/lib/kube-controller-manager"
			readOnly:  true
		}, {
			name:      "etc-kubernetes"
			mountPath: "/etc/kubernetes"
			readOnly:  true
		}, {
			name:      "etc-cni-netd"
			mountPath: "/etc/cni/net.d/"
			readOnly:  true
		}])
		"scanJob.podTemplateContainerSecurityContext": json.Marshal({
			allowPrivilegeEscalation: false
			capabilities: drop: ["ALL"]
			privileged:             false
			readOnlyRootFilesystem: true
		})
		"scanJob.compressLogs":          "true"
		"vulnerabilityReports.scanner":  "Trivy"
		"configAuditReports.scanner":    "Trivy"
		"compliance.failEntriesLimit":   "10"
		"report.recordFailedChecksOnly": "true"
		"node.collector.imageRef":       "ghcr.io/aquasecurity/node-collector:0.1.2"
		"policies.bundle.oci.ref":       "ghcr.io/aquasecurity/trivy-policies:0"
		"node.collector.nodeSelector":   "true"
	}
}, {
	metadata: name: "\(#Name)-policies-config"
}, {
	metadata: name: "\(#Name)-config"
	data: {
		OPERATOR_LOG_DEV_MODE:                                      "false"
		OPERATOR_SCAN_JOB_TTL:                                      ""
		OPERATOR_SCAN_JOB_TIMEOUT:                                  "5m"
		OPERATOR_CONCURRENT_SCAN_JOBS_LIMIT:                        "10"
		OPERATOR_CONCURRENT_NODE_COLLECTOR_LIMIT:                   "1"
		OPERATOR_SCAN_JOB_RETRY_AFTER:                              "30s"
		OPERATOR_BATCH_DELETE_LIMIT:                                "10"
		OPERATOR_BATCH_DELETE_DELAY:                                "10s"
		OPERATOR_METRICS_BIND_ADDRESS:                              ":8080"
		OPERATOR_METRICS_FINDINGS_ENABLED:                          "true"
		OPERATOR_METRICS_VULN_ID_ENABLED:                           "false"
		OPERATOR_HEALTH_PROBE_BIND_ADDRESS:                         ":9090"
		OPERATOR_VULNERABILITY_SCANNER_ENABLED:                     "true"
		OPERATOR_SBOM_GENERATION_ENABLED:                           "true"
		OPERATOR_CLUSTER_SBOM_CACHE_ENABLED:                        "false"
		OPERATOR_VULNERABILITY_SCANNER_SCAN_ONLY_CURRENT_REVISIONS: "true"
		OPERATOR_SCANNER_REPORT_TTL:                                "24h"
		OPERATOR_CACHE_REPORT_TTL:                                  "120h"
		CONTROLLER_CACHE_SYNC_TIMEOUT:                              "5m"
		OPERATOR_CONFIG_AUDIT_SCANNER_ENABLED:                      "true"
		OPERATOR_RBAC_ASSESSMENT_SCANNER_ENABLED:                   "true"
		OPERATOR_INFRA_ASSESSMENT_SCANNER_ENABLED:                  "true"
		OPERATOR_CONFIG_AUDIT_SCANNER_SCAN_ONLY_CURRENT_REVISIONS:  "true"
		OPERATOR_EXPOSED_SECRET_SCANNER_ENABLED:                    "true"
		OPERATOR_METRICS_EXPOSED_SECRET_INFO_ENABLED:               "false"
		OPERATOR_METRICS_CONFIG_AUDIT_INFO_ENABLED:                 "false"
		OPERATOR_METRICS_RBAC_ASSESSMENT_INFO_ENABLED:              "false"
		OPERATOR_METRICS_INFRA_ASSESSMENT_INFO_ENABLED:             "false"
		OPERATOR_METRICS_IMAGE_INFO_ENABLED:                        "false"
		OPERATOR_METRICS_CLUSTER_COMPLIANCE_INFO_ENABLED:           "false"
		OPERATOR_WEBHOOK_BROADCAST_URL:                             ""
		OPERATOR_WEBHOOK_BROADCAST_TIMEOUT:                         "30s"
		OPERATOR_SEND_DELETED_REPORTS:                              "false"
		OPERATOR_PRIVATE_REGISTRY_SCAN_SECRETS_NAMES:               "{}"
		OPERATOR_ACCESS_GLOBAL_SECRETS_SERVICE_ACCOUNTS:            "true"
		OPERATOR_BUILT_IN_TRIVY_SERVER:                             "false"
		TRIVY_SERVER_HEALTH_CHECK_CACHE_EXPIRATION:                 "10h"
		OPERATOR_MERGE_RBAC_FINDING_WITH_CONFIG_AUDIT:              "false"
		OPERATOR_CLUSTER_COMPLIANCE_ENABLED:                        "true"
	}
}, {
	metadata: name: "\(#Name)-trivy-config"
	data: {
		"trivy.repository":                          "ghcr.io/aquasecurity/trivy"
		"trivy.tag":                                 "0.50.1"
		"trivy.imagePullPolicy":                     "IfNotPresent"
		"trivy.additionalVulnerabilityReportFields": ""
		"trivy.severity":                            "UNKNOWN,LOW,MEDIUM,HIGH,CRITICAL"
		"trivy.slow":                                "true"
		"trivy.skipJavaDBUpdate":                    "false"
		"trivy.includeDevDeps":                      "false"
		"trivy.imageScanCacheDir":                   "/tmp/trivy/.cache"
		"trivy.filesystemScanCacheDir":              "/var/trivyoperator/trivy-db"
		"trivy.dbRepository":                        "ghcr.io/aquasecurity/trivy-db"
		"trivy.javaDbRepository":                    "ghcr.io/aquasecurity/trivy-java-db"
		"trivy.command":                             "image"
		"trivy.sbomSources":                         ""
		"trivy.dbRepositoryInsecure":                "false"
		"trivy.useBuiltinRegoPolicies":              "true"
		"trivy.supportedConfigAuditKinds":           "Workload,Service,Role,ClusterRole,NetworkPolicy,Ingress,LimitRange,ResourceQuota"
		"trivy.timeout":                             "5m0s"
		"trivy.mode":                                "Standalone"
		"trivy.resources.requests.cpu":              "1"
		"trivy.resources.requests.memory":           "1Gi"
		"trivy.resources.limits.cpu":                "1"
		"trivy.resources.limits.memory":             "1Gi"
	}
}]
