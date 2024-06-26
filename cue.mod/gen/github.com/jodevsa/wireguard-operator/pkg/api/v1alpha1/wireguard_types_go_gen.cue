// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/jodevsa/wireguard-operator/pkg/api/v1alpha1

package v1alpha1

import (
	corev1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#Pending: "pending"
#Error:   "error"
#Ready:   "ready"

#WgStatusReport: {
	// A string field that represents the current status of Wireguard. This could include values like ready, pending, or error.
	status?: string @go(Status)

	// A string field that provides additional information about the status of Wireguard. This could include error messages or other information that helps to diagnose issues with the wg instance.
	message?: string @go(Message)
}

// WireguardSpec defines the desired state of Wireguard
#WireguardSpec: {
	// A string field that specifies the maximum transmission unit (MTU) size for Wireguard packets for all peers.
	mtu?: string @go(Mtu)

	// A string field that specifies the address for the Wireguard VPN server. This is the public IP address or hostname that peers will use to connect to the VPN.
	address?: string @go(Address)

	// A string field that specifies the DNS server(s) to be used by the peers.
	dns?: string @go(Dns)

	// A field that specifies the type of Kubernetes service that should be used for the Wireguard VPN. This could be NodePort or LoadBalancer, depending on the needs of the deployment.
	serviceType?: corev1.#ServiceType @go(ServiceType)

	// A field that specifies the value to use for a nodePort ServiceType
	port?: int32 @go(NodePort)

	// A map of key value strings for service annotations
	serviceAnnotations?: {[string]: string} @go(ServiceAnnotations,map[string]string)

	// A boolean field that specifies whether IP forwarding should be enabled on the Wireguard VPN pod at startup. This can be useful to enable if the peers are having problems with sending traffic to the internet.
	enableIpForwardOnPodInit?: bool @go(EnableIpForwardOnPodInit)

	// A boolean field that specifies whether to use the userspace implementation of Wireguard instead of the kernel one.
	useWgUserspaceImplementation?: bool @go(UseWgUserspaceImplementation)
}

// WireguardStatus defines the observed state of Wireguard
#WireguardStatus: {
	// A string field that specifies the address for the Wireguard VPN server that is currently being used.
	address?: string @go(Address)
	dns?:     string @go(Dns)

	// A string field that specifies the port for the Wireguard VPN server that is currently being used.
	port?: string @go(Port)

	// A string field that represents the current status of Wireguard. This could include values like ready, pending, or error.
	status?: string @go(Status)

	// A string field that provides additional information about the status of Wireguard. This could include error messages or other information that helps to diagnose issues with the wg instance.
	message?: string @go(Message)
}

// Wireguard is the Schema for the wireguards API
#Wireguard: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec?:     #WireguardSpec     @go(Spec)
	status?:   #WireguardStatus   @go(Status)
}

// WireguardList contains a list of Wireguard
#WireguardList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Wireguard] @go(Items,[]Wireguard)
}
