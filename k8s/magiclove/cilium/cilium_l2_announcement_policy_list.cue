package cilium

import ciliumv2alpha1 "github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2alpha1"

#CiliumL2AnnouncementPolicyList: ciliumv2alpha1.#CiliumL2AnnouncementPolicyList & {
	apiVersion: "cilium.io/v2alpha1"
	kind:       "CiliumL2AnnouncementPolicyList"
	items: [...{
		apiVersion: "cilium.io/v2alpha1"
		kind:       "CiliumL2AnnouncementPolicy"
	}]
}

#CiliumL2AnnouncementPolicyList: items: [{
	metadata: name: "cilium-l2-announcement-policy-default"
	spec: {
		externalIPs:     true
		loadBalancerIPs: true
	}
}]
