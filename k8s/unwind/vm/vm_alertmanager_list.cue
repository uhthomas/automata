package vm

import "k8s.io/api/core/v1"

// TODO: Use generated types.
//
// https://github.com/cue-lang/cue/issues/2466
#VMAlertmanagerList: v1.#List & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMAlertmanagerList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMAlertmanager"
	}]
}

#VMAlertmanagerList: items: [{
	replicaCount: 3
	storage: volumeClaimTemplate: spec: {
		storageClassName: "rook-ceph-nvme-ec-delete-block"
		resources: requests: storage: "512Mi"
	}
	securityContext: {
		runAsUser:    1000
		runAsGroup:   3000
		runAsNonRoot: true
		fsGroup:      2000
		seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
	}
	selectAllByDefault: true
}]
