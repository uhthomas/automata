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
				// Jellyfin
				ip:   "192.168.135.5"
				port: 80
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
				// Jellyfin
				ip:   "192.168.135.5"
				port: 80
			}
			protocol: wirguardv1alpha1.#EgressNetworkPolicyProtocolTCP
		}]
	}
}]
