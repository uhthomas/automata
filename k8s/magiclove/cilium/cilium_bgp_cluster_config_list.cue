package cilium

import ciliumv2 "github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2"

#CiliumBGPClusterConfigList: ciliumv2.#CiliumBGPClusterConfigList & {
	apiVersion: "cilium.io/v2"
	kind:       "CiliumBGPClusterConfigList"
	items: [...{
		apiVersion: "cilium.io/v2"
		kind:       "CiliumBGPClusterConfig"
	}]
}

#CiliumBGPClusterConfigList: items: [{
	metadata: name: "default"
	spec: {
		nodeSelector: matchLabels: "kubernetes.io/hostname": "dice"
		bgpInstances: [{
			name:     "cilium"
			localASN: 65100
			peers: [{
				name:        "unifi"
				peerASN:     65000
				peerAddress: "172.16.0.1"
				peerConfigRef: name: "default"
			}]
		}]
	}
}]
