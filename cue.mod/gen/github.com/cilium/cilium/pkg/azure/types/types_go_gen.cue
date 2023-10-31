// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/pkg/azure/types

package types

// ProviderPrefix is the prefix used to indicate that a k8s ProviderID
// represents an Azure resource
#ProviderPrefix: "azure://"

// InterfaceAddressLimit is the maximum number of addresses on an interface
//
//
// For more information:
// https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits?toc=%2fazure%2fvirtual-network%2ftoc.json#networking-limits
#InterfaceAddressLimit: 256

// StateSucceeded is the address state for a successfully provisioned address
#StateSucceeded: "succeeded"

// AzureSpec is the Azure specification of a node running via the Azure IPAM
//
// The Azure specification can either be provided explicitly by the user or the
// cilium agent running on the node can be instructed to create the CiliumNode
// custom resource along with an Azure specification when the node registers
// itself to the Kubernetes cluster.
// This struct is embedded into v2.CiliumNode
//
// +k8s:deepcopy-gen=true
#AzureSpec: {
	// InterfaceName is the name of the interface the cilium-operator
	// will use to allocate all the IPs on
	//
	// +kubebuilder:validation:Optional
	"interface-name"?: string @go(InterfaceName)
}

// AzureStatus is the status of Azure addressing of the node.
// This struct is embedded into v2.CiliumNode
//
// +k8s:deepcopy-gen=true
#AzureStatus: {
	// Interfaces is the list of interfaces on the node
	//
	// +optional
	interfaces?: [...#AzureInterface] @go(Interfaces,[]AzureInterface)
}

// AzureAddress is an IP address assigned to an AzureInterface
#AzureAddress: {
	// IP is the ip address of the address
	ip?: string @go(IP)

	// Subnet is the subnet the address belongs to
	subnet?: string @go(Subnet)

	// State is the provisioning state of the address
	state?: string @go(State)
}

// AzureInterface represents an Azure Interface
//
// +k8s:deepcopy-gen=true
#AzureInterface: {
	// ID is the identifier
	//
	// +optional
	id?: string @go(ID)

	// Name is the name of the interface
	//
	// +optional
	name?: string @go(Name)

	// MAC is the mac address
	//
	// +optional
	mac?: string @go(MAC)

	// State is the provisioning state
	//
	// +optional
	state?: string @go(State)

	// Addresses is the list of all IPs associated with the interface,
	// including all secondary addresses
	//
	// +optional
	addresses?: [...#AzureAddress] @go(Addresses,[]AzureAddress)

	// SecurityGroup is the security group associated with the interface
	"security-group"?: string @go(SecurityGroup)

	// GatewayIP is the interface's subnet's default route
	//
	// OBSOLETE: This field is obsolete, please use Gateway field instead.
	//
	// +optional
	GatewayIP: string

	// Gateway is the interface's subnet's default route
	//
	// +optional
	gateway: string @go(Gateway)

	// CIDR is the range that the interface belongs to.
	//
	// +optional
	cidr?: string @go(CIDR)
}
