// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/pkg/policy/api

package api

// EgressCommonRule is a rule that shares some of its fields across the
// EgressRule and EgressDenyRule. It's publicly exported so the code generators
// can generate code for this structure.
//
// +deepequal-gen:private-method=true
#EgressCommonRule: {
	// ToEndpoints is a list of endpoints identified by an EndpointSelector to
	// which the endpoints subject to the rule are allowed to communicate.
	//
	// Example:
	// Any endpoint with the label "role=frontend" can communicate with any
	// endpoint carrying the label "role=backend".
	//
	// +kubebuilder:validation:Optional
	toEndpoints?: [...#EndpointSelector] @go(ToEndpoints,[]EndpointSelector)

	// ToRequires is a list of additional constraints which must be met
	// in order for the selected endpoints to be able to connect to other
	// endpoints. These additional constraints do no by itself grant access
	// privileges and must always be accompanied with at least one matching
	// ToEndpoints.
	//
	// Example:
	// Any Endpoint with the label "team=A" requires any endpoint to which it
	// communicates to also carry the label "team=A".
	//
	// +kubebuilder:validation:Optional
	toRequires?: [...#EndpointSelector] @go(ToRequires,[]EndpointSelector)

	// ToCIDR is a list of IP blocks which the endpoint subject to the rule
	// is allowed to initiate connections. Only connections destined for
	// outside of the cluster and not targeting the host will be subject
	// to CIDR rules.  This will match on the destination IP address of
	// outgoing connections. Adding a prefix into ToCIDR or into ToCIDRSet
	// with no ExcludeCIDRs is equivalent. Overlaps are allowed between
	// ToCIDR and ToCIDRSet.
	//
	// Example:
	// Any endpoint with the label "app=database-proxy" is allowed to
	// initiate connections to 10.2.3.0/24
	//
	// +kubebuilder:validation:Optional
	toCIDR?: #CIDRSlice @go(ToCIDR)

	// ToCIDRSet is a list of IP blocks which the endpoint subject to the rule
	// is allowed to initiate connections to in addition to connections
	// which are allowed via ToEndpoints, along with a list of subnets contained
	// within their corresponding IP block to which traffic should not be
	// allowed. This will match on the destination IP address of outgoing
	// connections. Adding a prefix into ToCIDR or into ToCIDRSet with no
	// ExcludeCIDRs is equivalent. Overlaps are allowed between ToCIDR and
	// ToCIDRSet.
	//
	// Example:
	// Any endpoint with the label "app=database-proxy" is allowed to
	// initiate connections to 10.2.3.0/24 except from IPs in subnet 10.2.3.0/28.
	//
	// +kubebuilder:validation:Optional
	toCIDRSet?: #CIDRRuleSlice @go(ToCIDRSet)

	// ToEntities is a list of special entities to which the endpoint subject
	// to the rule is allowed to initiate connections. Supported entities are
	// `world`, `cluster`,`host`,`remote-node`,`kube-apiserver`, `init`,
	// `health`,`unmanaged` and `all`.
	//
	// +kubebuilder:validation:Optional
	toEntities?: #EntitySlice @go(ToEntities)

	// ToServices is a list of services to which the endpoint subject
	// to the rule is allowed to initiate connections.
	// Currently Cilium only supports toServices for K8s services without
	// selectors.
	//
	// Example:
	// Any endpoint with the label "app=backend-app" is allowed to
	// initiate connections to all cidrs backing the "external-service" service
	//
	// +kubebuilder:validation:Optional
	toServices?: [...#Service] @go(ToServices,[]Service)

	// ToGroups is a directive that allows the integration with multiple outside
	// providers. Currently, only AWS is supported, and the rule can select by
	// multiple sub directives:
	//
	// Example:
	// toGroups:
	// - aws:
	//     securityGroupsIds:
	//     - 'sg-XXXXXXXXXXXXX'
	//
	// +kubebuilder:validation:Optional
	toGroups?: [...#Groups] @go(ToGroups,[]Groups)

	// ToNodes is a list of nodes identified by an
	// EndpointSelector to which endpoints subject to the rule is allowed to communicate.
	//
	// +kubebuilder:validation:Optional
	toNodes?: [...#EndpointSelector] @go(ToNodes,[]EndpointSelector)
}

// EgressRule contains all rule types which can be applied at egress, i.e.
// network traffic that originates inside the endpoint and exits the endpoint
// selected by the endpointSelector.
//
//   - All members of this structure are optional. If omitted or empty, the
//     member will have no effect on the rule.
//
//   - If multiple members of the structure are specified, then all members
//     must match in order for the rule to take effect. The exception to this
//     rule is the ToRequires member; the effects of any Requires field in any
//     rule will apply to all other rules as well.
//
//   - ToEndpoints, ToCIDR, ToCIDRSet, ToEntities, ToServices and ToGroups are
//     mutually exclusive. Only one of these members may be present within an
//     individual rule.
#EgressRule: {
	#EgressCommonRule

	// ToPorts is a list of destination ports identified by port number and
	// protocol which the endpoint subject to the rule is allowed to
	// connect to.
	//
	// Example:
	// Any endpoint with the label "role=frontend" is allowed to initiate
	// connections to destination port 8080/tcp
	//
	// +kubebuilder:validation:Optional
	toPorts?: #PortRules @go(ToPorts)

	// ToFQDN allows whitelisting DNS names in place of IPs. The IPs that result
	// from DNS resolution of `ToFQDN.MatchName`s are added to the same
	// EgressRule object as ToCIDRSet entries, and behave accordingly. Any L4 and
	// L7 rules within this EgressRule will also apply to these IPs.
	// The DNS -> IP mapping is re-resolved periodically from within the
	// cilium-agent, and the IPs in the DNS response are effected in the policy
	// for selected pods as-is (i.e. the list of IPs is not modified in any way).
	// Note: An explicit rule to allow for DNS traffic is needed for the pods, as
	// ToFQDN counts as an egress rule and will enforce egress policy when
	// PolicyEnforcment=default.
	// Note: If the resolved IPs are IPs within the kubernetes cluster, the
	// ToFQDN rule will not apply to that IP.
	// Note: ToFQDN cannot occur in the same policy as other To* rules.
	//
	// +kubebuilder:validation:Optional
	toFQDNs?: #FQDNSelectorSlice @go(ToFQDNs)

	// ICMPs is a list of ICMP rule identified by type number
	// which the endpoint subject to the rule is allowed to connect to.
	//
	// Example:
	// Any endpoint with the label "app=httpd" is allowed to initiate
	// type 8 ICMP connections.
	//
	// +kubebuilder:validation:Optional
	icmps?: #ICMPRules @go(ICMPs)

	// Authentication is the required authentication type for the allowed traffic, if any.
	//
	// +kubebuilder:validation:Optional
	authentication?: null | #Authentication @go(Authentication,*Authentication)
}

// EgressDenyRule contains all rule types which can be applied at egress, i.e.
// network traffic that originates inside the endpoint and exits the endpoint
// selected by the endpointSelector.
//
//   - All members of this structure are optional. If omitted or empty, the
//     member will have no effect on the rule.
//
//   - If multiple members of the structure are specified, then all members
//     must match in order for the rule to take effect. The exception to this
//     rule is the ToRequires member; the effects of any Requires field in any
//     rule will apply to all other rules as well.
//
//   - ToEndpoints, ToCIDR, ToCIDRSet, ToEntities, ToServices and ToGroups are
//     mutually exclusive. Only one of these members may be present within an
//     individual rule.
#EgressDenyRule: {
	#EgressCommonRule

	// ToPorts is a list of destination ports identified by port number and
	// protocol which the endpoint subject to the rule is not allowed to connect
	// to.
	//
	// Example:
	// Any endpoint with the label "role=frontend" is not allowed to initiate
	// connections to destination port 8080/tcp
	//
	// +kubebuilder:validation:Optional
	toPorts?: #PortDenyRules @go(ToPorts)

	// ICMPs is a list of ICMP rule identified by type number
	// which the endpoint subject to the rule is not allowed to connect to.
	//
	// Example:
	// Any endpoint with the label "app=httpd" is not allowed to initiate
	// type 8 ICMP connections.
	//
	// +kubebuilder:validation:Optional
	icmps?: #ICMPRules @go(ICMPs)
}
