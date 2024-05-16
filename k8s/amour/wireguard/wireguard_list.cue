package wireguard

import wirguardv1alpha1 "github.com/jodevsa/wireguard-operator/pkg/api/v1alpha1"

#WireguardList: wirguardv1alpha1.#WireguardList & {
	apiVersion: "vpn.wireguard-operator.io/v1alpha1"
	kind:       "WireguardList"
	items: [...{
		apiVersion: "vpn.wireguard-operator.io/v1alpha1"
		kind:       "Wireguard"
	}]
}

#WireguardList: items: [{metadata: name: "main"}]
