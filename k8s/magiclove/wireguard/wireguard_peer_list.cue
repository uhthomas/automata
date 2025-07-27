package wireguard

import (
	"crypto/md5"
	"encoding/hex"

	wirguardv1alpha1 "github.com/jodevsa/wireguard-operator/pkg/api/v1alpha1"
)

#WireguardPeerList: wirguardv1alpha1.#WireguardPeerList & {
	apiVersion: "vpn.wireguard-operator.io/v1alpha1"
	kind:       "WireguardPeerList"
	items: [...{
		apiVersion: "vpn.wireguard-operator.io/v1alpha1"
		kind:       "WireguardPeer"
	}]
}

#WireguardPeerList: items: [{
	let wireguardPublicKey = "HYaxdQdzxdEaDjszE1JSvpZ1MQRkz8UGmuiVSnjjYUE="

	metadata: name: hex.Encode(md5.Sum(wireguardPublicKey))
	spec: {
		publicKey:    wireguardPublicKey
		wireguardRef: "main"
		egressNetworkPolicies: [{
			action: wirguardv1alpha1.#EgressNetworkPolicyActionAccept
			to: {
				// Envoy Gateway LB
				ip:   "192.168.135.27"
				port: 443
			}
			protocol: wirguardv1alpha1.#EgressNetworkPolicyProtocolTCP
		}]
	}
}, {
	let wireguardPublicKey = "LsShAsakY3T4z06vjfAvW4B2TfCzFiQyi2YFe581kQ8="

	metadata: name: hex.Encode(md5.Sum(wireguardPublicKey))
	spec: {
		publicKey:    wireguardPublicKey
		wireguardRef: "main"
		egressNetworkPolicies: [{
			action: wirguardv1alpha1.#EgressNetworkPolicyActionAccept
			to: {
				// Envoy Gateway LB
				ip:   "192.168.135.27"
				port: 443
			}
			protocol: wirguardv1alpha1.#EgressNetworkPolicyProtocolTCP
		}]
	}
}, {
	let wireguardPublicKey = "GKwcHDNEzMpqG3nMCmbMt9f17X9wo0N8AqDCVsgMZQE="

	metadata: name: hex.Encode(md5.Sum(wireguardPublicKey))
	spec: {
		publicKey:    wireguardPublicKey
		wireguardRef: "main"
		egressNetworkPolicies: [{
			action: wirguardv1alpha1.#EgressNetworkPolicyActionAccept
			to: {
				// Envoy Gateway LB
				ip:   "192.168.135.27"
				port: 443
			}
			protocol: wirguardv1alpha1.#EgressNetworkPolicyProtocolTCP
		}]
	}
}, {
	let wireguardPublicKey = "2ZVBIjoV9PsaUB8JGod4qqI9uZJ9z+sYVHlxLlwLUSM="

	metadata: name: hex.Encode(md5.Sum(wireguardPublicKey))
	spec: {
		publicKey:    wireguardPublicKey
		wireguardRef: "main"
		egressNetworkPolicies: [{
			action: wirguardv1alpha1.#EgressNetworkPolicyActionAccept
			to: {
				// Envoy Gateway LB
				ip:   "192.168.135.27"
				port: 443
			}
			protocol: wirguardv1alpha1.#EgressNetworkPolicyProtocolTCP
		}]
	}
}, {
	let wireguardPublicKey = "bvan47eTWBWYEP9pR1ZdPNDBEBrVt/m3EFJbY5+WJE4="

	metadata: name: hex.Encode(md5.Sum(wireguardPublicKey))
	spec: {
		publicKey:    wireguardPublicKey
		wireguardRef: "main"
		egressNetworkPolicies: [{
			action: wirguardv1alpha1.#EgressNetworkPolicyActionAccept
			to: {
				// Envoy Gateway LB
				ip:   "192.168.135.27"
				port: 443
			}
			protocol: wirguardv1alpha1.#EgressNetworkPolicyProtocolTCP
		}]
	}
}]
