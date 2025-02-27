// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/pkg/alibabacloud/eni/types

package types

// Spec is the ENI specification of a node. This specification is considered
// by the cilium-operator to act as an IPAM operator and makes ENI IPs available
// via the IPAMSpec section.
//
// The ENI specification can either be provided explicitly by the user or the
// cilium-agent running on the node can be instructed to create the CiliumNode
// custom resource along with an ENI specification when the node registers
// itself to the Kubernetes cluster.
#Spec: {
	// InstanceType is the ECS instance type, e.g. "ecs.g6.2xlarge"
	//
	// +kubebuilder:validation:Optional
	"instance-type"?: string @go(InstanceType)

	// AvailabilityZone is the availability zone to use when allocating
	// ENIs.
	//
	// +kubebuilder:validation:Optional
	"availability-zone"?: string @go(AvailabilityZone)

	// VPCID is the VPC ID to use when allocating ENIs.
	//
	// +kubebuilder:validation:Optional
	"vpc-id"?: string @go(VPCID)

	// CIDRBlock is vpc ipv4 CIDR
	//
	// +kubebuilder:validation:Optional
	"cidr-block"?: string @go(CIDRBlock)

	// VSwitches is the ID of vSwitch available for ENI
	//
	// +kubebuilder:validation:Optional
	vswitches?: [...string] @go(VSwitches,[]string)

	// VSwitchTags is the list of tags to use when evaluating which
	// vSwitch to use for the ENI.
	//
	// +kubebuilder:validation:Optional
	"vswitch-tags"?: {[string]: string} @go(VSwitchTags,map[string]string)

	// SecurityGroups is the list of security groups to attach to any ENI
	// that is created and attached to the instance.
	//
	// +kubebuilder:validation:Optional
	"security-groups"?: [...string] @go(SecurityGroups,[]string)

	// SecurityGroupTags is the list of tags to use when evaluating which
	// security groups to use for the ENI.
	//
	// +kubebuilder:validation:Optional
	"security-group-tags"?: {[string]: string} @go(SecurityGroupTags,map[string]string)
}

// ENITypePrimary is the type for ENI
#ENITypePrimary: "Primary"

// ENITypeSecondary is the type for ENI
#ENITypeSecondary: "Secondary"

// ENI represents an AlibabaCloud Elastic Network Interface
#ENI: {
	// NetworkInterfaceID is the ENI id
	//
	// +optional
	"network-interface-id"?: string @go(NetworkInterfaceID)

	// MACAddress is the mac address of the ENI
	//
	// +optional
	"mac-address"?: string @go(MACAddress)

	// Type is the ENI type Primary or Secondary
	//
	// +optional
	type?: string @go(Type)

	// InstanceID is the InstanceID using this ENI
	//
	// +optional
	"instance-id"?: string @go(InstanceID)

	// SecurityGroupIDs is the security group ids used by this ENI
	//
	// +optional
	"security-groupids"?: [...string] @go(SecurityGroupIDs,[]string)

	// VPC is the vpc to which the ENI belongs
	//
	// +optional
	vpc?: #VPC @go(VPC)

	// ZoneID is the zone to which the ENI belongs
	//
	// +optional
	"zone-id"?: string @go(ZoneID)

	// VSwitch is the vSwitch the ENI is using
	//
	// +optional
	vswitch?: #VSwitch @go(VSwitch)

	// PrimaryIPAddress is the primary IP on ENI
	//
	// +optional
	"primary-ip-address"?: string @go(PrimaryIPAddress)

	// PrivateIPSets is the list of all IPs on the ENI, including PrimaryIPAddress
	//
	// +optional
	"private-ipsets"?: [...#PrivateIPSet] @go(PrivateIPSets,[]PrivateIPSet)

	// Tags is the tags on this ENI
	//
	// +optional
	tags?: {[string]: string} @go(Tags,map[string]string)
}

// ENIStatus is the status of ENI addressing of the node
#ENIStatus: {
	// ENIs is the list of ENIs on the node
	//
	// +optional
	enis?: {[string]: #ENI} @go(ENIs,map[string]ENI)
}

// PrivateIPSet is a nested struct in ecs response
#PrivateIPSet: {
	"private-ip-address"?: string @go(PrivateIpAddress)
	primary?:              bool   @go(Primary)
}

#VPC: {
	// VPCID is the vpc to which the ENI belongs
	//
	// +optional
	"vpc-id"?: string @go(VPCID)

	// CIDRBlock is the VPC IPv4 CIDR
	//
	// +optional
	cidr?: string @go(CIDRBlock)

	// IPv6CIDRBlock is the VPC IPv6 CIDR
	//
	// +optional
	"ipv6-cidr"?: string @go(IPv6CIDRBlock)

	// SecondaryCIDRs is the list of Secondary CIDRs associated with the VPC
	//
	// +optional
	"secondary-cidrs"?: [...string] @go(SecondaryCIDRs,[]string)
}

#VSwitch: {
	// VSwitchID is the vSwitch to which the ENI belongs
	//
	// +optional
	"vswitch-id"?: string @go(VSwitchID)

	// CIDRBlock is the vSwitch IPv4 CIDR
	//
	// +optional
	cidr?: string @go(CIDRBlock)

	// IPv6CIDRBlock is the vSwitch IPv6 CIDR
	//
	// +optional
	"ipv6-cidr"?: string @go(IPv6CIDRBlock)
}
