package olm

import "k8s.io/api/core/v1"

#ClusterServiceVersionList: v1.#List & {
	apiVersion: "operators.coreos.com/v1"
	kind:       "ClusterServiceVersionList"
	items: [...{
		apiVersion: "operators.coreos.com/v1"
		kind:       "ClusterServiceVersion"
	}]
}

#ClusterServiceVersionList: items: [{
	metadata: {
		name: "packageserver"
		labels: "olm.version": "v0.24.0"
	}
	spec: {
		displayName:    "Package Server"
		description:    "Represents an Operator package that is available from a given CatalogSource which will resolve to a ClusterServiceVersion."
		minKubeVersion: "1.11.0"
		keywords: ["packagemanifests", "olm", "packages"]
		maintainers: [{
			name:  "Red Hat"
			email: "openshift-operators@redhat.com"
		}]
		provider: name: "Red Hat"
		links: [{
			name: "Package Server"
			url:  "https://github.com/operator-framework/operator-lifecycle-manager/tree/master/pkg/package-server"
		}]
		installModes: [{
			type:      "OwnNamespace"
			supported: true
		}, {
			type:      "SingleNamespace"
			supported: true
		}, {
			type:      "MultiNamespace"
			supported: true
		}, {
			type:      "AllNamespaces"
			supported: true
		}]
		install: {
			strategy: "deployment"
			spec: {
				clusterPermissions: [{
					serviceAccountName: "olm-operator-serviceaccount"
					rules: [{
						apiGroups: [
							"authorization.k8s.io",
						]
						resources: [
							"subjectaccessreviews",
						]
						verbs: [
							"create",
							"get",
						]
					}, {
						apiGroups: [
							"",
						]
						resources: [
							"configmaps",
						]
						verbs: [
							"get",
							"list",
							"watch",
						]
					}, {
						apiGroups: [
							"operators.coreos.com",
						]
						resources: [
							"catalogsources",
						]
						verbs: [
							"get",
							"list",
							"watch",
						]
					}, {
						apiGroups: [
							"packages.operators.coreos.com",
						]
						resources: [
							"packagemanifests",
						]
						verbs: [
							"get",
							"list",
						]
					}]
				}]
				deployments: [{
					name: "packageserver"
					spec: {
						strategy: {
							type: "RollingUpdate"
							rollingUpdate: {
								maxUnavailable: 1
								maxSurge:       1
							}
						}
						replicas: 2
						selector: matchLabels: app: "packageserver"
						template: {
							metadata: labels: app: "packageserver"
							spec: {
								securityContext: {
									runAsNonRoot: true
									seccompProfile: type: "RuntimeDefault"
								}
								serviceAccountName: "olm-operator-serviceaccount"
								nodeSelector: "kubernetes.io/os": "linux"
								containers: [{
									name: "packageserver"
									securityContext: {
										allowPrivilegeEscalation: false
										capabilities: drop: ["ALL"]
									}
									command: [
										"/bin/package-server",
										"-v=4",
										"--secure-port",
										"5443",
										"--global-namespace",
										"olm",
									]
									image:           "quay.io/operator-framework/olm@sha256:f9ea8cef95ac9b31021401d4863711a5eec904536b449724e0f00357548a31e7"
									imagePullPolicy: "Always"
									ports: [{
										containerPort: 5443
									}]
									livenessProbe: httpGet: {
										scheme: "HTTPS"
										path:   "/healthz"
										port:   5443
									}
									readinessProbe: httpGet: {
										scheme: "HTTPS"
										path:   "/healthz"
										port:   5443
									}
									terminationMessagePolicy: "FallbackToLogsOnError"
									resources: requests: {
										cpu:    "10m"
										memory: "50Mi"
									}
									volumeMounts: [{
										name:      "tmpfs"
										mountPath: "/tmp"
									}]
								}]
								volumes: [{
									name: "tmpfs"
									emptyDir: {}
								}]
							}
						}
					}
				}]
			}
		}
		maturity: "alpha"
		version:  "v0.24.0"
		apiservicedefinitions: owned: [{
			group:          "packages.operators.coreos.com"
			version:        "v1"
			kind:           "PackageManifest"
			name:           "packagemanifests"
			displayName:    "PackageManifest"
			description:    "A PackageManifest is a resource generated from existing CatalogSources and their ConfigMaps"
			deploymentName: "packageserver"
			containerPort:  5443
		}]
	}
}]
