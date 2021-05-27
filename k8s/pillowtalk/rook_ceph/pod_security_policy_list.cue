package rook_ceph

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
	metadata: {
		// Note: Kubernetes matches PSPs to deployments alphabetically. In some environments, this PSP may
		// need to be renamed with a value that will match before others.
		name: "00-rook-privileged"
		annotations: {
			"seccomp.security.alpha.kubernetes.io/allowedProfileNames": "runtime/default"
			"seccomp.security.alpha.kubernetes.io/defaultProfileName":  "runtime/default"
		}
	}
	spec: {
		privileged: true
		allowedCapabilities:
		// required by CSI
		[
			"SYS_ADMIN",
		]
		// fsGroup - the flexVolume agent has fsGroup capabilities and could potentially be any group
		fsGroup: {
			rule: "RunAsAny"
		}
		// runAsUser, supplementalGroups - Rook needs to run some pods as root
		// Ceph pods could be run as the Ceph user, but that user isn't always known ahead of time
		runAsUser: {
			rule: "RunAsAny"
		}
		supplementalGroups: rule: "RunAsAny"
		// seLinux - seLinux context is unknown ahead of time; set if this is well-known
		seLinux: {
			rule: "RunAsAny"
		}
		volumes:
		// recommended minimum set
		[
			"configMap",
			"downwardAPI",
			"emptyDir",
			"persistentVolumeClaim",
			"secret",
			"projected",
			"hostPath",
			"flexVolume",
		]
		// required for Rook
		// allowedHostPaths can be set to Rook's known host volume mount points when they are fully-known
		// allowedHostPaths:
		//   - pathPrefix: "/run/udev"  # for OSD prep
		//     readOnly: false
		//   - pathPrefix: "/dev"  # for OSD prep
		//     readOnly: false
		//   - pathPrefix: "/var/lib/rook"  # or whatever the dataDirHostPath value is set to
		//     readOnly: false
		// Ceph requires host IPC for setting up encrypted devices
		hostIPC: true
		// Ceph OSDs need to share the same PID namespace
		hostPID: true
		// hostNetwork can be set to 'false' if host networking isn't used
		hostNetwork: true
		hostPorts: [{
			// Ceph messenger protocol v1
			min: 6789
			max: 6790
		}, {
			// <- support old default port
			// Ceph messenger protocol v2
			min: 3300
			max: 3300
		}, {
			// Ceph RADOS ports for OSDs, MDSes
			min: 6800
			max: 7300
		}, {
			// # Ceph dashboard port HTTP (not recommended)
			// - min: 7000
			//   max: 7000
			// Ceph dashboard port HTTPS
			min: 8443
			max: 8443
		}, {
			// Ceph mgr Prometheus Metrics
			min: 9283
			max: 9283
		}]
	}
}]
