package tigera_operator

import policyv1beta1 "k8s.io/api/policy/v1beta1"

podSecurityPolicyList: policyv1beta1.#PodSecurityPolicyList & {
	apiVersion: "policy/v1beta1"
	kind:       "PodSecurityPolicyList"
	items: [...{
		apiVersion: "policy/v1beta1"
		kind:       "PodSecurityPolicy"
	}]
}

podSecurityPolicyList: items: [{
	// Source: tigera-operator/templates/tigera-operator/02-podsecuritypolicy-tigera-operator.yaml
	// This should not be rendered for an OpenShift install.
	// OpenShift uses SecurityContextConstraints instead.
	metadata: annotations: "seccomp.security.alpha.kubernetes.io/allowedProfileNames": "*"
	spec: {
		privileged:               false
		allowPrivilegeEscalation: false
		requiredDropCapabilities: [
			"ALL",
		]
		volumes: [
			"hostPath",
			"configMap",
			"emptyDir",
			"projected",
			"secret",
			"downwardAPI",
			"persistentVolumeClaim",
		]
		// Assume that persistentVolumes set up by the cluster admin are safe to use.
		hostNetwork: true
		hostPorts: [{
			min: 0
			max: 65535
		}]
		hostIPC: false
		hostPID: false
		runAsUser: rule: "MustRunAsNonRoot"
		seLinux: rule:   "RunAsAny"
		supplementalGroups: {
			rule: "MustRunAs"
			ranges: [{
				// Forbid adding the root group.
				min: 1
				max: 65535
			}]
		}
		fsGroup: {
			rule: "MustRunAs"
			ranges: [{
				// Forbid adding the root group.
				min: 1
				max: 65535
			}]
		}
		readOnlyRootFilesystem: false
	}
}]
