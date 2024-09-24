package gateway_api

import apiextensionsv1 "k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1"

#CustomResourceDefinitionList: apiextensionsv1.#CustomResourceDefinitionList & {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinitionList"
	items: [...{
		apiVersion: "apiextensions.k8s.io/v1"
		kind:       "CustomResourceDefinition"
	}]
}

#CustomResourceDefinitionList: items: [{
	metadata: {
		name: "backendlbpolicies.gateway.networking.k8s.io"
		annotations: {
			"api-approved.kubernetes.io":               "https://github.com/kubernetes-sigs/gateway-api/pull/2997"
			"gateway.networking.k8s.io/bundle-version": "v1.1.0"
			"gateway.networking.k8s.io/channel":        "experimental"
		}
	}
	spec: {
		group: "gateway.networking.k8s.io"
		names: {
			categories: ["gateway-api"]
			kind:     "BackendLBPolicy"
			listKind: "BackendLBPolicyList"
			plural:   "backendlbpolicies"
			shortNames: ["blbpolicy"]
			singular: "backendlbpolicy"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1alpha2"
			schema: openAPIV3Schema: {
				description: """
					BackendLBPolicy provides a way to define load balancing rules
					for a backend.
					"""
				properties: {
					apiVersion: {
						description: """
	APIVersion defines the versioned schema of this representation of an object.
	Servers should convert recognized schemas to the latest internal value, and
	may reject unrecognized values.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	"""
						type: "string"
					}
					kind: {
						description: """
	Kind is a string value representing the REST resource this object represents.
	Servers may infer this from the endpoint the client submits requests to.
	Cannot be updated.
	In CamelCase.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	"""
						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec defines the desired state of BackendLBPolicy."
						properties: {
							sessionPersistence: {
								description: """
	SessionPersistence defines and configures session persistence
	for the backend.


	Support: Extended
	"""
								properties: {
									absoluteTimeout: {
										description: """
	AbsoluteTimeout defines the absolute timeout of the persistent
	session. Once the AbsoluteTimeout duration has elapsed, the
	session becomes invalid.


	Support: Extended
	"""
										pattern: "^([0-9]{1,5}(h|m|s|ms)){1,4}$"
										type:    "string"
									}
									cookieConfig: {
										description: """
	CookieConfig provides configuration settings that are specific
	to cookie-based session persistence.


	Support: Core
	"""
										properties: lifetimeType: {
											default: "Session"
											description: """
	LifetimeType specifies whether the cookie has a permanent or
	session-based lifetime. A permanent cookie persists until its
	specified expiry time, defined by the Expires or Max-Age cookie
	attributes, while a session cookie is deleted when the current
	session ends.


	When set to "Permanent", AbsoluteTimeout indicates the
	cookie's lifetime via the Expires or Max-Age cookie attributes
	and is required.


	When set to "Session", AbsoluteTimeout indicates the
	absolute lifetime of the cookie tracked by the gateway and
	is optional.


	Support: Core for "Session" type


	Support: Extended for "Permanent" type
	"""
											enum: [
												"Permanent",
												"Session",
											]
											type: "string"
										}
										type: "object"
									}
									idleTimeout: {
										description: """
	IdleTimeout defines the idle timeout of the persistent session.
	Once the session has been idle for more than the specified
	IdleTimeout duration, the session becomes invalid.


	Support: Extended
	"""
										pattern: "^([0-9]{1,5}(h|m|s|ms)){1,4}$"
										type:    "string"
									}
									sessionName: {
										description: """
	SessionName defines the name of the persistent session token
	which may be reflected in the cookie or the header. Users
	should avoid reusing session names to prevent unintended
	consequences, such as rejection or unpredictable behavior.


	Support: Implementation-specific
	"""
										maxLength: 128
										type:      "string"
									}
									type: {
										default: "Cookie"
										description: """
	Type defines the type of session persistence such as through
	the use a header or cookie. Defaults to cookie based session
	persistence.


	Support: Core for "Cookie" type


	Support: Extended for "Header" type
	"""
										enum: [
											"Cookie",
											"Header",
										]
										type: "string"
									}
								}
								type: "object"
								"x-kubernetes-validations": [{
									message: "AbsoluteTimeout must be specified when cookie lifetimeType is Permanent"
									rule:    "!has(self.cookieConfig.lifetimeType) || self.cookieConfig.lifetimeType != 'Permanent' || has(self.absoluteTimeout)"
								}]
							}
							targetRefs: {
								description: """
	TargetRef identifies an API object to apply policy to.
	Currently, Backends (i.e. Service, ServiceImport, or any
	implementation-specific backendRef) are the only valid API
	target references.
	"""
								items: {
									description: """
	LocalPolicyTargetReference identifies an API object to apply a direct or
	inherited policy to. This should be used as part of Policy resources
	that can target Gateway API resources. For more information on how this
	policy attachment model works, and a sample Policy resource, refer to
	the policy attachment documentation for Gateway API.
	"""
									properties: {
										group: {
											description: "Group is the group of the target resource."
											maxLength:   253
											pattern:     "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:        "string"
										}
										kind: {
											description: "Kind is kind of the target resource."
											maxLength:   63
											minLength:   1
											pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:        "string"
										}
										name: {
											description: "Name is the name of the target resource."
											maxLength:   253
											minLength:   1
											type:        "string"
										}
									}
									required: [
										"group",
										"kind",
										"name",
									]
									type: "object"
								}
								maxItems: 16
								minItems: 1
								type:     "array"
								"x-kubernetes-list-map-keys": [
									"group",
									"kind",
									"name",
								]
								"x-kubernetes-list-type": "map"
							}
						}
						required: ["targetRefs"]
						type: "object"
					}
					status: {
						description: "Status defines the current state of BackendLBPolicy."
						properties: ancestors: {
							description: """
	Ancestors is a list of ancestor resources (usually Gateways) that are
	associated with the policy, and the status of the policy with respect to
	each ancestor. When this policy attaches to a parent, the controller that
	manages the parent and the ancestors MUST add an entry to this list when
	the controller first sees the policy and SHOULD update the entry as
	appropriate when the relevant ancestor is modified.


	Note that choosing the relevant ancestor is left to the Policy designers;
	an important part of Policy design is designing the right object level at
	which to namespace this status.


	Note also that implementations MUST ONLY populate ancestor status for
	the Ancestor resources they are responsible for. Implementations MUST
	use the ControllerName field to uniquely identify the entries in this list
	that they are responsible for.


	Note that to achieve this, the list of PolicyAncestorStatus structs
	MUST be treated as a map with a composite key, made up of the AncestorRef
	and ControllerName fields combined.


	A maximum of 16 ancestors will be represented in this list. An empty list
	means the Policy is not relevant for any ancestors.


	If this slice is full, implementations MUST NOT add further entries.
	Instead they MUST consider the policy unimplementable and signal that
	on any related resources such as the ancestor that would be referenced
	here. For example, if this list was full on BackendTLSPolicy, no
	additional Gateways would be able to reference the Service targeted by
	the BackendTLSPolicy.
	"""
							items: {
								description: """
	PolicyAncestorStatus describes the status of a route with respect to an
	associated Ancestor.


	Ancestors refer to objects that are either the Target of a policy or above it
	in terms of object hierarchy. For example, if a policy targets a Service, the
	Policy's Ancestors are, in order, the Service, the HTTPRoute, the Gateway, and
	the GatewayClass. Almost always, in this hierarchy, the Gateway will be the most
	useful object to place Policy status on, so we recommend that implementations
	SHOULD use Gateway as the PolicyAncestorStatus object unless the designers
	have a _very_ good reason otherwise.


	In the context of policy attachment, the Ancestor is used to distinguish which
	resource results in a distinct application of this policy. For example, if a policy
	targets a Service, it may have a distinct result per attached Gateway.


	Policies targeting the same resource may have different effects depending on the
	ancestors of those resources. For example, different Gateways targeting the same
	Service may have different capabilities, especially if they have different underlying
	implementations.


	For example, in BackendTLSPolicy, the Policy attaches to a Service that is
	used as a backend in a HTTPRoute that is itself attached to a Gateway.
	In this case, the relevant object for status is the Gateway, and that is the
	ancestor object referred to in this status.


	Note that a parent is also an ancestor, so for objects where the parent is the
	relevant object for status, this struct SHOULD still be used.


	This struct is intended to be used in a slice that's effectively a map,
	with a composite key made up of the AncestorRef and the ControllerName.
	"""
								properties: {
									ancestorRef: {
										description: """
	AncestorRef corresponds with a ParentRef in the spec that this
	PolicyAncestorStatus struct describes the status of.
	"""
										properties: {
											group: {
												default: "gateway.networking.k8s.io"
												description: """
	Group is the group of the referent.
	When unspecified, "gateway.networking.k8s.io" is inferred.
	To set the core API group (such as for a "Service" kind referent),
	Group must be explicitly set to "" (empty string).


	Support: Core
	"""
												maxLength: 253
												pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
											kind: {
												default: "Gateway"
												description: """
	Kind is kind of the referent.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	Support for other resources is Implementation-Specific.
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:      "string"
											}
											name: {
												description: """
	Name is the name of the referent.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												type:      "string"
											}
											namespace: {
												description: """
	Namespace is the namespace of the referent. When unspecified, this refers
	to the local namespace of the Route.


	Note that there are specific rules for ParentRefs which cross namespace
	boundaries. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example:
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable any other kind of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.



	Support: Core
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
												type:      "string"
											}
											port: {
												description: """
	Port is the network port this Route targets. It can be interpreted
	differently based on the type of parent resource.


	When the parent resource is a Gateway, this targets all listeners
	listening on the specified port that also support this kind of Route(and
	select this Route). It's not recommended to set `Port` unless the
	networking behaviors specified in a Route must apply to a specific port
	as opposed to a listener(s) whose port(s) may be changed. When both Port
	and SectionName are specified, the name and port of the selected listener
	must match both specified values.



	When the parent resource is a Service, this targets a specific port in the
	Service spec. When both Port (experimental) and SectionName are specified,
	the name and port of the selected port must match both specified values.



	Implementations MAY choose to support other parent resources.
	Implementations supporting other types of parent resources MUST clearly
	document how/if Port is interpreted.


	For the purpose of status, an attachment is considered successful as
	long as the parent resource accepts it partially. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
	from the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route,
	the Route MUST be considered detached from the Gateway.


	Support: Extended
	"""
												format:  "int32"
												maximum: 65535
												minimum: 1
												type:    "integer"
											}
											sectionName: {
												description: """
	SectionName is the name of a section within the target resource. In the
	following resources, SectionName is interpreted as the following:


	* Gateway: Listener name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.
	* Service: Port name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.


	Implementations MAY choose to support attaching Routes to other resources.
	If that is the case, they MUST clearly document how SectionName is
	interpreted.


	When unspecified (empty string), this will reference the entire resource.
	For the purpose of status, an attachment is considered successful if at
	least one section in the parent resource accepts it. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
	the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route, the
	Route MUST be considered detached from the Gateway.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
										}
										required: ["name"]
										type: "object"
									}
									conditions: {
										description: "Conditions describes the status of the Policy with respect to the given Ancestor."
										items: {
											description: """
	Condition contains details for one aspect of the current state of this API Resource.
	---
	This struct is intended for direct use as an array at the field path .status.conditions.  For example,


	\ttype FooStatus struct{
	\t    // Represents the observations of a foo's current state.
	\t    // Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
	\t    // +patchMergeKey=type
	\t    // +patchStrategy=merge
	\t    // +listType=map
	\t    // +listMapKey=type
	\t    Conditions []metav1.Condition `json:"conditions,omitempty" patchStrategy:"merge" patchMergeKey:"type" protobuf:"bytes,1,rep,name=conditions"`


	\t    // other fields
	\t}
	"""
											properties: {
												lastTransitionTime: {
													description: """
	lastTransitionTime is the last time the condition transitioned from one status to another.
	This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
	"""
													format: "date-time"
													type:   "string"
												}
												message: {
													description: """
	message is a human readable message indicating details about the transition.
	This may be an empty string.
	"""
													maxLength: 32768
													type:      "string"
												}
												observedGeneration: {
													description: """
	observedGeneration represents the .metadata.generation that the condition was set based upon.
	For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
	with respect to the current state of the instance.
	"""
													format:  "int64"
													minimum: 0
													type:    "integer"
												}
												reason: {
													description: """
	reason contains a programmatic identifier indicating the reason for the condition's last transition.
	Producers of specific condition types may define expected values and meanings for this field,
	and whether the values are considered a guaranteed API.
	The value should be a CamelCase string.
	This field may not be empty.
	"""
													maxLength: 1024
													minLength: 1
													pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
													type:      "string"
												}
												status: {
													description: "status of the condition, one of True, False, Unknown."
													enum: [
														"True",
														"False",
														"Unknown",
													]
													type: "string"
												}
												type: {
													description: """
	type of condition in CamelCase or in foo.example.com/CamelCase.
	---
	Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be
	useful (see .node.status.conditions), the ability to deconflict is important.
	The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)
	"""
													maxLength: 316
													pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
													type:      "string"
												}
											}
											required: [
												"lastTransitionTime",
												"message",
												"reason",
												"status",
												"type",
											]
											type: "object"
										}
										maxItems: 8
										minItems: 1
										type:     "array"
										"x-kubernetes-list-map-keys": ["type"]
										"x-kubernetes-list-type": "map"
									}
									controllerName: {
										description: """
	ControllerName is a domain/path string that indicates the name of the
	controller that wrote this status. This corresponds with the
	controllerName field on GatewayClass.


	Example: "example.net/gateway-controller".


	The format of this field is DOMAIN "/" PATH, where DOMAIN and PATH are
	valid Kubernetes names
	(https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).


	Controllers MUST populate this field when writing status. Controllers should ensure that
	entries to status populated with their ControllerName are cleaned up when they are no
	longer necessary.
	"""
										maxLength: 253
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
										type:      "string"
									}
								}
								required: [
									"ancestorRef",
									"controllerName",
								]
								type: "object"
							}
							maxItems: 16
							type:     "array"
						}
						required: ["ancestors"]
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}, {
	metadata: {
		name: "backendtlspolicies.gateway.networking.k8s.io"
		labels: "gateway.networking.k8s.io/policy": "Direct"
		annotations: {
			"api-approved.kubernetes.io":               "https://github.com/kubernetes-sigs/gateway-api/pull/2997"
			"gateway.networking.k8s.io/bundle-version": "v1.1.0"
			"gateway.networking.k8s.io/channel":        "experimental"
		}
	}
	spec: {
		group: "gateway.networking.k8s.io"
		names: {
			categories: ["gateway-api"]
			kind:     "BackendTLSPolicy"
			listKind: "BackendTLSPolicyList"
			plural:   "backendtlspolicies"
			shortNames: ["btlspolicy"]
			singular: "backendtlspolicy"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1alpha3"
			schema: openAPIV3Schema: {
				description: """
					BackendTLSPolicy provides a way to configure how a Gateway
					connects to a Backend via TLS.
					"""
				properties: {
					apiVersion: {
						description: """
	APIVersion defines the versioned schema of this representation of an object.
	Servers should convert recognized schemas to the latest internal value, and
	may reject unrecognized values.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	"""
						type: "string"
					}
					kind: {
						description: """
	Kind is a string value representing the REST resource this object represents.
	Servers may infer this from the endpoint the client submits requests to.
	Cannot be updated.
	In CamelCase.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	"""
						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec defines the desired state of BackendTLSPolicy."
						properties: {
							targetRefs: {
								description: """
	TargetRefs identifies an API object to apply the policy to.
	Only Services have Extended support. Implementations MAY support
	additional objects, with Implementation Specific support.
	Note that this config applies to the entire referenced resource
	by default, but this default may change in the future to provide
	a more granular application of the policy.


	Support: Extended for Kubernetes Service


	Support: Implementation-specific for any other resource
	"""
								items: {
									description: """
	LocalPolicyTargetReferenceWithSectionName identifies an API object to apply a
	direct policy to. This should be used as part of Policy resources that can
	target single resources. For more information on how this policy attachment
	mode works, and a sample Policy resource, refer to the policy attachment
	documentation for Gateway API.


	Note: This should only be used for direct policy attachment when references
	to SectionName are actually needed. In all other cases,
	LocalPolicyTargetReference should be used.
	"""
									properties: {
										group: {
											description: "Group is the group of the target resource."
											maxLength:   253
											pattern:     "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:        "string"
										}
										kind: {
											description: "Kind is kind of the target resource."
											maxLength:   63
											minLength:   1
											pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:        "string"
										}
										name: {
											description: "Name is the name of the target resource."
											maxLength:   253
											minLength:   1
											type:        "string"
										}
										sectionName: {
											description: """
	SectionName is the name of a section within the target resource. When
	unspecified, this targetRef targets the entire resource. In the following
	resources, SectionName is interpreted as the following:


	* Gateway: Listener name
	* HTTPRoute: HTTPRouteRule name
	* Service: Port name


	If a SectionName is specified, but does not exist on the targeted object,
	the Policy must fail to attach, and the policy implementation should record
	a `ResolvedRefs` or similar Condition in the Policy's status.
	"""
											maxLength: 253
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
									}
									required: [
										"group",
										"kind",
										"name",
									]
									type: "object"
								}
								maxItems: 16
								minItems: 1
								type:     "array"
							}
							validation: {
								description: "Validation contains backend TLS validation configuration."
								properties: {
									caCertificateRefs: {
										description: """
	CACertificateRefs contains one or more references to Kubernetes objects that
	contain a PEM-encoded TLS CA certificate bundle, which is used to
	validate a TLS handshake between the Gateway and backend Pod.


	If CACertificateRefs is empty or unspecified, then WellKnownCACertificates must be
	specified. Only one of CACertificateRefs or WellKnownCACertificates may be specified,
	not both. If CACertifcateRefs is empty or unspecified, the configuration for
	WellKnownCACertificates MUST be honored instead if supported by the implementation.


	References to a resource in a different namespace are invalid for the
	moment, although we will revisit this in the future.


	A single CACertificateRef to a Kubernetes ConfigMap kind has "Core" support.
	Implementations MAY choose to support attaching multiple certificates to
	a backend, but this behavior is implementation-specific.


	Support: Core - An optional single reference to a Kubernetes ConfigMap,
	with the CA certificate in a key named `ca.crt`.


	Support: Implementation-specific (More than one reference, or other kinds
	of resources).
	"""
										items: {
											description: """
	LocalObjectReference identifies an API object within the namespace of the
	referrer.
	The API object must be valid in the cluster; the Group and Kind must
	be registered in the cluster for this reference to be valid.


	References to objects with invalid Group and Kind are not valid, and must
	be rejected by the implementation, with appropriate Conditions set
	on the containing object.
	"""
											properties: {
												group: {
													description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
													maxLength: 253
													pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
													type:      "string"
												}
												kind: {
													description: "Kind is kind of the referent. For example \"HTTPRoute\" or \"Service\"."
													maxLength:   63
													minLength:   1
													pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
													type:        "string"
												}
												name: {
													description: "Name is the name of the referent."
													maxLength:   253
													minLength:   1
													type:        "string"
												}
											}
											required: [
												"group",
												"kind",
												"name",
											]
											type: "object"
										}
										maxItems: 8
										type:     "array"
									}
									hostname: {
										description: """
	Hostname is used for two purposes in the connection between Gateways and
	backends:


	1. Hostname MUST be used as the SNI to connect to the backend (RFC 6066).
	2. Hostname MUST be used for authentication and MUST match the certificate
	   served by the matching backend.


	Support: Core
	"""
										maxLength: 253
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
										type:      "string"
									}
									wellKnownCACertificates: {
										description: """
	WellKnownCACertificates specifies whether system CA certificates may be used in
	the TLS handshake between the gateway and backend pod.


	If WellKnownCACertificates is unspecified or empty (""), then CACertificateRefs
	must be specified with at least one entry for a valid configuration. Only one of
	CACertificateRefs or WellKnownCACertificates may be specified, not both. If an
	implementation does not support the WellKnownCACertificates field or the value
	supplied is not supported, the Status Conditions on the Policy MUST be
	updated to include an Accepted: False Condition with Reason: Invalid.


	Support: Implementation-specific
	"""
										enum: ["System"]
										type: "string"
									}
								}
								required: ["hostname"]
								type: "object"
								"x-kubernetes-validations": [{
									message: "must not contain both CACertificateRefs and WellKnownCACertificates"
									rule:    "!(has(self.caCertificateRefs) && size(self.caCertificateRefs) > 0 && has(self.wellKnownCACertificates) && self.wellKnownCACertificates != \"\")"
								}, {
									message: "must specify either CACertificateRefs or WellKnownCACertificates"
									rule:    "(has(self.caCertificateRefs) && size(self.caCertificateRefs) > 0 || has(self.wellKnownCACertificates) && self.wellKnownCACertificates != \"\")"
								}]
							}
						}
						required: [
							"targetRefs",
							"validation",
						]
						type: "object"
					}
					status: {
						description: "Status defines the current state of BackendTLSPolicy."
						properties: ancestors: {
							description: """
	Ancestors is a list of ancestor resources (usually Gateways) that are
	associated with the policy, and the status of the policy with respect to
	each ancestor. When this policy attaches to a parent, the controller that
	manages the parent and the ancestors MUST add an entry to this list when
	the controller first sees the policy and SHOULD update the entry as
	appropriate when the relevant ancestor is modified.


	Note that choosing the relevant ancestor is left to the Policy designers;
	an important part of Policy design is designing the right object level at
	which to namespace this status.


	Note also that implementations MUST ONLY populate ancestor status for
	the Ancestor resources they are responsible for. Implementations MUST
	use the ControllerName field to uniquely identify the entries in this list
	that they are responsible for.


	Note that to achieve this, the list of PolicyAncestorStatus structs
	MUST be treated as a map with a composite key, made up of the AncestorRef
	and ControllerName fields combined.


	A maximum of 16 ancestors will be represented in this list. An empty list
	means the Policy is not relevant for any ancestors.


	If this slice is full, implementations MUST NOT add further entries.
	Instead they MUST consider the policy unimplementable and signal that
	on any related resources such as the ancestor that would be referenced
	here. For example, if this list was full on BackendTLSPolicy, no
	additional Gateways would be able to reference the Service targeted by
	the BackendTLSPolicy.
	"""
							items: {
								description: """
	PolicyAncestorStatus describes the status of a route with respect to an
	associated Ancestor.


	Ancestors refer to objects that are either the Target of a policy or above it
	in terms of object hierarchy. For example, if a policy targets a Service, the
	Policy's Ancestors are, in order, the Service, the HTTPRoute, the Gateway, and
	the GatewayClass. Almost always, in this hierarchy, the Gateway will be the most
	useful object to place Policy status on, so we recommend that implementations
	SHOULD use Gateway as the PolicyAncestorStatus object unless the designers
	have a _very_ good reason otherwise.


	In the context of policy attachment, the Ancestor is used to distinguish which
	resource results in a distinct application of this policy. For example, if a policy
	targets a Service, it may have a distinct result per attached Gateway.


	Policies targeting the same resource may have different effects depending on the
	ancestors of those resources. For example, different Gateways targeting the same
	Service may have different capabilities, especially if they have different underlying
	implementations.


	For example, in BackendTLSPolicy, the Policy attaches to a Service that is
	used as a backend in a HTTPRoute that is itself attached to a Gateway.
	In this case, the relevant object for status is the Gateway, and that is the
	ancestor object referred to in this status.


	Note that a parent is also an ancestor, so for objects where the parent is the
	relevant object for status, this struct SHOULD still be used.


	This struct is intended to be used in a slice that's effectively a map,
	with a composite key made up of the AncestorRef and the ControllerName.
	"""
								properties: {
									ancestorRef: {
										description: """
	AncestorRef corresponds with a ParentRef in the spec that this
	PolicyAncestorStatus struct describes the status of.
	"""
										properties: {
											group: {
												default: "gateway.networking.k8s.io"
												description: """
	Group is the group of the referent.
	When unspecified, "gateway.networking.k8s.io" is inferred.
	To set the core API group (such as for a "Service" kind referent),
	Group must be explicitly set to "" (empty string).


	Support: Core
	"""
												maxLength: 253
												pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
											kind: {
												default: "Gateway"
												description: """
	Kind is kind of the referent.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	Support for other resources is Implementation-Specific.
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:      "string"
											}
											name: {
												description: """
	Name is the name of the referent.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												type:      "string"
											}
											namespace: {
												description: """
	Namespace is the namespace of the referent. When unspecified, this refers
	to the local namespace of the Route.


	Note that there are specific rules for ParentRefs which cross namespace
	boundaries. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example:
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable any other kind of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.



	Support: Core
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
												type:      "string"
											}
											port: {
												description: """
	Port is the network port this Route targets. It can be interpreted
	differently based on the type of parent resource.


	When the parent resource is a Gateway, this targets all listeners
	listening on the specified port that also support this kind of Route(and
	select this Route). It's not recommended to set `Port` unless the
	networking behaviors specified in a Route must apply to a specific port
	as opposed to a listener(s) whose port(s) may be changed. When both Port
	and SectionName are specified, the name and port of the selected listener
	must match both specified values.



	When the parent resource is a Service, this targets a specific port in the
	Service spec. When both Port (experimental) and SectionName are specified,
	the name and port of the selected port must match both specified values.



	Implementations MAY choose to support other parent resources.
	Implementations supporting other types of parent resources MUST clearly
	document how/if Port is interpreted.


	For the purpose of status, an attachment is considered successful as
	long as the parent resource accepts it partially. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
	from the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route,
	the Route MUST be considered detached from the Gateway.


	Support: Extended
	"""
												format:  "int32"
												maximum: 65535
												minimum: 1
												type:    "integer"
											}
											sectionName: {
												description: """
	SectionName is the name of a section within the target resource. In the
	following resources, SectionName is interpreted as the following:


	* Gateway: Listener name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.
	* Service: Port name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.


	Implementations MAY choose to support attaching Routes to other resources.
	If that is the case, they MUST clearly document how SectionName is
	interpreted.


	When unspecified (empty string), this will reference the entire resource.
	For the purpose of status, an attachment is considered successful if at
	least one section in the parent resource accepts it. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
	the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route, the
	Route MUST be considered detached from the Gateway.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
										}
										required: ["name"]
										type: "object"
									}
									conditions: {
										description: "Conditions describes the status of the Policy with respect to the given Ancestor."
										items: {
											description: """
	Condition contains details for one aspect of the current state of this API Resource.
	---
	This struct is intended for direct use as an array at the field path .status.conditions.  For example,


	\ttype FooStatus struct{
	\t    // Represents the observations of a foo's current state.
	\t    // Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
	\t    // +patchMergeKey=type
	\t    // +patchStrategy=merge
	\t    // +listType=map
	\t    // +listMapKey=type
	\t    Conditions []metav1.Condition `json:"conditions,omitempty" patchStrategy:"merge" patchMergeKey:"type" protobuf:"bytes,1,rep,name=conditions"`


	\t    // other fields
	\t}
	"""
											properties: {
												lastTransitionTime: {
													description: """
	lastTransitionTime is the last time the condition transitioned from one status to another.
	This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
	"""
													format: "date-time"
													type:   "string"
												}
												message: {
													description: """
	message is a human readable message indicating details about the transition.
	This may be an empty string.
	"""
													maxLength: 32768
													type:      "string"
												}
												observedGeneration: {
													description: """
	observedGeneration represents the .metadata.generation that the condition was set based upon.
	For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
	with respect to the current state of the instance.
	"""
													format:  "int64"
													minimum: 0
													type:    "integer"
												}
												reason: {
													description: """
	reason contains a programmatic identifier indicating the reason for the condition's last transition.
	Producers of specific condition types may define expected values and meanings for this field,
	and whether the values are considered a guaranteed API.
	The value should be a CamelCase string.
	This field may not be empty.
	"""
													maxLength: 1024
													minLength: 1
													pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
													type:      "string"
												}
												status: {
													description: "status of the condition, one of True, False, Unknown."
													enum: [
														"True",
														"False",
														"Unknown",
													]
													type: "string"
												}
												type: {
													description: """
	type of condition in CamelCase or in foo.example.com/CamelCase.
	---
	Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be
	useful (see .node.status.conditions), the ability to deconflict is important.
	The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)
	"""
													maxLength: 316
													pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
													type:      "string"
												}
											}
											required: [
												"lastTransitionTime",
												"message",
												"reason",
												"status",
												"type",
											]
											type: "object"
										}
										maxItems: 8
										minItems: 1
										type:     "array"
										"x-kubernetes-list-map-keys": ["type"]
										"x-kubernetes-list-type": "map"
									}
									controllerName: {
										description: """
	ControllerName is a domain/path string that indicates the name of the
	controller that wrote this status. This corresponds with the
	controllerName field on GatewayClass.


	Example: "example.net/gateway-controller".


	The format of this field is DOMAIN "/" PATH, where DOMAIN and PATH are
	valid Kubernetes names
	(https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).


	Controllers MUST populate this field when writing status. Controllers should ensure that
	entries to status populated with their ControllerName are cleaned up when they are no
	longer necessary.
	"""
										maxLength: 253
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
										type:      "string"
									}
								}
								required: [
									"ancestorRef",
									"controllerName",
								]
								type: "object"
							}
							maxItems: 16
							type:     "array"
						}
						required: ["ancestors"]
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}, {
	metadata: {
		name: "gatewayclasses.gateway.networking.k8s.io"
		annotations: {
			"api-approved.kubernetes.io":               "https://github.com/kubernetes-sigs/gateway-api/pull/2997"
			"gateway.networking.k8s.io/bundle-version": "v1.1.0"
			"gateway.networking.k8s.io/channel":        "experimental"
		}
	}
	spec: {
		group: "gateway.networking.k8s.io"
		names: {
			categories: ["gateway-api"]
			kind:     "GatewayClass"
			listKind: "GatewayClassList"
			plural:   "gatewayclasses"
			shortNames: ["gc"]
			singular: "gatewayclass"
		}
		scope: apiextensionsv1.#ClusterScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.controllerName"
				name:     "Controller"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Accepted\")].status"
				name:     "Accepted"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".spec.description"
				name:     "Description"
				priority: 1
				type:     "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: """
					GatewayClass describes a class of Gateways available to the user for creating
					Gateway resources.


					It is recommended that this resource be used as a template for Gateways. This
					means that a Gateway is based on the state of the GatewayClass at the time it
					was created and changes to the GatewayClass or associated parameters are not
					propagated down to existing Gateways. This recommendation is intended to
					limit the blast radius of changes to GatewayClass or associated parameters.
					If implementations choose to propagate GatewayClass changes to existing
					Gateways, that MUST be clearly documented by the implementation.


					Whenever one or more Gateways are using a GatewayClass, implementations SHOULD
					add the `gateway-exists-finalizer.gateway.networking.k8s.io` finalizer on the
					associated GatewayClass. This ensures that a GatewayClass associated with a
					Gateway is not deleted while in use.


					GatewayClass is a Cluster level resource.
					"""
				properties: {
					apiVersion: {
						description: """
	APIVersion defines the versioned schema of this representation of an object.
	Servers should convert recognized schemas to the latest internal value, and
	may reject unrecognized values.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	"""
						type: "string"
					}
					kind: {
						description: """
	Kind is a string value representing the REST resource this object represents.
	Servers may infer this from the endpoint the client submits requests to.
	Cannot be updated.
	In CamelCase.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	"""
						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec defines the desired state of GatewayClass."
						properties: {
							controllerName: {
								description: """
	ControllerName is the name of the controller that is managing Gateways of
	this class. The value of this field MUST be a domain prefixed path.


	Example: "example.net/gateway-controller".


	This field is not mutable and cannot be empty.


	Support: Core
	"""
								maxLength: 253
								minLength: 1
								pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
								type:      "string"
								"x-kubernetes-validations": [{
									message: "Value is immutable"
									rule:    "self == oldSelf"
								}]
							}
							description: {
								description: "Description helps describe a GatewayClass with more details."
								maxLength:   64
								type:        "string"
							}
							parametersRef: {
								description: """
	ParametersRef is a reference to a resource that contains the configuration
	parameters corresponding to the GatewayClass. This is optional if the
	controller does not require any additional configuration.


	ParametersRef can reference a standard Kubernetes resource, i.e. ConfigMap,
	or an implementation-specific custom resource. The resource can be
	cluster-scoped or namespace-scoped.


	If the referent cannot be found, the GatewayClass's "InvalidParameters"
	status condition will be true.


	A Gateway for this GatewayClass may provide its own `parametersRef`. When both are specified,
	the merging behavior is implementation specific.
	It is generally recommended that GatewayClass provides defaults that can be overridden by a Gateway.


	Support: Implementation-specific
	"""
								properties: {
									group: {
										description: "Group is the group of the referent."
										maxLength:   253
										pattern:     "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
										type:        "string"
									}
									kind: {
										description: "Kind is kind of the referent."
										maxLength:   63
										minLength:   1
										pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
										type:        "string"
									}
									name: {
										description: "Name is the name of the referent."
										maxLength:   253
										minLength:   1
										type:        "string"
									}
									namespace: {
										description: """
	Namespace is the namespace of the referent.
	This field is required when referring to a Namespace-scoped resource and
	MUST be unset when referring to a Cluster-scoped resource.
	"""
										maxLength: 63
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
										type:      "string"
									}
								}
								required: [
									"group",
									"kind",
									"name",
								]
								type: "object"
							}
						}
						required: ["controllerName"]
						type: "object"
					}
					status: {
						default: conditions: [{
							lastTransitionTime: "1970-01-01T00:00:00Z"
							message:            "Waiting for controller"
							reason:             "Waiting"
							status:             "Unknown"
							type:               "Accepted"
						}]
						description: """
	Status defines the current state of GatewayClass.


	Implementations MUST populate status on all GatewayClass resources which
	specify their controller name.
	"""
						properties: {
							conditions: {
								default: [{
									lastTransitionTime: "1970-01-01T00:00:00Z"
									message:            "Waiting for controller"
									reason:             "Pending"
									status:             "Unknown"
									type:               "Accepted"
								}]
								description: """
	Conditions is the current status from the controller for
	this GatewayClass.


	Controllers should prefer to publish conditions using values
	of GatewayClassConditionType for the type of each Condition.
	"""
								items: {
									description: """
	Condition contains details for one aspect of the current state of this API Resource.
	---
	This struct is intended for direct use as an array at the field path .status.conditions.  For example,


	\ttype FooStatus struct{
	\t    // Represents the observations of a foo's current state.
	\t    // Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
	\t    // +patchMergeKey=type
	\t    // +patchStrategy=merge
	\t    // +listType=map
	\t    // +listMapKey=type
	\t    Conditions []metav1.Condition `json:"conditions,omitempty" patchStrategy:"merge" patchMergeKey:"type" protobuf:"bytes,1,rep,name=conditions"`


	\t    // other fields
	\t}
	"""
									properties: {
										lastTransitionTime: {
											description: """
	lastTransitionTime is the last time the condition transitioned from one status to another.
	This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
	"""
											format: "date-time"
											type:   "string"
										}
										message: {
											description: """
	message is a human readable message indicating details about the transition.
	This may be an empty string.
	"""
											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: """
	observedGeneration represents the .metadata.generation that the condition was set based upon.
	For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
	with respect to the current state of the instance.
	"""
											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: """
	reason contains a programmatic identifier indicating the reason for the condition's last transition.
	Producers of specific condition types may define expected values and meanings for this field,
	and whether the values are considered a guaranteed API.
	The value should be a CamelCase string.
	This field may not be empty.
	"""
											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: """
	type of condition in CamelCase or in foo.example.com/CamelCase.
	---
	Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be
	useful (see .node.status.conditions), the ability to deconflict is important.
	The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)
	"""
											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								maxItems: 8
								type:     "array"
								"x-kubernetes-list-map-keys": ["type"]
								"x-kubernetes-list-type": "map"
							}
							supportedFeatures: {
								description: """
	SupportedFeatures is the set of features the GatewayClass support.
	It MUST be sorted in ascending alphabetical order.

	"""
								items: {
									description: """
	SupportedFeature is used to describe distinct features that are covered by
	conformance tests.
	"""
									type: "string"
								}
								maxItems:                 64
								type:                     "array"
								"x-kubernetes-list-type": "set"
							}
						}
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".spec.controllerName"
				name:     "Controller"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Accepted\")].status"
				name:     "Accepted"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".spec.description"
				name:     "Description"
				priority: 1
				type:     "string"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: """
					GatewayClass describes a class of Gateways available to the user for creating
					Gateway resources.


					It is recommended that this resource be used as a template for Gateways. This
					means that a Gateway is based on the state of the GatewayClass at the time it
					was created and changes to the GatewayClass or associated parameters are not
					propagated down to existing Gateways. This recommendation is intended to
					limit the blast radius of changes to GatewayClass or associated parameters.
					If implementations choose to propagate GatewayClass changes to existing
					Gateways, that MUST be clearly documented by the implementation.


					Whenever one or more Gateways are using a GatewayClass, implementations SHOULD
					add the `gateway-exists-finalizer.gateway.networking.k8s.io` finalizer on the
					associated GatewayClass. This ensures that a GatewayClass associated with a
					Gateway is not deleted while in use.


					GatewayClass is a Cluster level resource.
					"""
				properties: {
					apiVersion: {
						description: """
	APIVersion defines the versioned schema of this representation of an object.
	Servers should convert recognized schemas to the latest internal value, and
	may reject unrecognized values.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	"""
						type: "string"
					}
					kind: {
						description: """
	Kind is a string value representing the REST resource this object represents.
	Servers may infer this from the endpoint the client submits requests to.
	Cannot be updated.
	In CamelCase.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	"""
						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec defines the desired state of GatewayClass."
						properties: {
							controllerName: {
								description: """
	ControllerName is the name of the controller that is managing Gateways of
	this class. The value of this field MUST be a domain prefixed path.


	Example: "example.net/gateway-controller".


	This field is not mutable and cannot be empty.


	Support: Core
	"""
								maxLength: 253
								minLength: 1
								pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
								type:      "string"
								"x-kubernetes-validations": [{
									message: "Value is immutable"
									rule:    "self == oldSelf"
								}]
							}
							description: {
								description: "Description helps describe a GatewayClass with more details."
								maxLength:   64
								type:        "string"
							}
							parametersRef: {
								description: """
	ParametersRef is a reference to a resource that contains the configuration
	parameters corresponding to the GatewayClass. This is optional if the
	controller does not require any additional configuration.


	ParametersRef can reference a standard Kubernetes resource, i.e. ConfigMap,
	or an implementation-specific custom resource. The resource can be
	cluster-scoped or namespace-scoped.


	If the referent cannot be found, the GatewayClass's "InvalidParameters"
	status condition will be true.


	A Gateway for this GatewayClass may provide its own `parametersRef`. When both are specified,
	the merging behavior is implementation specific.
	It is generally recommended that GatewayClass provides defaults that can be overridden by a Gateway.


	Support: Implementation-specific
	"""
								properties: {
									group: {
										description: "Group is the group of the referent."
										maxLength:   253
										pattern:     "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
										type:        "string"
									}
									kind: {
										description: "Kind is kind of the referent."
										maxLength:   63
										minLength:   1
										pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
										type:        "string"
									}
									name: {
										description: "Name is the name of the referent."
										maxLength:   253
										minLength:   1
										type:        "string"
									}
									namespace: {
										description: """
	Namespace is the namespace of the referent.
	This field is required when referring to a Namespace-scoped resource and
	MUST be unset when referring to a Cluster-scoped resource.
	"""
										maxLength: 63
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
										type:      "string"
									}
								}
								required: [
									"group",
									"kind",
									"name",
								]
								type: "object"
							}
						}
						required: ["controllerName"]
						type: "object"
					}
					status: {
						default: conditions: [{
							lastTransitionTime: "1970-01-01T00:00:00Z"
							message:            "Waiting for controller"
							reason:             "Waiting"
							status:             "Unknown"
							type:               "Accepted"
						}]
						description: """
	Status defines the current state of GatewayClass.


	Implementations MUST populate status on all GatewayClass resources which
	specify their controller name.
	"""
						properties: {
							conditions: {
								default: [{
									lastTransitionTime: "1970-01-01T00:00:00Z"
									message:            "Waiting for controller"
									reason:             "Pending"
									status:             "Unknown"
									type:               "Accepted"
								}]
								description: """
	Conditions is the current status from the controller for
	this GatewayClass.


	Controllers should prefer to publish conditions using values
	of GatewayClassConditionType for the type of each Condition.
	"""
								items: {
									description: """
	Condition contains details for one aspect of the current state of this API Resource.
	---
	This struct is intended for direct use as an array at the field path .status.conditions.  For example,


	\ttype FooStatus struct{
	\t    // Represents the observations of a foo's current state.
	\t    // Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
	\t    // +patchMergeKey=type
	\t    // +patchStrategy=merge
	\t    // +listType=map
	\t    // +listMapKey=type
	\t    Conditions []metav1.Condition `json:"conditions,omitempty" patchStrategy:"merge" patchMergeKey:"type" protobuf:"bytes,1,rep,name=conditions"`


	\t    // other fields
	\t}
	"""
									properties: {
										lastTransitionTime: {
											description: """
	lastTransitionTime is the last time the condition transitioned from one status to another.
	This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
	"""
											format: "date-time"
											type:   "string"
										}
										message: {
											description: """
	message is a human readable message indicating details about the transition.
	This may be an empty string.
	"""
											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: """
	observedGeneration represents the .metadata.generation that the condition was set based upon.
	For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
	with respect to the current state of the instance.
	"""
											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: """
	reason contains a programmatic identifier indicating the reason for the condition's last transition.
	Producers of specific condition types may define expected values and meanings for this field,
	and whether the values are considered a guaranteed API.
	The value should be a CamelCase string.
	This field may not be empty.
	"""
											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: """
	type of condition in CamelCase or in foo.example.com/CamelCase.
	---
	Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be
	useful (see .node.status.conditions), the ability to deconflict is important.
	The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)
	"""
											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								maxItems: 8
								type:     "array"
								"x-kubernetes-list-map-keys": ["type"]
								"x-kubernetes-list-type": "map"
							}
							supportedFeatures: {
								description: """
	SupportedFeatures is the set of features the GatewayClass support.
	It MUST be sorted in ascending alphabetical order.

	"""
								items: {
									description: """
	SupportedFeature is used to describe distinct features that are covered by
	conformance tests.
	"""
									type: "string"
								}
								maxItems:                 64
								type:                     "array"
								"x-kubernetes-list-type": "set"
							}
						}
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}]
	}
}, {
	metadata: {
		name: "gateways.gateway.networking.k8s.io"
		annotations: {
			"api-approved.kubernetes.io":               "https://github.com/kubernetes-sigs/gateway-api/pull/2997"
			"gateway.networking.k8s.io/bundle-version": "v1.1.0"
			"gateway.networking.k8s.io/channel":        "experimental"
		}
	}
	spec: {
		group: "gateway.networking.k8s.io"
		names: {
			categories: ["gateway-api"]
			kind:     "Gateway"
			listKind: "GatewayList"
			plural:   "gateways"
			shortNames: ["gtw"]
			singular: "gateway"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.gatewayClassName"
				name:     "Class"
				type:     "string"
			}, {
				jsonPath: ".status.addresses[*].value"
				name:     "Address"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Programmed\")].status"
				name:     "Programmed"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: """
					Gateway represents an instance of a service-traffic handling infrastructure
					by binding Listeners to a set of IP addresses.
					"""
				properties: {
					apiVersion: {
						description: """
	APIVersion defines the versioned schema of this representation of an object.
	Servers should convert recognized schemas to the latest internal value, and
	may reject unrecognized values.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	"""
						type: "string"
					}
					kind: {
						description: """
	Kind is a string value representing the REST resource this object represents.
	Servers may infer this from the endpoint the client submits requests to.
	Cannot be updated.
	In CamelCase.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	"""
						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec defines the desired state of Gateway."
						properties: {
							addresses: {
								description: """
	Addresses requested for this Gateway. This is optional and behavior can
	depend on the implementation. If a value is set in the spec and the
	requested address is invalid or unavailable, the implementation MUST
	indicate this in the associated entry in GatewayStatus.Addresses.


	The Addresses field represents a request for the address(es) on the
	"outside of the Gateway", that traffic bound for this Gateway will use.
	This could be the IP address or hostname of an external load balancer or
	other networking infrastructure, or some other address that traffic will
	be sent to.


	If no Addresses are specified, the implementation MAY schedule the
	Gateway in an implementation-specific manner, assigning an appropriate
	set of Addresses.


	The implementation MUST bind all Listeners to every GatewayAddress that
	it assigns to the Gateway and add a corresponding entry in
	GatewayStatus.Addresses.


	Support: Extended



	"""
								items: {
									description: "GatewayAddress describes an address that can be bound to a Gateway."
									oneOf: [{
										properties: {
											type: enum: ["IPAddress"]
											value: anyOf: [{
												format: "ipv4"
											}, {
												format: "ipv6"
											}]
										}
									}, {
										properties: type: not: enum: ["IPAddress"]
									}]
									properties: {
										type: {
											default:     "IPAddress"
											description: "Type of the address."
											maxLength:   253
											minLength:   1
											pattern:     "^Hostname|IPAddress|NamedAddress|[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
											type:        "string"
										}
										value: {
											description: """
	Value of the address. The validity of the values will depend
	on the type and support by the controller.


	Examples: `1.2.3.4`, `128::1`, `my-ip-address`.
	"""
											maxLength: 253
											minLength: 1
											type:      "string"
										}
									}
									required: ["value"]
									type: "object"
									"x-kubernetes-validations": [{
										message: "Hostname value must only contain valid characters (matching ^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$)"
										rule:    "self.type == 'Hostname' ? self.value.matches(r\"\"\"^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$\"\"\"): true"
									}]
								}
								maxItems: 16
								type:     "array"
								"x-kubernetes-validations": [{
									message: "IPAddress values must be unique"
									rule:    "self.all(a1, a1.type == 'IPAddress' ? self.exists_one(a2, a2.type == a1.type && a2.value == a1.value) : true )"
								}, {
									message: "Hostname values must be unique"
									rule:    "self.all(a1, a1.type == 'Hostname' ? self.exists_one(a2, a2.type == a1.type && a2.value == a1.value) : true )"
								}]
							}
							gatewayClassName: {
								description: """
	GatewayClassName used for this Gateway. This is the name of a
	GatewayClass resource.
	"""
								maxLength: 253
								minLength: 1
								type:      "string"
							}
							infrastructure: {
								description: """
	Infrastructure defines infrastructure level attributes about this Gateway instance.


	Support: Core



	"""
								properties: {
									annotations: {
										additionalProperties: {
											description: """
	AnnotationValue is the value of an annotation in Gateway API. This is used
	for validation of maps such as TLS options. This roughly matches Kubernetes
	annotation validation, although the length validation in that case is based
	on the entire size of the annotations struct.
	"""
											maxLength: 4096
											minLength: 0
											type:      "string"
										}
										description: """
	Annotations that SHOULD be applied to any resources created in response to this Gateway.


	For implementations creating other Kubernetes objects, this should be the `metadata.annotations` field on resources.
	For other implementations, this refers to any relevant (implementation specific) "annotations" concepts.


	An implementation may chose to add additional implementation-specific annotations as they see fit.


	Support: Extended
	"""
										maxProperties: 8
										type:          "object"
									}
									labels: {
										additionalProperties: {
											description: """
	AnnotationValue is the value of an annotation in Gateway API. This is used
	for validation of maps such as TLS options. This roughly matches Kubernetes
	annotation validation, although the length validation in that case is based
	on the entire size of the annotations struct.
	"""
											maxLength: 4096
											minLength: 0
											type:      "string"
										}
										description: """
	Labels that SHOULD be applied to any resources created in response to this Gateway.


	For implementations creating other Kubernetes objects, this should be the `metadata.labels` field on resources.
	For other implementations, this refers to any relevant (implementation specific) "labels" concepts.


	An implementation may chose to add additional implementation-specific labels as they see fit.


	Support: Extended
	"""
										maxProperties: 8
										type:          "object"
									}
									parametersRef: {
										description: """
	ParametersRef is a reference to a resource that contains the configuration
	parameters corresponding to the Gateway. This is optional if the
	controller does not require any additional configuration.


	This follows the same semantics as GatewayClass's `parametersRef`, but on a per-Gateway basis


	The Gateway's GatewayClass may provide its own `parametersRef`. When both are specified,
	the merging behavior is implementation specific.
	It is generally recommended that GatewayClass provides defaults that can be overridden by a Gateway.


	Support: Implementation-specific
	"""
										properties: {
											group: {
												description: "Group is the group of the referent."
												maxLength:   253
												pattern:     "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:        "string"
											}
											kind: {
												description: "Kind is kind of the referent."
												maxLength:   63
												minLength:   1
												pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:        "string"
											}
											name: {
												description: "Name is the name of the referent."
												maxLength:   253
												minLength:   1
												type:        "string"
											}
										}
										required: [
											"group",
											"kind",
											"name",
										]
										type: "object"
									}
								}
								type: "object"
							}
							listeners: {
								description: """
	Listeners associated with this Gateway. Listeners define
	logical endpoints that are bound on this Gateway's addresses.
	At least one Listener MUST be specified.


	Each Listener in a set of Listeners (for example, in a single Gateway)
	MUST be _distinct_, in that a traffic flow MUST be able to be assigned to
	exactly one listener. (This section uses "set of Listeners" rather than
	"Listeners in a single Gateway" because implementations MAY merge configuration
	from multiple Gateways onto a single data plane, and these rules _also_
	apply in that case).


	Practically, this means that each listener in a set MUST have a unique
	combination of Port, Protocol, and, if supported by the protocol, Hostname.


	Some combinations of port, protocol, and TLS settings are considered
	Core support and MUST be supported by implementations based on their
	targeted conformance profile:


	HTTP Profile


	1. HTTPRoute, Port: 80, Protocol: HTTP
	2. HTTPRoute, Port: 443, Protocol: HTTPS, TLS Mode: Terminate, TLS keypair provided


	TLS Profile


	1. TLSRoute, Port: 443, Protocol: TLS, TLS Mode: Passthrough


	"Distinct" Listeners have the following property:


	The implementation can match inbound requests to a single distinct
	Listener. When multiple Listeners share values for fields (for
	example, two Listeners with the same Port value), the implementation
	can match requests to only one of the Listeners using other
	Listener fields.


	For example, the following Listener scenarios are distinct:


	1. Multiple Listeners with the same Port that all use the "HTTP"
	   Protocol that all have unique Hostname values.
	2. Multiple Listeners with the same Port that use either the "HTTPS" or
	   "TLS" Protocol that all have unique Hostname values.
	3. A mixture of "TCP" and "UDP" Protocol Listeners, where no Listener
	   with the same Protocol has the same Port value.


	Some fields in the Listener struct have possible values that affect
	whether the Listener is distinct. Hostname is particularly relevant
	for HTTP or HTTPS protocols.


	When using the Hostname value to select between same-Port, same-Protocol
	Listeners, the Hostname value must be different on each Listener for the
	Listener to be distinct.


	When the Listeners are distinct based on Hostname, inbound request
	hostnames MUST match from the most specific to least specific Hostname
	values to choose the correct Listener and its associated set of Routes.


	Exact matches must be processed before wildcard matches, and wildcard
	matches must be processed before fallback (empty Hostname value)
	matches. For example, `"foo.example.com"` takes precedence over
	`"*.example.com"`, and `"*.example.com"` takes precedence over `""`.


	Additionally, if there are multiple wildcard entries, more specific
	wildcard entries must be processed before less specific wildcard entries.
	For example, `"*.foo.example.com"` takes precedence over `"*.example.com"`.
	The precise definition here is that the higher the number of dots in the
	hostname to the right of the wildcard character, the higher the precedence.


	The wildcard character will match any number of characters _and dots_ to
	the left, however, so `"*.example.com"` will match both
	`"foo.bar.example.com"` _and_ `"bar.example.com"`.


	If a set of Listeners contains Listeners that are not distinct, then those
	Listeners are Conflicted, and the implementation MUST set the "Conflicted"
	condition in the Listener Status to "True".


	Implementations MAY choose to accept a Gateway with some Conflicted
	Listeners only if they only accept the partial Listener set that contains
	no Conflicted Listeners. To put this another way, implementations may
	accept a partial Listener set only if they throw out *all* the conflicting
	Listeners. No picking one of the conflicting listeners as the winner.
	This also means that the Gateway must have at least one non-conflicting
	Listener in this case, otherwise it violates the requirement that at
	least one Listener must be present.


	The implementation MUST set a "ListenersNotValid" condition on the
	Gateway Status when the Gateway contains Conflicted Listeners whether or
	not they accept the Gateway. That Condition SHOULD clearly
	indicate in the Message which Listeners are conflicted, and which are
	Accepted. Additionally, the Listener status for those listeners SHOULD
	indicate which Listeners are conflicted and not Accepted.


	A Gateway's Listeners are considered "compatible" if:


	1. They are distinct.
	2. The implementation can serve them in compliance with the Addresses
	   requirement that all Listeners are available on all assigned
	   addresses.


	Compatible combinations in Extended support are expected to vary across
	implementations. A combination that is compatible for one implementation
	may not be compatible for another.


	For example, an implementation that cannot serve both TCP and UDP listeners
	on the same address, or cannot mix HTTPS and generic TLS listens on the same port
	would not consider those cases compatible, even though they are distinct.


	Note that requests SHOULD match at most one Listener. For example, if
	Listeners are defined for "foo.example.com" and "*.example.com", a
	request to "foo.example.com" SHOULD only be routed using routes attached
	to the "foo.example.com" Listener (and not the "*.example.com" Listener).
	This concept is known as "Listener Isolation". Implementations that do
	not support Listener Isolation MUST clearly document this.


	Implementations MAY merge separate Gateways onto a single set of
	Addresses if all Listeners across all Gateways are compatible.


	Support: Core
	"""
								items: {
									description: """
	Listener embodies the concept of a logical endpoint where a Gateway accepts
	network connections.
	"""
									properties: {
										allowedRoutes: {
											default: namespaces: from: "Same"
											description: """
	AllowedRoutes defines the types of routes that MAY be attached to a
	Listener and the trusted namespaces where those Route resources MAY be
	present.


	Although a client request may match multiple route rules, only one rule
	may ultimately receive the request. Matching precedence MUST be
	determined in order of the following criteria:


	* The most specific match as defined by the Route type.
	* The oldest Route based on creation timestamp. For example, a Route with
	  a creation timestamp of "2020-09-08 01:02:03" is given precedence over
	  a Route with a creation timestamp of "2020-09-08 01:02:04".
	* If everything else is equivalent, the Route appearing first in
	  alphabetical order (namespace/name) should be given precedence. For
	  example, foo/bar is given precedence over foo/baz.


	All valid rules within a Route attached to this Listener should be
	implemented. Invalid Route rules can be ignored (sometimes that will mean
	the full Route). If a Route rule transitions from valid to invalid,
	support for that Route rule should be dropped to ensure consistency. For
	example, even if a filter specified by a Route rule is invalid, the rest
	of the rules within that Route should still be supported.


	Support: Core
	"""
											properties: {
												kinds: {
													description: """
	Kinds specifies the groups and kinds of Routes that are allowed to bind
	to this Gateway Listener. When unspecified or empty, the kinds of Routes
	selected are determined using the Listener protocol.


	A RouteGroupKind MUST correspond to kinds of Routes that are compatible
	with the application protocol specified in the Listener's Protocol field.
	If an implementation does not support or recognize this resource type, it
	MUST set the "ResolvedRefs" condition to False for this Listener with the
	"InvalidRouteKinds" reason.


	Support: Core
	"""
													items: {
														description: "RouteGroupKind indicates the group and kind of a Route resource."
														properties: {
															group: {
																default:     "gateway.networking.k8s.io"
																description: "Group is the group of the Route."
																maxLength:   253
																pattern:     "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:        "string"
															}
															kind: {
																description: "Kind is the kind of the Route."
																maxLength:   63
																minLength:   1
																pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																type:        "string"
															}
														}
														required: ["kind"]
														type: "object"
													}
													maxItems: 8
													type:     "array"
												}
												namespaces: {
													default: from: "Same"
													description: """
	Namespaces indicates namespaces from which Routes may be attached to this
	Listener. This is restricted to the namespace of this Gateway by default.


	Support: Core
	"""
													properties: {
														from: {
															default: "Same"
															description: """
	From indicates where Routes will be selected for this Gateway. Possible
	values are:


	* All: Routes in all namespaces may be used by this Gateway.
	* Selector: Routes in namespaces selected by the selector may be used by
	  this Gateway.
	* Same: Only Routes in the same namespace may be used by this Gateway.


	Support: Core
	"""
															enum: [
																"All",
																"Selector",
																"Same",
															]
															type: "string"
														}
														selector: {
															description: """
	Selector must be specified when From is set to "Selector". In that case,
	only Routes in Namespaces matching this Selector will be selected by this
	Gateway. This field is ignored for other values of "From".


	Support: Core
	"""
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: """
	A label selector requirement is a selector that contains values, a key, and an operator that
	relates the key and values.
	"""
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: """
	operator represents a key's relationship to a set of values.
	Valid operators are In, NotIn, Exists and DoesNotExist.
	"""
																				type: "string"
																			}
																			values: {
																				description: """
	values is an array of string values. If the operator is In or NotIn,
	the values array must be non-empty. If the operator is Exists or DoesNotExist,
	the values array must be empty. This array is replaced during a strategic
	merge patch.
	"""
																				items: type: "string"
																				type:                     "array"
																				"x-kubernetes-list-type": "atomic"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	description: """
	matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels
	map is equivalent to an element of matchExpressions, whose key field is "key", the
	operator is "In", and the values array contains only "value". The requirements are ANDed.
	"""
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										hostname: {
											description: """
	Hostname specifies the virtual hostname to match for protocol types that
	define this concept. When unspecified, all hostnames are matched. This
	field is ignored for protocols that don't require hostname based
	matching.


	Implementations MUST apply Hostname matching appropriately for each of
	the following protocols:


	* TLS: The Listener Hostname MUST match the SNI.
	* HTTP: The Listener Hostname MUST match the Host header of the request.
	* HTTPS: The Listener Hostname SHOULD match at both the TLS and HTTP
	  protocol layers as described above. If an implementation does not
	  ensure that both the SNI and Host header match the Listener hostname,
	  it MUST clearly document that.


	For HTTPRoute and TLSRoute resources, there is an interaction with the
	`spec.hostnames` array. When both listener and route specify hostnames,
	there MUST be an intersection between the values for a Route to be
	accepted. For more information, refer to the Route specific Hostnames
	documentation.


	Hostnames that are prefixed with a wildcard label (`*.`) are interpreted
	as a suffix match. That means that a match for `*.example.com` would match
	both `test.example.com`, and `foo.test.example.com`, but not `example.com`.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											pattern:   "^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										name: {
											description: """
	Name is the name of the Listener. This name MUST be unique within a
	Gateway.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										port: {
											description: """
	Port is the network port. Multiple listeners may use the
	same port, subject to the Listener compatibility rules.


	Support: Core
	"""
											format:  "int32"
											maximum: 65535
											minimum: 1
											type:    "integer"
										}
										protocol: {
											description: """
	Protocol specifies the network protocol this listener expects to receive.


	Support: Core
	"""
											maxLength: 255
											minLength: 1
											pattern:   "^[a-zA-Z0-9]([-a-zSA-Z0-9]*[a-zA-Z0-9])?$|[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9]+$"
											type:      "string"
										}
										tls: {
											description: """
	TLS is the TLS configuration for the Listener. This field is required if
	the Protocol field is "HTTPS" or "TLS". It is invalid to set this field
	if the Protocol field is "HTTP", "TCP", or "UDP".


	The association of SNIs to Certificate defined in GatewayTLSConfig is
	defined based on the Hostname field for this listener.


	The GatewayClass MUST use the longest matching SNI out of all
	available certificates for any TLS handshake.


	Support: Core
	"""
											properties: {
												certificateRefs: {
													description: """
	CertificateRefs contains a series of references to Kubernetes objects that
	contains TLS certificates and private keys. These certificates are used to
	establish a TLS handshake for requests that match the hostname of the
	associated listener.


	A single CertificateRef to a Kubernetes Secret has "Core" support.
	Implementations MAY choose to support attaching multiple certificates to
	a Listener, but this behavior is implementation-specific.


	References to a resource in different namespace are invalid UNLESS there
	is a ReferenceGrant in the target namespace that allows the certificate
	to be attached. If a ReferenceGrant does not allow this reference, the
	"ResolvedRefs" condition MUST be set to False for this listener with the
	"RefNotPermitted" reason.


	This field is required to have at least one element when the mode is set
	to "Terminate" (default) and is optional otherwise.


	CertificateRefs can reference to standard Kubernetes resources, i.e.
	Secret, or implementation-specific custom resources.


	Support: Core - A single reference to a Kubernetes Secret of type kubernetes.io/tls


	Support: Implementation-specific (More than one reference or other resource types)
	"""
													items: {
														description: """
	SecretObjectReference identifies an API object including its namespace,
	defaulting to Secret.


	The API object must be valid in the cluster; the Group and Kind must
	be registered in the cluster for this reference to be valid.


	References to objects with invalid Group and Kind are not valid, and must
	be rejected by the implementation, with appropriate Conditions set
	on the containing object.
	"""
														properties: {
															group: {
																default: ""
																description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																maxLength: 253
																pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															kind: {
																default:     "Secret"
																description: "Kind is kind of the referent. For example \"Secret\"."
																maxLength:   63
																minLength:   1
																pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																type:        "string"
															}
															name: {
																description: "Name is the name of the referent."
																maxLength:   253
																minLength:   1
																type:        "string"
															}
															namespace: {
																description: """
	Namespace is the namespace of the referenced object. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
																maxLength: 63
																minLength: 1
																pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
																type:      "string"
															}
														}
														required: ["name"]
														type: "object"
													}
													maxItems: 64
													type:     "array"
												}
												frontendValidation: {
													description: """
	FrontendValidation holds configuration information for validating the frontend (client).
	Setting this field will require clients to send a client certificate
	required for validation during the TLS handshake. In browsers this may result in a dialog appearing
	that requests a user to specify the client certificate.
	The maximum depth of a certificate chain accepted in verification is Implementation specific.


	Support: Extended



	"""
													properties: caCertificateRefs: {
														description: """
	CACertificateRefs contains one or more references to
	Kubernetes objects that contain TLS certificates of
	the Certificate Authorities that can be used
	as a trust anchor to validate the certificates presented by the client.


	A single CA certificate reference to a Kubernetes ConfigMap
	has "Core" support.
	Implementations MAY choose to support attaching multiple CA certificates to
	a Listener, but this behavior is implementation-specific.


	Support: Core - A single reference to a Kubernetes ConfigMap
	with the CA certificate in a key named `ca.crt`.


	Support: Implementation-specific (More than one reference, or other kinds
	of resources).


	References to a resource in a different namespace are invalid UNLESS there
	is a ReferenceGrant in the target namespace that allows the certificate
	to be attached. If a ReferenceGrant does not allow this reference, the
	"ResolvedRefs" condition MUST be set to False for this listener with the
	"RefNotPermitted" reason.
	"""
														items: {
															description: """
	ObjectReference identifies an API object including its namespace.


	The API object must be valid in the cluster; the Group and Kind must
	be registered in the cluster for this reference to be valid.


	References to objects with invalid Group and Kind are not valid, and must
	be rejected by the implementation, with appropriate Conditions set
	on the containing object.
	"""
															properties: {
																group: {
																	description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																	maxLength: 253
																	pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																	type:      "string"
																}
																kind: {
																	description: "Kind is kind of the referent. For example \"ConfigMap\" or \"Service\"."
																	maxLength:   63
																	minLength:   1
																	pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																	type:        "string"
																}
																name: {
																	description: "Name is the name of the referent."
																	maxLength:   253
																	minLength:   1
																	type:        "string"
																}
																namespace: {
																	description: """
	Namespace is the namespace of the referenced object. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
																	maxLength: 63
																	minLength: 1
																	pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
																	type:      "string"
																}
															}
															required: [
																"group",
																"kind",
																"name",
															]
															type: "object"
														}
														maxItems: 8
														minItems: 1
														type:     "array"
													}
													type: "object"
												}
												mode: {
													default: "Terminate"
													description: """
	Mode defines the TLS behavior for the TLS session initiated by the client.
	There are two possible modes:


	- Terminate: The TLS session between the downstream client and the
	  Gateway is terminated at the Gateway. This mode requires certificates
	  to be specified in some way, such as populating the certificateRefs
	  field.
	- Passthrough: The TLS session is NOT terminated by the Gateway. This
	  implies that the Gateway can't decipher the TLS stream except for
	  the ClientHello message of the TLS protocol. The certificateRefs field
	  is ignored in this mode.


	Support: Core
	"""
													enum: [
														"Terminate",
														"Passthrough",
													]
													type: "string"
												}
												options: {
													additionalProperties: {
														description: """
	AnnotationValue is the value of an annotation in Gateway API. This is used
	for validation of maps such as TLS options. This roughly matches Kubernetes
	annotation validation, although the length validation in that case is based
	on the entire size of the annotations struct.
	"""
														maxLength: 4096
														minLength: 0
														type:      "string"
													}
													description: """
	Options are a list of key/value pairs to enable extended TLS
	configuration for each implementation. For example, configuring the
	minimum TLS version or supported cipher suites.


	A set of common keys MAY be defined by the API in the future. To avoid
	any ambiguity, implementation-specific definitions MUST use
	domain-prefixed names, such as `example.com/my-custom-option`.
	Un-prefixed names are reserved for key names defined by Gateway API.


	Support: Implementation-specific
	"""
													maxProperties: 16
													type:          "object"
												}
											}
											type: "object"
											"x-kubernetes-validations": [{
												message: "certificateRefs or options must be specified when mode is Terminate"
												rule:    "self.mode == 'Terminate' ? size(self.certificateRefs) > 0 || size(self.options) > 0 : true"
											}]
										}
									}
									required: [
										"name",
										"port",
										"protocol",
									]
									type: "object"
								}
								maxItems: 64
								minItems: 1
								type:     "array"
								"x-kubernetes-list-map-keys": ["name"]
								"x-kubernetes-list-type": "map"
								"x-kubernetes-validations": [{
									message: "tls must not be specified for protocols ['HTTP', 'TCP', 'UDP']"
									rule:    "self.all(l, l.protocol in ['HTTP', 'TCP', 'UDP'] ? !has(l.tls) : true)"
								}, {
									message: "tls mode must be Terminate for protocol HTTPS"
									rule:    "self.all(l, (l.protocol == 'HTTPS' && has(l.tls)) ? (l.tls.mode == '' || l.tls.mode == 'Terminate') : true)"
								}, {
									message: "hostname must not be specified for protocols ['TCP', 'UDP']"
									rule:    "self.all(l, l.protocol in ['TCP', 'UDP']  ? (!has(l.hostname) || l.hostname == '') : true)"
								}, {
									message: "Listener name must be unique within the Gateway"
									rule:    "self.all(l1, self.exists_one(l2, l1.name == l2.name))"
								}, {
									message: "Combination of port, protocol and hostname must be unique for each listener"
									rule:    "self.all(l1, self.exists_one(l2, l1.port == l2.port && l1.protocol == l2.protocol && (has(l1.hostname) && has(l2.hostname) ? l1.hostname == l2.hostname : !has(l1.hostname) && !has(l2.hostname))))"
								}]
							}
						}
						required: [
							"gatewayClassName",
							"listeners",
						]
						type: "object"
					}
					status: {
						default: conditions: [{
							lastTransitionTime: "1970-01-01T00:00:00Z"
							message:            "Waiting for controller"
							reason:             "Pending"
							status:             "Unknown"
							type:               "Accepted"
						}, {
							lastTransitionTime: "1970-01-01T00:00:00Z"
							message:            "Waiting for controller"
							reason:             "Pending"
							status:             "Unknown"
							type:               "Programmed"
						}]
						description: "Status defines the current state of Gateway."
						properties: {
							addresses: {
								description: """
	Addresses lists the network addresses that have been bound to the
	Gateway.


	This list may differ from the addresses provided in the spec under some
	conditions:


	  * no addresses are specified, all addresses are dynamically assigned
	  * a combination of specified and dynamic addresses are assigned
	  * a specified address was unusable (e.g. already in use)



	"""
								items: {
									description: "GatewayStatusAddress describes a network address that is bound to a Gateway."
									oneOf: [{
										properties: {
											type: enum: ["IPAddress"]
											value: anyOf: [{
												format: "ipv4"
											}, {
												format: "ipv6"
											}]
										}
									}, {
										properties: type: not: enum: ["IPAddress"]
									}]
									properties: {
										type: {
											default:     "IPAddress"
											description: "Type of the address."
											maxLength:   253
											minLength:   1
											pattern:     "^Hostname|IPAddress|NamedAddress|[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
											type:        "string"
										}
										value: {
											description: """
	Value of the address. The validity of the values will depend
	on the type and support by the controller.


	Examples: `1.2.3.4`, `128::1`, `my-ip-address`.
	"""
											maxLength: 253
											minLength: 1
											type:      "string"
										}
									}
									required: ["value"]
									type: "object"
									"x-kubernetes-validations": [{
										message: "Hostname value must only contain valid characters (matching ^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$)"
										rule:    "self.type == 'Hostname' ? self.value.matches(r\"\"\"^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$\"\"\"): true"
									}]
								}
								maxItems: 16
								type:     "array"
							}
							conditions: {
								default: [{
									lastTransitionTime: "1970-01-01T00:00:00Z"
									message:            "Waiting for controller"
									reason:             "Pending"
									status:             "Unknown"
									type:               "Accepted"
								}, {
									lastTransitionTime: "1970-01-01T00:00:00Z"
									message:            "Waiting for controller"
									reason:             "Pending"
									status:             "Unknown"
									type:               "Programmed"
								}]
								description: """
	Conditions describe the current conditions of the Gateway.


	Implementations should prefer to express Gateway conditions
	using the `GatewayConditionType` and `GatewayConditionReason`
	constants so that operators and tools can converge on a common
	vocabulary to describe Gateway state.


	Known condition types are:


	* "Accepted"
	* "Programmed"
	* "Ready"
	"""
								items: {
									description: """
	Condition contains details for one aspect of the current state of this API Resource.
	---
	This struct is intended for direct use as an array at the field path .status.conditions.  For example,


	\ttype FooStatus struct{
	\t    // Represents the observations of a foo's current state.
	\t    // Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
	\t    // +patchMergeKey=type
	\t    // +patchStrategy=merge
	\t    // +listType=map
	\t    // +listMapKey=type
	\t    Conditions []metav1.Condition `json:"conditions,omitempty" patchStrategy:"merge" patchMergeKey:"type" protobuf:"bytes,1,rep,name=conditions"`


	\t    // other fields
	\t}
	"""
									properties: {
										lastTransitionTime: {
											description: """
	lastTransitionTime is the last time the condition transitioned from one status to another.
	This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
	"""
											format: "date-time"
											type:   "string"
										}
										message: {
											description: """
	message is a human readable message indicating details about the transition.
	This may be an empty string.
	"""
											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: """
	observedGeneration represents the .metadata.generation that the condition was set based upon.
	For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
	with respect to the current state of the instance.
	"""
											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: """
	reason contains a programmatic identifier indicating the reason for the condition's last transition.
	Producers of specific condition types may define expected values and meanings for this field,
	and whether the values are considered a guaranteed API.
	The value should be a CamelCase string.
	This field may not be empty.
	"""
											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: """
	type of condition in CamelCase or in foo.example.com/CamelCase.
	---
	Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be
	useful (see .node.status.conditions), the ability to deconflict is important.
	The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)
	"""
											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								maxItems: 8
								type:     "array"
								"x-kubernetes-list-map-keys": ["type"]
								"x-kubernetes-list-type": "map"
							}
							listeners: {
								description: "Listeners provide status for each unique listener port defined in the Spec."
								items: {
									description: "ListenerStatus is the status associated with a Listener."
									properties: {
										attachedRoutes: {
											description: """
	AttachedRoutes represents the total number of Routes that have been
	successfully attached to this Listener.


	Successful attachment of a Route to a Listener is based solely on the
	combination of the AllowedRoutes field on the corresponding Listener
	and the Route's ParentRefs field. A Route is successfully attached to
	a Listener when it is selected by the Listener's AllowedRoutes field
	AND the Route has a valid ParentRef selecting the whole Gateway
	resource or a specific Listener as a parent resource (more detail on
	attachment semantics can be found in the documentation on the various
	Route kinds ParentRefs fields). Listener or Route status does not impact
	successful attachment, i.e. the AttachedRoutes field count MUST be set
	for Listeners with condition Accepted: false and MUST count successfully
	attached Routes that may themselves have Accepted: false conditions.


	Uses for this field include troubleshooting Route attachment and
	measuring blast radius/impact of changes to a Listener.
	"""
											format: "int32"
											type:   "integer"
										}
										conditions: {
											description: "Conditions describe the current condition of this listener."
											items: {
												description: """
	Condition contains details for one aspect of the current state of this API Resource.
	---
	This struct is intended for direct use as an array at the field path .status.conditions.  For example,


	\ttype FooStatus struct{
	\t    // Represents the observations of a foo's current state.
	\t    // Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
	\t    // +patchMergeKey=type
	\t    // +patchStrategy=merge
	\t    // +listType=map
	\t    // +listMapKey=type
	\t    Conditions []metav1.Condition `json:"conditions,omitempty" patchStrategy:"merge" patchMergeKey:"type" protobuf:"bytes,1,rep,name=conditions"`


	\t    // other fields
	\t}
	"""
												properties: {
													lastTransitionTime: {
														description: """
	lastTransitionTime is the last time the condition transitioned from one status to another.
	This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
	"""
														format: "date-time"
														type:   "string"
													}
													message: {
														description: """
	message is a human readable message indicating details about the transition.
	This may be an empty string.
	"""
														maxLength: 32768
														type:      "string"
													}
													observedGeneration: {
														description: """
	observedGeneration represents the .metadata.generation that the condition was set based upon.
	For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
	with respect to the current state of the instance.
	"""
														format:  "int64"
														minimum: 0
														type:    "integer"
													}
													reason: {
														description: """
	reason contains a programmatic identifier indicating the reason for the condition's last transition.
	Producers of specific condition types may define expected values and meanings for this field,
	and whether the values are considered a guaranteed API.
	The value should be a CamelCase string.
	This field may not be empty.
	"""
														maxLength: 1024
														minLength: 1
														pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
														type:      "string"
													}
													status: {
														description: "status of the condition, one of True, False, Unknown."
														enum: [
															"True",
															"False",
															"Unknown",
														]
														type: "string"
													}
													type: {
														description: """
	type of condition in CamelCase or in foo.example.com/CamelCase.
	---
	Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be
	useful (see .node.status.conditions), the ability to deconflict is important.
	The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)
	"""
														maxLength: 316
														pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
														type:      "string"
													}
												}
												required: [
													"lastTransitionTime",
													"message",
													"reason",
													"status",
													"type",
												]
												type: "object"
											}
											maxItems: 8
											type:     "array"
											"x-kubernetes-list-map-keys": ["type"]
											"x-kubernetes-list-type": "map"
										}
										name: {
											description: "Name is the name of the Listener that this status corresponds to."
											maxLength:   253
											minLength:   1
											pattern:     "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:        "string"
										}
										supportedKinds: {
											description: """
	SupportedKinds is the list indicating the Kinds supported by this
	listener. This MUST represent the kinds an implementation supports for
	that Listener configuration.


	If kinds are specified in Spec that are not supported, they MUST NOT
	appear in this list and an implementation MUST set the "ResolvedRefs"
	condition to "False" with the "InvalidRouteKinds" reason. If both valid
	and invalid Route kinds are specified, the implementation MUST
	reference the valid Route kinds that have been specified.
	"""
											items: {
												description: "RouteGroupKind indicates the group and kind of a Route resource."
												properties: {
													group: {
														default:     "gateway.networking.k8s.io"
														description: "Group is the group of the Route."
														maxLength:   253
														pattern:     "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
														type:        "string"
													}
													kind: {
														description: "Kind is the kind of the Route."
														maxLength:   63
														minLength:   1
														pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
														type:        "string"
													}
												}
												required: ["kind"]
												type: "object"
											}
											maxItems: 8
											type:     "array"
										}
									}
									required: [
										"attachedRoutes",
										"conditions",
										"name",
										"supportedKinds",
									]
									type: "object"
								}
								maxItems: 64
								type:     "array"
								"x-kubernetes-list-map-keys": ["name"]
								"x-kubernetes-list-type": "map"
							}
						}
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".spec.gatewayClassName"
				name:     "Class"
				type:     "string"
			}, {
				jsonPath: ".status.addresses[*].value"
				name:     "Address"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Programmed\")].status"
				name:     "Programmed"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: """
					Gateway represents an instance of a service-traffic handling infrastructure
					by binding Listeners to a set of IP addresses.
					"""
				properties: {
					apiVersion: {
						description: """
	APIVersion defines the versioned schema of this representation of an object.
	Servers should convert recognized schemas to the latest internal value, and
	may reject unrecognized values.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	"""
						type: "string"
					}
					kind: {
						description: """
	Kind is a string value representing the REST resource this object represents.
	Servers may infer this from the endpoint the client submits requests to.
	Cannot be updated.
	In CamelCase.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	"""
						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec defines the desired state of Gateway."
						properties: {
							addresses: {
								description: """
	Addresses requested for this Gateway. This is optional and behavior can
	depend on the implementation. If a value is set in the spec and the
	requested address is invalid or unavailable, the implementation MUST
	indicate this in the associated entry in GatewayStatus.Addresses.


	The Addresses field represents a request for the address(es) on the
	"outside of the Gateway", that traffic bound for this Gateway will use.
	This could be the IP address or hostname of an external load balancer or
	other networking infrastructure, or some other address that traffic will
	be sent to.


	If no Addresses are specified, the implementation MAY schedule the
	Gateway in an implementation-specific manner, assigning an appropriate
	set of Addresses.


	The implementation MUST bind all Listeners to every GatewayAddress that
	it assigns to the Gateway and add a corresponding entry in
	GatewayStatus.Addresses.


	Support: Extended



	"""
								items: {
									description: "GatewayAddress describes an address that can be bound to a Gateway."
									oneOf: [{
										properties: {
											type: enum: ["IPAddress"]
											value: anyOf: [{
												format: "ipv4"
											}, {
												format: "ipv6"
											}]
										}
									}, {
										properties: type: not: enum: ["IPAddress"]
									}]
									properties: {
										type: {
											default:     "IPAddress"
											description: "Type of the address."
											maxLength:   253
											minLength:   1
											pattern:     "^Hostname|IPAddress|NamedAddress|[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
											type:        "string"
										}
										value: {
											description: """
	Value of the address. The validity of the values will depend
	on the type and support by the controller.


	Examples: `1.2.3.4`, `128::1`, `my-ip-address`.
	"""
											maxLength: 253
											minLength: 1
											type:      "string"
										}
									}
									required: ["value"]
									type: "object"
									"x-kubernetes-validations": [{
										message: "Hostname value must only contain valid characters (matching ^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$)"
										rule:    "self.type == 'Hostname' ? self.value.matches(r\"\"\"^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$\"\"\"): true"
									}]
								}
								maxItems: 16
								type:     "array"
								"x-kubernetes-validations": [{
									message: "IPAddress values must be unique"
									rule:    "self.all(a1, a1.type == 'IPAddress' ? self.exists_one(a2, a2.type == a1.type && a2.value == a1.value) : true )"
								}, {
									message: "Hostname values must be unique"
									rule:    "self.all(a1, a1.type == 'Hostname' ? self.exists_one(a2, a2.type == a1.type && a2.value == a1.value) : true )"
								}]
							}
							gatewayClassName: {
								description: """
	GatewayClassName used for this Gateway. This is the name of a
	GatewayClass resource.
	"""
								maxLength: 253
								minLength: 1
								type:      "string"
							}
							infrastructure: {
								description: """
	Infrastructure defines infrastructure level attributes about this Gateway instance.


	Support: Core



	"""
								properties: {
									annotations: {
										additionalProperties: {
											description: """
	AnnotationValue is the value of an annotation in Gateway API. This is used
	for validation of maps such as TLS options. This roughly matches Kubernetes
	annotation validation, although the length validation in that case is based
	on the entire size of the annotations struct.
	"""
											maxLength: 4096
											minLength: 0
											type:      "string"
										}
										description: """
	Annotations that SHOULD be applied to any resources created in response to this Gateway.


	For implementations creating other Kubernetes objects, this should be the `metadata.annotations` field on resources.
	For other implementations, this refers to any relevant (implementation specific) "annotations" concepts.


	An implementation may chose to add additional implementation-specific annotations as they see fit.


	Support: Extended
	"""
										maxProperties: 8
										type:          "object"
									}
									labels: {
										additionalProperties: {
											description: """
	AnnotationValue is the value of an annotation in Gateway API. This is used
	for validation of maps such as TLS options. This roughly matches Kubernetes
	annotation validation, although the length validation in that case is based
	on the entire size of the annotations struct.
	"""
											maxLength: 4096
											minLength: 0
											type:      "string"
										}
										description: """
	Labels that SHOULD be applied to any resources created in response to this Gateway.


	For implementations creating other Kubernetes objects, this should be the `metadata.labels` field on resources.
	For other implementations, this refers to any relevant (implementation specific) "labels" concepts.


	An implementation may chose to add additional implementation-specific labels as they see fit.


	Support: Extended
	"""
										maxProperties: 8
										type:          "object"
									}
									parametersRef: {
										description: """
	ParametersRef is a reference to a resource that contains the configuration
	parameters corresponding to the Gateway. This is optional if the
	controller does not require any additional configuration.


	This follows the same semantics as GatewayClass's `parametersRef`, but on a per-Gateway basis


	The Gateway's GatewayClass may provide its own `parametersRef`. When both are specified,
	the merging behavior is implementation specific.
	It is generally recommended that GatewayClass provides defaults that can be overridden by a Gateway.


	Support: Implementation-specific
	"""
										properties: {
											group: {
												description: "Group is the group of the referent."
												maxLength:   253
												pattern:     "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:        "string"
											}
											kind: {
												description: "Kind is kind of the referent."
												maxLength:   63
												minLength:   1
												pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:        "string"
											}
											name: {
												description: "Name is the name of the referent."
												maxLength:   253
												minLength:   1
												type:        "string"
											}
										}
										required: [
											"group",
											"kind",
											"name",
										]
										type: "object"
									}
								}
								type: "object"
							}
							listeners: {
								description: """
	Listeners associated with this Gateway. Listeners define
	logical endpoints that are bound on this Gateway's addresses.
	At least one Listener MUST be specified.


	Each Listener in a set of Listeners (for example, in a single Gateway)
	MUST be _distinct_, in that a traffic flow MUST be able to be assigned to
	exactly one listener. (This section uses "set of Listeners" rather than
	"Listeners in a single Gateway" because implementations MAY merge configuration
	from multiple Gateways onto a single data plane, and these rules _also_
	apply in that case).


	Practically, this means that each listener in a set MUST have a unique
	combination of Port, Protocol, and, if supported by the protocol, Hostname.


	Some combinations of port, protocol, and TLS settings are considered
	Core support and MUST be supported by implementations based on their
	targeted conformance profile:


	HTTP Profile


	1. HTTPRoute, Port: 80, Protocol: HTTP
	2. HTTPRoute, Port: 443, Protocol: HTTPS, TLS Mode: Terminate, TLS keypair provided


	TLS Profile


	1. TLSRoute, Port: 443, Protocol: TLS, TLS Mode: Passthrough


	"Distinct" Listeners have the following property:


	The implementation can match inbound requests to a single distinct
	Listener. When multiple Listeners share values for fields (for
	example, two Listeners with the same Port value), the implementation
	can match requests to only one of the Listeners using other
	Listener fields.


	For example, the following Listener scenarios are distinct:


	1. Multiple Listeners with the same Port that all use the "HTTP"
	   Protocol that all have unique Hostname values.
	2. Multiple Listeners with the same Port that use either the "HTTPS" or
	   "TLS" Protocol that all have unique Hostname values.
	3. A mixture of "TCP" and "UDP" Protocol Listeners, where no Listener
	   with the same Protocol has the same Port value.


	Some fields in the Listener struct have possible values that affect
	whether the Listener is distinct. Hostname is particularly relevant
	for HTTP or HTTPS protocols.


	When using the Hostname value to select between same-Port, same-Protocol
	Listeners, the Hostname value must be different on each Listener for the
	Listener to be distinct.


	When the Listeners are distinct based on Hostname, inbound request
	hostnames MUST match from the most specific to least specific Hostname
	values to choose the correct Listener and its associated set of Routes.


	Exact matches must be processed before wildcard matches, and wildcard
	matches must be processed before fallback (empty Hostname value)
	matches. For example, `"foo.example.com"` takes precedence over
	`"*.example.com"`, and `"*.example.com"` takes precedence over `""`.


	Additionally, if there are multiple wildcard entries, more specific
	wildcard entries must be processed before less specific wildcard entries.
	For example, `"*.foo.example.com"` takes precedence over `"*.example.com"`.
	The precise definition here is that the higher the number of dots in the
	hostname to the right of the wildcard character, the higher the precedence.


	The wildcard character will match any number of characters _and dots_ to
	the left, however, so `"*.example.com"` will match both
	`"foo.bar.example.com"` _and_ `"bar.example.com"`.


	If a set of Listeners contains Listeners that are not distinct, then those
	Listeners are Conflicted, and the implementation MUST set the "Conflicted"
	condition in the Listener Status to "True".


	Implementations MAY choose to accept a Gateway with some Conflicted
	Listeners only if they only accept the partial Listener set that contains
	no Conflicted Listeners. To put this another way, implementations may
	accept a partial Listener set only if they throw out *all* the conflicting
	Listeners. No picking one of the conflicting listeners as the winner.
	This also means that the Gateway must have at least one non-conflicting
	Listener in this case, otherwise it violates the requirement that at
	least one Listener must be present.


	The implementation MUST set a "ListenersNotValid" condition on the
	Gateway Status when the Gateway contains Conflicted Listeners whether or
	not they accept the Gateway. That Condition SHOULD clearly
	indicate in the Message which Listeners are conflicted, and which are
	Accepted. Additionally, the Listener status for those listeners SHOULD
	indicate which Listeners are conflicted and not Accepted.


	A Gateway's Listeners are considered "compatible" if:


	1. They are distinct.
	2. The implementation can serve them in compliance with the Addresses
	   requirement that all Listeners are available on all assigned
	   addresses.


	Compatible combinations in Extended support are expected to vary across
	implementations. A combination that is compatible for one implementation
	may not be compatible for another.


	For example, an implementation that cannot serve both TCP and UDP listeners
	on the same address, or cannot mix HTTPS and generic TLS listens on the same port
	would not consider those cases compatible, even though they are distinct.


	Note that requests SHOULD match at most one Listener. For example, if
	Listeners are defined for "foo.example.com" and "*.example.com", a
	request to "foo.example.com" SHOULD only be routed using routes attached
	to the "foo.example.com" Listener (and not the "*.example.com" Listener).
	This concept is known as "Listener Isolation". Implementations that do
	not support Listener Isolation MUST clearly document this.


	Implementations MAY merge separate Gateways onto a single set of
	Addresses if all Listeners across all Gateways are compatible.


	Support: Core
	"""
								items: {
									description: """
	Listener embodies the concept of a logical endpoint where a Gateway accepts
	network connections.
	"""
									properties: {
										allowedRoutes: {
											default: namespaces: from: "Same"
											description: """
	AllowedRoutes defines the types of routes that MAY be attached to a
	Listener and the trusted namespaces where those Route resources MAY be
	present.


	Although a client request may match multiple route rules, only one rule
	may ultimately receive the request. Matching precedence MUST be
	determined in order of the following criteria:


	* The most specific match as defined by the Route type.
	* The oldest Route based on creation timestamp. For example, a Route with
	  a creation timestamp of "2020-09-08 01:02:03" is given precedence over
	  a Route with a creation timestamp of "2020-09-08 01:02:04".
	* If everything else is equivalent, the Route appearing first in
	  alphabetical order (namespace/name) should be given precedence. For
	  example, foo/bar is given precedence over foo/baz.


	All valid rules within a Route attached to this Listener should be
	implemented. Invalid Route rules can be ignored (sometimes that will mean
	the full Route). If a Route rule transitions from valid to invalid,
	support for that Route rule should be dropped to ensure consistency. For
	example, even if a filter specified by a Route rule is invalid, the rest
	of the rules within that Route should still be supported.


	Support: Core
	"""
											properties: {
												kinds: {
													description: """
	Kinds specifies the groups and kinds of Routes that are allowed to bind
	to this Gateway Listener. When unspecified or empty, the kinds of Routes
	selected are determined using the Listener protocol.


	A RouteGroupKind MUST correspond to kinds of Routes that are compatible
	with the application protocol specified in the Listener's Protocol field.
	If an implementation does not support or recognize this resource type, it
	MUST set the "ResolvedRefs" condition to False for this Listener with the
	"InvalidRouteKinds" reason.


	Support: Core
	"""
													items: {
														description: "RouteGroupKind indicates the group and kind of a Route resource."
														properties: {
															group: {
																default:     "gateway.networking.k8s.io"
																description: "Group is the group of the Route."
																maxLength:   253
																pattern:     "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:        "string"
															}
															kind: {
																description: "Kind is the kind of the Route."
																maxLength:   63
																minLength:   1
																pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																type:        "string"
															}
														}
														required: ["kind"]
														type: "object"
													}
													maxItems: 8
													type:     "array"
												}
												namespaces: {
													default: from: "Same"
													description: """
	Namespaces indicates namespaces from which Routes may be attached to this
	Listener. This is restricted to the namespace of this Gateway by default.


	Support: Core
	"""
													properties: {
														from: {
															default: "Same"
															description: """
	From indicates where Routes will be selected for this Gateway. Possible
	values are:


	* All: Routes in all namespaces may be used by this Gateway.
	* Selector: Routes in namespaces selected by the selector may be used by
	  this Gateway.
	* Same: Only Routes in the same namespace may be used by this Gateway.


	Support: Core
	"""
															enum: [
																"All",
																"Selector",
																"Same",
															]
															type: "string"
														}
														selector: {
															description: """
	Selector must be specified when From is set to "Selector". In that case,
	only Routes in Namespaces matching this Selector will be selected by this
	Gateway. This field is ignored for other values of "From".


	Support: Core
	"""
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: """
	A label selector requirement is a selector that contains values, a key, and an operator that
	relates the key and values.
	"""
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: """
	operator represents a key's relationship to a set of values.
	Valid operators are In, NotIn, Exists and DoesNotExist.
	"""
																				type: "string"
																			}
																			values: {
																				description: """
	values is an array of string values. If the operator is In or NotIn,
	the values array must be non-empty. If the operator is Exists or DoesNotExist,
	the values array must be empty. This array is replaced during a strategic
	merge patch.
	"""
																				items: type: "string"
																				type:                     "array"
																				"x-kubernetes-list-type": "atomic"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	description: """
	matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels
	map is equivalent to an element of matchExpressions, whose key field is "key", the
	operator is "In", and the values array contains only "value". The requirements are ANDed.
	"""
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										hostname: {
											description: """
	Hostname specifies the virtual hostname to match for protocol types that
	define this concept. When unspecified, all hostnames are matched. This
	field is ignored for protocols that don't require hostname based
	matching.


	Implementations MUST apply Hostname matching appropriately for each of
	the following protocols:


	* TLS: The Listener Hostname MUST match the SNI.
	* HTTP: The Listener Hostname MUST match the Host header of the request.
	* HTTPS: The Listener Hostname SHOULD match at both the TLS and HTTP
	  protocol layers as described above. If an implementation does not
	  ensure that both the SNI and Host header match the Listener hostname,
	  it MUST clearly document that.


	For HTTPRoute and TLSRoute resources, there is an interaction with the
	`spec.hostnames` array. When both listener and route specify hostnames,
	there MUST be an intersection between the values for a Route to be
	accepted. For more information, refer to the Route specific Hostnames
	documentation.


	Hostnames that are prefixed with a wildcard label (`*.`) are interpreted
	as a suffix match. That means that a match for `*.example.com` would match
	both `test.example.com`, and `foo.test.example.com`, but not `example.com`.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											pattern:   "^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										name: {
											description: """
	Name is the name of the Listener. This name MUST be unique within a
	Gateway.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										port: {
											description: """
	Port is the network port. Multiple listeners may use the
	same port, subject to the Listener compatibility rules.


	Support: Core
	"""
											format:  "int32"
											maximum: 65535
											minimum: 1
											type:    "integer"
										}
										protocol: {
											description: """
	Protocol specifies the network protocol this listener expects to receive.


	Support: Core
	"""
											maxLength: 255
											minLength: 1
											pattern:   "^[a-zA-Z0-9]([-a-zSA-Z0-9]*[a-zA-Z0-9])?$|[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9]+$"
											type:      "string"
										}
										tls: {
											description: """
	TLS is the TLS configuration for the Listener. This field is required if
	the Protocol field is "HTTPS" or "TLS". It is invalid to set this field
	if the Protocol field is "HTTP", "TCP", or "UDP".


	The association of SNIs to Certificate defined in GatewayTLSConfig is
	defined based on the Hostname field for this listener.


	The GatewayClass MUST use the longest matching SNI out of all
	available certificates for any TLS handshake.


	Support: Core
	"""
											properties: {
												certificateRefs: {
													description: """
	CertificateRefs contains a series of references to Kubernetes objects that
	contains TLS certificates and private keys. These certificates are used to
	establish a TLS handshake for requests that match the hostname of the
	associated listener.


	A single CertificateRef to a Kubernetes Secret has "Core" support.
	Implementations MAY choose to support attaching multiple certificates to
	a Listener, but this behavior is implementation-specific.


	References to a resource in different namespace are invalid UNLESS there
	is a ReferenceGrant in the target namespace that allows the certificate
	to be attached. If a ReferenceGrant does not allow this reference, the
	"ResolvedRefs" condition MUST be set to False for this listener with the
	"RefNotPermitted" reason.


	This field is required to have at least one element when the mode is set
	to "Terminate" (default) and is optional otherwise.


	CertificateRefs can reference to standard Kubernetes resources, i.e.
	Secret, or implementation-specific custom resources.


	Support: Core - A single reference to a Kubernetes Secret of type kubernetes.io/tls


	Support: Implementation-specific (More than one reference or other resource types)
	"""
													items: {
														description: """
	SecretObjectReference identifies an API object including its namespace,
	defaulting to Secret.


	The API object must be valid in the cluster; the Group and Kind must
	be registered in the cluster for this reference to be valid.


	References to objects with invalid Group and Kind are not valid, and must
	be rejected by the implementation, with appropriate Conditions set
	on the containing object.
	"""
														properties: {
															group: {
																default: ""
																description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																maxLength: 253
																pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															kind: {
																default:     "Secret"
																description: "Kind is kind of the referent. For example \"Secret\"."
																maxLength:   63
																minLength:   1
																pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																type:        "string"
															}
															name: {
																description: "Name is the name of the referent."
																maxLength:   253
																minLength:   1
																type:        "string"
															}
															namespace: {
																description: """
	Namespace is the namespace of the referenced object. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
																maxLength: 63
																minLength: 1
																pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
																type:      "string"
															}
														}
														required: ["name"]
														type: "object"
													}
													maxItems: 64
													type:     "array"
												}
												frontendValidation: {
													description: """
	FrontendValidation holds configuration information for validating the frontend (client).
	Setting this field will require clients to send a client certificate
	required for validation during the TLS handshake. In browsers this may result in a dialog appearing
	that requests a user to specify the client certificate.
	The maximum depth of a certificate chain accepted in verification is Implementation specific.


	Support: Extended



	"""
													properties: caCertificateRefs: {
														description: """
	CACertificateRefs contains one or more references to
	Kubernetes objects that contain TLS certificates of
	the Certificate Authorities that can be used
	as a trust anchor to validate the certificates presented by the client.


	A single CA certificate reference to a Kubernetes ConfigMap
	has "Core" support.
	Implementations MAY choose to support attaching multiple CA certificates to
	a Listener, but this behavior is implementation-specific.


	Support: Core - A single reference to a Kubernetes ConfigMap
	with the CA certificate in a key named `ca.crt`.


	Support: Implementation-specific (More than one reference, or other kinds
	of resources).


	References to a resource in a different namespace are invalid UNLESS there
	is a ReferenceGrant in the target namespace that allows the certificate
	to be attached. If a ReferenceGrant does not allow this reference, the
	"ResolvedRefs" condition MUST be set to False for this listener with the
	"RefNotPermitted" reason.
	"""
														items: {
															description: """
	ObjectReference identifies an API object including its namespace.


	The API object must be valid in the cluster; the Group and Kind must
	be registered in the cluster for this reference to be valid.


	References to objects with invalid Group and Kind are not valid, and must
	be rejected by the implementation, with appropriate Conditions set
	on the containing object.
	"""
															properties: {
																group: {
																	description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																	maxLength: 253
																	pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																	type:      "string"
																}
																kind: {
																	description: "Kind is kind of the referent. For example \"ConfigMap\" or \"Service\"."
																	maxLength:   63
																	minLength:   1
																	pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																	type:        "string"
																}
																name: {
																	description: "Name is the name of the referent."
																	maxLength:   253
																	minLength:   1
																	type:        "string"
																}
																namespace: {
																	description: """
	Namespace is the namespace of the referenced object. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
																	maxLength: 63
																	minLength: 1
																	pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
																	type:      "string"
																}
															}
															required: [
																"group",
																"kind",
																"name",
															]
															type: "object"
														}
														maxItems: 8
														minItems: 1
														type:     "array"
													}
													type: "object"
												}
												mode: {
													default: "Terminate"
													description: """
	Mode defines the TLS behavior for the TLS session initiated by the client.
	There are two possible modes:


	- Terminate: The TLS session between the downstream client and the
	  Gateway is terminated at the Gateway. This mode requires certificates
	  to be specified in some way, such as populating the certificateRefs
	  field.
	- Passthrough: The TLS session is NOT terminated by the Gateway. This
	  implies that the Gateway can't decipher the TLS stream except for
	  the ClientHello message of the TLS protocol. The certificateRefs field
	  is ignored in this mode.


	Support: Core
	"""
													enum: [
														"Terminate",
														"Passthrough",
													]
													type: "string"
												}
												options: {
													additionalProperties: {
														description: """
	AnnotationValue is the value of an annotation in Gateway API. This is used
	for validation of maps such as TLS options. This roughly matches Kubernetes
	annotation validation, although the length validation in that case is based
	on the entire size of the annotations struct.
	"""
														maxLength: 4096
														minLength: 0
														type:      "string"
													}
													description: """
	Options are a list of key/value pairs to enable extended TLS
	configuration for each implementation. For example, configuring the
	minimum TLS version or supported cipher suites.


	A set of common keys MAY be defined by the API in the future. To avoid
	any ambiguity, implementation-specific definitions MUST use
	domain-prefixed names, such as `example.com/my-custom-option`.
	Un-prefixed names are reserved for key names defined by Gateway API.


	Support: Implementation-specific
	"""
													maxProperties: 16
													type:          "object"
												}
											}
											type: "object"
											"x-kubernetes-validations": [{
												message: "certificateRefs or options must be specified when mode is Terminate"
												rule:    "self.mode == 'Terminate' ? size(self.certificateRefs) > 0 || size(self.options) > 0 : true"
											}]
										}
									}
									required: [
										"name",
										"port",
										"protocol",
									]
									type: "object"
								}
								maxItems: 64
								minItems: 1
								type:     "array"
								"x-kubernetes-list-map-keys": ["name"]
								"x-kubernetes-list-type": "map"
								"x-kubernetes-validations": [{
									message: "tls must not be specified for protocols ['HTTP', 'TCP', 'UDP']"
									rule:    "self.all(l, l.protocol in ['HTTP', 'TCP', 'UDP'] ? !has(l.tls) : true)"
								}, {
									message: "tls mode must be Terminate for protocol HTTPS"
									rule:    "self.all(l, (l.protocol == 'HTTPS' && has(l.tls)) ? (l.tls.mode == '' || l.tls.mode == 'Terminate') : true)"
								}, {
									message: "hostname must not be specified for protocols ['TCP', 'UDP']"
									rule:    "self.all(l, l.protocol in ['TCP', 'UDP']  ? (!has(l.hostname) || l.hostname == '') : true)"
								}, {
									message: "Listener name must be unique within the Gateway"
									rule:    "self.all(l1, self.exists_one(l2, l1.name == l2.name))"
								}, {
									message: "Combination of port, protocol and hostname must be unique for each listener"
									rule:    "self.all(l1, self.exists_one(l2, l1.port == l2.port && l1.protocol == l2.protocol && (has(l1.hostname) && has(l2.hostname) ? l1.hostname == l2.hostname : !has(l1.hostname) && !has(l2.hostname))))"
								}]
							}
						}
						required: [
							"gatewayClassName",
							"listeners",
						]
						type: "object"
					}
					status: {
						default: conditions: [{
							lastTransitionTime: "1970-01-01T00:00:00Z"
							message:            "Waiting for controller"
							reason:             "Pending"
							status:             "Unknown"
							type:               "Accepted"
						}, {
							lastTransitionTime: "1970-01-01T00:00:00Z"
							message:            "Waiting for controller"
							reason:             "Pending"
							status:             "Unknown"
							type:               "Programmed"
						}]
						description: "Status defines the current state of Gateway."
						properties: {
							addresses: {
								description: """
	Addresses lists the network addresses that have been bound to the
	Gateway.


	This list may differ from the addresses provided in the spec under some
	conditions:


	  * no addresses are specified, all addresses are dynamically assigned
	  * a combination of specified and dynamic addresses are assigned
	  * a specified address was unusable (e.g. already in use)



	"""
								items: {
									description: "GatewayStatusAddress describes a network address that is bound to a Gateway."
									oneOf: [{
										properties: {
											type: enum: ["IPAddress"]
											value: anyOf: [{
												format: "ipv4"
											}, {
												format: "ipv6"
											}]
										}
									}, {
										properties: type: not: enum: ["IPAddress"]
									}]
									properties: {
										type: {
											default:     "IPAddress"
											description: "Type of the address."
											maxLength:   253
											minLength:   1
											pattern:     "^Hostname|IPAddress|NamedAddress|[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
											type:        "string"
										}
										value: {
											description: """
	Value of the address. The validity of the values will depend
	on the type and support by the controller.


	Examples: `1.2.3.4`, `128::1`, `my-ip-address`.
	"""
											maxLength: 253
											minLength: 1
											type:      "string"
										}
									}
									required: ["value"]
									type: "object"
									"x-kubernetes-validations": [{
										message: "Hostname value must only contain valid characters (matching ^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$)"
										rule:    "self.type == 'Hostname' ? self.value.matches(r\"\"\"^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$\"\"\"): true"
									}]
								}
								maxItems: 16
								type:     "array"
							}
							conditions: {
								default: [{
									lastTransitionTime: "1970-01-01T00:00:00Z"
									message:            "Waiting for controller"
									reason:             "Pending"
									status:             "Unknown"
									type:               "Accepted"
								}, {
									lastTransitionTime: "1970-01-01T00:00:00Z"
									message:            "Waiting for controller"
									reason:             "Pending"
									status:             "Unknown"
									type:               "Programmed"
								}]
								description: """
	Conditions describe the current conditions of the Gateway.


	Implementations should prefer to express Gateway conditions
	using the `GatewayConditionType` and `GatewayConditionReason`
	constants so that operators and tools can converge on a common
	vocabulary to describe Gateway state.


	Known condition types are:


	* "Accepted"
	* "Programmed"
	* "Ready"
	"""
								items: {
									description: """
	Condition contains details for one aspect of the current state of this API Resource.
	---
	This struct is intended for direct use as an array at the field path .status.conditions.  For example,


	\ttype FooStatus struct{
	\t    // Represents the observations of a foo's current state.
	\t    // Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
	\t    // +patchMergeKey=type
	\t    // +patchStrategy=merge
	\t    // +listType=map
	\t    // +listMapKey=type
	\t    Conditions []metav1.Condition `json:"conditions,omitempty" patchStrategy:"merge" patchMergeKey:"type" protobuf:"bytes,1,rep,name=conditions"`


	\t    // other fields
	\t}
	"""
									properties: {
										lastTransitionTime: {
											description: """
	lastTransitionTime is the last time the condition transitioned from one status to another.
	This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
	"""
											format: "date-time"
											type:   "string"
										}
										message: {
											description: """
	message is a human readable message indicating details about the transition.
	This may be an empty string.
	"""
											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: """
	observedGeneration represents the .metadata.generation that the condition was set based upon.
	For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
	with respect to the current state of the instance.
	"""
											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: """
	reason contains a programmatic identifier indicating the reason for the condition's last transition.
	Producers of specific condition types may define expected values and meanings for this field,
	and whether the values are considered a guaranteed API.
	The value should be a CamelCase string.
	This field may not be empty.
	"""
											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: """
	type of condition in CamelCase or in foo.example.com/CamelCase.
	---
	Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be
	useful (see .node.status.conditions), the ability to deconflict is important.
	The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)
	"""
											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								maxItems: 8
								type:     "array"
								"x-kubernetes-list-map-keys": ["type"]
								"x-kubernetes-list-type": "map"
							}
							listeners: {
								description: "Listeners provide status for each unique listener port defined in the Spec."
								items: {
									description: "ListenerStatus is the status associated with a Listener."
									properties: {
										attachedRoutes: {
											description: """
	AttachedRoutes represents the total number of Routes that have been
	successfully attached to this Listener.


	Successful attachment of a Route to a Listener is based solely on the
	combination of the AllowedRoutes field on the corresponding Listener
	and the Route's ParentRefs field. A Route is successfully attached to
	a Listener when it is selected by the Listener's AllowedRoutes field
	AND the Route has a valid ParentRef selecting the whole Gateway
	resource or a specific Listener as a parent resource (more detail on
	attachment semantics can be found in the documentation on the various
	Route kinds ParentRefs fields). Listener or Route status does not impact
	successful attachment, i.e. the AttachedRoutes field count MUST be set
	for Listeners with condition Accepted: false and MUST count successfully
	attached Routes that may themselves have Accepted: false conditions.


	Uses for this field include troubleshooting Route attachment and
	measuring blast radius/impact of changes to a Listener.
	"""
											format: "int32"
											type:   "integer"
										}
										conditions: {
											description: "Conditions describe the current condition of this listener."
											items: {
												description: """
	Condition contains details for one aspect of the current state of this API Resource.
	---
	This struct is intended for direct use as an array at the field path .status.conditions.  For example,


	\ttype FooStatus struct{
	\t    // Represents the observations of a foo's current state.
	\t    // Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
	\t    // +patchMergeKey=type
	\t    // +patchStrategy=merge
	\t    // +listType=map
	\t    // +listMapKey=type
	\t    Conditions []metav1.Condition `json:"conditions,omitempty" patchStrategy:"merge" patchMergeKey:"type" protobuf:"bytes,1,rep,name=conditions"`


	\t    // other fields
	\t}
	"""
												properties: {
													lastTransitionTime: {
														description: """
	lastTransitionTime is the last time the condition transitioned from one status to another.
	This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
	"""
														format: "date-time"
														type:   "string"
													}
													message: {
														description: """
	message is a human readable message indicating details about the transition.
	This may be an empty string.
	"""
														maxLength: 32768
														type:      "string"
													}
													observedGeneration: {
														description: """
	observedGeneration represents the .metadata.generation that the condition was set based upon.
	For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
	with respect to the current state of the instance.
	"""
														format:  "int64"
														minimum: 0
														type:    "integer"
													}
													reason: {
														description: """
	reason contains a programmatic identifier indicating the reason for the condition's last transition.
	Producers of specific condition types may define expected values and meanings for this field,
	and whether the values are considered a guaranteed API.
	The value should be a CamelCase string.
	This field may not be empty.
	"""
														maxLength: 1024
														minLength: 1
														pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
														type:      "string"
													}
													status: {
														description: "status of the condition, one of True, False, Unknown."
														enum: [
															"True",
															"False",
															"Unknown",
														]
														type: "string"
													}
													type: {
														description: """
	type of condition in CamelCase or in foo.example.com/CamelCase.
	---
	Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be
	useful (see .node.status.conditions), the ability to deconflict is important.
	The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)
	"""
														maxLength: 316
														pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
														type:      "string"
													}
												}
												required: [
													"lastTransitionTime",
													"message",
													"reason",
													"status",
													"type",
												]
												type: "object"
											}
											maxItems: 8
											type:     "array"
											"x-kubernetes-list-map-keys": ["type"]
											"x-kubernetes-list-type": "map"
										}
										name: {
											description: "Name is the name of the Listener that this status corresponds to."
											maxLength:   253
											minLength:   1
											pattern:     "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:        "string"
										}
										supportedKinds: {
											description: """
	SupportedKinds is the list indicating the Kinds supported by this
	listener. This MUST represent the kinds an implementation supports for
	that Listener configuration.


	If kinds are specified in Spec that are not supported, they MUST NOT
	appear in this list and an implementation MUST set the "ResolvedRefs"
	condition to "False" with the "InvalidRouteKinds" reason. If both valid
	and invalid Route kinds are specified, the implementation MUST
	reference the valid Route kinds that have been specified.
	"""
											items: {
												description: "RouteGroupKind indicates the group and kind of a Route resource."
												properties: {
													group: {
														default:     "gateway.networking.k8s.io"
														description: "Group is the group of the Route."
														maxLength:   253
														pattern:     "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
														type:        "string"
													}
													kind: {
														description: "Kind is the kind of the Route."
														maxLength:   63
														minLength:   1
														pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
														type:        "string"
													}
												}
												required: ["kind"]
												type: "object"
											}
											maxItems: 8
											type:     "array"
										}
									}
									required: [
										"attachedRoutes",
										"conditions",
										"name",
										"supportedKinds",
									]
									type: "object"
								}
								maxItems: 64
								type:     "array"
								"x-kubernetes-list-map-keys": ["name"]
								"x-kubernetes-list-type": "map"
							}
						}
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}]
	}
}, {
	metadata: {
		name: "grpcroutes.gateway.networking.k8s.io"
		annotations: {
			"api-approved.kubernetes.io":               "https://github.com/kubernetes-sigs/gateway-api/pull/2997"
			"gateway.networking.k8s.io/bundle-version": "v1.1.0"
			"gateway.networking.k8s.io/channel":        "experimental"
		}
	}
	spec: {
		group: "gateway.networking.k8s.io"
		names: {
			categories: ["gateway-api"]
			kind:     "GRPCRoute"
			listKind: "GRPCRouteList"
			plural:   "grpcroutes"
			singular: "grpcroute"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.hostnames"
				name:     "Hostnames"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: """
					GRPCRoute provides a way to route gRPC requests. This includes the capability
					to match requests by hostname, gRPC service, gRPC method, or HTTP/2 header.
					Filters can be used to specify additional processing steps. Backends specify
					where matching requests will be routed.


					GRPCRoute falls under extended support within the Gateway API. Within the
					following specification, the word "MUST" indicates that an implementation
					supporting GRPCRoute must conform to the indicated requirement, but an
					implementation not supporting this route type need not follow the requirement
					unless explicitly indicated.


					Implementations supporting `GRPCRoute` with the `HTTPS` `ProtocolType` MUST
					accept HTTP/2 connections without an initial upgrade from HTTP/1.1, i.e. via
					ALPN. If the implementation does not support this, then it MUST set the
					"Accepted" condition to "False" for the affected listener with a reason of
					"UnsupportedProtocol".  Implementations MAY also accept HTTP/2 connections
					with an upgrade from HTTP/1.


					Implementations supporting `GRPCRoute` with the `HTTP` `ProtocolType` MUST
					support HTTP/2 over cleartext TCP (h2c,
					https://www.rfc-editor.org/rfc/rfc7540#section-3.1) without an initial
					upgrade from HTTP/1.1, i.e. with prior knowledge
					(https://www.rfc-editor.org/rfc/rfc7540#section-3.4). If the implementation
					does not support this, then it MUST set the "Accepted" condition to "False"
					for the affected listener with a reason of "UnsupportedProtocol".
					Implementations MAY also accept HTTP/2 connections with an upgrade from
					HTTP/1, i.e. without prior knowledge.
					"""
				properties: {
					apiVersion: {
						description: """
	APIVersion defines the versioned schema of this representation of an object.
	Servers should convert recognized schemas to the latest internal value, and
	may reject unrecognized values.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	"""
						type: "string"
					}
					kind: {
						description: """
	Kind is a string value representing the REST resource this object represents.
	Servers may infer this from the endpoint the client submits requests to.
	Cannot be updated.
	In CamelCase.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	"""
						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec defines the desired state of GRPCRoute."
						properties: {
							hostnames: {
								description: """
	Hostnames defines a set of hostnames to match against the GRPC
	Host header to select a GRPCRoute to process the request. This matches
	the RFC 1123 definition of a hostname with 2 notable exceptions:


	1. IPs are not allowed.
	2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard
	   label MUST appear by itself as the first label.


	If a hostname is specified by both the Listener and GRPCRoute, there
	MUST be at least one intersecting hostname for the GRPCRoute to be
	attached to the Listener. For example:


	* A Listener with `test.example.com` as the hostname matches GRPCRoutes
	  that have either not specified any hostnames, or have specified at
	  least one of `test.example.com` or `*.example.com`.
	* A Listener with `*.example.com` as the hostname matches GRPCRoutes
	  that have either not specified any hostnames or have specified at least
	  one hostname that matches the Listener hostname. For example,
	  `test.example.com` and `*.example.com` would both match. On the other
	  hand, `example.com` and `test.example.net` would not match.


	Hostnames that are prefixed with a wildcard label (`*.`) are interpreted
	as a suffix match. That means that a match for `*.example.com` would match
	both `test.example.com`, and `foo.test.example.com`, but not `example.com`.


	If both the Listener and GRPCRoute have specified hostnames, any
	GRPCRoute hostnames that do not match the Listener hostname MUST be
	ignored. For example, if a Listener specified `*.example.com`, and the
	GRPCRoute specified `test.example.com` and `test.example.net`,
	`test.example.net` MUST NOT be considered for a match.


	If both the Listener and GRPCRoute have specified hostnames, and none
	match with the criteria above, then the GRPCRoute MUST NOT be accepted by
	the implementation. The implementation MUST raise an 'Accepted' Condition
	with a status of `False` in the corresponding RouteParentStatus.


	If a Route (A) of type HTTPRoute or GRPCRoute is attached to a
	Listener and that listener already has another Route (B) of the other
	type attached and the intersection of the hostnames of A and B is
	non-empty, then the implementation MUST accept exactly one of these two
	routes, determined by the following criteria, in order:


	* The oldest Route based on creation timestamp.
	* The Route appearing first in alphabetical order by
	  "{namespace}/{name}".


	The rejected Route MUST raise an 'Accepted' condition with a status of
	'False' in the corresponding RouteParentStatus.


	Support: Core
	"""
								items: {
									description: """
	Hostname is the fully qualified domain name of a network host. This matches
	the RFC 1123 definition of a hostname with 2 notable exceptions:


	 1. IPs are not allowed.
	 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard
	    label must appear by itself as the first label.


	Hostname can be "precise" which is a domain name without the terminating
	dot of a network host (e.g. "foo.example.com") or "wildcard", which is a
	domain name prefixed with a single wildcard label (e.g. `*.example.com`).


	Note that as per RFC1035 and RFC1123, a *label* must consist of lower case
	alphanumeric characters or '-', and must start and end with an alphanumeric
	character. No other punctuation is allowed.
	"""
									maxLength: 253
									minLength: 1
									pattern:   "^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
									type:      "string"
								}
								maxItems: 16
								type:     "array"
							}
							parentRefs: {
								description: """
	ParentRefs references the resources (usually Gateways) that a Route wants
	to be attached to. Note that the referenced parent resource needs to
	allow this for the attachment to be complete. For Gateways, that means
	the Gateway needs to allow attachment from Routes of this kind and
	namespace. For Services, that means the Service must either be in the same
	namespace for a "producer" route, or the mesh implementation must support
	and allow "consumer" routes for the referenced Service. ReferenceGrant is
	not applicable for governing ParentRefs to Services - it is not possible to
	create a "producer" route for a Service in a different namespace from the
	Route.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	This API may be extended in the future to support additional kinds of parent
	resources.


	ParentRefs must be _distinct_. This means either that:


	* They select different objects.  If this is the case, then parentRef
	  entries are distinct. In terms of fields, this means that the
	  multi-part key defined by `group`, `kind`, `namespace`, and `name` must
	  be unique across all parentRef entries in the Route.
	* They do not select different objects, but for each optional field used,
	  each ParentRef that selects the same object must set the same set of
	  optional fields to different values. If one ParentRef sets a
	  combination of optional fields, all must set the same combination.


	Some examples:


	* If one ParentRef sets `sectionName`, all ParentRefs referencing the
	  same object must also set `sectionName`.
	* If one ParentRef sets `port`, all ParentRefs referencing the same
	  object must also set `port`.
	* If one ParentRef sets `sectionName` and `port`, all ParentRefs
	  referencing the same object must also set `sectionName` and `port`.


	It is possible to separately reference multiple distinct objects that may
	be collapsed by an implementation. For example, some implementations may
	choose to merge compatible Gateway Listeners together. If that is the
	case, the list of routes attached to those resources should also be
	merged.


	Note that for ParentRefs that cross namespace boundaries, there are specific
	rules. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example,
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable other kinds of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.







	"""
								items: {
									description: """
	ParentReference identifies an API object (usually a Gateway) that can be considered
	a parent of this resource (usually a route). There are two kinds of parent resources
	with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	This API may be extended in the future to support additional kinds of parent
	resources.


	The API object must be valid in the cluster; the Group and Kind must
	be registered in the cluster for this reference to be valid.
	"""
									properties: {
										group: {
											default: "gateway.networking.k8s.io"
											description: """
	Group is the group of the referent.
	When unspecified, "gateway.networking.k8s.io" is inferred.
	To set the core API group (such as for a "Service" kind referent),
	Group must be explicitly set to "" (empty string).


	Support: Core
	"""
											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											default: "Gateway"
											description: """
	Kind is kind of the referent.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	Support for other resources is Implementation-Specific.
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										name: {
											description: """
	Name is the name of the referent.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: """
	Namespace is the namespace of the referent. When unspecified, this refers
	to the local namespace of the Route.


	Note that there are specific rules for ParentRefs which cross namespace
	boundaries. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example:
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable any other kind of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.



	Support: Core
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
											type:      "string"
										}
										port: {
											description: """
	Port is the network port this Route targets. It can be interpreted
	differently based on the type of parent resource.


	When the parent resource is a Gateway, this targets all listeners
	listening on the specified port that also support this kind of Route(and
	select this Route). It's not recommended to set `Port` unless the
	networking behaviors specified in a Route must apply to a specific port
	as opposed to a listener(s) whose port(s) may be changed. When both Port
	and SectionName are specified, the name and port of the selected listener
	must match both specified values.



	When the parent resource is a Service, this targets a specific port in the
	Service spec. When both Port (experimental) and SectionName are specified,
	the name and port of the selected port must match both specified values.



	Implementations MAY choose to support other parent resources.
	Implementations supporting other types of parent resources MUST clearly
	document how/if Port is interpreted.


	For the purpose of status, an attachment is considered successful as
	long as the parent resource accepts it partially. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
	from the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route,
	the Route MUST be considered detached from the Gateway.


	Support: Extended
	"""
											format:  "int32"
											maximum: 65535
											minimum: 1
											type:    "integer"
										}
										sectionName: {
											description: """
	SectionName is the name of a section within the target resource. In the
	following resources, SectionName is interpreted as the following:


	* Gateway: Listener name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.
	* Service: Port name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.


	Implementations MAY choose to support attaching Routes to other resources.
	If that is the case, they MUST clearly document how SectionName is
	interpreted.


	When unspecified (empty string), this will reference the entire resource.
	For the purpose of status, an attachment is considered successful if at
	least one section in the parent resource accepts it. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
	the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route, the
	Route MUST be considered detached from the Gateway.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								maxItems: 32
								type:     "array"
								"x-kubernetes-validations": [{
									message: "sectionName or port must be specified when parentRefs includes 2 or more references to the same parent"
									rule:    "self.all(p1, self.all(p2, p1.group == p2.group && p1.kind == p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) || p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ == '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__ == p2.__namespace__)) ? ((!has(p1.sectionName) || p1.sectionName == '') == (!has(p2.sectionName) || p2.sectionName == '') && (!has(p1.port) || p1.port == 0) == (!has(p2.port) || p2.port == 0)): true))"
								}, {
									message: "sectionName or port must be unique when parentRefs includes 2 or more references to the same parent"
									rule:    "self.all(p1, self.exists_one(p2, p1.group == p2.group && p1.kind == p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) || p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ == '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__ == p2.__namespace__ )) && (((!has(p1.sectionName) || p1.sectionName == '') && (!has(p2.sectionName) || p2.sectionName == '')) || ( has(p1.sectionName) && has(p2.sectionName) && p1.sectionName == p2.sectionName)) && (((!has(p1.port) || p1.port == 0) && (!has(p2.port) || p2.port == 0)) || (has(p1.port) && has(p2.port) && p1.port == p2.port))))"
								}]
							}
							rules: {
								description: "Rules are a list of GRPC matchers, filters and actions."
								items: {
									description: """
	GRPCRouteRule defines the semantics for matching a gRPC request based on
	conditions (matches), processing it (filters), and forwarding the request to
	an API object (backendRefs).
	"""
									properties: {
										backendRefs: {
											description: """
	BackendRefs defines the backend(s) where matching requests should be
	sent.


	Failure behavior here depends on how many BackendRefs are specified and
	how many are invalid.


	If *all* entries in BackendRefs are invalid, and there are also no filters
	specified in this route rule, *all* traffic which matches this rule MUST
	receive an `UNAVAILABLE` status.


	See the GRPCBackendRef definition for the rules about what makes a single
	GRPCBackendRef invalid.


	When a GRPCBackendRef is invalid, `UNAVAILABLE` statuses MUST be returned for
	requests that would have otherwise been routed to an invalid backend. If
	multiple backends are specified, and some are invalid, the proportion of
	requests that would otherwise have been routed to an invalid backend
	MUST receive an `UNAVAILABLE` status.


	For example, if two backends are specified with equal weights, and one is
	invalid, 50 percent of traffic MUST receive an `UNAVAILABLE` status.
	Implementations may choose how that 50 percent is determined.


	Support: Core for Kubernetes Service


	Support: Implementation-specific for any other resource


	Support for weight: Core
	"""
											items: {
												description: """
	GRPCBackendRef defines how a GRPCRoute forwards a gRPC request.


	Note that when a namespace different than the local namespace is specified, a
	ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	<gateway:experimental:description>


	When the BackendRef points to a Kubernetes Service, implementations SHOULD
	honor the appProtocol field if it is set for the target Service Port.


	Implementations supporting appProtocol SHOULD recognize the Kubernetes
	Standard Application Protocols defined in KEP-3726.


	If a Service appProtocol isn't specified, an implementation MAY infer the
	backend protocol through its own means. Implementations MAY infer the
	protocol from the Route type referring to the backend Service.


	If a Route is not able to send traffic to the backend using the specified
	protocol then the backend is considered invalid. Implementations MUST set the
	"ResolvedRefs" condition to "False" with the "UnsupportedProtocol" reason.


	</gateway:experimental:description>
	"""
												properties: {
													filters: {
														description: """
	Filters defined at this level MUST be executed if and only if the
	request is being forwarded to the backend defined here.


	Support: Implementation-specific (For broader support of filters, use the
	Filters field in GRPCRouteRule.)
	"""
														items: {
															description: """
	GRPCRouteFilter defines processing steps that must be completed during the
	request or response lifecycle. GRPCRouteFilters are meant as an extension
	point to express processing that may be done in Gateway implementations. Some
	examples include request or response modification, implementing
	authentication strategies, rate-limiting, and traffic shaping. API
	guarantee/conformance is defined based on the type of the filter.
	"""
															properties: {
																extensionRef: {
																	description: """
	ExtensionRef is an optional, implementation-specific extension to the
	"filter" behavior.  For example, resource "myroutefilter" in group
	"networking.example.net"). ExtensionRef MUST NOT be used for core and
	extended filters.


	Support: Implementation-specific


	This filter can be used multiple times within the same rule.
	"""
																	properties: {
																		group: {
																			description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																			maxLength: 253
																			pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		kind: {
																			description: "Kind is kind of the referent. For example \"HTTPRoute\" or \"Service\"."
																			maxLength:   63
																			minLength:   1
																			pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																			type:        "string"
																		}
																		name: {
																			description: "Name is the name of the referent."
																			maxLength:   253
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"group",
																		"kind",
																		"name",
																	]
																	type: "object"
																}
																requestHeaderModifier: {
																	description: """
	RequestHeaderModifier defines a schema for a filter that modifies request
	headers.


	Support: Core
	"""
																	properties: {
																		add: {
																			description: """
	Add adds the given header(s) (name, value) to the request
	before the action. It appends to any existing values associated
	with the header name.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  add:
	  - name: "my-header"
	    value: "bar,baz"


	Output:
	  GET /foo HTTP/1.1
	  my-header: foo,bar,baz
	"""
																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																				properties: {
																					name: {
																						description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."
																						maxLength:   4096
																						minLength:   1
																						type:        "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
	Remove the given header(s) from the HTTP request before the action. The
	value of Remove is a list of HTTP header names. Note that the header
	names are case-insensitive (see
	https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).


	Input:
	  GET /foo HTTP/1.1
	  my-header1: foo
	  my-header2: bar
	  my-header3: baz


	Config:
	  remove: ["my-header1", "my-header3"]


	Output:
	  GET /foo HTTP/1.1
	  my-header2: bar
	"""
																			items: type: "string"
																			maxItems:                 16
																			type:                     "array"
																			"x-kubernetes-list-type": "set"
																		}
																		set: {
																			description: """
	Set overwrites the request with the given header (name, value)
	before the action.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  set:
	  - name: "my-header"
	    value: "bar"


	Output:
	  GET /foo HTTP/1.1
	  my-header: bar
	"""
																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																				properties: {
																					name: {
																						description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."
																						maxLength:   4096
																						minLength:   1
																						type:        "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																requestMirror: {
																	description: """
	RequestMirror defines a schema for a filter that mirrors requests.
	Requests are sent to the specified destination, but responses from
	that destination are ignored.


	This filter can be used multiple times within the same rule. Note that
	not all implementations will be able to support mirroring to multiple
	backends.


	Support: Extended
	"""
																	properties: backendRef: {
																		description: """
	BackendRef references a resource where mirrored requests are sent.


	Mirrored requests must be sent only to a single destination endpoint
	within this BackendRef, irrespective of how many endpoints are present
	within this BackendRef.


	If the referent cannot be found, this BackendRef is invalid and must be
	dropped from the Gateway. The controller must ensure the "ResolvedRefs"
	condition on the Route status is set to `status: False` and not configure
	this backend in the underlying implementation.


	If there is a cross-namespace reference to an *existing* object
	that is not allowed by a ReferenceGrant, the controller must ensure the
	"ResolvedRefs"  condition on the Route is set to `status: False`,
	with the "RefNotPermitted" reason and not configure this backend in the
	underlying implementation.


	In either error case, the Message of the `ResolvedRefs` Condition
	should be used to provide more detail about the problem.


	Support: Extended for Kubernetes Service


	Support: Implementation-specific for any other resource
	"""
																		properties: {
																			group: {
																				default: ""
																				description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																				maxLength: 253
																				pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																				type:      "string"
																			}
																			kind: {
																				default: "Service"
																				description: """
	Kind is the Kubernetes resource kind of the referent. For example
	"Service".


	Defaults to "Service" when not specified.


	ExternalName services can refer to CNAME DNS records that may live
	outside of the cluster and as such are difficult to reason about in
	terms of conformance. They also may not be safe to forward to (see
	CVE-2021-25740 for more information). Implementations SHOULD NOT
	support ExternalName Services.


	Support: Core (Services with a type other than ExternalName)


	Support: Implementation-specific (Services with type ExternalName)
	"""
																				maxLength: 63
																				minLength: 1
																				pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																				type:      "string"
																			}
																			name: {
																				description: "Name is the name of the referent."
																				maxLength:   253
																				minLength:   1
																				type:        "string"
																			}
																			namespace: {
																				description: """
	Namespace is the namespace of the backend. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
																				maxLength: 63
																				minLength: 1
																				pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
																				type:      "string"
																			}
																			port: {
																				description: """
	Port specifies the destination port number to use for this resource.
	Port is required when the referent is a Kubernetes Service. In this
	case, the port number is the service port number, not the target port.
	For other resources, destination port might be derived from the referent
	resource or this field.
	"""
																				format:  "int32"
																				maximum: 65535
																				minimum: 1
																				type:    "integer"
																			}
																		}
																		required: ["name"]
																		type: "object"
																		"x-kubernetes-validations": [{
																			message: "Must have port for Service reference"
																			rule:    "(size(self.group) == 0 && self.kind == 'Service') ? has(self.port) : true"
																		}]
																	}
																	required: ["backendRef"]
																	type: "object"
																}
																responseHeaderModifier: {
																	description: """
	ResponseHeaderModifier defines a schema for a filter that modifies response
	headers.


	Support: Extended
	"""
																	properties: {
																		add: {
																			description: """
	Add adds the given header(s) (name, value) to the request
	before the action. It appends to any existing values associated
	with the header name.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  add:
	  - name: "my-header"
	    value: "bar,baz"


	Output:
	  GET /foo HTTP/1.1
	  my-header: foo,bar,baz
	"""
																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																				properties: {
																					name: {
																						description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."
																						maxLength:   4096
																						minLength:   1
																						type:        "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
	Remove the given header(s) from the HTTP request before the action. The
	value of Remove is a list of HTTP header names. Note that the header
	names are case-insensitive (see
	https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).


	Input:
	  GET /foo HTTP/1.1
	  my-header1: foo
	  my-header2: bar
	  my-header3: baz


	Config:
	  remove: ["my-header1", "my-header3"]


	Output:
	  GET /foo HTTP/1.1
	  my-header2: bar
	"""
																			items: type: "string"
																			maxItems:                 16
																			type:                     "array"
																			"x-kubernetes-list-type": "set"
																		}
																		set: {
																			description: """
	Set overwrites the request with the given header (name, value)
	before the action.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  set:
	  - name: "my-header"
	    value: "bar"


	Output:
	  GET /foo HTTP/1.1
	  my-header: bar
	"""
																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																				properties: {
																					name: {
																						description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."
																						maxLength:   4096
																						minLength:   1
																						type:        "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																type: {
																	description: """
	Type identifies the type of filter to apply. As with other API fields,
	types are classified into three conformance levels:


	- Core: Filter types and their corresponding configuration defined by
	  "Support: Core" in this package, e.g. "RequestHeaderModifier". All
	  implementations supporting GRPCRoute MUST support core filters.


	- Extended: Filter types and their corresponding configuration defined by
	  "Support: Extended" in this package, e.g. "RequestMirror". Implementers
	  are encouraged to support extended filters.


	- Implementation-specific: Filters that are defined and supported by specific vendors.
	  In the future, filters showing convergence in behavior across multiple
	  implementations will be considered for inclusion in extended or core
	  conformance levels. Filter-specific configuration for such filters
	  is specified using the ExtensionRef field. `Type` MUST be set to
	  "ExtensionRef" for custom filters.


	Implementers are encouraged to define custom implementation types to
	extend the core API with implementation-specific behavior.


	If a reference to a custom filter type cannot be resolved, the filter
	MUST NOT be skipped. Instead, requests that would have been processed by
	that filter MUST receive a HTTP error response.



	"""
																	enum: [
																		"ResponseHeaderModifier",
																		"RequestHeaderModifier",
																		"RequestMirror",
																		"ExtensionRef",
																	]
																	type: "string"
																}
															}
															required: ["type"]
															type: "object"
															"x-kubernetes-validations": [{
																message: "filter.requestHeaderModifier must be nil if the filter.type is not RequestHeaderModifier"
																rule:    "!(has(self.requestHeaderModifier) && self.type != 'RequestHeaderModifier')"
															}, {
																message: "filter.requestHeaderModifier must be specified for RequestHeaderModifier filter.type"
																rule:    "!(!has(self.requestHeaderModifier) && self.type == 'RequestHeaderModifier')"
															}, {
																message: "filter.responseHeaderModifier must be nil if the filter.type is not ResponseHeaderModifier"
																rule:    "!(has(self.responseHeaderModifier) && self.type != 'ResponseHeaderModifier')"
															}, {
																message: "filter.responseHeaderModifier must be specified for ResponseHeaderModifier filter.type"
																rule:    "!(!has(self.responseHeaderModifier) && self.type == 'ResponseHeaderModifier')"
															}, {
																message: "filter.requestMirror must be nil if the filter.type is not RequestMirror"
																rule:    "!(has(self.requestMirror) && self.type != 'RequestMirror')"
															}, {
																message: "filter.requestMirror must be specified for RequestMirror filter.type"
																rule:    "!(!has(self.requestMirror) && self.type == 'RequestMirror')"
															}, {
																message: "filter.extensionRef must be nil if the filter.type is not ExtensionRef"
																rule:    "!(has(self.extensionRef) && self.type != 'ExtensionRef')"
															}, {
																message: "filter.extensionRef must be specified for ExtensionRef filter.type"
																rule:    "!(!has(self.extensionRef) && self.type == 'ExtensionRef')"
															}]
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-validations": [{
															message: "RequestHeaderModifier filter cannot be repeated"
															rule:    "self.filter(f, f.type == 'RequestHeaderModifier').size() <= 1"
														}, {
															message: "ResponseHeaderModifier filter cannot be repeated"
															rule:    "self.filter(f, f.type == 'ResponseHeaderModifier').size() <= 1"
														}]
													}
													group: {
														default: ""
														description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
														maxLength: 253
														pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
														type:      "string"
													}
													kind: {
														default: "Service"
														description: """
	Kind is the Kubernetes resource kind of the referent. For example
	"Service".


	Defaults to "Service" when not specified.


	ExternalName services can refer to CNAME DNS records that may live
	outside of the cluster and as such are difficult to reason about in
	terms of conformance. They also may not be safe to forward to (see
	CVE-2021-25740 for more information). Implementations SHOULD NOT
	support ExternalName Services.


	Support: Core (Services with a type other than ExternalName)


	Support: Implementation-specific (Services with type ExternalName)
	"""
														maxLength: 63
														minLength: 1
														pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
														type:      "string"
													}
													name: {
														description: "Name is the name of the referent."
														maxLength:   253
														minLength:   1
														type:        "string"
													}
													namespace: {
														description: """
	Namespace is the namespace of the backend. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
														maxLength: 63
														minLength: 1
														pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
														type:      "string"
													}
													port: {
														description: """
	Port specifies the destination port number to use for this resource.
	Port is required when the referent is a Kubernetes Service. In this
	case, the port number is the service port number, not the target port.
	For other resources, destination port might be derived from the referent
	resource or this field.
	"""
														format:  "int32"
														maximum: 65535
														minimum: 1
														type:    "integer"
													}
													weight: {
														default: 1
														description: """
	Weight specifies the proportion of requests forwarded to the referenced
	backend. This is computed as weight/(sum of all weights in this
	BackendRefs list). For non-zero values, there may be some epsilon from
	the exact proportion defined here depending on the precision an
	implementation supports. Weight is not a percentage and the sum of
	weights does not need to equal 100.


	If only one backend is specified and it has a weight greater than 0, 100%
	of the traffic is forwarded to that backend. If weight is set to 0, no
	traffic should be forwarded for this entry. If unspecified, weight
	defaults to 1.


	Support for this field varies based on the context where used.
	"""
														format:  "int32"
														maximum: 1000000
														minimum: 0
														type:    "integer"
													}
												}
												required: ["name"]
												type: "object"
												"x-kubernetes-validations": [{
													message: "Must have port for Service reference"
													rule:    "(size(self.group) == 0 && self.kind == 'Service') ? has(self.port) : true"
												}]
											}
											maxItems: 16
											type:     "array"
										}
										filters: {
											description: """
	Filters define the filters that are applied to requests that match
	this rule.


	The effects of ordering of multiple behaviors are currently unspecified.
	This can change in the future based on feedback during the alpha stage.


	Conformance-levels at this level are defined based on the type of filter:


	- ALL core filters MUST be supported by all implementations that support
	  GRPCRoute.
	- Implementers are encouraged to support extended filters.
	- Implementation-specific custom filters have no API guarantees across
	  implementations.


	Specifying the same filter multiple times is not supported unless explicitly
	indicated in the filter.


	If an implementation can not support a combination of filters, it must clearly
	document that limitation. In cases where incompatible or unsupported
	filters are specified and cause the `Accepted` condition to be set to status
	`False`, implementations may use the `IncompatibleFilters` reason to specify
	this configuration error.


	Support: Core
	"""
											items: {
												description: """
	GRPCRouteFilter defines processing steps that must be completed during the
	request or response lifecycle. GRPCRouteFilters are meant as an extension
	point to express processing that may be done in Gateway implementations. Some
	examples include request or response modification, implementing
	authentication strategies, rate-limiting, and traffic shaping. API
	guarantee/conformance is defined based on the type of the filter.
	"""
												properties: {
													extensionRef: {
														description: """
	ExtensionRef is an optional, implementation-specific extension to the
	"filter" behavior.  For example, resource "myroutefilter" in group
	"networking.example.net"). ExtensionRef MUST NOT be used for core and
	extended filters.


	Support: Implementation-specific


	This filter can be used multiple times within the same rule.
	"""
														properties: {
															group: {
																description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																maxLength: 253
																pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															kind: {
																description: "Kind is kind of the referent. For example \"HTTPRoute\" or \"Service\"."
																maxLength:   63
																minLength:   1
																pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																type:        "string"
															}
															name: {
																description: "Name is the name of the referent."
																maxLength:   253
																minLength:   1
																type:        "string"
															}
														}
														required: [
															"group",
															"kind",
															"name",
														]
														type: "object"
													}
													requestHeaderModifier: {
														description: """
	RequestHeaderModifier defines a schema for a filter that modifies request
	headers.


	Support: Core
	"""
														properties: {
															add: {
																description: """
	Add adds the given header(s) (name, value) to the request
	before the action. It appends to any existing values associated
	with the header name.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  add:
	  - name: "my-header"
	    value: "bar,baz"


	Output:
	  GET /foo HTTP/1.1
	  my-header: foo,bar,baz
	"""
																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																	properties: {
																		name: {
																			description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."
																			maxLength:   4096
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
															remove: {
																description: """
	Remove the given header(s) from the HTTP request before the action. The
	value of Remove is a list of HTTP header names. Note that the header
	names are case-insensitive (see
	https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).


	Input:
	  GET /foo HTTP/1.1
	  my-header1: foo
	  my-header2: bar
	  my-header3: baz


	Config:
	  remove: ["my-header1", "my-header3"]


	Output:
	  GET /foo HTTP/1.1
	  my-header2: bar
	"""
																items: type: "string"
																maxItems:                 16
																type:                     "array"
																"x-kubernetes-list-type": "set"
															}
															set: {
																description: """
	Set overwrites the request with the given header (name, value)
	before the action.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  set:
	  - name: "my-header"
	    value: "bar"


	Output:
	  GET /foo HTTP/1.1
	  my-header: bar
	"""
																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																	properties: {
																		name: {
																			description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."
																			maxLength:   4096
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
														}
														type: "object"
													}
													requestMirror: {
														description: """
	RequestMirror defines a schema for a filter that mirrors requests.
	Requests are sent to the specified destination, but responses from
	that destination are ignored.


	This filter can be used multiple times within the same rule. Note that
	not all implementations will be able to support mirroring to multiple
	backends.


	Support: Extended
	"""
														properties: backendRef: {
															description: """
	BackendRef references a resource where mirrored requests are sent.


	Mirrored requests must be sent only to a single destination endpoint
	within this BackendRef, irrespective of how many endpoints are present
	within this BackendRef.


	If the referent cannot be found, this BackendRef is invalid and must be
	dropped from the Gateway. The controller must ensure the "ResolvedRefs"
	condition on the Route status is set to `status: False` and not configure
	this backend in the underlying implementation.


	If there is a cross-namespace reference to an *existing* object
	that is not allowed by a ReferenceGrant, the controller must ensure the
	"ResolvedRefs"  condition on the Route is set to `status: False`,
	with the "RefNotPermitted" reason and not configure this backend in the
	underlying implementation.


	In either error case, the Message of the `ResolvedRefs` Condition
	should be used to provide more detail about the problem.


	Support: Extended for Kubernetes Service


	Support: Implementation-specific for any other resource
	"""
															properties: {
																group: {
																	default: ""
																	description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																	maxLength: 253
																	pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																	type:      "string"
																}
																kind: {
																	default: "Service"
																	description: """
	Kind is the Kubernetes resource kind of the referent. For example
	"Service".


	Defaults to "Service" when not specified.


	ExternalName services can refer to CNAME DNS records that may live
	outside of the cluster and as such are difficult to reason about in
	terms of conformance. They also may not be safe to forward to (see
	CVE-2021-25740 for more information). Implementations SHOULD NOT
	support ExternalName Services.


	Support: Core (Services with a type other than ExternalName)


	Support: Implementation-specific (Services with type ExternalName)
	"""
																	maxLength: 63
																	minLength: 1
																	pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																	type:      "string"
																}
																name: {
																	description: "Name is the name of the referent."
																	maxLength:   253
																	minLength:   1
																	type:        "string"
																}
																namespace: {
																	description: """
	Namespace is the namespace of the backend. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
																	maxLength: 63
																	minLength: 1
																	pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
																	type:      "string"
																}
																port: {
																	description: """
	Port specifies the destination port number to use for this resource.
	Port is required when the referent is a Kubernetes Service. In this
	case, the port number is the service port number, not the target port.
	For other resources, destination port might be derived from the referent
	resource or this field.
	"""
																	format:  "int32"
																	maximum: 65535
																	minimum: 1
																	type:    "integer"
																}
															}
															required: ["name"]
															type: "object"
															"x-kubernetes-validations": [{
																message: "Must have port for Service reference"
																rule:    "(size(self.group) == 0 && self.kind == 'Service') ? has(self.port) : true"
															}]
														}
														required: ["backendRef"]
														type: "object"
													}
													responseHeaderModifier: {
														description: """
	ResponseHeaderModifier defines a schema for a filter that modifies response
	headers.


	Support: Extended
	"""
														properties: {
															add: {
																description: """
	Add adds the given header(s) (name, value) to the request
	before the action. It appends to any existing values associated
	with the header name.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  add:
	  - name: "my-header"
	    value: "bar,baz"


	Output:
	  GET /foo HTTP/1.1
	  my-header: foo,bar,baz
	"""
																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																	properties: {
																		name: {
																			description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."
																			maxLength:   4096
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
															remove: {
																description: """
	Remove the given header(s) from the HTTP request before the action. The
	value of Remove is a list of HTTP header names. Note that the header
	names are case-insensitive (see
	https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).


	Input:
	  GET /foo HTTP/1.1
	  my-header1: foo
	  my-header2: bar
	  my-header3: baz


	Config:
	  remove: ["my-header1", "my-header3"]


	Output:
	  GET /foo HTTP/1.1
	  my-header2: bar
	"""
																items: type: "string"
																maxItems:                 16
																type:                     "array"
																"x-kubernetes-list-type": "set"
															}
															set: {
																description: """
	Set overwrites the request with the given header (name, value)
	before the action.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  set:
	  - name: "my-header"
	    value: "bar"


	Output:
	  GET /foo HTTP/1.1
	  my-header: bar
	"""
																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																	properties: {
																		name: {
																			description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."
																			maxLength:   4096
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
														}
														type: "object"
													}
													type: {
														description: """
	Type identifies the type of filter to apply. As with other API fields,
	types are classified into three conformance levels:


	- Core: Filter types and their corresponding configuration defined by
	  "Support: Core" in this package, e.g. "RequestHeaderModifier". All
	  implementations supporting GRPCRoute MUST support core filters.


	- Extended: Filter types and their corresponding configuration defined by
	  "Support: Extended" in this package, e.g. "RequestMirror". Implementers
	  are encouraged to support extended filters.


	- Implementation-specific: Filters that are defined and supported by specific vendors.
	  In the future, filters showing convergence in behavior across multiple
	  implementations will be considered for inclusion in extended or core
	  conformance levels. Filter-specific configuration for such filters
	  is specified using the ExtensionRef field. `Type` MUST be set to
	  "ExtensionRef" for custom filters.


	Implementers are encouraged to define custom implementation types to
	extend the core API with implementation-specific behavior.


	If a reference to a custom filter type cannot be resolved, the filter
	MUST NOT be skipped. Instead, requests that would have been processed by
	that filter MUST receive a HTTP error response.



	"""
														enum: [
															"ResponseHeaderModifier",
															"RequestHeaderModifier",
															"RequestMirror",
															"ExtensionRef",
														]
														type: "string"
													}
												}
												required: ["type"]
												type: "object"
												"x-kubernetes-validations": [{
													message: "filter.requestHeaderModifier must be nil if the filter.type is not RequestHeaderModifier"
													rule:    "!(has(self.requestHeaderModifier) && self.type != 'RequestHeaderModifier')"
												}, {
													message: "filter.requestHeaderModifier must be specified for RequestHeaderModifier filter.type"
													rule:    "!(!has(self.requestHeaderModifier) && self.type == 'RequestHeaderModifier')"
												}, {
													message: "filter.responseHeaderModifier must be nil if the filter.type is not ResponseHeaderModifier"
													rule:    "!(has(self.responseHeaderModifier) && self.type != 'ResponseHeaderModifier')"
												}, {
													message: "filter.responseHeaderModifier must be specified for ResponseHeaderModifier filter.type"
													rule:    "!(!has(self.responseHeaderModifier) && self.type == 'ResponseHeaderModifier')"
												}, {
													message: "filter.requestMirror must be nil if the filter.type is not RequestMirror"
													rule:    "!(has(self.requestMirror) && self.type != 'RequestMirror')"
												}, {
													message: "filter.requestMirror must be specified for RequestMirror filter.type"
													rule:    "!(!has(self.requestMirror) && self.type == 'RequestMirror')"
												}, {
													message: "filter.extensionRef must be nil if the filter.type is not ExtensionRef"
													rule:    "!(has(self.extensionRef) && self.type != 'ExtensionRef')"
												}, {
													message: "filter.extensionRef must be specified for ExtensionRef filter.type"
													rule:    "!(!has(self.extensionRef) && self.type == 'ExtensionRef')"
												}]
											}
											maxItems: 16
											type:     "array"
											"x-kubernetes-validations": [{
												message: "RequestHeaderModifier filter cannot be repeated"
												rule:    "self.filter(f, f.type == 'RequestHeaderModifier').size() <= 1"
											}, {
												message: "ResponseHeaderModifier filter cannot be repeated"
												rule:    "self.filter(f, f.type == 'ResponseHeaderModifier').size() <= 1"
											}]
										}
										matches: {
											description: """
	Matches define conditions used for matching the rule against incoming
	gRPC requests. Each match is independent, i.e. this rule will be matched
	if **any** one of the matches is satisfied.


	For example, take the following matches configuration:


	```
	matches:
	- method:
	    service: foo.bar
	  headers:
	    values:
	      version: 2
	- method:
	    service: foo.bar.v2
	```


	For a request to match against this rule, it MUST satisfy
	EITHER of the two conditions:


	- service of foo.bar AND contains the header `version: 2`
	- service of foo.bar.v2


	See the documentation for GRPCRouteMatch on how to specify multiple
	match conditions to be ANDed together.


	If no matches are specified, the implementation MUST match every gRPC request.


	Proxy or Load Balancer routing configuration generated from GRPCRoutes
	MUST prioritize rules based on the following criteria, continuing on
	ties. Merging MUST not be done between GRPCRoutes and HTTPRoutes.
	Precedence MUST be given to the rule with the largest number of:


	* Characters in a matching non-wildcard hostname.
	* Characters in a matching hostname.
	* Characters in a matching service.
	* Characters in a matching method.
	* Header matches.


	If ties still exist across multiple Routes, matching precedence MUST be
	determined in order of the following criteria, continuing on ties:


	* The oldest Route based on creation timestamp.
	* The Route appearing first in alphabetical order by
	  "{namespace}/{name}".


	If ties still exist within the Route that has been given precedence,
	matching precedence MUST be granted to the first matching rule meeting
	the above criteria.
	"""
											items: {
												description: """
	GRPCRouteMatch defines the predicate used to match requests to a given
	action. Multiple match types are ANDed together, i.e. the match will
	evaluate to true only if all conditions are satisfied.


	For example, the match below will match a gRPC request only if its service
	is `foo` AND it contains the `version: v1` header:


	```
	matches:
	  - method:
	    type: Exact
	    service: "foo"
	    headers:
	  - name: "version"
	    value "v1"


	```
	"""
												properties: {
													headers: {
														description: """
	Headers specifies gRPC request header matchers. Multiple match values are
	ANDed together, meaning, a request MUST match all the specified headers
	to select the route.
	"""
														items: {
															description: """
	GRPCHeaderMatch describes how to select a gRPC route by matching gRPC request
	headers.
	"""
															properties: {
																name: {
																	description: """
	Name is the name of the gRPC Header to be matched.


	If multiple entries specify equivalent header names, only the first
	entry with an equivalent name MUST be considered for a match. Subsequent
	entries with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																	maxLength: 256
																	minLength: 1
																	pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																	type:      "string"
																}
																type: {
																	default:     "Exact"
																	description: "Type specifies how to match against the value of the header."
																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of the gRPC Header to be matched."
																	maxLength:   4096
																	minLength:   1
																	type:        "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
													method: {
														description: """
	Method specifies a gRPC request service/method matcher. If this field is
	not specified, all services and methods will match.
	"""
														properties: {
															method: {
																description: """
	Value of the method to match against. If left empty or omitted, will
	match all services.


	At least one of Service and Method MUST be a non-empty string.
	"""
																maxLength: 1024
																type:      "string"
															}
															service: {
																description: """
	Value of the service to match against. If left empty or omitted, will
	match any service.


	At least one of Service and Method MUST be a non-empty string.
	"""
																maxLength: 1024
																type:      "string"
															}
															type: {
																default: "Exact"
																description: """
	Type specifies how to match against the service and/or method.
	Support: Core (Exact with service and method specified)


	Support: Implementation-specific (Exact with method specified but no service specified)


	Support: Implementation-specific (RegularExpression)
	"""
																enum: [
																	"Exact",
																	"RegularExpression",
																]
																type: "string"
															}
														}
														type: "object"
														"x-kubernetes-validations": [{
															message: "One or both of 'service' or 'method' must be specified"
															rule:    "has(self.type) ? has(self.service) || has(self.method) : true"
														}, {
															message: "service must only contain valid characters (matching ^(?i)\\.?[a-z_][a-z_0-9]*(\\.[a-z_][a-z_0-9]*)*$)"
															rule:    "(!has(self.type) || self.type == 'Exact') && has(self.service) ? self.service.matches(r\"\"\"^(?i)\\.?[a-z_][a-z_0-9]*(\\.[a-z_][a-z_0-9]*)*$\"\"\"): true"
														}, {
															message: "method must only contain valid characters (matching ^[A-Za-z_][A-Za-z_0-9]*$)"
															rule:    "(!has(self.type) || self.type == 'Exact') && has(self.method) ? self.method.matches(r\"\"\"^[A-Za-z_][A-Za-z_0-9]*$\"\"\"): true"
														}]
													}
												}
												type: "object"
											}
											maxItems: 8
											type:     "array"
										}
										sessionPersistence: {
											description: """
	SessionPersistence defines and configures session persistence
	for the route rule.


	Support: Extended



	"""
											properties: {
												absoluteTimeout: {
													description: """
	AbsoluteTimeout defines the absolute timeout of the persistent
	session. Once the AbsoluteTimeout duration has elapsed, the
	session becomes invalid.


	Support: Extended
	"""
													pattern: "^([0-9]{1,5}(h|m|s|ms)){1,4}$"
													type:    "string"
												}
												cookieConfig: {
													description: """
	CookieConfig provides configuration settings that are specific
	to cookie-based session persistence.


	Support: Core
	"""
													properties: lifetimeType: {
														default: "Session"
														description: """
	LifetimeType specifies whether the cookie has a permanent or
	session-based lifetime. A permanent cookie persists until its
	specified expiry time, defined by the Expires or Max-Age cookie
	attributes, while a session cookie is deleted when the current
	session ends.


	When set to "Permanent", AbsoluteTimeout indicates the
	cookie's lifetime via the Expires or Max-Age cookie attributes
	and is required.


	When set to "Session", AbsoluteTimeout indicates the
	absolute lifetime of the cookie tracked by the gateway and
	is optional.


	Support: Core for "Session" type


	Support: Extended for "Permanent" type
	"""
														enum: [
															"Permanent",
															"Session",
														]
														type: "string"
													}
													type: "object"
												}
												idleTimeout: {
													description: """
	IdleTimeout defines the idle timeout of the persistent session.
	Once the session has been idle for more than the specified
	IdleTimeout duration, the session becomes invalid.


	Support: Extended
	"""
													pattern: "^([0-9]{1,5}(h|m|s|ms)){1,4}$"
													type:    "string"
												}
												sessionName: {
													description: """
	SessionName defines the name of the persistent session token
	which may be reflected in the cookie or the header. Users
	should avoid reusing session names to prevent unintended
	consequences, such as rejection or unpredictable behavior.


	Support: Implementation-specific
	"""
													maxLength: 128
													type:      "string"
												}
												type: {
													default: "Cookie"
													description: """
	Type defines the type of session persistence such as through
	the use a header or cookie. Defaults to cookie based session
	persistence.


	Support: Core for "Cookie" type


	Support: Extended for "Header" type
	"""
													enum: [
														"Cookie",
														"Header",
													]
													type: "string"
												}
											}
											type: "object"
											"x-kubernetes-validations": [{
												message: "AbsoluteTimeout must be specified when cookie lifetimeType is Permanent"
												rule:    "!has(self.cookieConfig.lifetimeType) || self.cookieConfig.lifetimeType != 'Permanent' || has(self.absoluteTimeout)"
											}]
										}
									}
									type: "object"
								}
								maxItems: 16
								type:     "array"
							}
						}
						type: "object"
					}
					status: {
						description: "Status defines the current state of GRPCRoute."
						properties: parents: {
							description: """
	Parents is a list of parent resources (usually Gateways) that are
	associated with the route, and the status of the route with respect to
	each parent. When this route attaches to a parent, the controller that
	manages the parent must add an entry to this list when the controller
	first sees the route and should update the entry as appropriate when the
	route or gateway is modified.


	Note that parent references that cannot be resolved by an implementation
	of this API will not be added to this list. Implementations of this API
	can only populate Route status for the Gateways/parent resources they are
	responsible for.


	A maximum of 32 Gateways will be represented in this list. An empty list
	means the route has not been attached to any Gateway.
	"""
							items: {
								description: """
	RouteParentStatus describes the status of a route with respect to an
	associated Parent.
	"""
								properties: {
									conditions: {
										description: """
	Conditions describes the status of the route with respect to the Gateway.
	Note that the route's availability is also subject to the Gateway's own
	status conditions and listener status.


	If the Route's ParentRef specifies an existing Gateway that supports
	Routes of this kind AND that Gateway's controller has sufficient access,
	then that Gateway's controller MUST set the "Accepted" condition on the
	Route, to indicate whether the route has been accepted or rejected by the
	Gateway, and why.


	A Route MUST be considered "Accepted" if at least one of the Route's
	rules is implemented by the Gateway.


	There are a number of cases where the "Accepted" condition may not be set
	due to lack of controller visibility, that includes when:


	* The Route refers to a non-existent parent.
	* The Route is of a type that the controller does not support.
	* The Route is in a namespace the controller does not have access to.
	"""
										items: {
											description: """
	Condition contains details for one aspect of the current state of this API Resource.
	---
	This struct is intended for direct use as an array at the field path .status.conditions.  For example,


	\ttype FooStatus struct{
	\t    // Represents the observations of a foo's current state.
	\t    // Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
	\t    // +patchMergeKey=type
	\t    // +patchStrategy=merge
	\t    // +listType=map
	\t    // +listMapKey=type
	\t    Conditions []metav1.Condition `json:"conditions,omitempty" patchStrategy:"merge" patchMergeKey:"type" protobuf:"bytes,1,rep,name=conditions"`


	\t    // other fields
	\t}
	"""
											properties: {
												lastTransitionTime: {
													description: """
	lastTransitionTime is the last time the condition transitioned from one status to another.
	This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
	"""
													format: "date-time"
													type:   "string"
												}
												message: {
													description: """
	message is a human readable message indicating details about the transition.
	This may be an empty string.
	"""
													maxLength: 32768
													type:      "string"
												}
												observedGeneration: {
													description: """
	observedGeneration represents the .metadata.generation that the condition was set based upon.
	For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
	with respect to the current state of the instance.
	"""
													format:  "int64"
													minimum: 0
													type:    "integer"
												}
												reason: {
													description: """
	reason contains a programmatic identifier indicating the reason for the condition's last transition.
	Producers of specific condition types may define expected values and meanings for this field,
	and whether the values are considered a guaranteed API.
	The value should be a CamelCase string.
	This field may not be empty.
	"""
													maxLength: 1024
													minLength: 1
													pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
													type:      "string"
												}
												status: {
													description: "status of the condition, one of True, False, Unknown."
													enum: [
														"True",
														"False",
														"Unknown",
													]
													type: "string"
												}
												type: {
													description: """
	type of condition in CamelCase or in foo.example.com/CamelCase.
	---
	Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be
	useful (see .node.status.conditions), the ability to deconflict is important.
	The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)
	"""
													maxLength: 316
													pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
													type:      "string"
												}
											}
											required: [
												"lastTransitionTime",
												"message",
												"reason",
												"status",
												"type",
											]
											type: "object"
										}
										maxItems: 8
										minItems: 1
										type:     "array"
										"x-kubernetes-list-map-keys": ["type"]
										"x-kubernetes-list-type": "map"
									}
									controllerName: {
										description: """
	ControllerName is a domain/path string that indicates the name of the
	controller that wrote this status. This corresponds with the
	controllerName field on GatewayClass.


	Example: "example.net/gateway-controller".


	The format of this field is DOMAIN "/" PATH, where DOMAIN and PATH are
	valid Kubernetes names
	(https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).


	Controllers MUST populate this field when writing status. Controllers should ensure that
	entries to status populated with their ControllerName are cleaned up when they are no
	longer necessary.
	"""
										maxLength: 253
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
										type:      "string"
									}
									parentRef: {
										description: """
	ParentRef corresponds with a ParentRef in the spec that this
	RouteParentStatus struct describes the status of.
	"""
										properties: {
											group: {
												default: "gateway.networking.k8s.io"
												description: """
	Group is the group of the referent.
	When unspecified, "gateway.networking.k8s.io" is inferred.
	To set the core API group (such as for a "Service" kind referent),
	Group must be explicitly set to "" (empty string).


	Support: Core
	"""
												maxLength: 253
												pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
											kind: {
												default: "Gateway"
												description: """
	Kind is kind of the referent.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	Support for other resources is Implementation-Specific.
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:      "string"
											}
											name: {
												description: """
	Name is the name of the referent.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												type:      "string"
											}
											namespace: {
												description: """
	Namespace is the namespace of the referent. When unspecified, this refers
	to the local namespace of the Route.


	Note that there are specific rules for ParentRefs which cross namespace
	boundaries. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example:
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable any other kind of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.



	Support: Core
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
												type:      "string"
											}
											port: {
												description: """
	Port is the network port this Route targets. It can be interpreted
	differently based on the type of parent resource.


	When the parent resource is a Gateway, this targets all listeners
	listening on the specified port that also support this kind of Route(and
	select this Route). It's not recommended to set `Port` unless the
	networking behaviors specified in a Route must apply to a specific port
	as opposed to a listener(s) whose port(s) may be changed. When both Port
	and SectionName are specified, the name and port of the selected listener
	must match both specified values.



	When the parent resource is a Service, this targets a specific port in the
	Service spec. When both Port (experimental) and SectionName are specified,
	the name and port of the selected port must match both specified values.



	Implementations MAY choose to support other parent resources.
	Implementations supporting other types of parent resources MUST clearly
	document how/if Port is interpreted.


	For the purpose of status, an attachment is considered successful as
	long as the parent resource accepts it partially. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
	from the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route,
	the Route MUST be considered detached from the Gateway.


	Support: Extended
	"""
												format:  "int32"
												maximum: 65535
												minimum: 1
												type:    "integer"
											}
											sectionName: {
												description: """
	SectionName is the name of a section within the target resource. In the
	following resources, SectionName is interpreted as the following:


	* Gateway: Listener name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.
	* Service: Port name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.


	Implementations MAY choose to support attaching Routes to other resources.
	If that is the case, they MUST clearly document how SectionName is
	interpreted.


	When unspecified (empty string), this will reference the entire resource.
	For the purpose of status, an attachment is considered successful if at
	least one section in the parent resource accepts it. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
	the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route, the
	Route MUST be considered detached from the Gateway.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
										}
										required: ["name"]
										type: "object"
									}
								}
								required: [
									"controllerName",
									"parentRef",
								]
								type: "object"
							}
							maxItems: 32
							type:     "array"
						}
						required: ["parents"]
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}, {
			deprecated:         true
			deprecationWarning: "The v1alpha2 version of GRPCRoute has been deprecated and will be removed in a future release of the API. Please upgrade to v1."
			name:               "v1alpha2"
			schema: openAPIV3Schema: {
				description: """
					GRPCRoute provides a way to route gRPC requests. This includes the capability
					to match requests by hostname, gRPC service, gRPC method, or HTTP/2 header.
					Filters can be used to specify additional processing steps. Backends specify
					where matching requests will be routed.


					GRPCRoute falls under extended support within the Gateway API. Within the
					following specification, the word "MUST" indicates that an implementation
					supporting GRPCRoute must conform to the indicated requirement, but an
					implementation not supporting this route type need not follow the requirement
					unless explicitly indicated.


					Implementations supporting `GRPCRoute` with the `HTTPS` `ProtocolType` MUST
					accept HTTP/2 connections without an initial upgrade from HTTP/1.1, i.e. via
					ALPN. If the implementation does not support this, then it MUST set the
					"Accepted" condition to "False" for the affected listener with a reason of
					"UnsupportedProtocol".  Implementations MAY also accept HTTP/2 connections
					with an upgrade from HTTP/1.


					Implementations supporting `GRPCRoute` with the `HTTP` `ProtocolType` MUST
					support HTTP/2 over cleartext TCP (h2c,
					https://www.rfc-editor.org/rfc/rfc7540#section-3.1) without an initial
					upgrade from HTTP/1.1, i.e. with prior knowledge
					(https://www.rfc-editor.org/rfc/rfc7540#section-3.4). If the implementation
					does not support this, then it MUST set the "Accepted" condition to "False"
					for the affected listener with a reason of "UnsupportedProtocol".
					Implementations MAY also accept HTTP/2 connections with an upgrade from
					HTTP/1, i.e. without prior knowledge.
					"""
				properties: {
					apiVersion: {
						description: """
	APIVersion defines the versioned schema of this representation of an object.
	Servers should convert recognized schemas to the latest internal value, and
	may reject unrecognized values.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	"""
						type: "string"
					}
					kind: {
						description: """
	Kind is a string value representing the REST resource this object represents.
	Servers may infer this from the endpoint the client submits requests to.
	Cannot be updated.
	In CamelCase.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	"""
						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec defines the desired state of GRPCRoute."
						properties: {
							hostnames: {
								description: """
	Hostnames defines a set of hostnames to match against the GRPC
	Host header to select a GRPCRoute to process the request. This matches
	the RFC 1123 definition of a hostname with 2 notable exceptions:


	1. IPs are not allowed.
	2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard
	   label MUST appear by itself as the first label.


	If a hostname is specified by both the Listener and GRPCRoute, there
	MUST be at least one intersecting hostname for the GRPCRoute to be
	attached to the Listener. For example:


	* A Listener with `test.example.com` as the hostname matches GRPCRoutes
	  that have either not specified any hostnames, or have specified at
	  least one of `test.example.com` or `*.example.com`.
	* A Listener with `*.example.com` as the hostname matches GRPCRoutes
	  that have either not specified any hostnames or have specified at least
	  one hostname that matches the Listener hostname. For example,
	  `test.example.com` and `*.example.com` would both match. On the other
	  hand, `example.com` and `test.example.net` would not match.


	Hostnames that are prefixed with a wildcard label (`*.`) are interpreted
	as a suffix match. That means that a match for `*.example.com` would match
	both `test.example.com`, and `foo.test.example.com`, but not `example.com`.


	If both the Listener and GRPCRoute have specified hostnames, any
	GRPCRoute hostnames that do not match the Listener hostname MUST be
	ignored. For example, if a Listener specified `*.example.com`, and the
	GRPCRoute specified `test.example.com` and `test.example.net`,
	`test.example.net` MUST NOT be considered for a match.


	If both the Listener and GRPCRoute have specified hostnames, and none
	match with the criteria above, then the GRPCRoute MUST NOT be accepted by
	the implementation. The implementation MUST raise an 'Accepted' Condition
	with a status of `False` in the corresponding RouteParentStatus.


	If a Route (A) of type HTTPRoute or GRPCRoute is attached to a
	Listener and that listener already has another Route (B) of the other
	type attached and the intersection of the hostnames of A and B is
	non-empty, then the implementation MUST accept exactly one of these two
	routes, determined by the following criteria, in order:


	* The oldest Route based on creation timestamp.
	* The Route appearing first in alphabetical order by
	  "{namespace}/{name}".


	The rejected Route MUST raise an 'Accepted' condition with a status of
	'False' in the corresponding RouteParentStatus.


	Support: Core
	"""
								items: {
									description: """
	Hostname is the fully qualified domain name of a network host. This matches
	the RFC 1123 definition of a hostname with 2 notable exceptions:


	 1. IPs are not allowed.
	 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard
	    label must appear by itself as the first label.


	Hostname can be "precise" which is a domain name without the terminating
	dot of a network host (e.g. "foo.example.com") or "wildcard", which is a
	domain name prefixed with a single wildcard label (e.g. `*.example.com`).


	Note that as per RFC1035 and RFC1123, a *label* must consist of lower case
	alphanumeric characters or '-', and must start and end with an alphanumeric
	character. No other punctuation is allowed.
	"""
									maxLength: 253
									minLength: 1
									pattern:   "^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
									type:      "string"
								}
								maxItems: 16
								type:     "array"
							}
							parentRefs: {
								description: """
	ParentRefs references the resources (usually Gateways) that a Route wants
	to be attached to. Note that the referenced parent resource needs to
	allow this for the attachment to be complete. For Gateways, that means
	the Gateway needs to allow attachment from Routes of this kind and
	namespace. For Services, that means the Service must either be in the same
	namespace for a "producer" route, or the mesh implementation must support
	and allow "consumer" routes for the referenced Service. ReferenceGrant is
	not applicable for governing ParentRefs to Services - it is not possible to
	create a "producer" route for a Service in a different namespace from the
	Route.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	This API may be extended in the future to support additional kinds of parent
	resources.


	ParentRefs must be _distinct_. This means either that:


	* They select different objects.  If this is the case, then parentRef
	  entries are distinct. In terms of fields, this means that the
	  multi-part key defined by `group`, `kind`, `namespace`, and `name` must
	  be unique across all parentRef entries in the Route.
	* They do not select different objects, but for each optional field used,
	  each ParentRef that selects the same object must set the same set of
	  optional fields to different values. If one ParentRef sets a
	  combination of optional fields, all must set the same combination.


	Some examples:


	* If one ParentRef sets `sectionName`, all ParentRefs referencing the
	  same object must also set `sectionName`.
	* If one ParentRef sets `port`, all ParentRefs referencing the same
	  object must also set `port`.
	* If one ParentRef sets `sectionName` and `port`, all ParentRefs
	  referencing the same object must also set `sectionName` and `port`.


	It is possible to separately reference multiple distinct objects that may
	be collapsed by an implementation. For example, some implementations may
	choose to merge compatible Gateway Listeners together. If that is the
	case, the list of routes attached to those resources should also be
	merged.


	Note that for ParentRefs that cross namespace boundaries, there are specific
	rules. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example,
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable other kinds of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.







	"""
								items: {
									description: """
	ParentReference identifies an API object (usually a Gateway) that can be considered
	a parent of this resource (usually a route). There are two kinds of parent resources
	with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	This API may be extended in the future to support additional kinds of parent
	resources.


	The API object must be valid in the cluster; the Group and Kind must
	be registered in the cluster for this reference to be valid.
	"""
									properties: {
										group: {
											default: "gateway.networking.k8s.io"
											description: """
	Group is the group of the referent.
	When unspecified, "gateway.networking.k8s.io" is inferred.
	To set the core API group (such as for a "Service" kind referent),
	Group must be explicitly set to "" (empty string).


	Support: Core
	"""
											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											default: "Gateway"
											description: """
	Kind is kind of the referent.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	Support for other resources is Implementation-Specific.
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										name: {
											description: """
	Name is the name of the referent.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: """
	Namespace is the namespace of the referent. When unspecified, this refers
	to the local namespace of the Route.


	Note that there are specific rules for ParentRefs which cross namespace
	boundaries. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example:
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable any other kind of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.



	Support: Core
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
											type:      "string"
										}
										port: {
											description: """
	Port is the network port this Route targets. It can be interpreted
	differently based on the type of parent resource.


	When the parent resource is a Gateway, this targets all listeners
	listening on the specified port that also support this kind of Route(and
	select this Route). It's not recommended to set `Port` unless the
	networking behaviors specified in a Route must apply to a specific port
	as opposed to a listener(s) whose port(s) may be changed. When both Port
	and SectionName are specified, the name and port of the selected listener
	must match both specified values.



	When the parent resource is a Service, this targets a specific port in the
	Service spec. When both Port (experimental) and SectionName are specified,
	the name and port of the selected port must match both specified values.



	Implementations MAY choose to support other parent resources.
	Implementations supporting other types of parent resources MUST clearly
	document how/if Port is interpreted.


	For the purpose of status, an attachment is considered successful as
	long as the parent resource accepts it partially. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
	from the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route,
	the Route MUST be considered detached from the Gateway.


	Support: Extended
	"""
											format:  "int32"
											maximum: 65535
											minimum: 1
											type:    "integer"
										}
										sectionName: {
											description: """
	SectionName is the name of a section within the target resource. In the
	following resources, SectionName is interpreted as the following:


	* Gateway: Listener name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.
	* Service: Port name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.


	Implementations MAY choose to support attaching Routes to other resources.
	If that is the case, they MUST clearly document how SectionName is
	interpreted.


	When unspecified (empty string), this will reference the entire resource.
	For the purpose of status, an attachment is considered successful if at
	least one section in the parent resource accepts it. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
	the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route, the
	Route MUST be considered detached from the Gateway.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								maxItems: 32
								type:     "array"
								"x-kubernetes-validations": [{
									message: "sectionName or port must be specified when parentRefs includes 2 or more references to the same parent"
									rule:    "self.all(p1, self.all(p2, p1.group == p2.group && p1.kind == p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) || p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ == '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__ == p2.__namespace__)) ? ((!has(p1.sectionName) || p1.sectionName == '') == (!has(p2.sectionName) || p2.sectionName == '') && (!has(p1.port) || p1.port == 0) == (!has(p2.port) || p2.port == 0)): true))"
								}, {
									message: "sectionName or port must be unique when parentRefs includes 2 or more references to the same parent"
									rule:    "self.all(p1, self.exists_one(p2, p1.group == p2.group && p1.kind == p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) || p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ == '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__ == p2.__namespace__ )) && (((!has(p1.sectionName) || p1.sectionName == '') && (!has(p2.sectionName) || p2.sectionName == '')) || ( has(p1.sectionName) && has(p2.sectionName) && p1.sectionName == p2.sectionName)) && (((!has(p1.port) || p1.port == 0) && (!has(p2.port) || p2.port == 0)) || (has(p1.port) && has(p2.port) && p1.port == p2.port))))"
								}]
							}
							rules: {
								description: "Rules are a list of GRPC matchers, filters and actions."
								items: {
									description: """
	GRPCRouteRule defines the semantics for matching a gRPC request based on
	conditions (matches), processing it (filters), and forwarding the request to
	an API object (backendRefs).
	"""
									properties: {
										backendRefs: {
											description: """
	BackendRefs defines the backend(s) where matching requests should be
	sent.


	Failure behavior here depends on how many BackendRefs are specified and
	how many are invalid.


	If *all* entries in BackendRefs are invalid, and there are also no filters
	specified in this route rule, *all* traffic which matches this rule MUST
	receive an `UNAVAILABLE` status.


	See the GRPCBackendRef definition for the rules about what makes a single
	GRPCBackendRef invalid.


	When a GRPCBackendRef is invalid, `UNAVAILABLE` statuses MUST be returned for
	requests that would have otherwise been routed to an invalid backend. If
	multiple backends are specified, and some are invalid, the proportion of
	requests that would otherwise have been routed to an invalid backend
	MUST receive an `UNAVAILABLE` status.


	For example, if two backends are specified with equal weights, and one is
	invalid, 50 percent of traffic MUST receive an `UNAVAILABLE` status.
	Implementations may choose how that 50 percent is determined.


	Support: Core for Kubernetes Service


	Support: Implementation-specific for any other resource


	Support for weight: Core
	"""
											items: {
												description: """
	GRPCBackendRef defines how a GRPCRoute forwards a gRPC request.


	Note that when a namespace different than the local namespace is specified, a
	ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	<gateway:experimental:description>


	When the BackendRef points to a Kubernetes Service, implementations SHOULD
	honor the appProtocol field if it is set for the target Service Port.


	Implementations supporting appProtocol SHOULD recognize the Kubernetes
	Standard Application Protocols defined in KEP-3726.


	If a Service appProtocol isn't specified, an implementation MAY infer the
	backend protocol through its own means. Implementations MAY infer the
	protocol from the Route type referring to the backend Service.


	If a Route is not able to send traffic to the backend using the specified
	protocol then the backend is considered invalid. Implementations MUST set the
	"ResolvedRefs" condition to "False" with the "UnsupportedProtocol" reason.


	</gateway:experimental:description>
	"""
												properties: {
													filters: {
														description: """
	Filters defined at this level MUST be executed if and only if the
	request is being forwarded to the backend defined here.


	Support: Implementation-specific (For broader support of filters, use the
	Filters field in GRPCRouteRule.)
	"""
														items: {
															description: """
	GRPCRouteFilter defines processing steps that must be completed during the
	request or response lifecycle. GRPCRouteFilters are meant as an extension
	point to express processing that may be done in Gateway implementations. Some
	examples include request or response modification, implementing
	authentication strategies, rate-limiting, and traffic shaping. API
	guarantee/conformance is defined based on the type of the filter.
	"""
															properties: {
																extensionRef: {
																	description: """
	ExtensionRef is an optional, implementation-specific extension to the
	"filter" behavior.  For example, resource "myroutefilter" in group
	"networking.example.net"). ExtensionRef MUST NOT be used for core and
	extended filters.


	Support: Implementation-specific


	This filter can be used multiple times within the same rule.
	"""
																	properties: {
																		group: {
																			description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																			maxLength: 253
																			pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		kind: {
																			description: "Kind is kind of the referent. For example \"HTTPRoute\" or \"Service\"."
																			maxLength:   63
																			minLength:   1
																			pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																			type:        "string"
																		}
																		name: {
																			description: "Name is the name of the referent."
																			maxLength:   253
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"group",
																		"kind",
																		"name",
																	]
																	type: "object"
																}
																requestHeaderModifier: {
																	description: """
	RequestHeaderModifier defines a schema for a filter that modifies request
	headers.


	Support: Core
	"""
																	properties: {
																		add: {
																			description: """
	Add adds the given header(s) (name, value) to the request
	before the action. It appends to any existing values associated
	with the header name.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  add:
	  - name: "my-header"
	    value: "bar,baz"


	Output:
	  GET /foo HTTP/1.1
	  my-header: foo,bar,baz
	"""
																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																				properties: {
																					name: {
																						description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."
																						maxLength:   4096
																						minLength:   1
																						type:        "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
	Remove the given header(s) from the HTTP request before the action. The
	value of Remove is a list of HTTP header names. Note that the header
	names are case-insensitive (see
	https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).


	Input:
	  GET /foo HTTP/1.1
	  my-header1: foo
	  my-header2: bar
	  my-header3: baz


	Config:
	  remove: ["my-header1", "my-header3"]


	Output:
	  GET /foo HTTP/1.1
	  my-header2: bar
	"""
																			items: type: "string"
																			maxItems:                 16
																			type:                     "array"
																			"x-kubernetes-list-type": "set"
																		}
																		set: {
																			description: """
	Set overwrites the request with the given header (name, value)
	before the action.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  set:
	  - name: "my-header"
	    value: "bar"


	Output:
	  GET /foo HTTP/1.1
	  my-header: bar
	"""
																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																				properties: {
																					name: {
																						description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."
																						maxLength:   4096
																						minLength:   1
																						type:        "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																requestMirror: {
																	description: """
	RequestMirror defines a schema for a filter that mirrors requests.
	Requests are sent to the specified destination, but responses from
	that destination are ignored.


	This filter can be used multiple times within the same rule. Note that
	not all implementations will be able to support mirroring to multiple
	backends.


	Support: Extended
	"""
																	properties: backendRef: {
																		description: """
	BackendRef references a resource where mirrored requests are sent.


	Mirrored requests must be sent only to a single destination endpoint
	within this BackendRef, irrespective of how many endpoints are present
	within this BackendRef.


	If the referent cannot be found, this BackendRef is invalid and must be
	dropped from the Gateway. The controller must ensure the "ResolvedRefs"
	condition on the Route status is set to `status: False` and not configure
	this backend in the underlying implementation.


	If there is a cross-namespace reference to an *existing* object
	that is not allowed by a ReferenceGrant, the controller must ensure the
	"ResolvedRefs"  condition on the Route is set to `status: False`,
	with the "RefNotPermitted" reason and not configure this backend in the
	underlying implementation.


	In either error case, the Message of the `ResolvedRefs` Condition
	should be used to provide more detail about the problem.


	Support: Extended for Kubernetes Service


	Support: Implementation-specific for any other resource
	"""
																		properties: {
																			group: {
																				default: ""
																				description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																				maxLength: 253
																				pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																				type:      "string"
																			}
																			kind: {
																				default: "Service"
																				description: """
	Kind is the Kubernetes resource kind of the referent. For example
	"Service".


	Defaults to "Service" when not specified.


	ExternalName services can refer to CNAME DNS records that may live
	outside of the cluster and as such are difficult to reason about in
	terms of conformance. They also may not be safe to forward to (see
	CVE-2021-25740 for more information). Implementations SHOULD NOT
	support ExternalName Services.


	Support: Core (Services with a type other than ExternalName)


	Support: Implementation-specific (Services with type ExternalName)
	"""
																				maxLength: 63
																				minLength: 1
																				pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																				type:      "string"
																			}
																			name: {
																				description: "Name is the name of the referent."
																				maxLength:   253
																				minLength:   1
																				type:        "string"
																			}
																			namespace: {
																				description: """
	Namespace is the namespace of the backend. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
																				maxLength: 63
																				minLength: 1
																				pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
																				type:      "string"
																			}
																			port: {
																				description: """
	Port specifies the destination port number to use for this resource.
	Port is required when the referent is a Kubernetes Service. In this
	case, the port number is the service port number, not the target port.
	For other resources, destination port might be derived from the referent
	resource or this field.
	"""
																				format:  "int32"
																				maximum: 65535
																				minimum: 1
																				type:    "integer"
																			}
																		}
																		required: ["name"]
																		type: "object"
																		"x-kubernetes-validations": [{
																			message: "Must have port for Service reference"
																			rule:    "(size(self.group) == 0 && self.kind == 'Service') ? has(self.port) : true"
																		}]
																	}
																	required: ["backendRef"]
																	type: "object"
																}
																responseHeaderModifier: {
																	description: """
	ResponseHeaderModifier defines a schema for a filter that modifies response
	headers.


	Support: Extended
	"""
																	properties: {
																		add: {
																			description: """
	Add adds the given header(s) (name, value) to the request
	before the action. It appends to any existing values associated
	with the header name.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  add:
	  - name: "my-header"
	    value: "bar,baz"


	Output:
	  GET /foo HTTP/1.1
	  my-header: foo,bar,baz
	"""
																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																				properties: {
																					name: {
																						description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."
																						maxLength:   4096
																						minLength:   1
																						type:        "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
	Remove the given header(s) from the HTTP request before the action. The
	value of Remove is a list of HTTP header names. Note that the header
	names are case-insensitive (see
	https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).


	Input:
	  GET /foo HTTP/1.1
	  my-header1: foo
	  my-header2: bar
	  my-header3: baz


	Config:
	  remove: ["my-header1", "my-header3"]


	Output:
	  GET /foo HTTP/1.1
	  my-header2: bar
	"""
																			items: type: "string"
																			maxItems:                 16
																			type:                     "array"
																			"x-kubernetes-list-type": "set"
																		}
																		set: {
																			description: """
	Set overwrites the request with the given header (name, value)
	before the action.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  set:
	  - name: "my-header"
	    value: "bar"


	Output:
	  GET /foo HTTP/1.1
	  my-header: bar
	"""
																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																				properties: {
																					name: {
																						description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."
																						maxLength:   4096
																						minLength:   1
																						type:        "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																type: {
																	description: """
	Type identifies the type of filter to apply. As with other API fields,
	types are classified into three conformance levels:


	- Core: Filter types and their corresponding configuration defined by
	  "Support: Core" in this package, e.g. "RequestHeaderModifier". All
	  implementations supporting GRPCRoute MUST support core filters.


	- Extended: Filter types and their corresponding configuration defined by
	  "Support: Extended" in this package, e.g. "RequestMirror". Implementers
	  are encouraged to support extended filters.


	- Implementation-specific: Filters that are defined and supported by specific vendors.
	  In the future, filters showing convergence in behavior across multiple
	  implementations will be considered for inclusion in extended or core
	  conformance levels. Filter-specific configuration for such filters
	  is specified using the ExtensionRef field. `Type` MUST be set to
	  "ExtensionRef" for custom filters.


	Implementers are encouraged to define custom implementation types to
	extend the core API with implementation-specific behavior.


	If a reference to a custom filter type cannot be resolved, the filter
	MUST NOT be skipped. Instead, requests that would have been processed by
	that filter MUST receive a HTTP error response.



	"""
																	enum: [
																		"ResponseHeaderModifier",
																		"RequestHeaderModifier",
																		"RequestMirror",
																		"ExtensionRef",
																	]
																	type: "string"
																}
															}
															required: ["type"]
															type: "object"
															"x-kubernetes-validations": [{
																message: "filter.requestHeaderModifier must be nil if the filter.type is not RequestHeaderModifier"
																rule:    "!(has(self.requestHeaderModifier) && self.type != 'RequestHeaderModifier')"
															}, {
																message: "filter.requestHeaderModifier must be specified for RequestHeaderModifier filter.type"
																rule:    "!(!has(self.requestHeaderModifier) && self.type == 'RequestHeaderModifier')"
															}, {
																message: "filter.responseHeaderModifier must be nil if the filter.type is not ResponseHeaderModifier"
																rule:    "!(has(self.responseHeaderModifier) && self.type != 'ResponseHeaderModifier')"
															}, {
																message: "filter.responseHeaderModifier must be specified for ResponseHeaderModifier filter.type"
																rule:    "!(!has(self.responseHeaderModifier) && self.type == 'ResponseHeaderModifier')"
															}, {
																message: "filter.requestMirror must be nil if the filter.type is not RequestMirror"
																rule:    "!(has(self.requestMirror) && self.type != 'RequestMirror')"
															}, {
																message: "filter.requestMirror must be specified for RequestMirror filter.type"
																rule:    "!(!has(self.requestMirror) && self.type == 'RequestMirror')"
															}, {
																message: "filter.extensionRef must be nil if the filter.type is not ExtensionRef"
																rule:    "!(has(self.extensionRef) && self.type != 'ExtensionRef')"
															}, {
																message: "filter.extensionRef must be specified for ExtensionRef filter.type"
																rule:    "!(!has(self.extensionRef) && self.type == 'ExtensionRef')"
															}]
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-validations": [{
															message: "RequestHeaderModifier filter cannot be repeated"
															rule:    "self.filter(f, f.type == 'RequestHeaderModifier').size() <= 1"
														}, {
															message: "ResponseHeaderModifier filter cannot be repeated"
															rule:    "self.filter(f, f.type == 'ResponseHeaderModifier').size() <= 1"
														}]
													}
													group: {
														default: ""
														description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
														maxLength: 253
														pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
														type:      "string"
													}
													kind: {
														default: "Service"
														description: """
	Kind is the Kubernetes resource kind of the referent. For example
	"Service".


	Defaults to "Service" when not specified.


	ExternalName services can refer to CNAME DNS records that may live
	outside of the cluster and as such are difficult to reason about in
	terms of conformance. They also may not be safe to forward to (see
	CVE-2021-25740 for more information). Implementations SHOULD NOT
	support ExternalName Services.


	Support: Core (Services with a type other than ExternalName)


	Support: Implementation-specific (Services with type ExternalName)
	"""
														maxLength: 63
														minLength: 1
														pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
														type:      "string"
													}
													name: {
														description: "Name is the name of the referent."
														maxLength:   253
														minLength:   1
														type:        "string"
													}
													namespace: {
														description: """
	Namespace is the namespace of the backend. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
														maxLength: 63
														minLength: 1
														pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
														type:      "string"
													}
													port: {
														description: """
	Port specifies the destination port number to use for this resource.
	Port is required when the referent is a Kubernetes Service. In this
	case, the port number is the service port number, not the target port.
	For other resources, destination port might be derived from the referent
	resource or this field.
	"""
														format:  "int32"
														maximum: 65535
														minimum: 1
														type:    "integer"
													}
													weight: {
														default: 1
														description: """
	Weight specifies the proportion of requests forwarded to the referenced
	backend. This is computed as weight/(sum of all weights in this
	BackendRefs list). For non-zero values, there may be some epsilon from
	the exact proportion defined here depending on the precision an
	implementation supports. Weight is not a percentage and the sum of
	weights does not need to equal 100.


	If only one backend is specified and it has a weight greater than 0, 100%
	of the traffic is forwarded to that backend. If weight is set to 0, no
	traffic should be forwarded for this entry. If unspecified, weight
	defaults to 1.


	Support for this field varies based on the context where used.
	"""
														format:  "int32"
														maximum: 1000000
														minimum: 0
														type:    "integer"
													}
												}
												required: ["name"]
												type: "object"
												"x-kubernetes-validations": [{
													message: "Must have port for Service reference"
													rule:    "(size(self.group) == 0 && self.kind == 'Service') ? has(self.port) : true"
												}]
											}
											maxItems: 16
											type:     "array"
										}
										filters: {
											description: """
	Filters define the filters that are applied to requests that match
	this rule.


	The effects of ordering of multiple behaviors are currently unspecified.
	This can change in the future based on feedback during the alpha stage.


	Conformance-levels at this level are defined based on the type of filter:


	- ALL core filters MUST be supported by all implementations that support
	  GRPCRoute.
	- Implementers are encouraged to support extended filters.
	- Implementation-specific custom filters have no API guarantees across
	  implementations.


	Specifying the same filter multiple times is not supported unless explicitly
	indicated in the filter.


	If an implementation can not support a combination of filters, it must clearly
	document that limitation. In cases where incompatible or unsupported
	filters are specified and cause the `Accepted` condition to be set to status
	`False`, implementations may use the `IncompatibleFilters` reason to specify
	this configuration error.


	Support: Core
	"""
											items: {
												description: """
	GRPCRouteFilter defines processing steps that must be completed during the
	request or response lifecycle. GRPCRouteFilters are meant as an extension
	point to express processing that may be done in Gateway implementations. Some
	examples include request or response modification, implementing
	authentication strategies, rate-limiting, and traffic shaping. API
	guarantee/conformance is defined based on the type of the filter.
	"""
												properties: {
													extensionRef: {
														description: """
	ExtensionRef is an optional, implementation-specific extension to the
	"filter" behavior.  For example, resource "myroutefilter" in group
	"networking.example.net"). ExtensionRef MUST NOT be used for core and
	extended filters.


	Support: Implementation-specific


	This filter can be used multiple times within the same rule.
	"""
														properties: {
															group: {
																description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																maxLength: 253
																pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															kind: {
																description: "Kind is kind of the referent. For example \"HTTPRoute\" or \"Service\"."
																maxLength:   63
																minLength:   1
																pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																type:        "string"
															}
															name: {
																description: "Name is the name of the referent."
																maxLength:   253
																minLength:   1
																type:        "string"
															}
														}
														required: [
															"group",
															"kind",
															"name",
														]
														type: "object"
													}
													requestHeaderModifier: {
														description: """
	RequestHeaderModifier defines a schema for a filter that modifies request
	headers.


	Support: Core
	"""
														properties: {
															add: {
																description: """
	Add adds the given header(s) (name, value) to the request
	before the action. It appends to any existing values associated
	with the header name.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  add:
	  - name: "my-header"
	    value: "bar,baz"


	Output:
	  GET /foo HTTP/1.1
	  my-header: foo,bar,baz
	"""
																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																	properties: {
																		name: {
																			description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."
																			maxLength:   4096
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
															remove: {
																description: """
	Remove the given header(s) from the HTTP request before the action. The
	value of Remove is a list of HTTP header names. Note that the header
	names are case-insensitive (see
	https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).


	Input:
	  GET /foo HTTP/1.1
	  my-header1: foo
	  my-header2: bar
	  my-header3: baz


	Config:
	  remove: ["my-header1", "my-header3"]


	Output:
	  GET /foo HTTP/1.1
	  my-header2: bar
	"""
																items: type: "string"
																maxItems:                 16
																type:                     "array"
																"x-kubernetes-list-type": "set"
															}
															set: {
																description: """
	Set overwrites the request with the given header (name, value)
	before the action.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  set:
	  - name: "my-header"
	    value: "bar"


	Output:
	  GET /foo HTTP/1.1
	  my-header: bar
	"""
																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																	properties: {
																		name: {
																			description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."
																			maxLength:   4096
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
														}
														type: "object"
													}
													requestMirror: {
														description: """
	RequestMirror defines a schema for a filter that mirrors requests.
	Requests are sent to the specified destination, but responses from
	that destination are ignored.


	This filter can be used multiple times within the same rule. Note that
	not all implementations will be able to support mirroring to multiple
	backends.


	Support: Extended
	"""
														properties: backendRef: {
															description: """
	BackendRef references a resource where mirrored requests are sent.


	Mirrored requests must be sent only to a single destination endpoint
	within this BackendRef, irrespective of how many endpoints are present
	within this BackendRef.


	If the referent cannot be found, this BackendRef is invalid and must be
	dropped from the Gateway. The controller must ensure the "ResolvedRefs"
	condition on the Route status is set to `status: False` and not configure
	this backend in the underlying implementation.


	If there is a cross-namespace reference to an *existing* object
	that is not allowed by a ReferenceGrant, the controller must ensure the
	"ResolvedRefs"  condition on the Route is set to `status: False`,
	with the "RefNotPermitted" reason and not configure this backend in the
	underlying implementation.


	In either error case, the Message of the `ResolvedRefs` Condition
	should be used to provide more detail about the problem.


	Support: Extended for Kubernetes Service


	Support: Implementation-specific for any other resource
	"""
															properties: {
																group: {
																	default: ""
																	description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																	maxLength: 253
																	pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																	type:      "string"
																}
																kind: {
																	default: "Service"
																	description: """
	Kind is the Kubernetes resource kind of the referent. For example
	"Service".


	Defaults to "Service" when not specified.


	ExternalName services can refer to CNAME DNS records that may live
	outside of the cluster and as such are difficult to reason about in
	terms of conformance. They also may not be safe to forward to (see
	CVE-2021-25740 for more information). Implementations SHOULD NOT
	support ExternalName Services.


	Support: Core (Services with a type other than ExternalName)


	Support: Implementation-specific (Services with type ExternalName)
	"""
																	maxLength: 63
																	minLength: 1
																	pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																	type:      "string"
																}
																name: {
																	description: "Name is the name of the referent."
																	maxLength:   253
																	minLength:   1
																	type:        "string"
																}
																namespace: {
																	description: """
	Namespace is the namespace of the backend. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
																	maxLength: 63
																	minLength: 1
																	pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
																	type:      "string"
																}
																port: {
																	description: """
	Port specifies the destination port number to use for this resource.
	Port is required when the referent is a Kubernetes Service. In this
	case, the port number is the service port number, not the target port.
	For other resources, destination port might be derived from the referent
	resource or this field.
	"""
																	format:  "int32"
																	maximum: 65535
																	minimum: 1
																	type:    "integer"
																}
															}
															required: ["name"]
															type: "object"
															"x-kubernetes-validations": [{
																message: "Must have port for Service reference"
																rule:    "(size(self.group) == 0 && self.kind == 'Service') ? has(self.port) : true"
															}]
														}
														required: ["backendRef"]
														type: "object"
													}
													responseHeaderModifier: {
														description: """
	ResponseHeaderModifier defines a schema for a filter that modifies response
	headers.


	Support: Extended
	"""
														properties: {
															add: {
																description: """
	Add adds the given header(s) (name, value) to the request
	before the action. It appends to any existing values associated
	with the header name.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  add:
	  - name: "my-header"
	    value: "bar,baz"


	Output:
	  GET /foo HTTP/1.1
	  my-header: foo,bar,baz
	"""
																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																	properties: {
																		name: {
																			description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."
																			maxLength:   4096
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
															remove: {
																description: """
	Remove the given header(s) from the HTTP request before the action. The
	value of Remove is a list of HTTP header names. Note that the header
	names are case-insensitive (see
	https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).


	Input:
	  GET /foo HTTP/1.1
	  my-header1: foo
	  my-header2: bar
	  my-header3: baz


	Config:
	  remove: ["my-header1", "my-header3"]


	Output:
	  GET /foo HTTP/1.1
	  my-header2: bar
	"""
																items: type: "string"
																maxItems:                 16
																type:                     "array"
																"x-kubernetes-list-type": "set"
															}
															set: {
																description: """
	Set overwrites the request with the given header (name, value)
	before the action.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  set:
	  - name: "my-header"
	    value: "bar"


	Output:
	  GET /foo HTTP/1.1
	  my-header: bar
	"""
																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																	properties: {
																		name: {
																			description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."
																			maxLength:   4096
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
														}
														type: "object"
													}
													type: {
														description: """
	Type identifies the type of filter to apply. As with other API fields,
	types are classified into three conformance levels:


	- Core: Filter types and their corresponding configuration defined by
	  "Support: Core" in this package, e.g. "RequestHeaderModifier". All
	  implementations supporting GRPCRoute MUST support core filters.


	- Extended: Filter types and their corresponding configuration defined by
	  "Support: Extended" in this package, e.g. "RequestMirror". Implementers
	  are encouraged to support extended filters.


	- Implementation-specific: Filters that are defined and supported by specific vendors.
	  In the future, filters showing convergence in behavior across multiple
	  implementations will be considered for inclusion in extended or core
	  conformance levels. Filter-specific configuration for such filters
	  is specified using the ExtensionRef field. `Type` MUST be set to
	  "ExtensionRef" for custom filters.


	Implementers are encouraged to define custom implementation types to
	extend the core API with implementation-specific behavior.


	If a reference to a custom filter type cannot be resolved, the filter
	MUST NOT be skipped. Instead, requests that would have been processed by
	that filter MUST receive a HTTP error response.



	"""
														enum: [
															"ResponseHeaderModifier",
															"RequestHeaderModifier",
															"RequestMirror",
															"ExtensionRef",
														]
														type: "string"
													}
												}
												required: ["type"]
												type: "object"
												"x-kubernetes-validations": [{
													message: "filter.requestHeaderModifier must be nil if the filter.type is not RequestHeaderModifier"
													rule:    "!(has(self.requestHeaderModifier) && self.type != 'RequestHeaderModifier')"
												}, {
													message: "filter.requestHeaderModifier must be specified for RequestHeaderModifier filter.type"
													rule:    "!(!has(self.requestHeaderModifier) && self.type == 'RequestHeaderModifier')"
												}, {
													message: "filter.responseHeaderModifier must be nil if the filter.type is not ResponseHeaderModifier"
													rule:    "!(has(self.responseHeaderModifier) && self.type != 'ResponseHeaderModifier')"
												}, {
													message: "filter.responseHeaderModifier must be specified for ResponseHeaderModifier filter.type"
													rule:    "!(!has(self.responseHeaderModifier) && self.type == 'ResponseHeaderModifier')"
												}, {
													message: "filter.requestMirror must be nil if the filter.type is not RequestMirror"
													rule:    "!(has(self.requestMirror) && self.type != 'RequestMirror')"
												}, {
													message: "filter.requestMirror must be specified for RequestMirror filter.type"
													rule:    "!(!has(self.requestMirror) && self.type == 'RequestMirror')"
												}, {
													message: "filter.extensionRef must be nil if the filter.type is not ExtensionRef"
													rule:    "!(has(self.extensionRef) && self.type != 'ExtensionRef')"
												}, {
													message: "filter.extensionRef must be specified for ExtensionRef filter.type"
													rule:    "!(!has(self.extensionRef) && self.type == 'ExtensionRef')"
												}]
											}
											maxItems: 16
											type:     "array"
											"x-kubernetes-validations": [{
												message: "RequestHeaderModifier filter cannot be repeated"
												rule:    "self.filter(f, f.type == 'RequestHeaderModifier').size() <= 1"
											}, {
												message: "ResponseHeaderModifier filter cannot be repeated"
												rule:    "self.filter(f, f.type == 'ResponseHeaderModifier').size() <= 1"
											}]
										}
										matches: {
											description: """
	Matches define conditions used for matching the rule against incoming
	gRPC requests. Each match is independent, i.e. this rule will be matched
	if **any** one of the matches is satisfied.


	For example, take the following matches configuration:


	```
	matches:
	- method:
	    service: foo.bar
	  headers:
	    values:
	      version: 2
	- method:
	    service: foo.bar.v2
	```


	For a request to match against this rule, it MUST satisfy
	EITHER of the two conditions:


	- service of foo.bar AND contains the header `version: 2`
	- service of foo.bar.v2


	See the documentation for GRPCRouteMatch on how to specify multiple
	match conditions to be ANDed together.


	If no matches are specified, the implementation MUST match every gRPC request.


	Proxy or Load Balancer routing configuration generated from GRPCRoutes
	MUST prioritize rules based on the following criteria, continuing on
	ties. Merging MUST not be done between GRPCRoutes and HTTPRoutes.
	Precedence MUST be given to the rule with the largest number of:


	* Characters in a matching non-wildcard hostname.
	* Characters in a matching hostname.
	* Characters in a matching service.
	* Characters in a matching method.
	* Header matches.


	If ties still exist across multiple Routes, matching precedence MUST be
	determined in order of the following criteria, continuing on ties:


	* The oldest Route based on creation timestamp.
	* The Route appearing first in alphabetical order by
	  "{namespace}/{name}".


	If ties still exist within the Route that has been given precedence,
	matching precedence MUST be granted to the first matching rule meeting
	the above criteria.
	"""
											items: {
												description: """
	GRPCRouteMatch defines the predicate used to match requests to a given
	action. Multiple match types are ANDed together, i.e. the match will
	evaluate to true only if all conditions are satisfied.


	For example, the match below will match a gRPC request only if its service
	is `foo` AND it contains the `version: v1` header:


	```
	matches:
	  - method:
	    type: Exact
	    service: "foo"
	    headers:
	  - name: "version"
	    value "v1"


	```
	"""
												properties: {
													headers: {
														description: """
	Headers specifies gRPC request header matchers. Multiple match values are
	ANDed together, meaning, a request MUST match all the specified headers
	to select the route.
	"""
														items: {
															description: """
	GRPCHeaderMatch describes how to select a gRPC route by matching gRPC request
	headers.
	"""
															properties: {
																name: {
																	description: """
	Name is the name of the gRPC Header to be matched.


	If multiple entries specify equivalent header names, only the first
	entry with an equivalent name MUST be considered for a match. Subsequent
	entries with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																	maxLength: 256
																	minLength: 1
																	pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																	type:      "string"
																}
																type: {
																	default:     "Exact"
																	description: "Type specifies how to match against the value of the header."
																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of the gRPC Header to be matched."
																	maxLength:   4096
																	minLength:   1
																	type:        "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
													method: {
														description: """
	Method specifies a gRPC request service/method matcher. If this field is
	not specified, all services and methods will match.
	"""
														properties: {
															method: {
																description: """
	Value of the method to match against. If left empty or omitted, will
	match all services.


	At least one of Service and Method MUST be a non-empty string.
	"""
																maxLength: 1024
																type:      "string"
															}
															service: {
																description: """
	Value of the service to match against. If left empty or omitted, will
	match any service.


	At least one of Service and Method MUST be a non-empty string.
	"""
																maxLength: 1024
																type:      "string"
															}
															type: {
																default: "Exact"
																description: """
	Type specifies how to match against the service and/or method.
	Support: Core (Exact with service and method specified)


	Support: Implementation-specific (Exact with method specified but no service specified)


	Support: Implementation-specific (RegularExpression)
	"""
																enum: [
																	"Exact",
																	"RegularExpression",
																]
																type: "string"
															}
														}
														type: "object"
														"x-kubernetes-validations": [{
															message: "One or both of 'service' or 'method' must be specified"
															rule:    "has(self.type) ? has(self.service) || has(self.method) : true"
														}, {
															message: "service must only contain valid characters (matching ^(?i)\\.?[a-z_][a-z_0-9]*(\\.[a-z_][a-z_0-9]*)*$)"
															rule:    "(!has(self.type) || self.type == 'Exact') && has(self.service) ? self.service.matches(r\"\"\"^(?i)\\.?[a-z_][a-z_0-9]*(\\.[a-z_][a-z_0-9]*)*$\"\"\"): true"
														}, {
															message: "method must only contain valid characters (matching ^[A-Za-z_][A-Za-z_0-9]*$)"
															rule:    "(!has(self.type) || self.type == 'Exact') && has(self.method) ? self.method.matches(r\"\"\"^[A-Za-z_][A-Za-z_0-9]*$\"\"\"): true"
														}]
													}
												}
												type: "object"
											}
											maxItems: 8
											type:     "array"
										}
										sessionPersistence: {
											description: """
	SessionPersistence defines and configures session persistence
	for the route rule.


	Support: Extended



	"""
											properties: {
												absoluteTimeout: {
													description: """
	AbsoluteTimeout defines the absolute timeout of the persistent
	session. Once the AbsoluteTimeout duration has elapsed, the
	session becomes invalid.


	Support: Extended
	"""
													pattern: "^([0-9]{1,5}(h|m|s|ms)){1,4}$"
													type:    "string"
												}
												cookieConfig: {
													description: """
	CookieConfig provides configuration settings that are specific
	to cookie-based session persistence.


	Support: Core
	"""
													properties: lifetimeType: {
														default: "Session"
														description: """
	LifetimeType specifies whether the cookie has a permanent or
	session-based lifetime. A permanent cookie persists until its
	specified expiry time, defined by the Expires or Max-Age cookie
	attributes, while a session cookie is deleted when the current
	session ends.


	When set to "Permanent", AbsoluteTimeout indicates the
	cookie's lifetime via the Expires or Max-Age cookie attributes
	and is required.


	When set to "Session", AbsoluteTimeout indicates the
	absolute lifetime of the cookie tracked by the gateway and
	is optional.


	Support: Core for "Session" type


	Support: Extended for "Permanent" type
	"""
														enum: [
															"Permanent",
															"Session",
														]
														type: "string"
													}
													type: "object"
												}
												idleTimeout: {
													description: """
	IdleTimeout defines the idle timeout of the persistent session.
	Once the session has been idle for more than the specified
	IdleTimeout duration, the session becomes invalid.


	Support: Extended
	"""
													pattern: "^([0-9]{1,5}(h|m|s|ms)){1,4}$"
													type:    "string"
												}
												sessionName: {
													description: """
	SessionName defines the name of the persistent session token
	which may be reflected in the cookie or the header. Users
	should avoid reusing session names to prevent unintended
	consequences, such as rejection or unpredictable behavior.


	Support: Implementation-specific
	"""
													maxLength: 128
													type:      "string"
												}
												type: {
													default: "Cookie"
													description: """
	Type defines the type of session persistence such as through
	the use a header or cookie. Defaults to cookie based session
	persistence.


	Support: Core for "Cookie" type


	Support: Extended for "Header" type
	"""
													enum: [
														"Cookie",
														"Header",
													]
													type: "string"
												}
											}
											type: "object"
											"x-kubernetes-validations": [{
												message: "AbsoluteTimeout must be specified when cookie lifetimeType is Permanent"
												rule:    "!has(self.cookieConfig.lifetimeType) || self.cookieConfig.lifetimeType != 'Permanent' || has(self.absoluteTimeout)"
											}]
										}
									}
									type: "object"
								}
								maxItems: 16
								type:     "array"
							}
						}
						type: "object"
					}
					status: {
						description: "Status defines the current state of GRPCRoute."
						properties: parents: {
							description: """
	Parents is a list of parent resources (usually Gateways) that are
	associated with the route, and the status of the route with respect to
	each parent. When this route attaches to a parent, the controller that
	manages the parent must add an entry to this list when the controller
	first sees the route and should update the entry as appropriate when the
	route or gateway is modified.


	Note that parent references that cannot be resolved by an implementation
	of this API will not be added to this list. Implementations of this API
	can only populate Route status for the Gateways/parent resources they are
	responsible for.


	A maximum of 32 Gateways will be represented in this list. An empty list
	means the route has not been attached to any Gateway.
	"""
							items: {
								description: """
	RouteParentStatus describes the status of a route with respect to an
	associated Parent.
	"""
								properties: {
									conditions: {
										description: """
	Conditions describes the status of the route with respect to the Gateway.
	Note that the route's availability is also subject to the Gateway's own
	status conditions and listener status.


	If the Route's ParentRef specifies an existing Gateway that supports
	Routes of this kind AND that Gateway's controller has sufficient access,
	then that Gateway's controller MUST set the "Accepted" condition on the
	Route, to indicate whether the route has been accepted or rejected by the
	Gateway, and why.


	A Route MUST be considered "Accepted" if at least one of the Route's
	rules is implemented by the Gateway.


	There are a number of cases where the "Accepted" condition may not be set
	due to lack of controller visibility, that includes when:


	* The Route refers to a non-existent parent.
	* The Route is of a type that the controller does not support.
	* The Route is in a namespace the controller does not have access to.
	"""
										items: {
											description: """
	Condition contains details for one aspect of the current state of this API Resource.
	---
	This struct is intended for direct use as an array at the field path .status.conditions.  For example,


	\ttype FooStatus struct{
	\t    // Represents the observations of a foo's current state.
	\t    // Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
	\t    // +patchMergeKey=type
	\t    // +patchStrategy=merge
	\t    // +listType=map
	\t    // +listMapKey=type
	\t    Conditions []metav1.Condition `json:"conditions,omitempty" patchStrategy:"merge" patchMergeKey:"type" protobuf:"bytes,1,rep,name=conditions"`


	\t    // other fields
	\t}
	"""
											properties: {
												lastTransitionTime: {
													description: """
	lastTransitionTime is the last time the condition transitioned from one status to another.
	This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
	"""
													format: "date-time"
													type:   "string"
												}
												message: {
													description: """
	message is a human readable message indicating details about the transition.
	This may be an empty string.
	"""
													maxLength: 32768
													type:      "string"
												}
												observedGeneration: {
													description: """
	observedGeneration represents the .metadata.generation that the condition was set based upon.
	For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
	with respect to the current state of the instance.
	"""
													format:  "int64"
													minimum: 0
													type:    "integer"
												}
												reason: {
													description: """
	reason contains a programmatic identifier indicating the reason for the condition's last transition.
	Producers of specific condition types may define expected values and meanings for this field,
	and whether the values are considered a guaranteed API.
	The value should be a CamelCase string.
	This field may not be empty.
	"""
													maxLength: 1024
													minLength: 1
													pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
													type:      "string"
												}
												status: {
													description: "status of the condition, one of True, False, Unknown."
													enum: [
														"True",
														"False",
														"Unknown",
													]
													type: "string"
												}
												type: {
													description: """
	type of condition in CamelCase or in foo.example.com/CamelCase.
	---
	Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be
	useful (see .node.status.conditions), the ability to deconflict is important.
	The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)
	"""
													maxLength: 316
													pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
													type:      "string"
												}
											}
											required: [
												"lastTransitionTime",
												"message",
												"reason",
												"status",
												"type",
											]
											type: "object"
										}
										maxItems: 8
										minItems: 1
										type:     "array"
										"x-kubernetes-list-map-keys": ["type"]
										"x-kubernetes-list-type": "map"
									}
									controllerName: {
										description: """
	ControllerName is a domain/path string that indicates the name of the
	controller that wrote this status. This corresponds with the
	controllerName field on GatewayClass.


	Example: "example.net/gateway-controller".


	The format of this field is DOMAIN "/" PATH, where DOMAIN and PATH are
	valid Kubernetes names
	(https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).


	Controllers MUST populate this field when writing status. Controllers should ensure that
	entries to status populated with their ControllerName are cleaned up when they are no
	longer necessary.
	"""
										maxLength: 253
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
										type:      "string"
									}
									parentRef: {
										description: """
	ParentRef corresponds with a ParentRef in the spec that this
	RouteParentStatus struct describes the status of.
	"""
										properties: {
											group: {
												default: "gateway.networking.k8s.io"
												description: """
	Group is the group of the referent.
	When unspecified, "gateway.networking.k8s.io" is inferred.
	To set the core API group (such as for a "Service" kind referent),
	Group must be explicitly set to "" (empty string).


	Support: Core
	"""
												maxLength: 253
												pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
											kind: {
												default: "Gateway"
												description: """
	Kind is kind of the referent.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	Support for other resources is Implementation-Specific.
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:      "string"
											}
											name: {
												description: """
	Name is the name of the referent.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												type:      "string"
											}
											namespace: {
												description: """
	Namespace is the namespace of the referent. When unspecified, this refers
	to the local namespace of the Route.


	Note that there are specific rules for ParentRefs which cross namespace
	boundaries. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example:
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable any other kind of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.



	Support: Core
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
												type:      "string"
											}
											port: {
												description: """
	Port is the network port this Route targets. It can be interpreted
	differently based on the type of parent resource.


	When the parent resource is a Gateway, this targets all listeners
	listening on the specified port that also support this kind of Route(and
	select this Route). It's not recommended to set `Port` unless the
	networking behaviors specified in a Route must apply to a specific port
	as opposed to a listener(s) whose port(s) may be changed. When both Port
	and SectionName are specified, the name and port of the selected listener
	must match both specified values.



	When the parent resource is a Service, this targets a specific port in the
	Service spec. When both Port (experimental) and SectionName are specified,
	the name and port of the selected port must match both specified values.



	Implementations MAY choose to support other parent resources.
	Implementations supporting other types of parent resources MUST clearly
	document how/if Port is interpreted.


	For the purpose of status, an attachment is considered successful as
	long as the parent resource accepts it partially. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
	from the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route,
	the Route MUST be considered detached from the Gateway.


	Support: Extended
	"""
												format:  "int32"
												maximum: 65535
												minimum: 1
												type:    "integer"
											}
											sectionName: {
												description: """
	SectionName is the name of a section within the target resource. In the
	following resources, SectionName is interpreted as the following:


	* Gateway: Listener name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.
	* Service: Port name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.


	Implementations MAY choose to support attaching Routes to other resources.
	If that is the case, they MUST clearly document how SectionName is
	interpreted.


	When unspecified (empty string), this will reference the entire resource.
	For the purpose of status, an attachment is considered successful if at
	least one section in the parent resource accepts it. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
	the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route, the
	Route MUST be considered detached from the Gateway.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
										}
										required: ["name"]
										type: "object"
									}
								}
								required: [
									"controllerName",
									"parentRef",
								]
								type: "object"
							}
							maxItems: 32
							type:     "array"
						}
						required: ["parents"]
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
		}]
	}
}, {
	metadata: {
		name: "httproutes.gateway.networking.k8s.io"
		annotations: {
			"api-approved.kubernetes.io":               "https://github.com/kubernetes-sigs/gateway-api/pull/2997"
			"gateway.networking.k8s.io/bundle-version": "v1.1.0"
			"gateway.networking.k8s.io/channel":        "experimental"
		}
	}
	spec: {
		group: "gateway.networking.k8s.io"
		names: {
			categories: ["gateway-api"]
			kind:     "HTTPRoute"
			listKind: "HTTPRouteList"
			plural:   "httproutes"
			singular: "httproute"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.hostnames"
				name:     "Hostnames"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: """
					HTTPRoute provides a way to route HTTP requests. This includes the capability
					to match requests by hostname, path, header, or query param. Filters can be
					used to specify additional processing steps. Backends specify where matching
					requests should be routed.
					"""
				properties: {
					apiVersion: {
						description: """
	APIVersion defines the versioned schema of this representation of an object.
	Servers should convert recognized schemas to the latest internal value, and
	may reject unrecognized values.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	"""
						type: "string"
					}
					kind: {
						description: """
	Kind is a string value representing the REST resource this object represents.
	Servers may infer this from the endpoint the client submits requests to.
	Cannot be updated.
	In CamelCase.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	"""
						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec defines the desired state of HTTPRoute."
						properties: {
							hostnames: {
								description: """
	Hostnames defines a set of hostnames that should match against the HTTP Host
	header to select a HTTPRoute used to process the request. Implementations
	MUST ignore any port value specified in the HTTP Host header while
	performing a match and (absent of any applicable header modification
	configuration) MUST forward this header unmodified to the backend.


	Valid values for Hostnames are determined by RFC 1123 definition of a
	hostname with 2 notable exceptions:


	1. IPs are not allowed.
	2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard
	   label must appear by itself as the first label.


	If a hostname is specified by both the Listener and HTTPRoute, there
	must be at least one intersecting hostname for the HTTPRoute to be
	attached to the Listener. For example:


	* A Listener with `test.example.com` as the hostname matches HTTPRoutes
	  that have either not specified any hostnames, or have specified at
	  least one of `test.example.com` or `*.example.com`.
	* A Listener with `*.example.com` as the hostname matches HTTPRoutes
	  that have either not specified any hostnames or have specified at least
	  one hostname that matches the Listener hostname. For example,
	  `*.example.com`, `test.example.com`, and `foo.test.example.com` would
	  all match. On the other hand, `example.com` and `test.example.net` would
	  not match.


	Hostnames that are prefixed with a wildcard label (`*.`) are interpreted
	as a suffix match. That means that a match for `*.example.com` would match
	both `test.example.com`, and `foo.test.example.com`, but not `example.com`.


	If both the Listener and HTTPRoute have specified hostnames, any
	HTTPRoute hostnames that do not match the Listener hostname MUST be
	ignored. For example, if a Listener specified `*.example.com`, and the
	HTTPRoute specified `test.example.com` and `test.example.net`,
	`test.example.net` must not be considered for a match.


	If both the Listener and HTTPRoute have specified hostnames, and none
	match with the criteria above, then the HTTPRoute is not accepted. The
	implementation must raise an 'Accepted' Condition with a status of
	`False` in the corresponding RouteParentStatus.


	In the event that multiple HTTPRoutes specify intersecting hostnames (e.g.
	overlapping wildcard matching and exact matching hostnames), precedence must
	be given to rules from the HTTPRoute with the largest number of:


	* Characters in a matching non-wildcard hostname.
	* Characters in a matching hostname.


	If ties exist across multiple Routes, the matching precedence rules for
	HTTPRouteMatches takes over.


	Support: Core
	"""
								items: {
									description: """
	Hostname is the fully qualified domain name of a network host. This matches
	the RFC 1123 definition of a hostname with 2 notable exceptions:


	 1. IPs are not allowed.
	 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard
	    label must appear by itself as the first label.


	Hostname can be "precise" which is a domain name without the terminating
	dot of a network host (e.g. "foo.example.com") or "wildcard", which is a
	domain name prefixed with a single wildcard label (e.g. `*.example.com`).


	Note that as per RFC1035 and RFC1123, a *label* must consist of lower case
	alphanumeric characters or '-', and must start and end with an alphanumeric
	character. No other punctuation is allowed.
	"""
									maxLength: 253
									minLength: 1
									pattern:   "^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
									type:      "string"
								}
								maxItems: 16
								type:     "array"
							}
							parentRefs: {
								description: """
	ParentRefs references the resources (usually Gateways) that a Route wants
	to be attached to. Note that the referenced parent resource needs to
	allow this for the attachment to be complete. For Gateways, that means
	the Gateway needs to allow attachment from Routes of this kind and
	namespace. For Services, that means the Service must either be in the same
	namespace for a "producer" route, or the mesh implementation must support
	and allow "consumer" routes for the referenced Service. ReferenceGrant is
	not applicable for governing ParentRefs to Services - it is not possible to
	create a "producer" route for a Service in a different namespace from the
	Route.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	This API may be extended in the future to support additional kinds of parent
	resources.


	ParentRefs must be _distinct_. This means either that:


	* They select different objects.  If this is the case, then parentRef
	  entries are distinct. In terms of fields, this means that the
	  multi-part key defined by `group`, `kind`, `namespace`, and `name` must
	  be unique across all parentRef entries in the Route.
	* They do not select different objects, but for each optional field used,
	  each ParentRef that selects the same object must set the same set of
	  optional fields to different values. If one ParentRef sets a
	  combination of optional fields, all must set the same combination.


	Some examples:


	* If one ParentRef sets `sectionName`, all ParentRefs referencing the
	  same object must also set `sectionName`.
	* If one ParentRef sets `port`, all ParentRefs referencing the same
	  object must also set `port`.
	* If one ParentRef sets `sectionName` and `port`, all ParentRefs
	  referencing the same object must also set `sectionName` and `port`.


	It is possible to separately reference multiple distinct objects that may
	be collapsed by an implementation. For example, some implementations may
	choose to merge compatible Gateway Listeners together. If that is the
	case, the list of routes attached to those resources should also be
	merged.


	Note that for ParentRefs that cross namespace boundaries, there are specific
	rules. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example,
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable other kinds of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.







	"""
								items: {
									description: """
	ParentReference identifies an API object (usually a Gateway) that can be considered
	a parent of this resource (usually a route). There are two kinds of parent resources
	with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	This API may be extended in the future to support additional kinds of parent
	resources.


	The API object must be valid in the cluster; the Group and Kind must
	be registered in the cluster for this reference to be valid.
	"""
									properties: {
										group: {
											default: "gateway.networking.k8s.io"
											description: """
	Group is the group of the referent.
	When unspecified, "gateway.networking.k8s.io" is inferred.
	To set the core API group (such as for a "Service" kind referent),
	Group must be explicitly set to "" (empty string).


	Support: Core
	"""
											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											default: "Gateway"
											description: """
	Kind is kind of the referent.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	Support for other resources is Implementation-Specific.
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										name: {
											description: """
	Name is the name of the referent.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: """
	Namespace is the namespace of the referent. When unspecified, this refers
	to the local namespace of the Route.


	Note that there are specific rules for ParentRefs which cross namespace
	boundaries. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example:
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable any other kind of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.



	Support: Core
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
											type:      "string"
										}
										port: {
											description: """
	Port is the network port this Route targets. It can be interpreted
	differently based on the type of parent resource.


	When the parent resource is a Gateway, this targets all listeners
	listening on the specified port that also support this kind of Route(and
	select this Route). It's not recommended to set `Port` unless the
	networking behaviors specified in a Route must apply to a specific port
	as opposed to a listener(s) whose port(s) may be changed. When both Port
	and SectionName are specified, the name and port of the selected listener
	must match both specified values.



	When the parent resource is a Service, this targets a specific port in the
	Service spec. When both Port (experimental) and SectionName are specified,
	the name and port of the selected port must match both specified values.



	Implementations MAY choose to support other parent resources.
	Implementations supporting other types of parent resources MUST clearly
	document how/if Port is interpreted.


	For the purpose of status, an attachment is considered successful as
	long as the parent resource accepts it partially. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
	from the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route,
	the Route MUST be considered detached from the Gateway.


	Support: Extended
	"""
											format:  "int32"
											maximum: 65535
											minimum: 1
											type:    "integer"
										}
										sectionName: {
											description: """
	SectionName is the name of a section within the target resource. In the
	following resources, SectionName is interpreted as the following:


	* Gateway: Listener name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.
	* Service: Port name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.


	Implementations MAY choose to support attaching Routes to other resources.
	If that is the case, they MUST clearly document how SectionName is
	interpreted.


	When unspecified (empty string), this will reference the entire resource.
	For the purpose of status, an attachment is considered successful if at
	least one section in the parent resource accepts it. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
	the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route, the
	Route MUST be considered detached from the Gateway.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								maxItems: 32
								type:     "array"
								"x-kubernetes-validations": [{
									message: "sectionName or port must be specified when parentRefs includes 2 or more references to the same parent"
									rule:    "self.all(p1, self.all(p2, p1.group == p2.group && p1.kind == p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) || p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ == '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__ == p2.__namespace__)) ? ((!has(p1.sectionName) || p1.sectionName == '') == (!has(p2.sectionName) || p2.sectionName == '') && (!has(p1.port) || p1.port == 0) == (!has(p2.port) || p2.port == 0)): true))"
								}, {
									message: "sectionName or port must be unique when parentRefs includes 2 or more references to the same parent"
									rule:    "self.all(p1, self.exists_one(p2, p1.group == p2.group && p1.kind == p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) || p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ == '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__ == p2.__namespace__ )) && (((!has(p1.sectionName) || p1.sectionName == '') && (!has(p2.sectionName) || p2.sectionName == '')) || ( has(p1.sectionName) && has(p2.sectionName) && p1.sectionName == p2.sectionName)) && (((!has(p1.port) || p1.port == 0) && (!has(p2.port) || p2.port == 0)) || (has(p1.port) && has(p2.port) && p1.port == p2.port))))"
								}]
							}
							rules: {
								default: [{
									matches: [{
										path: {
											type:  "PathPrefix"
											value: "/"
										}
									}]
								}]
								description: "Rules are a list of HTTP matchers, filters and actions."
								items: {
									description: """
	HTTPRouteRule defines semantics for matching an HTTP request based on
	conditions (matches), processing it (filters), and forwarding the request to
	an API object (backendRefs).
	"""
									properties: {
										backendRefs: {
											description: """
	BackendRefs defines the backend(s) where matching requests should be
	sent.


	Failure behavior here depends on how many BackendRefs are specified and
	how many are invalid.


	If *all* entries in BackendRefs are invalid, and there are also no filters
	specified in this route rule, *all* traffic which matches this rule MUST
	receive a 500 status code.


	See the HTTPBackendRef definition for the rules about what makes a single
	HTTPBackendRef invalid.


	When a HTTPBackendRef is invalid, 500 status codes MUST be returned for
	requests that would have otherwise been routed to an invalid backend. If
	multiple backends are specified, and some are invalid, the proportion of
	requests that would otherwise have been routed to an invalid backend
	MUST receive a 500 status code.


	For example, if two backends are specified with equal weights, and one is
	invalid, 50 percent of traffic must receive a 500. Implementations may
	choose how that 50 percent is determined.


	Support: Core for Kubernetes Service


	Support: Extended for Kubernetes ServiceImport


	Support: Implementation-specific for any other resource


	Support for weight: Core
	"""
											items: {
												description: """
	HTTPBackendRef defines how a HTTPRoute forwards a HTTP request.


	Note that when a namespace different than the local namespace is specified, a
	ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	<gateway:experimental:description>


	When the BackendRef points to a Kubernetes Service, implementations SHOULD
	honor the appProtocol field if it is set for the target Service Port.


	Implementations supporting appProtocol SHOULD recognize the Kubernetes
	Standard Application Protocols defined in KEP-3726.


	If a Service appProtocol isn't specified, an implementation MAY infer the
	backend protocol through its own means. Implementations MAY infer the
	protocol from the Route type referring to the backend Service.


	If a Route is not able to send traffic to the backend using the specified
	protocol then the backend is considered invalid. Implementations MUST set the
	"ResolvedRefs" condition to "False" with the "UnsupportedProtocol" reason.


	</gateway:experimental:description>
	"""
												properties: {
													filters: {
														description: """
	Filters defined at this level should be executed if and only if the
	request is being forwarded to the backend defined here.


	Support: Implementation-specific (For broader support of filters, use the
	Filters field in HTTPRouteRule.)
	"""
														items: {
															description: """
	HTTPRouteFilter defines processing steps that must be completed during the
	request or response lifecycle. HTTPRouteFilters are meant as an extension
	point to express processing that may be done in Gateway implementations. Some
	examples include request or response modification, implementing
	authentication strategies, rate-limiting, and traffic shaping. API
	guarantee/conformance is defined based on the type of the filter.
	"""
															properties: {
																extensionRef: {
																	description: """
	ExtensionRef is an optional, implementation-specific extension to the
	"filter" behavior.  For example, resource "myroutefilter" in group
	"networking.example.net"). ExtensionRef MUST NOT be used for core and
	extended filters.


	This filter can be used multiple times within the same rule.


	Support: Implementation-specific
	"""
																	properties: {
																		group: {
																			description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																			maxLength: 253
																			pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		kind: {
																			description: "Kind is kind of the referent. For example \"HTTPRoute\" or \"Service\"."
																			maxLength:   63
																			minLength:   1
																			pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																			type:        "string"
																		}
																		name: {
																			description: "Name is the name of the referent."
																			maxLength:   253
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"group",
																		"kind",
																		"name",
																	]
																	type: "object"
																}
																requestHeaderModifier: {
																	description: """
	RequestHeaderModifier defines a schema for a filter that modifies request
	headers.


	Support: Core
	"""
																	properties: {
																		add: {
																			description: """
	Add adds the given header(s) (name, value) to the request
	before the action. It appends to any existing values associated
	with the header name.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  add:
	  - name: "my-header"
	    value: "bar,baz"


	Output:
	  GET /foo HTTP/1.1
	  my-header: foo,bar,baz
	"""
																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																				properties: {
																					name: {
																						description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."
																						maxLength:   4096
																						minLength:   1
																						type:        "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
	Remove the given header(s) from the HTTP request before the action. The
	value of Remove is a list of HTTP header names. Note that the header
	names are case-insensitive (see
	https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).


	Input:
	  GET /foo HTTP/1.1
	  my-header1: foo
	  my-header2: bar
	  my-header3: baz


	Config:
	  remove: ["my-header1", "my-header3"]


	Output:
	  GET /foo HTTP/1.1
	  my-header2: bar
	"""
																			items: type: "string"
																			maxItems:                 16
																			type:                     "array"
																			"x-kubernetes-list-type": "set"
																		}
																		set: {
																			description: """
	Set overwrites the request with the given header (name, value)
	before the action.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  set:
	  - name: "my-header"
	    value: "bar"


	Output:
	  GET /foo HTTP/1.1
	  my-header: bar
	"""
																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																				properties: {
																					name: {
																						description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."
																						maxLength:   4096
																						minLength:   1
																						type:        "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																requestMirror: {
																	description: """
	RequestMirror defines a schema for a filter that mirrors requests.
	Requests are sent to the specified destination, but responses from
	that destination are ignored.


	This filter can be used multiple times within the same rule. Note that
	not all implementations will be able to support mirroring to multiple
	backends.


	Support: Extended
	"""
																	properties: backendRef: {
																		description: """
	BackendRef references a resource where mirrored requests are sent.


	Mirrored requests must be sent only to a single destination endpoint
	within this BackendRef, irrespective of how many endpoints are present
	within this BackendRef.


	If the referent cannot be found, this BackendRef is invalid and must be
	dropped from the Gateway. The controller must ensure the "ResolvedRefs"
	condition on the Route status is set to `status: False` and not configure
	this backend in the underlying implementation.


	If there is a cross-namespace reference to an *existing* object
	that is not allowed by a ReferenceGrant, the controller must ensure the
	"ResolvedRefs"  condition on the Route is set to `status: False`,
	with the "RefNotPermitted" reason and not configure this backend in the
	underlying implementation.


	In either error case, the Message of the `ResolvedRefs` Condition
	should be used to provide more detail about the problem.


	Support: Extended for Kubernetes Service


	Support: Implementation-specific for any other resource
	"""
																		properties: {
																			group: {
																				default: ""
																				description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																				maxLength: 253
																				pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																				type:      "string"
																			}
																			kind: {
																				default: "Service"
																				description: """
	Kind is the Kubernetes resource kind of the referent. For example
	"Service".


	Defaults to "Service" when not specified.


	ExternalName services can refer to CNAME DNS records that may live
	outside of the cluster and as such are difficult to reason about in
	terms of conformance. They also may not be safe to forward to (see
	CVE-2021-25740 for more information). Implementations SHOULD NOT
	support ExternalName Services.


	Support: Core (Services with a type other than ExternalName)


	Support: Implementation-specific (Services with type ExternalName)
	"""
																				maxLength: 63
																				minLength: 1
																				pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																				type:      "string"
																			}
																			name: {
																				description: "Name is the name of the referent."
																				maxLength:   253
																				minLength:   1
																				type:        "string"
																			}
																			namespace: {
																				description: """
	Namespace is the namespace of the backend. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
																				maxLength: 63
																				minLength: 1
																				pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
																				type:      "string"
																			}
																			port: {
																				description: """
	Port specifies the destination port number to use for this resource.
	Port is required when the referent is a Kubernetes Service. In this
	case, the port number is the service port number, not the target port.
	For other resources, destination port might be derived from the referent
	resource or this field.
	"""
																				format:  "int32"
																				maximum: 65535
																				minimum: 1
																				type:    "integer"
																			}
																		}
																		required: ["name"]
																		type: "object"
																		"x-kubernetes-validations": [{
																			message: "Must have port for Service reference"
																			rule:    "(size(self.group) == 0 && self.kind == 'Service') ? has(self.port) : true"
																		}]
																	}
																	required: ["backendRef"]
																	type: "object"
																}
																requestRedirect: {
																	description: """
	RequestRedirect defines a schema for a filter that responds to the
	request with an HTTP redirection.


	Support: Core
	"""
																	properties: {
																		hostname: {
																			description: """
	Hostname is the hostname to be used in the value of the `Location`
	header in the response.
	When empty, the hostname in the `Host` header of the request is used.


	Support: Core
	"""
																			maxLength: 253
																			minLength: 1
																			pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		path: {
																			description: """
	Path defines parameters used to modify the path of the incoming request.
	The modified path is then used to construct the `Location` header. When
	empty, the request path is used as-is.


	Support: Extended
	"""
																			properties: {
																				replaceFullPath: {
																					description: """
	ReplaceFullPath specifies the value with which to replace the full path
	of a request during a rewrite or redirect.
	"""
																					maxLength: 1024
																					type:      "string"
																				}
																				replacePrefixMatch: {
																					description: """
	ReplacePrefixMatch specifies the value with which to replace the prefix
	match of a request during a rewrite or redirect. For example, a request
	to "/foo/bar" with a prefix match of "/foo" and a ReplacePrefixMatch
	of "/xyz" would be modified to "/xyz/bar".


	Note that this matches the behavior of the PathPrefix match type. This
	matches full path elements. A path element refers to the list of labels
	in the path split by the `/` separator. When specified, a trailing `/` is
	ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all
	match the prefix `/abc`, but the path `/abcd` would not.


	ReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.
	Using any other HTTPRouteMatch type on the same HTTPRouteRule will result in
	the implementation setting the Accepted Condition for the Route to `status: False`.


	Request Path | Prefix Match | Replace Prefix | Modified Path
	-------------|--------------|----------------|----------
	/foo/bar     | /foo         | /xyz           | /xyz/bar
	/foo/bar     | /foo         | /xyz/          | /xyz/bar
	/foo/bar     | /foo/        | /xyz           | /xyz/bar
	/foo/bar     | /foo/        | /xyz/          | /xyz/bar
	/foo         | /foo         | /xyz           | /xyz
	/foo/        | /foo         | /xyz           | /xyz/
	/foo/bar     | /foo         | <empty string> | /bar
	/foo/        | /foo         | <empty string> | /
	/foo         | /foo         | <empty string> | /
	/foo/        | /foo         | /              | /
	/foo         | /foo         | /              | /
	"""
																					maxLength: 1024
																					type:      "string"
																				}
																				type: {
																					description: """
	Type defines the type of path modifier. Additional types may be
	added in a future release of the API.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.
	"""
																					enum: [
																						"ReplaceFullPath",
																						"ReplacePrefixMatch",
																					]
																					type: "string"
																				}
																			}
																			required: ["type"]
																			type: "object"
																			"x-kubernetes-validations": [{
																				message: "replaceFullPath must be specified when type is set to 'ReplaceFullPath'"
																				rule:    "self.type == 'ReplaceFullPath' ? has(self.replaceFullPath) : true"
																			}, {
																				message: "type must be 'ReplaceFullPath' when replaceFullPath is set"
																				rule:    "has(self.replaceFullPath) ? self.type == 'ReplaceFullPath' : true"
																			}, {
																				message: "replacePrefixMatch must be specified when type is set to 'ReplacePrefixMatch'"
																				rule:    "self.type == 'ReplacePrefixMatch' ? has(self.replacePrefixMatch) : true"
																			}, {
																				message: "type must be 'ReplacePrefixMatch' when replacePrefixMatch is set"
																				rule:    "has(self.replacePrefixMatch) ? self.type == 'ReplacePrefixMatch' : true"
																			}]
																		}
																		port: {
																			description: """
	Port is the port to be used in the value of the `Location`
	header in the response.


	If no port is specified, the redirect port MUST be derived using the
	following rules:


	* If redirect scheme is not-empty, the redirect port MUST be the well-known
	  port associated with the redirect scheme. Specifically "http" to port 80
	  and "https" to port 443. If the redirect scheme does not have a
	  well-known port, the listener port of the Gateway SHOULD be used.
	* If redirect scheme is empty, the redirect port MUST be the Gateway
	  Listener port.


	Implementations SHOULD NOT add the port number in the 'Location'
	header in the following cases:


	* A Location header that will use HTTP (whether that is determined via
	  the Listener protocol or the Scheme field) _and_ use port 80.
	* A Location header that will use HTTPS (whether that is determined via
	  the Listener protocol or the Scheme field) _and_ use port 443.


	Support: Extended
	"""
																			format:  "int32"
																			maximum: 65535
																			minimum: 1
																			type:    "integer"
																		}
																		scheme: {
																			description: """
	Scheme is the scheme to be used in the value of the `Location` header in
	the response. When empty, the scheme of the request is used.


	Scheme redirects can affect the port of the redirect, for more information,
	refer to the documentation for the port field of this filter.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.


	Support: Extended
	"""
																			enum: [
																				"http",
																				"https",
																			]
																			type: "string"
																		}
																		statusCode: {
																			default: 302
																			description: """
	StatusCode is the HTTP status code to be used in response.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.


	Support: Core
	"""
																			enum: [
																				301,
																				302,
																			]
																			type: "integer"
																		}
																	}
																	type: "object"
																}
																responseHeaderModifier: {
																	description: """
	ResponseHeaderModifier defines a schema for a filter that modifies response
	headers.


	Support: Extended
	"""
																	properties: {
																		add: {
																			description: """
	Add adds the given header(s) (name, value) to the request
	before the action. It appends to any existing values associated
	with the header name.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  add:
	  - name: "my-header"
	    value: "bar,baz"


	Output:
	  GET /foo HTTP/1.1
	  my-header: foo,bar,baz
	"""
																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																				properties: {
																					name: {
																						description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."
																						maxLength:   4096
																						minLength:   1
																						type:        "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
	Remove the given header(s) from the HTTP request before the action. The
	value of Remove is a list of HTTP header names. Note that the header
	names are case-insensitive (see
	https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).


	Input:
	  GET /foo HTTP/1.1
	  my-header1: foo
	  my-header2: bar
	  my-header3: baz


	Config:
	  remove: ["my-header1", "my-header3"]


	Output:
	  GET /foo HTTP/1.1
	  my-header2: bar
	"""
																			items: type: "string"
																			maxItems:                 16
																			type:                     "array"
																			"x-kubernetes-list-type": "set"
																		}
																		set: {
																			description: """
	Set overwrites the request with the given header (name, value)
	before the action.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  set:
	  - name: "my-header"
	    value: "bar"


	Output:
	  GET /foo HTTP/1.1
	  my-header: bar
	"""
																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																				properties: {
																					name: {
																						description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."
																						maxLength:   4096
																						minLength:   1
																						type:        "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																type: {
																	description: """
	Type identifies the type of filter to apply. As with other API fields,
	types are classified into three conformance levels:


	- Core: Filter types and their corresponding configuration defined by
	  "Support: Core" in this package, e.g. "RequestHeaderModifier". All
	  implementations must support core filters.


	- Extended: Filter types and their corresponding configuration defined by
	  "Support: Extended" in this package, e.g. "RequestMirror". Implementers
	  are encouraged to support extended filters.


	- Implementation-specific: Filters that are defined and supported by
	  specific vendors.
	  In the future, filters showing convergence in behavior across multiple
	  implementations will be considered for inclusion in extended or core
	  conformance levels. Filter-specific configuration for such filters
	  is specified using the ExtensionRef field. `Type` should be set to
	  "ExtensionRef" for custom filters.


	Implementers are encouraged to define custom implementation types to
	extend the core API with implementation-specific behavior.


	If a reference to a custom filter type cannot be resolved, the filter
	MUST NOT be skipped. Instead, requests that would have been processed by
	that filter MUST receive a HTTP error response.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.
	"""
																	enum: [
																		"RequestHeaderModifier",
																		"ResponseHeaderModifier",
																		"RequestMirror",
																		"RequestRedirect",
																		"URLRewrite",
																		"ExtensionRef",
																	]
																	type: "string"
																}
																urlRewrite: {
																	description: """
	URLRewrite defines a schema for a filter that modifies a request during forwarding.


	Support: Extended
	"""
																	properties: {
																		hostname: {
																			description: """
	Hostname is the value to be used to replace the Host header value during
	forwarding.


	Support: Extended
	"""
																			maxLength: 253
																			minLength: 1
																			pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		path: {
																			description: """
	Path defines a path rewrite.


	Support: Extended
	"""
																			properties: {
																				replaceFullPath: {
																					description: """
	ReplaceFullPath specifies the value with which to replace the full path
	of a request during a rewrite or redirect.
	"""
																					maxLength: 1024
																					type:      "string"
																				}
																				replacePrefixMatch: {
																					description: """
	ReplacePrefixMatch specifies the value with which to replace the prefix
	match of a request during a rewrite or redirect. For example, a request
	to "/foo/bar" with a prefix match of "/foo" and a ReplacePrefixMatch
	of "/xyz" would be modified to "/xyz/bar".


	Note that this matches the behavior of the PathPrefix match type. This
	matches full path elements. A path element refers to the list of labels
	in the path split by the `/` separator. When specified, a trailing `/` is
	ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all
	match the prefix `/abc`, but the path `/abcd` would not.


	ReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.
	Using any other HTTPRouteMatch type on the same HTTPRouteRule will result in
	the implementation setting the Accepted Condition for the Route to `status: False`.


	Request Path | Prefix Match | Replace Prefix | Modified Path
	-------------|--------------|----------------|----------
	/foo/bar     | /foo         | /xyz           | /xyz/bar
	/foo/bar     | /foo         | /xyz/          | /xyz/bar
	/foo/bar     | /foo/        | /xyz           | /xyz/bar
	/foo/bar     | /foo/        | /xyz/          | /xyz/bar
	/foo         | /foo         | /xyz           | /xyz
	/foo/        | /foo         | /xyz           | /xyz/
	/foo/bar     | /foo         | <empty string> | /bar
	/foo/        | /foo         | <empty string> | /
	/foo         | /foo         | <empty string> | /
	/foo/        | /foo         | /              | /
	/foo         | /foo         | /              | /
	"""
																					maxLength: 1024
																					type:      "string"
																				}
																				type: {
																					description: """
	Type defines the type of path modifier. Additional types may be
	added in a future release of the API.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.
	"""
																					enum: [
																						"ReplaceFullPath",
																						"ReplacePrefixMatch",
																					]
																					type: "string"
																				}
																			}
																			required: ["type"]
																			type: "object"
																			"x-kubernetes-validations": [{
																				message: "replaceFullPath must be specified when type is set to 'ReplaceFullPath'"
																				rule:    "self.type == 'ReplaceFullPath' ? has(self.replaceFullPath) : true"
																			}, {
																				message: "type must be 'ReplaceFullPath' when replaceFullPath is set"
																				rule:    "has(self.replaceFullPath) ? self.type == 'ReplaceFullPath' : true"
																			}, {
																				message: "replacePrefixMatch must be specified when type is set to 'ReplacePrefixMatch'"
																				rule:    "self.type == 'ReplacePrefixMatch' ? has(self.replacePrefixMatch) : true"
																			}, {
																				message: "type must be 'ReplacePrefixMatch' when replacePrefixMatch is set"
																				rule:    "has(self.replacePrefixMatch) ? self.type == 'ReplacePrefixMatch' : true"
																			}]
																		}
																	}
																	type: "object"
																}
															}
															required: ["type"]
															type: "object"
															"x-kubernetes-validations": [{
																message: "filter.requestHeaderModifier must be nil if the filter.type is not RequestHeaderModifier"
																rule:    "!(has(self.requestHeaderModifier) && self.type != 'RequestHeaderModifier')"
															}, {
																message: "filter.requestHeaderModifier must be specified for RequestHeaderModifier filter.type"
																rule:    "!(!has(self.requestHeaderModifier) && self.type == 'RequestHeaderModifier')"
															}, {
																message: "filter.responseHeaderModifier must be nil if the filter.type is not ResponseHeaderModifier"
																rule:    "!(has(self.responseHeaderModifier) && self.type != 'ResponseHeaderModifier')"
															}, {
																message: "filter.responseHeaderModifier must be specified for ResponseHeaderModifier filter.type"
																rule:    "!(!has(self.responseHeaderModifier) && self.type == 'ResponseHeaderModifier')"
															}, {
																message: "filter.requestMirror must be nil if the filter.type is not RequestMirror"
																rule:    "!(has(self.requestMirror) && self.type != 'RequestMirror')"
															}, {
																message: "filter.requestMirror must be specified for RequestMirror filter.type"
																rule:    "!(!has(self.requestMirror) && self.type == 'RequestMirror')"
															}, {
																message: "filter.requestRedirect must be nil if the filter.type is not RequestRedirect"
																rule:    "!(has(self.requestRedirect) && self.type != 'RequestRedirect')"
															}, {
																message: "filter.requestRedirect must be specified for RequestRedirect filter.type"
																rule:    "!(!has(self.requestRedirect) && self.type == 'RequestRedirect')"
															}, {
																message: "filter.urlRewrite must be nil if the filter.type is not URLRewrite"
																rule:    "!(has(self.urlRewrite) && self.type != 'URLRewrite')"
															}, {
																message: "filter.urlRewrite must be specified for URLRewrite filter.type"
																rule:    "!(!has(self.urlRewrite) && self.type == 'URLRewrite')"
															}, {
																message: "filter.extensionRef must be nil if the filter.type is not ExtensionRef"
																rule:    "!(has(self.extensionRef) && self.type != 'ExtensionRef')"
															}, {
																message: "filter.extensionRef must be specified for ExtensionRef filter.type"
																rule:    "!(!has(self.extensionRef) && self.type == 'ExtensionRef')"
															}]
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-validations": [{
															message: "May specify either httpRouteFilterRequestRedirect or httpRouteFilterRequestRewrite, but not both"
															rule:    "!(self.exists(f, f.type == 'RequestRedirect') && self.exists(f, f.type == 'URLRewrite'))"
														}, {
															message: "May specify either httpRouteFilterRequestRedirect or httpRouteFilterRequestRewrite, but not both"
															rule:    "!(self.exists(f, f.type == 'RequestRedirect') && self.exists(f, f.type == 'URLRewrite'))"
														}, {
															message: "RequestHeaderModifier filter cannot be repeated"
															rule:    "self.filter(f, f.type == 'RequestHeaderModifier').size() <= 1"
														}, {
															message: "ResponseHeaderModifier filter cannot be repeated"
															rule:    "self.filter(f, f.type == 'ResponseHeaderModifier').size() <= 1"
														}, {
															message: "RequestRedirect filter cannot be repeated"
															rule:    "self.filter(f, f.type == 'RequestRedirect').size() <= 1"
														}, {
															message: "URLRewrite filter cannot be repeated"
															rule:    "self.filter(f, f.type == 'URLRewrite').size() <= 1"
														}]
													}
													group: {
														default: ""
														description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
														maxLength: 253
														pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
														type:      "string"
													}
													kind: {
														default: "Service"
														description: """
	Kind is the Kubernetes resource kind of the referent. For example
	"Service".


	Defaults to "Service" when not specified.


	ExternalName services can refer to CNAME DNS records that may live
	outside of the cluster and as such are difficult to reason about in
	terms of conformance. They also may not be safe to forward to (see
	CVE-2021-25740 for more information). Implementations SHOULD NOT
	support ExternalName Services.


	Support: Core (Services with a type other than ExternalName)


	Support: Implementation-specific (Services with type ExternalName)
	"""
														maxLength: 63
														minLength: 1
														pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
														type:      "string"
													}
													name: {
														description: "Name is the name of the referent."
														maxLength:   253
														minLength:   1
														type:        "string"
													}
													namespace: {
														description: """
	Namespace is the namespace of the backend. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
														maxLength: 63
														minLength: 1
														pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
														type:      "string"
													}
													port: {
														description: """
	Port specifies the destination port number to use for this resource.
	Port is required when the referent is a Kubernetes Service. In this
	case, the port number is the service port number, not the target port.
	For other resources, destination port might be derived from the referent
	resource or this field.
	"""
														format:  "int32"
														maximum: 65535
														minimum: 1
														type:    "integer"
													}
													weight: {
														default: 1
														description: """
	Weight specifies the proportion of requests forwarded to the referenced
	backend. This is computed as weight/(sum of all weights in this
	BackendRefs list). For non-zero values, there may be some epsilon from
	the exact proportion defined here depending on the precision an
	implementation supports. Weight is not a percentage and the sum of
	weights does not need to equal 100.


	If only one backend is specified and it has a weight greater than 0, 100%
	of the traffic is forwarded to that backend. If weight is set to 0, no
	traffic should be forwarded for this entry. If unspecified, weight
	defaults to 1.


	Support for this field varies based on the context where used.
	"""
														format:  "int32"
														maximum: 1000000
														minimum: 0
														type:    "integer"
													}
												}
												required: ["name"]
												type: "object"
												"x-kubernetes-validations": [{
													message: "Must have port for Service reference"
													rule:    "(size(self.group) == 0 && self.kind == 'Service') ? has(self.port) : true"
												}]
											}
											maxItems: 16
											type:     "array"
										}
										filters: {
											description: """
	Filters define the filters that are applied to requests that match
	this rule.


	Wherever possible, implementations SHOULD implement filters in the order
	they are specified.


	Implementations MAY choose to implement this ordering strictly, rejecting
	any combination or order of filters that can not be supported. If implementations
	choose a strict interpretation of filter ordering, they MUST clearly document
	that behavior.


	To reject an invalid combination or order of filters, implementations SHOULD
	consider the Route Rules with this configuration invalid. If all Route Rules
	in a Route are invalid, the entire Route would be considered invalid. If only
	a portion of Route Rules are invalid, implementations MUST set the
	"PartiallyInvalid" condition for the Route.


	Conformance-levels at this level are defined based on the type of filter:


	- ALL core filters MUST be supported by all implementations.
	- Implementers are encouraged to support extended filters.
	- Implementation-specific custom filters have no API guarantees across
	  implementations.


	Specifying the same filter multiple times is not supported unless explicitly
	indicated in the filter.


	All filters are expected to be compatible with each other except for the
	URLRewrite and RequestRedirect filters, which may not be combined. If an
	implementation can not support other combinations of filters, they must clearly
	document that limitation. In cases where incompatible or unsupported
	filters are specified and cause the `Accepted` condition to be set to status
	`False`, implementations may use the `IncompatibleFilters` reason to specify
	this configuration error.


	Support: Core
	"""
											items: {
												description: """
	HTTPRouteFilter defines processing steps that must be completed during the
	request or response lifecycle. HTTPRouteFilters are meant as an extension
	point to express processing that may be done in Gateway implementations. Some
	examples include request or response modification, implementing
	authentication strategies, rate-limiting, and traffic shaping. API
	guarantee/conformance is defined based on the type of the filter.
	"""
												properties: {
													extensionRef: {
														description: """
	ExtensionRef is an optional, implementation-specific extension to the
	"filter" behavior.  For example, resource "myroutefilter" in group
	"networking.example.net"). ExtensionRef MUST NOT be used for core and
	extended filters.


	This filter can be used multiple times within the same rule.


	Support: Implementation-specific
	"""
														properties: {
															group: {
																description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																maxLength: 253
																pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															kind: {
																description: "Kind is kind of the referent. For example \"HTTPRoute\" or \"Service\"."
																maxLength:   63
																minLength:   1
																pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																type:        "string"
															}
															name: {
																description: "Name is the name of the referent."
																maxLength:   253
																minLength:   1
																type:        "string"
															}
														}
														required: [
															"group",
															"kind",
															"name",
														]
														type: "object"
													}
													requestHeaderModifier: {
														description: """
	RequestHeaderModifier defines a schema for a filter that modifies request
	headers.


	Support: Core
	"""
														properties: {
															add: {
																description: """
	Add adds the given header(s) (name, value) to the request
	before the action. It appends to any existing values associated
	with the header name.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  add:
	  - name: "my-header"
	    value: "bar,baz"


	Output:
	  GET /foo HTTP/1.1
	  my-header: foo,bar,baz
	"""
																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																	properties: {
																		name: {
																			description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."
																			maxLength:   4096
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
															remove: {
																description: """
	Remove the given header(s) from the HTTP request before the action. The
	value of Remove is a list of HTTP header names. Note that the header
	names are case-insensitive (see
	https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).


	Input:
	  GET /foo HTTP/1.1
	  my-header1: foo
	  my-header2: bar
	  my-header3: baz


	Config:
	  remove: ["my-header1", "my-header3"]


	Output:
	  GET /foo HTTP/1.1
	  my-header2: bar
	"""
																items: type: "string"
																maxItems:                 16
																type:                     "array"
																"x-kubernetes-list-type": "set"
															}
															set: {
																description: """
	Set overwrites the request with the given header (name, value)
	before the action.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  set:
	  - name: "my-header"
	    value: "bar"


	Output:
	  GET /foo HTTP/1.1
	  my-header: bar
	"""
																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																	properties: {
																		name: {
																			description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."
																			maxLength:   4096
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
														}
														type: "object"
													}
													requestMirror: {
														description: """
	RequestMirror defines a schema for a filter that mirrors requests.
	Requests are sent to the specified destination, but responses from
	that destination are ignored.


	This filter can be used multiple times within the same rule. Note that
	not all implementations will be able to support mirroring to multiple
	backends.


	Support: Extended
	"""
														properties: backendRef: {
															description: """
	BackendRef references a resource where mirrored requests are sent.


	Mirrored requests must be sent only to a single destination endpoint
	within this BackendRef, irrespective of how many endpoints are present
	within this BackendRef.


	If the referent cannot be found, this BackendRef is invalid and must be
	dropped from the Gateway. The controller must ensure the "ResolvedRefs"
	condition on the Route status is set to `status: False` and not configure
	this backend in the underlying implementation.


	If there is a cross-namespace reference to an *existing* object
	that is not allowed by a ReferenceGrant, the controller must ensure the
	"ResolvedRefs"  condition on the Route is set to `status: False`,
	with the "RefNotPermitted" reason and not configure this backend in the
	underlying implementation.


	In either error case, the Message of the `ResolvedRefs` Condition
	should be used to provide more detail about the problem.


	Support: Extended for Kubernetes Service


	Support: Implementation-specific for any other resource
	"""
															properties: {
																group: {
																	default: ""
																	description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																	maxLength: 253
																	pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																	type:      "string"
																}
																kind: {
																	default: "Service"
																	description: """
	Kind is the Kubernetes resource kind of the referent. For example
	"Service".


	Defaults to "Service" when not specified.


	ExternalName services can refer to CNAME DNS records that may live
	outside of the cluster and as such are difficult to reason about in
	terms of conformance. They also may not be safe to forward to (see
	CVE-2021-25740 for more information). Implementations SHOULD NOT
	support ExternalName Services.


	Support: Core (Services with a type other than ExternalName)


	Support: Implementation-specific (Services with type ExternalName)
	"""
																	maxLength: 63
																	minLength: 1
																	pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																	type:      "string"
																}
																name: {
																	description: "Name is the name of the referent."
																	maxLength:   253
																	minLength:   1
																	type:        "string"
																}
																namespace: {
																	description: """
	Namespace is the namespace of the backend. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
																	maxLength: 63
																	minLength: 1
																	pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
																	type:      "string"
																}
																port: {
																	description: """
	Port specifies the destination port number to use for this resource.
	Port is required when the referent is a Kubernetes Service. In this
	case, the port number is the service port number, not the target port.
	For other resources, destination port might be derived from the referent
	resource or this field.
	"""
																	format:  "int32"
																	maximum: 65535
																	minimum: 1
																	type:    "integer"
																}
															}
															required: ["name"]
															type: "object"
															"x-kubernetes-validations": [{
																message: "Must have port for Service reference"
																rule:    "(size(self.group) == 0 && self.kind == 'Service') ? has(self.port) : true"
															}]
														}
														required: ["backendRef"]
														type: "object"
													}
													requestRedirect: {
														description: """
	RequestRedirect defines a schema for a filter that responds to the
	request with an HTTP redirection.


	Support: Core
	"""
														properties: {
															hostname: {
																description: """
	Hostname is the hostname to be used in the value of the `Location`
	header in the response.
	When empty, the hostname in the `Host` header of the request is used.


	Support: Core
	"""
																maxLength: 253
																minLength: 1
																pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															path: {
																description: """
	Path defines parameters used to modify the path of the incoming request.
	The modified path is then used to construct the `Location` header. When
	empty, the request path is used as-is.


	Support: Extended
	"""
																properties: {
																	replaceFullPath: {
																		description: """
	ReplaceFullPath specifies the value with which to replace the full path
	of a request during a rewrite or redirect.
	"""
																		maxLength: 1024
																		type:      "string"
																	}
																	replacePrefixMatch: {
																		description: """
	ReplacePrefixMatch specifies the value with which to replace the prefix
	match of a request during a rewrite or redirect. For example, a request
	to "/foo/bar" with a prefix match of "/foo" and a ReplacePrefixMatch
	of "/xyz" would be modified to "/xyz/bar".


	Note that this matches the behavior of the PathPrefix match type. This
	matches full path elements. A path element refers to the list of labels
	in the path split by the `/` separator. When specified, a trailing `/` is
	ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all
	match the prefix `/abc`, but the path `/abcd` would not.


	ReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.
	Using any other HTTPRouteMatch type on the same HTTPRouteRule will result in
	the implementation setting the Accepted Condition for the Route to `status: False`.


	Request Path | Prefix Match | Replace Prefix | Modified Path
	-------------|--------------|----------------|----------
	/foo/bar     | /foo         | /xyz           | /xyz/bar
	/foo/bar     | /foo         | /xyz/          | /xyz/bar
	/foo/bar     | /foo/        | /xyz           | /xyz/bar
	/foo/bar     | /foo/        | /xyz/          | /xyz/bar
	/foo         | /foo         | /xyz           | /xyz
	/foo/        | /foo         | /xyz           | /xyz/
	/foo/bar     | /foo         | <empty string> | /bar
	/foo/        | /foo         | <empty string> | /
	/foo         | /foo         | <empty string> | /
	/foo/        | /foo         | /              | /
	/foo         | /foo         | /              | /
	"""
																		maxLength: 1024
																		type:      "string"
																	}
																	type: {
																		description: """
	Type defines the type of path modifier. Additional types may be
	added in a future release of the API.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.
	"""
																		enum: [
																			"ReplaceFullPath",
																			"ReplacePrefixMatch",
																		]
																		type: "string"
																	}
																}
																required: ["type"]
																type: "object"
																"x-kubernetes-validations": [{
																	message: "replaceFullPath must be specified when type is set to 'ReplaceFullPath'"
																	rule:    "self.type == 'ReplaceFullPath' ? has(self.replaceFullPath) : true"
																}, {
																	message: "type must be 'ReplaceFullPath' when replaceFullPath is set"
																	rule:    "has(self.replaceFullPath) ? self.type == 'ReplaceFullPath' : true"
																}, {
																	message: "replacePrefixMatch must be specified when type is set to 'ReplacePrefixMatch'"
																	rule:    "self.type == 'ReplacePrefixMatch' ? has(self.replacePrefixMatch) : true"
																}, {
																	message: "type must be 'ReplacePrefixMatch' when replacePrefixMatch is set"
																	rule:    "has(self.replacePrefixMatch) ? self.type == 'ReplacePrefixMatch' : true"
																}]
															}
															port: {
																description: """
	Port is the port to be used in the value of the `Location`
	header in the response.


	If no port is specified, the redirect port MUST be derived using the
	following rules:


	* If redirect scheme is not-empty, the redirect port MUST be the well-known
	  port associated with the redirect scheme. Specifically "http" to port 80
	  and "https" to port 443. If the redirect scheme does not have a
	  well-known port, the listener port of the Gateway SHOULD be used.
	* If redirect scheme is empty, the redirect port MUST be the Gateway
	  Listener port.


	Implementations SHOULD NOT add the port number in the 'Location'
	header in the following cases:


	* A Location header that will use HTTP (whether that is determined via
	  the Listener protocol or the Scheme field) _and_ use port 80.
	* A Location header that will use HTTPS (whether that is determined via
	  the Listener protocol or the Scheme field) _and_ use port 443.


	Support: Extended
	"""
																format:  "int32"
																maximum: 65535
																minimum: 1
																type:    "integer"
															}
															scheme: {
																description: """
	Scheme is the scheme to be used in the value of the `Location` header in
	the response. When empty, the scheme of the request is used.


	Scheme redirects can affect the port of the redirect, for more information,
	refer to the documentation for the port field of this filter.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.


	Support: Extended
	"""
																enum: [
																	"http",
																	"https",
																]
																type: "string"
															}
															statusCode: {
																default: 302
																description: """
	StatusCode is the HTTP status code to be used in response.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.


	Support: Core
	"""
																enum: [
																	301,
																	302,
																]
																type: "integer"
															}
														}
														type: "object"
													}
													responseHeaderModifier: {
														description: """
	ResponseHeaderModifier defines a schema for a filter that modifies response
	headers.


	Support: Extended
	"""
														properties: {
															add: {
																description: """
	Add adds the given header(s) (name, value) to the request
	before the action. It appends to any existing values associated
	with the header name.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  add:
	  - name: "my-header"
	    value: "bar,baz"


	Output:
	  GET /foo HTTP/1.1
	  my-header: foo,bar,baz
	"""
																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																	properties: {
																		name: {
																			description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."
																			maxLength:   4096
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
															remove: {
																description: """
	Remove the given header(s) from the HTTP request before the action. The
	value of Remove is a list of HTTP header names. Note that the header
	names are case-insensitive (see
	https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).


	Input:
	  GET /foo HTTP/1.1
	  my-header1: foo
	  my-header2: bar
	  my-header3: baz


	Config:
	  remove: ["my-header1", "my-header3"]


	Output:
	  GET /foo HTTP/1.1
	  my-header2: bar
	"""
																items: type: "string"
																maxItems:                 16
																type:                     "array"
																"x-kubernetes-list-type": "set"
															}
															set: {
																description: """
	Set overwrites the request with the given header (name, value)
	before the action.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  set:
	  - name: "my-header"
	    value: "bar"


	Output:
	  GET /foo HTTP/1.1
	  my-header: bar
	"""
																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																	properties: {
																		name: {
																			description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."
																			maxLength:   4096
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
														}
														type: "object"
													}
													type: {
														description: """
	Type identifies the type of filter to apply. As with other API fields,
	types are classified into three conformance levels:


	- Core: Filter types and their corresponding configuration defined by
	  "Support: Core" in this package, e.g. "RequestHeaderModifier". All
	  implementations must support core filters.


	- Extended: Filter types and their corresponding configuration defined by
	  "Support: Extended" in this package, e.g. "RequestMirror". Implementers
	  are encouraged to support extended filters.


	- Implementation-specific: Filters that are defined and supported by
	  specific vendors.
	  In the future, filters showing convergence in behavior across multiple
	  implementations will be considered for inclusion in extended or core
	  conformance levels. Filter-specific configuration for such filters
	  is specified using the ExtensionRef field. `Type` should be set to
	  "ExtensionRef" for custom filters.


	Implementers are encouraged to define custom implementation types to
	extend the core API with implementation-specific behavior.


	If a reference to a custom filter type cannot be resolved, the filter
	MUST NOT be skipped. Instead, requests that would have been processed by
	that filter MUST receive a HTTP error response.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.
	"""
														enum: [
															"RequestHeaderModifier",
															"ResponseHeaderModifier",
															"RequestMirror",
															"RequestRedirect",
															"URLRewrite",
															"ExtensionRef",
														]
														type: "string"
													}
													urlRewrite: {
														description: """
	URLRewrite defines a schema for a filter that modifies a request during forwarding.


	Support: Extended
	"""
														properties: {
															hostname: {
																description: """
	Hostname is the value to be used to replace the Host header value during
	forwarding.


	Support: Extended
	"""
																maxLength: 253
																minLength: 1
																pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															path: {
																description: """
	Path defines a path rewrite.


	Support: Extended
	"""
																properties: {
																	replaceFullPath: {
																		description: """
	ReplaceFullPath specifies the value with which to replace the full path
	of a request during a rewrite or redirect.
	"""
																		maxLength: 1024
																		type:      "string"
																	}
																	replacePrefixMatch: {
																		description: """
	ReplacePrefixMatch specifies the value with which to replace the prefix
	match of a request during a rewrite or redirect. For example, a request
	to "/foo/bar" with a prefix match of "/foo" and a ReplacePrefixMatch
	of "/xyz" would be modified to "/xyz/bar".


	Note that this matches the behavior of the PathPrefix match type. This
	matches full path elements. A path element refers to the list of labels
	in the path split by the `/` separator. When specified, a trailing `/` is
	ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all
	match the prefix `/abc`, but the path `/abcd` would not.


	ReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.
	Using any other HTTPRouteMatch type on the same HTTPRouteRule will result in
	the implementation setting the Accepted Condition for the Route to `status: False`.


	Request Path | Prefix Match | Replace Prefix | Modified Path
	-------------|--------------|----------------|----------
	/foo/bar     | /foo         | /xyz           | /xyz/bar
	/foo/bar     | /foo         | /xyz/          | /xyz/bar
	/foo/bar     | /foo/        | /xyz           | /xyz/bar
	/foo/bar     | /foo/        | /xyz/          | /xyz/bar
	/foo         | /foo         | /xyz           | /xyz
	/foo/        | /foo         | /xyz           | /xyz/
	/foo/bar     | /foo         | <empty string> | /bar
	/foo/        | /foo         | <empty string> | /
	/foo         | /foo         | <empty string> | /
	/foo/        | /foo         | /              | /
	/foo         | /foo         | /              | /
	"""
																		maxLength: 1024
																		type:      "string"
																	}
																	type: {
																		description: """
	Type defines the type of path modifier. Additional types may be
	added in a future release of the API.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.
	"""
																		enum: [
																			"ReplaceFullPath",
																			"ReplacePrefixMatch",
																		]
																		type: "string"
																	}
																}
																required: ["type"]
																type: "object"
																"x-kubernetes-validations": [{
																	message: "replaceFullPath must be specified when type is set to 'ReplaceFullPath'"
																	rule:    "self.type == 'ReplaceFullPath' ? has(self.replaceFullPath) : true"
																}, {
																	message: "type must be 'ReplaceFullPath' when replaceFullPath is set"
																	rule:    "has(self.replaceFullPath) ? self.type == 'ReplaceFullPath' : true"
																}, {
																	message: "replacePrefixMatch must be specified when type is set to 'ReplacePrefixMatch'"
																	rule:    "self.type == 'ReplacePrefixMatch' ? has(self.replacePrefixMatch) : true"
																}, {
																	message: "type must be 'ReplacePrefixMatch' when replacePrefixMatch is set"
																	rule:    "has(self.replacePrefixMatch) ? self.type == 'ReplacePrefixMatch' : true"
																}]
															}
														}
														type: "object"
													}
												}
												required: ["type"]
												type: "object"
												"x-kubernetes-validations": [{
													message: "filter.requestHeaderModifier must be nil if the filter.type is not RequestHeaderModifier"
													rule:    "!(has(self.requestHeaderModifier) && self.type != 'RequestHeaderModifier')"
												}, {
													message: "filter.requestHeaderModifier must be specified for RequestHeaderModifier filter.type"
													rule:    "!(!has(self.requestHeaderModifier) && self.type == 'RequestHeaderModifier')"
												}, {
													message: "filter.responseHeaderModifier must be nil if the filter.type is not ResponseHeaderModifier"
													rule:    "!(has(self.responseHeaderModifier) && self.type != 'ResponseHeaderModifier')"
												}, {
													message: "filter.responseHeaderModifier must be specified for ResponseHeaderModifier filter.type"
													rule:    "!(!has(self.responseHeaderModifier) && self.type == 'ResponseHeaderModifier')"
												}, {
													message: "filter.requestMirror must be nil if the filter.type is not RequestMirror"
													rule:    "!(has(self.requestMirror) && self.type != 'RequestMirror')"
												}, {
													message: "filter.requestMirror must be specified for RequestMirror filter.type"
													rule:    "!(!has(self.requestMirror) && self.type == 'RequestMirror')"
												}, {
													message: "filter.requestRedirect must be nil if the filter.type is not RequestRedirect"
													rule:    "!(has(self.requestRedirect) && self.type != 'RequestRedirect')"
												}, {
													message: "filter.requestRedirect must be specified for RequestRedirect filter.type"
													rule:    "!(!has(self.requestRedirect) && self.type == 'RequestRedirect')"
												}, {
													message: "filter.urlRewrite must be nil if the filter.type is not URLRewrite"
													rule:    "!(has(self.urlRewrite) && self.type != 'URLRewrite')"
												}, {
													message: "filter.urlRewrite must be specified for URLRewrite filter.type"
													rule:    "!(!has(self.urlRewrite) && self.type == 'URLRewrite')"
												}, {
													message: "filter.extensionRef must be nil if the filter.type is not ExtensionRef"
													rule:    "!(has(self.extensionRef) && self.type != 'ExtensionRef')"
												}, {
													message: "filter.extensionRef must be specified for ExtensionRef filter.type"
													rule:    "!(!has(self.extensionRef) && self.type == 'ExtensionRef')"
												}]
											}
											maxItems: 16
											type:     "array"
											"x-kubernetes-validations": [{
												message: "May specify either httpRouteFilterRequestRedirect or httpRouteFilterRequestRewrite, but not both"
												rule:    "!(self.exists(f, f.type == 'RequestRedirect') && self.exists(f, f.type == 'URLRewrite'))"
											}, {
												message: "RequestHeaderModifier filter cannot be repeated"
												rule:    "self.filter(f, f.type == 'RequestHeaderModifier').size() <= 1"
											}, {
												message: "ResponseHeaderModifier filter cannot be repeated"
												rule:    "self.filter(f, f.type == 'ResponseHeaderModifier').size() <= 1"
											}, {
												message: "RequestRedirect filter cannot be repeated"
												rule:    "self.filter(f, f.type == 'RequestRedirect').size() <= 1"
											}, {
												message: "URLRewrite filter cannot be repeated"
												rule:    "self.filter(f, f.type == 'URLRewrite').size() <= 1"
											}]
										}
										matches: {
											default: [{
												path: {
													type:  "PathPrefix"
													value: "/"
												}
											}]
											description: """
	Matches define conditions used for matching the rule against incoming
	HTTP requests. Each match is independent, i.e. this rule will be matched
	if **any** one of the matches is satisfied.


	For example, take the following matches configuration:


	```
	matches:
	- path:
	    value: "/foo"
	  headers:
	  - name: "version"
	    value: "v2"
	- path:
	    value: "/v2/foo"
	```


	For a request to match against this rule, a request must satisfy
	EITHER of the two conditions:


	- path prefixed with `/foo` AND contains the header `version: v2`
	- path prefix of `/v2/foo`


	See the documentation for HTTPRouteMatch on how to specify multiple
	match conditions that should be ANDed together.


	If no matches are specified, the default is a prefix
	path match on "/", which has the effect of matching every
	HTTP request.


	Proxy or Load Balancer routing configuration generated from HTTPRoutes
	MUST prioritize matches based on the following criteria, continuing on
	ties. Across all rules specified on applicable Routes, precedence must be
	given to the match having:


	* "Exact" path match.
	* "Prefix" path match with largest number of characters.
	* Method match.
	* Largest number of header matches.
	* Largest number of query param matches.


	Note: The precedence of RegularExpression path matches are implementation-specific.


	If ties still exist across multiple Routes, matching precedence MUST be
	determined in order of the following criteria, continuing on ties:


	* The oldest Route based on creation timestamp.
	* The Route appearing first in alphabetical order by
	  "{namespace}/{name}".


	If ties still exist within an HTTPRoute, matching precedence MUST be granted
	to the FIRST matching rule (in list order) with a match meeting the above
	criteria.


	When no rules matching a request have been successfully attached to the
	parent a request is coming from, a HTTP 404 status code MUST be returned.
	"""
											items: {
												description: """
	HTTPRouteMatch defines the predicate used to match requests to a given
	action. Multiple match types are ANDed together, i.e. the match will
	evaluate to true only if all conditions are satisfied.


	For example, the match below will match a HTTP request only if its path
	starts with `/foo` AND it contains the `version: v1` header:


	```
	match:


	\tpath:
	\t  value: "/foo"
	\theaders:
	\t- name: "version"
	\t  value "v1"


	```
	"""
												properties: {
													headers: {
														description: """
	Headers specifies HTTP request header matchers. Multiple match values are
	ANDed together, meaning, a request must match all the specified headers
	to select the route.
	"""
														items: {
															description: """
	HTTPHeaderMatch describes how to select a HTTP route by matching HTTP request
	headers.
	"""
															properties: {
																name: {
																	description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, only the first
	entry with an equivalent name MUST be considered for a match. Subsequent
	entries with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.


	When a header is repeated in an HTTP request, it is
	implementation-specific behavior as to how this is represented.
	Generally, proxies should follow the guidance from the RFC:
	https://www.rfc-editor.org/rfc/rfc7230.html#section-3.2.2 regarding
	processing a repeated header, with special handling for "Set-Cookie".
	"""
																	maxLength: 256
																	minLength: 1
																	pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																	type:      "string"
																}
																type: {
																	default: "Exact"
																	description: """
	Type specifies how to match against the value of the header.


	Support: Core (Exact)


	Support: Implementation-specific (RegularExpression)


	Since RegularExpression HeaderMatchType has implementation-specific
	conformance, implementations can support POSIX, PCRE or any other dialects
	of regular expressions. Please read the implementation's documentation to
	determine the supported dialect.
	"""
																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of HTTP Header to be matched."
																	maxLength:   4096
																	minLength:   1
																	type:        "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
													method: {
														description: """
	Method specifies HTTP method matcher.
	When specified, this route will be matched only if the request has the
	specified method.


	Support: Extended
	"""
														enum: [
															"GET",
															"HEAD",
															"POST",
															"PUT",
															"DELETE",
															"CONNECT",
															"OPTIONS",
															"TRACE",
															"PATCH",
														]
														type: "string"
													}
													path: {
														default: {
															type:  "PathPrefix"
															value: "/"
														}
														description: """
	Path specifies a HTTP request path matcher. If this field is not
	specified, a default prefix match on the "/" path is provided.
	"""
														properties: {
															type: {
																default: "PathPrefix"
																description: """
	Type specifies how to match against the path Value.


	Support: Core (Exact, PathPrefix)


	Support: Implementation-specific (RegularExpression)
	"""
																enum: [
																	"Exact",
																	"PathPrefix",
																	"RegularExpression",
																]
																type: "string"
															}
															value: {
																default:     "/"
																description: "Value of the HTTP path to match against."
																maxLength:   1024
																type:        "string"
															}
														}
														type: "object"
														"x-kubernetes-validations": [{
															message: "value must be an absolute path and start with '/' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? self.value.startsWith('/') : true"
														}, {
															message: "must not contain '//' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? !self.value.contains('//') : true"
														}, {
															message: "must not contain '/./' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? !self.value.contains('/./') : true"
														}, {
															message: "must not contain '/../' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? !self.value.contains('/../') : true"
														}, {
															message: "must not contain '%2f' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? !self.value.contains('%2f') : true"
														}, {
															message: "must not contain '%2F' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? !self.value.contains('%2F') : true"
														}, {
															message: "must not contain '#' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? !self.value.contains('#') : true"
														}, {
															message: "must not end with '/..' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? !self.value.endsWith('/..') : true"
														}, {
															message: "must not end with '/.' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? !self.value.endsWith('/.') : true"
														}, {
															message: "type must be one of ['Exact', 'PathPrefix', 'RegularExpression']"
															rule:    "self.type in ['Exact','PathPrefix'] || self.type == 'RegularExpression'"
														}, {
															message: "must only contain valid characters (matching ^(?:[-A-Za-z0-9/._~!$&'()*+,;=:@]|[%][0-9a-fA-F]{2})+$) for types ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? self.value.matches(r\"\"\"^(?:[-A-Za-z0-9/._~!$&'()*+,;=:@]|[%][0-9a-fA-F]{2})+$\"\"\") : true"
														}]
													}
													queryParams: {
														description: """
	QueryParams specifies HTTP query parameter matchers. Multiple match
	values are ANDed together, meaning, a request must match all the
	specified query parameters to select the route.


	Support: Extended
	"""
														items: {
															description: """
	HTTPQueryParamMatch describes how to select a HTTP route by matching HTTP
	query parameters.
	"""
															properties: {
																name: {
																	description: """
	Name is the name of the HTTP query param to be matched. This must be an
	exact string match. (See
	https://tools.ietf.org/html/rfc7230#section-2.7.3).


	If multiple entries specify equivalent query param names, only the first
	entry with an equivalent name MUST be considered for a match. Subsequent
	entries with an equivalent query param name MUST be ignored.


	If a query param is repeated in an HTTP request, the behavior is
	purposely left undefined, since different data planes have different
	capabilities. However, it is *recommended* that implementations should
	match against the first value of the param if the data plane supports it,
	as this behavior is expected in other load balancing contexts outside of
	the Gateway API.


	Users SHOULD NOT route traffic based on repeated query params to guard
	themselves against potential differences in the implementations.
	"""
																	maxLength: 256
																	minLength: 1
																	pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																	type:      "string"
																}
																type: {
																	default: "Exact"
																	description: """
	Type specifies how to match against the value of the query parameter.


	Support: Extended (Exact)


	Support: Implementation-specific (RegularExpression)


	Since RegularExpression QueryParamMatchType has Implementation-specific
	conformance, implementations can support POSIX, PCRE or any other
	dialects of regular expressions. Please read the implementation's
	documentation to determine the supported dialect.
	"""
																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of HTTP query param to be matched."
																	maxLength:   1024
																	minLength:   1
																	type:        "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
												}
												type: "object"
											}
											maxItems: 8
											type:     "array"
										}
										sessionPersistence: {
											description: """
	SessionPersistence defines and configures session persistence
	for the route rule.


	Support: Extended



	"""
											properties: {
												absoluteTimeout: {
													description: """
	AbsoluteTimeout defines the absolute timeout of the persistent
	session. Once the AbsoluteTimeout duration has elapsed, the
	session becomes invalid.


	Support: Extended
	"""
													pattern: "^([0-9]{1,5}(h|m|s|ms)){1,4}$"
													type:    "string"
												}
												cookieConfig: {
													description: """
	CookieConfig provides configuration settings that are specific
	to cookie-based session persistence.


	Support: Core
	"""
													properties: lifetimeType: {
														default: "Session"
														description: """
	LifetimeType specifies whether the cookie has a permanent or
	session-based lifetime. A permanent cookie persists until its
	specified expiry time, defined by the Expires or Max-Age cookie
	attributes, while a session cookie is deleted when the current
	session ends.


	When set to "Permanent", AbsoluteTimeout indicates the
	cookie's lifetime via the Expires or Max-Age cookie attributes
	and is required.


	When set to "Session", AbsoluteTimeout indicates the
	absolute lifetime of the cookie tracked by the gateway and
	is optional.


	Support: Core for "Session" type


	Support: Extended for "Permanent" type
	"""
														enum: [
															"Permanent",
															"Session",
														]
														type: "string"
													}
													type: "object"
												}
												idleTimeout: {
													description: """
	IdleTimeout defines the idle timeout of the persistent session.
	Once the session has been idle for more than the specified
	IdleTimeout duration, the session becomes invalid.


	Support: Extended
	"""
													pattern: "^([0-9]{1,5}(h|m|s|ms)){1,4}$"
													type:    "string"
												}
												sessionName: {
													description: """
	SessionName defines the name of the persistent session token
	which may be reflected in the cookie or the header. Users
	should avoid reusing session names to prevent unintended
	consequences, such as rejection or unpredictable behavior.


	Support: Implementation-specific
	"""
													maxLength: 128
													type:      "string"
												}
												type: {
													default: "Cookie"
													description: """
	Type defines the type of session persistence such as through
	the use a header or cookie. Defaults to cookie based session
	persistence.


	Support: Core for "Cookie" type


	Support: Extended for "Header" type
	"""
													enum: [
														"Cookie",
														"Header",
													]
													type: "string"
												}
											}
											type: "object"
											"x-kubernetes-validations": [{
												message: "AbsoluteTimeout must be specified when cookie lifetimeType is Permanent"
												rule:    "!has(self.cookieConfig.lifetimeType) || self.cookieConfig.lifetimeType != 'Permanent' || has(self.absoluteTimeout)"
											}]
										}
										timeouts: {
											description: """
	Timeouts defines the timeouts that can be configured for an HTTP request.


	Support: Extended



	"""
											properties: {
												backendRequest: {
													description: """
	BackendRequest specifies a timeout for an individual request from the gateway
	to a backend. This covers the time from when the request first starts being
	sent from the gateway to when the full response has been received from the backend.


	Setting a timeout to the zero duration (e.g. "0s") SHOULD disable the timeout
	completely. Implementations that cannot completely disable the timeout MUST
	instead interpret the zero duration as the longest possible value to which
	the timeout can be set.


	An entire client HTTP transaction with a gateway, covered by the Request timeout,
	may result in more than one call from the gateway to the destination backend,
	for example, if automatic retries are supported.


	Because the Request timeout encompasses the BackendRequest timeout, the value of
	BackendRequest must be <= the value of Request timeout.


	Support: Extended
	"""
													pattern: "^([0-9]{1,5}(h|m|s|ms)){1,4}$"
													type:    "string"
												}
												request: {
													description: """
	Request specifies the maximum duration for a gateway to respond to an HTTP request.
	If the gateway has not been able to respond before this deadline is met, the gateway
	MUST return a timeout error.


	For example, setting the `rules.timeouts.request` field to the value `10s` in an
	`HTTPRoute` will cause a timeout if a client request is taking longer than 10 seconds
	to complete.


	Setting a timeout to the zero duration (e.g. "0s") SHOULD disable the timeout
	completely. Implementations that cannot completely disable the timeout MUST
	instead interpret the zero duration as the longest possible value to which
	the timeout can be set.


	This timeout is intended to cover as close to the whole request-response transaction
	as possible although an implementation MAY choose to start the timeout after the entire
	request stream has been received instead of immediately after the transaction is
	initiated by the client.


	When this field is unspecified, request timeout behavior is implementation-specific.


	Support: Extended
	"""
													pattern: "^([0-9]{1,5}(h|m|s|ms)){1,4}$"
													type:    "string"
												}
											}
											type: "object"
											"x-kubernetes-validations": [{
												message: "backendRequest timeout cannot be longer than request timeout"
												rule:    "!(has(self.request) && has(self.backendRequest) && duration(self.request) != duration('0s') && duration(self.backendRequest) > duration(self.request))"
											}]
										}
									}
									type: "object"
									"x-kubernetes-validations": [{
										message: "RequestRedirect filter must not be used together with backendRefs"
										rule:    "(has(self.backendRefs) && size(self.backendRefs) > 0) ? (!has(self.filters) || self.filters.all(f, !has(f.requestRedirect))): true"
									}, {
										message: "When using RequestRedirect filter with path.replacePrefixMatch, exactly one PathPrefix match must be specified"
										rule:    "(has(self.filters) && self.filters.exists_one(f, has(f.requestRedirect) && has(f.requestRedirect.path) && f.requestRedirect.path.type == 'ReplacePrefixMatch' && has(f.requestRedirect.path.replacePrefixMatch))) ? ((size(self.matches) != 1 || !has(self.matches[0].path) || self.matches[0].path.type != 'PathPrefix') ? false : true) : true"
									}, {
										message: "When using URLRewrite filter with path.replacePrefixMatch, exactly one PathPrefix match must be specified"
										rule:    "(has(self.filters) && self.filters.exists_one(f, has(f.urlRewrite) && has(f.urlRewrite.path) && f.urlRewrite.path.type == 'ReplacePrefixMatch' && has(f.urlRewrite.path.replacePrefixMatch))) ? ((size(self.matches) != 1 || !has(self.matches[0].path) || self.matches[0].path.type != 'PathPrefix') ? false : true) : true"
									}, {
										message: "Within backendRefs, when using RequestRedirect filter with path.replacePrefixMatch, exactly one PathPrefix match must be specified"
										rule:    "(has(self.backendRefs) && self.backendRefs.exists_one(b, (has(b.filters) && b.filters.exists_one(f, has(f.requestRedirect) && has(f.requestRedirect.path) && f.requestRedirect.path.type == 'ReplacePrefixMatch' && has(f.requestRedirect.path.replacePrefixMatch))) )) ? ((size(self.matches) != 1 || !has(self.matches[0].path) || self.matches[0].path.type != 'PathPrefix') ? false : true) : true"
									}, {
										message: "Within backendRefs, When using URLRewrite filter with path.replacePrefixMatch, exactly one PathPrefix match must be specified"
										rule:    "(has(self.backendRefs) && self.backendRefs.exists_one(b, (has(b.filters) && b.filters.exists_one(f, has(f.urlRewrite) && has(f.urlRewrite.path) && f.urlRewrite.path.type == 'ReplacePrefixMatch' && has(f.urlRewrite.path.replacePrefixMatch))) )) ? ((size(self.matches) != 1 || !has(self.matches[0].path) || self.matches[0].path.type != 'PathPrefix') ? false : true) : true"
									}]
								}
								maxItems: 16
								type:     "array"
							}
						}
						type: "object"
					}
					status: {
						description: "Status defines the current state of HTTPRoute."
						properties: parents: {
							description: """
	Parents is a list of parent resources (usually Gateways) that are
	associated with the route, and the status of the route with respect to
	each parent. When this route attaches to a parent, the controller that
	manages the parent must add an entry to this list when the controller
	first sees the route and should update the entry as appropriate when the
	route or gateway is modified.


	Note that parent references that cannot be resolved by an implementation
	of this API will not be added to this list. Implementations of this API
	can only populate Route status for the Gateways/parent resources they are
	responsible for.


	A maximum of 32 Gateways will be represented in this list. An empty list
	means the route has not been attached to any Gateway.
	"""
							items: {
								description: """
	RouteParentStatus describes the status of a route with respect to an
	associated Parent.
	"""
								properties: {
									conditions: {
										description: """
	Conditions describes the status of the route with respect to the Gateway.
	Note that the route's availability is also subject to the Gateway's own
	status conditions and listener status.


	If the Route's ParentRef specifies an existing Gateway that supports
	Routes of this kind AND that Gateway's controller has sufficient access,
	then that Gateway's controller MUST set the "Accepted" condition on the
	Route, to indicate whether the route has been accepted or rejected by the
	Gateway, and why.


	A Route MUST be considered "Accepted" if at least one of the Route's
	rules is implemented by the Gateway.


	There are a number of cases where the "Accepted" condition may not be set
	due to lack of controller visibility, that includes when:


	* The Route refers to a non-existent parent.
	* The Route is of a type that the controller does not support.
	* The Route is in a namespace the controller does not have access to.
	"""
										items: {
											description: """
	Condition contains details for one aspect of the current state of this API Resource.
	---
	This struct is intended for direct use as an array at the field path .status.conditions.  For example,


	\ttype FooStatus struct{
	\t    // Represents the observations of a foo's current state.
	\t    // Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
	\t    // +patchMergeKey=type
	\t    // +patchStrategy=merge
	\t    // +listType=map
	\t    // +listMapKey=type
	\t    Conditions []metav1.Condition `json:"conditions,omitempty" patchStrategy:"merge" patchMergeKey:"type" protobuf:"bytes,1,rep,name=conditions"`


	\t    // other fields
	\t}
	"""
											properties: {
												lastTransitionTime: {
													description: """
	lastTransitionTime is the last time the condition transitioned from one status to another.
	This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
	"""
													format: "date-time"
													type:   "string"
												}
												message: {
													description: """
	message is a human readable message indicating details about the transition.
	This may be an empty string.
	"""
													maxLength: 32768
													type:      "string"
												}
												observedGeneration: {
													description: """
	observedGeneration represents the .metadata.generation that the condition was set based upon.
	For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
	with respect to the current state of the instance.
	"""
													format:  "int64"
													minimum: 0
													type:    "integer"
												}
												reason: {
													description: """
	reason contains a programmatic identifier indicating the reason for the condition's last transition.
	Producers of specific condition types may define expected values and meanings for this field,
	and whether the values are considered a guaranteed API.
	The value should be a CamelCase string.
	This field may not be empty.
	"""
													maxLength: 1024
													minLength: 1
													pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
													type:      "string"
												}
												status: {
													description: "status of the condition, one of True, False, Unknown."
													enum: [
														"True",
														"False",
														"Unknown",
													]
													type: "string"
												}
												type: {
													description: """
	type of condition in CamelCase or in foo.example.com/CamelCase.
	---
	Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be
	useful (see .node.status.conditions), the ability to deconflict is important.
	The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)
	"""
													maxLength: 316
													pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
													type:      "string"
												}
											}
											required: [
												"lastTransitionTime",
												"message",
												"reason",
												"status",
												"type",
											]
											type: "object"
										}
										maxItems: 8
										minItems: 1
										type:     "array"
										"x-kubernetes-list-map-keys": ["type"]
										"x-kubernetes-list-type": "map"
									}
									controllerName: {
										description: """
	ControllerName is a domain/path string that indicates the name of the
	controller that wrote this status. This corresponds with the
	controllerName field on GatewayClass.


	Example: "example.net/gateway-controller".


	The format of this field is DOMAIN "/" PATH, where DOMAIN and PATH are
	valid Kubernetes names
	(https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).


	Controllers MUST populate this field when writing status. Controllers should ensure that
	entries to status populated with their ControllerName are cleaned up when they are no
	longer necessary.
	"""
										maxLength: 253
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
										type:      "string"
									}
									parentRef: {
										description: """
	ParentRef corresponds with a ParentRef in the spec that this
	RouteParentStatus struct describes the status of.
	"""
										properties: {
											group: {
												default: "gateway.networking.k8s.io"
												description: """
	Group is the group of the referent.
	When unspecified, "gateway.networking.k8s.io" is inferred.
	To set the core API group (such as for a "Service" kind referent),
	Group must be explicitly set to "" (empty string).


	Support: Core
	"""
												maxLength: 253
												pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
											kind: {
												default: "Gateway"
												description: """
	Kind is kind of the referent.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	Support for other resources is Implementation-Specific.
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:      "string"
											}
											name: {
												description: """
	Name is the name of the referent.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												type:      "string"
											}
											namespace: {
												description: """
	Namespace is the namespace of the referent. When unspecified, this refers
	to the local namespace of the Route.


	Note that there are specific rules for ParentRefs which cross namespace
	boundaries. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example:
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable any other kind of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.



	Support: Core
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
												type:      "string"
											}
											port: {
												description: """
	Port is the network port this Route targets. It can be interpreted
	differently based on the type of parent resource.


	When the parent resource is a Gateway, this targets all listeners
	listening on the specified port that also support this kind of Route(and
	select this Route). It's not recommended to set `Port` unless the
	networking behaviors specified in a Route must apply to a specific port
	as opposed to a listener(s) whose port(s) may be changed. When both Port
	and SectionName are specified, the name and port of the selected listener
	must match both specified values.



	When the parent resource is a Service, this targets a specific port in the
	Service spec. When both Port (experimental) and SectionName are specified,
	the name and port of the selected port must match both specified values.



	Implementations MAY choose to support other parent resources.
	Implementations supporting other types of parent resources MUST clearly
	document how/if Port is interpreted.


	For the purpose of status, an attachment is considered successful as
	long as the parent resource accepts it partially. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
	from the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route,
	the Route MUST be considered detached from the Gateway.


	Support: Extended
	"""
												format:  "int32"
												maximum: 65535
												minimum: 1
												type:    "integer"
											}
											sectionName: {
												description: """
	SectionName is the name of a section within the target resource. In the
	following resources, SectionName is interpreted as the following:


	* Gateway: Listener name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.
	* Service: Port name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.


	Implementations MAY choose to support attaching Routes to other resources.
	If that is the case, they MUST clearly document how SectionName is
	interpreted.


	When unspecified (empty string), this will reference the entire resource.
	For the purpose of status, an attachment is considered successful if at
	least one section in the parent resource accepts it. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
	the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route, the
	Route MUST be considered detached from the Gateway.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
										}
										required: ["name"]
										type: "object"
									}
								}
								required: [
									"controllerName",
									"parentRef",
								]
								type: "object"
							}
							maxItems: 32
							type:     "array"
						}
						required: ["parents"]
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".spec.hostnames"
				name:     "Hostnames"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: """
					HTTPRoute provides a way to route HTTP requests. This includes the capability
					to match requests by hostname, path, header, or query param. Filters can be
					used to specify additional processing steps. Backends specify where matching
					requests should be routed.
					"""
				properties: {
					apiVersion: {
						description: """
	APIVersion defines the versioned schema of this representation of an object.
	Servers should convert recognized schemas to the latest internal value, and
	may reject unrecognized values.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	"""
						type: "string"
					}
					kind: {
						description: """
	Kind is a string value representing the REST resource this object represents.
	Servers may infer this from the endpoint the client submits requests to.
	Cannot be updated.
	In CamelCase.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	"""
						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec defines the desired state of HTTPRoute."
						properties: {
							hostnames: {
								description: """
	Hostnames defines a set of hostnames that should match against the HTTP Host
	header to select a HTTPRoute used to process the request. Implementations
	MUST ignore any port value specified in the HTTP Host header while
	performing a match and (absent of any applicable header modification
	configuration) MUST forward this header unmodified to the backend.


	Valid values for Hostnames are determined by RFC 1123 definition of a
	hostname with 2 notable exceptions:


	1. IPs are not allowed.
	2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard
	   label must appear by itself as the first label.


	If a hostname is specified by both the Listener and HTTPRoute, there
	must be at least one intersecting hostname for the HTTPRoute to be
	attached to the Listener. For example:


	* A Listener with `test.example.com` as the hostname matches HTTPRoutes
	  that have either not specified any hostnames, or have specified at
	  least one of `test.example.com` or `*.example.com`.
	* A Listener with `*.example.com` as the hostname matches HTTPRoutes
	  that have either not specified any hostnames or have specified at least
	  one hostname that matches the Listener hostname. For example,
	  `*.example.com`, `test.example.com`, and `foo.test.example.com` would
	  all match. On the other hand, `example.com` and `test.example.net` would
	  not match.


	Hostnames that are prefixed with a wildcard label (`*.`) are interpreted
	as a suffix match. That means that a match for `*.example.com` would match
	both `test.example.com`, and `foo.test.example.com`, but not `example.com`.


	If both the Listener and HTTPRoute have specified hostnames, any
	HTTPRoute hostnames that do not match the Listener hostname MUST be
	ignored. For example, if a Listener specified `*.example.com`, and the
	HTTPRoute specified `test.example.com` and `test.example.net`,
	`test.example.net` must not be considered for a match.


	If both the Listener and HTTPRoute have specified hostnames, and none
	match with the criteria above, then the HTTPRoute is not accepted. The
	implementation must raise an 'Accepted' Condition with a status of
	`False` in the corresponding RouteParentStatus.


	In the event that multiple HTTPRoutes specify intersecting hostnames (e.g.
	overlapping wildcard matching and exact matching hostnames), precedence must
	be given to rules from the HTTPRoute with the largest number of:


	* Characters in a matching non-wildcard hostname.
	* Characters in a matching hostname.


	If ties exist across multiple Routes, the matching precedence rules for
	HTTPRouteMatches takes over.


	Support: Core
	"""
								items: {
									description: """
	Hostname is the fully qualified domain name of a network host. This matches
	the RFC 1123 definition of a hostname with 2 notable exceptions:


	 1. IPs are not allowed.
	 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard
	    label must appear by itself as the first label.


	Hostname can be "precise" which is a domain name without the terminating
	dot of a network host (e.g. "foo.example.com") or "wildcard", which is a
	domain name prefixed with a single wildcard label (e.g. `*.example.com`).


	Note that as per RFC1035 and RFC1123, a *label* must consist of lower case
	alphanumeric characters or '-', and must start and end with an alphanumeric
	character. No other punctuation is allowed.
	"""
									maxLength: 253
									minLength: 1
									pattern:   "^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
									type:      "string"
								}
								maxItems: 16
								type:     "array"
							}
							parentRefs: {
								description: """
	ParentRefs references the resources (usually Gateways) that a Route wants
	to be attached to. Note that the referenced parent resource needs to
	allow this for the attachment to be complete. For Gateways, that means
	the Gateway needs to allow attachment from Routes of this kind and
	namespace. For Services, that means the Service must either be in the same
	namespace for a "producer" route, or the mesh implementation must support
	and allow "consumer" routes for the referenced Service. ReferenceGrant is
	not applicable for governing ParentRefs to Services - it is not possible to
	create a "producer" route for a Service in a different namespace from the
	Route.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	This API may be extended in the future to support additional kinds of parent
	resources.


	ParentRefs must be _distinct_. This means either that:


	* They select different objects.  If this is the case, then parentRef
	  entries are distinct. In terms of fields, this means that the
	  multi-part key defined by `group`, `kind`, `namespace`, and `name` must
	  be unique across all parentRef entries in the Route.
	* They do not select different objects, but for each optional field used,
	  each ParentRef that selects the same object must set the same set of
	  optional fields to different values. If one ParentRef sets a
	  combination of optional fields, all must set the same combination.


	Some examples:


	* If one ParentRef sets `sectionName`, all ParentRefs referencing the
	  same object must also set `sectionName`.
	* If one ParentRef sets `port`, all ParentRefs referencing the same
	  object must also set `port`.
	* If one ParentRef sets `sectionName` and `port`, all ParentRefs
	  referencing the same object must also set `sectionName` and `port`.


	It is possible to separately reference multiple distinct objects that may
	be collapsed by an implementation. For example, some implementations may
	choose to merge compatible Gateway Listeners together. If that is the
	case, the list of routes attached to those resources should also be
	merged.


	Note that for ParentRefs that cross namespace boundaries, there are specific
	rules. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example,
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable other kinds of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.







	"""
								items: {
									description: """
	ParentReference identifies an API object (usually a Gateway) that can be considered
	a parent of this resource (usually a route). There are two kinds of parent resources
	with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	This API may be extended in the future to support additional kinds of parent
	resources.


	The API object must be valid in the cluster; the Group and Kind must
	be registered in the cluster for this reference to be valid.
	"""
									properties: {
										group: {
											default: "gateway.networking.k8s.io"
											description: """
	Group is the group of the referent.
	When unspecified, "gateway.networking.k8s.io" is inferred.
	To set the core API group (such as for a "Service" kind referent),
	Group must be explicitly set to "" (empty string).


	Support: Core
	"""
											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											default: "Gateway"
											description: """
	Kind is kind of the referent.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	Support for other resources is Implementation-Specific.
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										name: {
											description: """
	Name is the name of the referent.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: """
	Namespace is the namespace of the referent. When unspecified, this refers
	to the local namespace of the Route.


	Note that there are specific rules for ParentRefs which cross namespace
	boundaries. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example:
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable any other kind of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.



	Support: Core
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
											type:      "string"
										}
										port: {
											description: """
	Port is the network port this Route targets. It can be interpreted
	differently based on the type of parent resource.


	When the parent resource is a Gateway, this targets all listeners
	listening on the specified port that also support this kind of Route(and
	select this Route). It's not recommended to set `Port` unless the
	networking behaviors specified in a Route must apply to a specific port
	as opposed to a listener(s) whose port(s) may be changed. When both Port
	and SectionName are specified, the name and port of the selected listener
	must match both specified values.



	When the parent resource is a Service, this targets a specific port in the
	Service spec. When both Port (experimental) and SectionName are specified,
	the name and port of the selected port must match both specified values.



	Implementations MAY choose to support other parent resources.
	Implementations supporting other types of parent resources MUST clearly
	document how/if Port is interpreted.


	For the purpose of status, an attachment is considered successful as
	long as the parent resource accepts it partially. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
	from the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route,
	the Route MUST be considered detached from the Gateway.


	Support: Extended
	"""
											format:  "int32"
											maximum: 65535
											minimum: 1
											type:    "integer"
										}
										sectionName: {
											description: """
	SectionName is the name of a section within the target resource. In the
	following resources, SectionName is interpreted as the following:


	* Gateway: Listener name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.
	* Service: Port name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.


	Implementations MAY choose to support attaching Routes to other resources.
	If that is the case, they MUST clearly document how SectionName is
	interpreted.


	When unspecified (empty string), this will reference the entire resource.
	For the purpose of status, an attachment is considered successful if at
	least one section in the parent resource accepts it. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
	the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route, the
	Route MUST be considered detached from the Gateway.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								maxItems: 32
								type:     "array"
								"x-kubernetes-validations": [{
									message: "sectionName or port must be specified when parentRefs includes 2 or more references to the same parent"
									rule:    "self.all(p1, self.all(p2, p1.group == p2.group && p1.kind == p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) || p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ == '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__ == p2.__namespace__)) ? ((!has(p1.sectionName) || p1.sectionName == '') == (!has(p2.sectionName) || p2.sectionName == '') && (!has(p1.port) || p1.port == 0) == (!has(p2.port) || p2.port == 0)): true))"
								}, {
									message: "sectionName or port must be unique when parentRefs includes 2 or more references to the same parent"
									rule:    "self.all(p1, self.exists_one(p2, p1.group == p2.group && p1.kind == p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) || p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ == '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__ == p2.__namespace__ )) && (((!has(p1.sectionName) || p1.sectionName == '') && (!has(p2.sectionName) || p2.sectionName == '')) || ( has(p1.sectionName) && has(p2.sectionName) && p1.sectionName == p2.sectionName)) && (((!has(p1.port) || p1.port == 0) && (!has(p2.port) || p2.port == 0)) || (has(p1.port) && has(p2.port) && p1.port == p2.port))))"
								}]
							}
							rules: {
								default: [{
									matches: [{
										path: {
											type:  "PathPrefix"
											value: "/"
										}
									}]
								}]
								description: "Rules are a list of HTTP matchers, filters and actions."
								items: {
									description: """
	HTTPRouteRule defines semantics for matching an HTTP request based on
	conditions (matches), processing it (filters), and forwarding the request to
	an API object (backendRefs).
	"""
									properties: {
										backendRefs: {
											description: """
	BackendRefs defines the backend(s) where matching requests should be
	sent.


	Failure behavior here depends on how many BackendRefs are specified and
	how many are invalid.


	If *all* entries in BackendRefs are invalid, and there are also no filters
	specified in this route rule, *all* traffic which matches this rule MUST
	receive a 500 status code.


	See the HTTPBackendRef definition for the rules about what makes a single
	HTTPBackendRef invalid.


	When a HTTPBackendRef is invalid, 500 status codes MUST be returned for
	requests that would have otherwise been routed to an invalid backend. If
	multiple backends are specified, and some are invalid, the proportion of
	requests that would otherwise have been routed to an invalid backend
	MUST receive a 500 status code.


	For example, if two backends are specified with equal weights, and one is
	invalid, 50 percent of traffic must receive a 500. Implementations may
	choose how that 50 percent is determined.


	Support: Core for Kubernetes Service


	Support: Extended for Kubernetes ServiceImport


	Support: Implementation-specific for any other resource


	Support for weight: Core
	"""
											items: {
												description: """
	HTTPBackendRef defines how a HTTPRoute forwards a HTTP request.


	Note that when a namespace different than the local namespace is specified, a
	ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	<gateway:experimental:description>


	When the BackendRef points to a Kubernetes Service, implementations SHOULD
	honor the appProtocol field if it is set for the target Service Port.


	Implementations supporting appProtocol SHOULD recognize the Kubernetes
	Standard Application Protocols defined in KEP-3726.


	If a Service appProtocol isn't specified, an implementation MAY infer the
	backend protocol through its own means. Implementations MAY infer the
	protocol from the Route type referring to the backend Service.


	If a Route is not able to send traffic to the backend using the specified
	protocol then the backend is considered invalid. Implementations MUST set the
	"ResolvedRefs" condition to "False" with the "UnsupportedProtocol" reason.


	</gateway:experimental:description>
	"""
												properties: {
													filters: {
														description: """
	Filters defined at this level should be executed if and only if the
	request is being forwarded to the backend defined here.


	Support: Implementation-specific (For broader support of filters, use the
	Filters field in HTTPRouteRule.)
	"""
														items: {
															description: """
	HTTPRouteFilter defines processing steps that must be completed during the
	request or response lifecycle. HTTPRouteFilters are meant as an extension
	point to express processing that may be done in Gateway implementations. Some
	examples include request or response modification, implementing
	authentication strategies, rate-limiting, and traffic shaping. API
	guarantee/conformance is defined based on the type of the filter.
	"""
															properties: {
																extensionRef: {
																	description: """
	ExtensionRef is an optional, implementation-specific extension to the
	"filter" behavior.  For example, resource "myroutefilter" in group
	"networking.example.net"). ExtensionRef MUST NOT be used for core and
	extended filters.


	This filter can be used multiple times within the same rule.


	Support: Implementation-specific
	"""
																	properties: {
																		group: {
																			description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																			maxLength: 253
																			pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		kind: {
																			description: "Kind is kind of the referent. For example \"HTTPRoute\" or \"Service\"."
																			maxLength:   63
																			minLength:   1
																			pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																			type:        "string"
																		}
																		name: {
																			description: "Name is the name of the referent."
																			maxLength:   253
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"group",
																		"kind",
																		"name",
																	]
																	type: "object"
																}
																requestHeaderModifier: {
																	description: """
	RequestHeaderModifier defines a schema for a filter that modifies request
	headers.


	Support: Core
	"""
																	properties: {
																		add: {
																			description: """
	Add adds the given header(s) (name, value) to the request
	before the action. It appends to any existing values associated
	with the header name.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  add:
	  - name: "my-header"
	    value: "bar,baz"


	Output:
	  GET /foo HTTP/1.1
	  my-header: foo,bar,baz
	"""
																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																				properties: {
																					name: {
																						description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."
																						maxLength:   4096
																						minLength:   1
																						type:        "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
	Remove the given header(s) from the HTTP request before the action. The
	value of Remove is a list of HTTP header names. Note that the header
	names are case-insensitive (see
	https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).


	Input:
	  GET /foo HTTP/1.1
	  my-header1: foo
	  my-header2: bar
	  my-header3: baz


	Config:
	  remove: ["my-header1", "my-header3"]


	Output:
	  GET /foo HTTP/1.1
	  my-header2: bar
	"""
																			items: type: "string"
																			maxItems:                 16
																			type:                     "array"
																			"x-kubernetes-list-type": "set"
																		}
																		set: {
																			description: """
	Set overwrites the request with the given header (name, value)
	before the action.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  set:
	  - name: "my-header"
	    value: "bar"


	Output:
	  GET /foo HTTP/1.1
	  my-header: bar
	"""
																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																				properties: {
																					name: {
																						description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."
																						maxLength:   4096
																						minLength:   1
																						type:        "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																requestMirror: {
																	description: """
	RequestMirror defines a schema for a filter that mirrors requests.
	Requests are sent to the specified destination, but responses from
	that destination are ignored.


	This filter can be used multiple times within the same rule. Note that
	not all implementations will be able to support mirroring to multiple
	backends.


	Support: Extended
	"""
																	properties: backendRef: {
																		description: """
	BackendRef references a resource where mirrored requests are sent.


	Mirrored requests must be sent only to a single destination endpoint
	within this BackendRef, irrespective of how many endpoints are present
	within this BackendRef.


	If the referent cannot be found, this BackendRef is invalid and must be
	dropped from the Gateway. The controller must ensure the "ResolvedRefs"
	condition on the Route status is set to `status: False` and not configure
	this backend in the underlying implementation.


	If there is a cross-namespace reference to an *existing* object
	that is not allowed by a ReferenceGrant, the controller must ensure the
	"ResolvedRefs"  condition on the Route is set to `status: False`,
	with the "RefNotPermitted" reason and not configure this backend in the
	underlying implementation.


	In either error case, the Message of the `ResolvedRefs` Condition
	should be used to provide more detail about the problem.


	Support: Extended for Kubernetes Service


	Support: Implementation-specific for any other resource
	"""
																		properties: {
																			group: {
																				default: ""
																				description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																				maxLength: 253
																				pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																				type:      "string"
																			}
																			kind: {
																				default: "Service"
																				description: """
	Kind is the Kubernetes resource kind of the referent. For example
	"Service".


	Defaults to "Service" when not specified.


	ExternalName services can refer to CNAME DNS records that may live
	outside of the cluster and as such are difficult to reason about in
	terms of conformance. They also may not be safe to forward to (see
	CVE-2021-25740 for more information). Implementations SHOULD NOT
	support ExternalName Services.


	Support: Core (Services with a type other than ExternalName)


	Support: Implementation-specific (Services with type ExternalName)
	"""
																				maxLength: 63
																				minLength: 1
																				pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																				type:      "string"
																			}
																			name: {
																				description: "Name is the name of the referent."
																				maxLength:   253
																				minLength:   1
																				type:        "string"
																			}
																			namespace: {
																				description: """
	Namespace is the namespace of the backend. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
																				maxLength: 63
																				minLength: 1
																				pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
																				type:      "string"
																			}
																			port: {
																				description: """
	Port specifies the destination port number to use for this resource.
	Port is required when the referent is a Kubernetes Service. In this
	case, the port number is the service port number, not the target port.
	For other resources, destination port might be derived from the referent
	resource or this field.
	"""
																				format:  "int32"
																				maximum: 65535
																				minimum: 1
																				type:    "integer"
																			}
																		}
																		required: ["name"]
																		type: "object"
																		"x-kubernetes-validations": [{
																			message: "Must have port for Service reference"
																			rule:    "(size(self.group) == 0 && self.kind == 'Service') ? has(self.port) : true"
																		}]
																	}
																	required: ["backendRef"]
																	type: "object"
																}
																requestRedirect: {
																	description: """
	RequestRedirect defines a schema for a filter that responds to the
	request with an HTTP redirection.


	Support: Core
	"""
																	properties: {
																		hostname: {
																			description: """
	Hostname is the hostname to be used in the value of the `Location`
	header in the response.
	When empty, the hostname in the `Host` header of the request is used.


	Support: Core
	"""
																			maxLength: 253
																			minLength: 1
																			pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		path: {
																			description: """
	Path defines parameters used to modify the path of the incoming request.
	The modified path is then used to construct the `Location` header. When
	empty, the request path is used as-is.


	Support: Extended
	"""
																			properties: {
																				replaceFullPath: {
																					description: """
	ReplaceFullPath specifies the value with which to replace the full path
	of a request during a rewrite or redirect.
	"""
																					maxLength: 1024
																					type:      "string"
																				}
																				replacePrefixMatch: {
																					description: """
	ReplacePrefixMatch specifies the value with which to replace the prefix
	match of a request during a rewrite or redirect. For example, a request
	to "/foo/bar" with a prefix match of "/foo" and a ReplacePrefixMatch
	of "/xyz" would be modified to "/xyz/bar".


	Note that this matches the behavior of the PathPrefix match type. This
	matches full path elements. A path element refers to the list of labels
	in the path split by the `/` separator. When specified, a trailing `/` is
	ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all
	match the prefix `/abc`, but the path `/abcd` would not.


	ReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.
	Using any other HTTPRouteMatch type on the same HTTPRouteRule will result in
	the implementation setting the Accepted Condition for the Route to `status: False`.


	Request Path | Prefix Match | Replace Prefix | Modified Path
	-------------|--------------|----------------|----------
	/foo/bar     | /foo         | /xyz           | /xyz/bar
	/foo/bar     | /foo         | /xyz/          | /xyz/bar
	/foo/bar     | /foo/        | /xyz           | /xyz/bar
	/foo/bar     | /foo/        | /xyz/          | /xyz/bar
	/foo         | /foo         | /xyz           | /xyz
	/foo/        | /foo         | /xyz           | /xyz/
	/foo/bar     | /foo         | <empty string> | /bar
	/foo/        | /foo         | <empty string> | /
	/foo         | /foo         | <empty string> | /
	/foo/        | /foo         | /              | /
	/foo         | /foo         | /              | /
	"""
																					maxLength: 1024
																					type:      "string"
																				}
																				type: {
																					description: """
	Type defines the type of path modifier. Additional types may be
	added in a future release of the API.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.
	"""
																					enum: [
																						"ReplaceFullPath",
																						"ReplacePrefixMatch",
																					]
																					type: "string"
																				}
																			}
																			required: ["type"]
																			type: "object"
																			"x-kubernetes-validations": [{
																				message: "replaceFullPath must be specified when type is set to 'ReplaceFullPath'"
																				rule:    "self.type == 'ReplaceFullPath' ? has(self.replaceFullPath) : true"
																			}, {
																				message: "type must be 'ReplaceFullPath' when replaceFullPath is set"
																				rule:    "has(self.replaceFullPath) ? self.type == 'ReplaceFullPath' : true"
																			}, {
																				message: "replacePrefixMatch must be specified when type is set to 'ReplacePrefixMatch'"
																				rule:    "self.type == 'ReplacePrefixMatch' ? has(self.replacePrefixMatch) : true"
																			}, {
																				message: "type must be 'ReplacePrefixMatch' when replacePrefixMatch is set"
																				rule:    "has(self.replacePrefixMatch) ? self.type == 'ReplacePrefixMatch' : true"
																			}]
																		}
																		port: {
																			description: """
	Port is the port to be used in the value of the `Location`
	header in the response.


	If no port is specified, the redirect port MUST be derived using the
	following rules:


	* If redirect scheme is not-empty, the redirect port MUST be the well-known
	  port associated with the redirect scheme. Specifically "http" to port 80
	  and "https" to port 443. If the redirect scheme does not have a
	  well-known port, the listener port of the Gateway SHOULD be used.
	* If redirect scheme is empty, the redirect port MUST be the Gateway
	  Listener port.


	Implementations SHOULD NOT add the port number in the 'Location'
	header in the following cases:


	* A Location header that will use HTTP (whether that is determined via
	  the Listener protocol or the Scheme field) _and_ use port 80.
	* A Location header that will use HTTPS (whether that is determined via
	  the Listener protocol or the Scheme field) _and_ use port 443.


	Support: Extended
	"""
																			format:  "int32"
																			maximum: 65535
																			minimum: 1
																			type:    "integer"
																		}
																		scheme: {
																			description: """
	Scheme is the scheme to be used in the value of the `Location` header in
	the response. When empty, the scheme of the request is used.


	Scheme redirects can affect the port of the redirect, for more information,
	refer to the documentation for the port field of this filter.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.


	Support: Extended
	"""
																			enum: [
																				"http",
																				"https",
																			]
																			type: "string"
																		}
																		statusCode: {
																			default: 302
																			description: """
	StatusCode is the HTTP status code to be used in response.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.


	Support: Core
	"""
																			enum: [
																				301,
																				302,
																			]
																			type: "integer"
																		}
																	}
																	type: "object"
																}
																responseHeaderModifier: {
																	description: """
	ResponseHeaderModifier defines a schema for a filter that modifies response
	headers.


	Support: Extended
	"""
																	properties: {
																		add: {
																			description: """
	Add adds the given header(s) (name, value) to the request
	before the action. It appends to any existing values associated
	with the header name.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  add:
	  - name: "my-header"
	    value: "bar,baz"


	Output:
	  GET /foo HTTP/1.1
	  my-header: foo,bar,baz
	"""
																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																				properties: {
																					name: {
																						description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."
																						maxLength:   4096
																						minLength:   1
																						type:        "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
	Remove the given header(s) from the HTTP request before the action. The
	value of Remove is a list of HTTP header names. Note that the header
	names are case-insensitive (see
	https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).


	Input:
	  GET /foo HTTP/1.1
	  my-header1: foo
	  my-header2: bar
	  my-header3: baz


	Config:
	  remove: ["my-header1", "my-header3"]


	Output:
	  GET /foo HTTP/1.1
	  my-header2: bar
	"""
																			items: type: "string"
																			maxItems:                 16
																			type:                     "array"
																			"x-kubernetes-list-type": "set"
																		}
																		set: {
																			description: """
	Set overwrites the request with the given header (name, value)
	before the action.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  set:
	  - name: "my-header"
	    value: "bar"


	Output:
	  GET /foo HTTP/1.1
	  my-header: bar
	"""
																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																				properties: {
																					name: {
																						description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."
																						maxLength:   4096
																						minLength:   1
																						type:        "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																type: {
																	description: """
	Type identifies the type of filter to apply. As with other API fields,
	types are classified into three conformance levels:


	- Core: Filter types and their corresponding configuration defined by
	  "Support: Core" in this package, e.g. "RequestHeaderModifier". All
	  implementations must support core filters.


	- Extended: Filter types and their corresponding configuration defined by
	  "Support: Extended" in this package, e.g. "RequestMirror". Implementers
	  are encouraged to support extended filters.


	- Implementation-specific: Filters that are defined and supported by
	  specific vendors.
	  In the future, filters showing convergence in behavior across multiple
	  implementations will be considered for inclusion in extended or core
	  conformance levels. Filter-specific configuration for such filters
	  is specified using the ExtensionRef field. `Type` should be set to
	  "ExtensionRef" for custom filters.


	Implementers are encouraged to define custom implementation types to
	extend the core API with implementation-specific behavior.


	If a reference to a custom filter type cannot be resolved, the filter
	MUST NOT be skipped. Instead, requests that would have been processed by
	that filter MUST receive a HTTP error response.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.
	"""
																	enum: [
																		"RequestHeaderModifier",
																		"ResponseHeaderModifier",
																		"RequestMirror",
																		"RequestRedirect",
																		"URLRewrite",
																		"ExtensionRef",
																	]
																	type: "string"
																}
																urlRewrite: {
																	description: """
	URLRewrite defines a schema for a filter that modifies a request during forwarding.


	Support: Extended
	"""
																	properties: {
																		hostname: {
																			description: """
	Hostname is the value to be used to replace the Host header value during
	forwarding.


	Support: Extended
	"""
																			maxLength: 253
																			minLength: 1
																			pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		path: {
																			description: """
	Path defines a path rewrite.


	Support: Extended
	"""
																			properties: {
																				replaceFullPath: {
																					description: """
	ReplaceFullPath specifies the value with which to replace the full path
	of a request during a rewrite or redirect.
	"""
																					maxLength: 1024
																					type:      "string"
																				}
																				replacePrefixMatch: {
																					description: """
	ReplacePrefixMatch specifies the value with which to replace the prefix
	match of a request during a rewrite or redirect. For example, a request
	to "/foo/bar" with a prefix match of "/foo" and a ReplacePrefixMatch
	of "/xyz" would be modified to "/xyz/bar".


	Note that this matches the behavior of the PathPrefix match type. This
	matches full path elements. A path element refers to the list of labels
	in the path split by the `/` separator. When specified, a trailing `/` is
	ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all
	match the prefix `/abc`, but the path `/abcd` would not.


	ReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.
	Using any other HTTPRouteMatch type on the same HTTPRouteRule will result in
	the implementation setting the Accepted Condition for the Route to `status: False`.


	Request Path | Prefix Match | Replace Prefix | Modified Path
	-------------|--------------|----------------|----------
	/foo/bar     | /foo         | /xyz           | /xyz/bar
	/foo/bar     | /foo         | /xyz/          | /xyz/bar
	/foo/bar     | /foo/        | /xyz           | /xyz/bar
	/foo/bar     | /foo/        | /xyz/          | /xyz/bar
	/foo         | /foo         | /xyz           | /xyz
	/foo/        | /foo         | /xyz           | /xyz/
	/foo/bar     | /foo         | <empty string> | /bar
	/foo/        | /foo         | <empty string> | /
	/foo         | /foo         | <empty string> | /
	/foo/        | /foo         | /              | /
	/foo         | /foo         | /              | /
	"""
																					maxLength: 1024
																					type:      "string"
																				}
																				type: {
																					description: """
	Type defines the type of path modifier. Additional types may be
	added in a future release of the API.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.
	"""
																					enum: [
																						"ReplaceFullPath",
																						"ReplacePrefixMatch",
																					]
																					type: "string"
																				}
																			}
																			required: ["type"]
																			type: "object"
																			"x-kubernetes-validations": [{
																				message: "replaceFullPath must be specified when type is set to 'ReplaceFullPath'"
																				rule:    "self.type == 'ReplaceFullPath' ? has(self.replaceFullPath) : true"
																			}, {
																				message: "type must be 'ReplaceFullPath' when replaceFullPath is set"
																				rule:    "has(self.replaceFullPath) ? self.type == 'ReplaceFullPath' : true"
																			}, {
																				message: "replacePrefixMatch must be specified when type is set to 'ReplacePrefixMatch'"
																				rule:    "self.type == 'ReplacePrefixMatch' ? has(self.replacePrefixMatch) : true"
																			}, {
																				message: "type must be 'ReplacePrefixMatch' when replacePrefixMatch is set"
																				rule:    "has(self.replacePrefixMatch) ? self.type == 'ReplacePrefixMatch' : true"
																			}]
																		}
																	}
																	type: "object"
																}
															}
															required: ["type"]
															type: "object"
															"x-kubernetes-validations": [{
																message: "filter.requestHeaderModifier must be nil if the filter.type is not RequestHeaderModifier"
																rule:    "!(has(self.requestHeaderModifier) && self.type != 'RequestHeaderModifier')"
															}, {
																message: "filter.requestHeaderModifier must be specified for RequestHeaderModifier filter.type"
																rule:    "!(!has(self.requestHeaderModifier) && self.type == 'RequestHeaderModifier')"
															}, {
																message: "filter.responseHeaderModifier must be nil if the filter.type is not ResponseHeaderModifier"
																rule:    "!(has(self.responseHeaderModifier) && self.type != 'ResponseHeaderModifier')"
															}, {
																message: "filter.responseHeaderModifier must be specified for ResponseHeaderModifier filter.type"
																rule:    "!(!has(self.responseHeaderModifier) && self.type == 'ResponseHeaderModifier')"
															}, {
																message: "filter.requestMirror must be nil if the filter.type is not RequestMirror"
																rule:    "!(has(self.requestMirror) && self.type != 'RequestMirror')"
															}, {
																message: "filter.requestMirror must be specified for RequestMirror filter.type"
																rule:    "!(!has(self.requestMirror) && self.type == 'RequestMirror')"
															}, {
																message: "filter.requestRedirect must be nil if the filter.type is not RequestRedirect"
																rule:    "!(has(self.requestRedirect) && self.type != 'RequestRedirect')"
															}, {
																message: "filter.requestRedirect must be specified for RequestRedirect filter.type"
																rule:    "!(!has(self.requestRedirect) && self.type == 'RequestRedirect')"
															}, {
																message: "filter.urlRewrite must be nil if the filter.type is not URLRewrite"
																rule:    "!(has(self.urlRewrite) && self.type != 'URLRewrite')"
															}, {
																message: "filter.urlRewrite must be specified for URLRewrite filter.type"
																rule:    "!(!has(self.urlRewrite) && self.type == 'URLRewrite')"
															}, {
																message: "filter.extensionRef must be nil if the filter.type is not ExtensionRef"
																rule:    "!(has(self.extensionRef) && self.type != 'ExtensionRef')"
															}, {
																message: "filter.extensionRef must be specified for ExtensionRef filter.type"
																rule:    "!(!has(self.extensionRef) && self.type == 'ExtensionRef')"
															}]
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-validations": [{
															message: "May specify either httpRouteFilterRequestRedirect or httpRouteFilterRequestRewrite, but not both"
															rule:    "!(self.exists(f, f.type == 'RequestRedirect') && self.exists(f, f.type == 'URLRewrite'))"
														}, {
															message: "May specify either httpRouteFilterRequestRedirect or httpRouteFilterRequestRewrite, but not both"
															rule:    "!(self.exists(f, f.type == 'RequestRedirect') && self.exists(f, f.type == 'URLRewrite'))"
														}, {
															message: "RequestHeaderModifier filter cannot be repeated"
															rule:    "self.filter(f, f.type == 'RequestHeaderModifier').size() <= 1"
														}, {
															message: "ResponseHeaderModifier filter cannot be repeated"
															rule:    "self.filter(f, f.type == 'ResponseHeaderModifier').size() <= 1"
														}, {
															message: "RequestRedirect filter cannot be repeated"
															rule:    "self.filter(f, f.type == 'RequestRedirect').size() <= 1"
														}, {
															message: "URLRewrite filter cannot be repeated"
															rule:    "self.filter(f, f.type == 'URLRewrite').size() <= 1"
														}]
													}
													group: {
														default: ""
														description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
														maxLength: 253
														pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
														type:      "string"
													}
													kind: {
														default: "Service"
														description: """
	Kind is the Kubernetes resource kind of the referent. For example
	"Service".


	Defaults to "Service" when not specified.


	ExternalName services can refer to CNAME DNS records that may live
	outside of the cluster and as such are difficult to reason about in
	terms of conformance. They also may not be safe to forward to (see
	CVE-2021-25740 for more information). Implementations SHOULD NOT
	support ExternalName Services.


	Support: Core (Services with a type other than ExternalName)


	Support: Implementation-specific (Services with type ExternalName)
	"""
														maxLength: 63
														minLength: 1
														pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
														type:      "string"
													}
													name: {
														description: "Name is the name of the referent."
														maxLength:   253
														minLength:   1
														type:        "string"
													}
													namespace: {
														description: """
	Namespace is the namespace of the backend. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
														maxLength: 63
														minLength: 1
														pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
														type:      "string"
													}
													port: {
														description: """
	Port specifies the destination port number to use for this resource.
	Port is required when the referent is a Kubernetes Service. In this
	case, the port number is the service port number, not the target port.
	For other resources, destination port might be derived from the referent
	resource or this field.
	"""
														format:  "int32"
														maximum: 65535
														minimum: 1
														type:    "integer"
													}
													weight: {
														default: 1
														description: """
	Weight specifies the proportion of requests forwarded to the referenced
	backend. This is computed as weight/(sum of all weights in this
	BackendRefs list). For non-zero values, there may be some epsilon from
	the exact proportion defined here depending on the precision an
	implementation supports. Weight is not a percentage and the sum of
	weights does not need to equal 100.


	If only one backend is specified and it has a weight greater than 0, 100%
	of the traffic is forwarded to that backend. If weight is set to 0, no
	traffic should be forwarded for this entry. If unspecified, weight
	defaults to 1.


	Support for this field varies based on the context where used.
	"""
														format:  "int32"
														maximum: 1000000
														minimum: 0
														type:    "integer"
													}
												}
												required: ["name"]
												type: "object"
												"x-kubernetes-validations": [{
													message: "Must have port for Service reference"
													rule:    "(size(self.group) == 0 && self.kind == 'Service') ? has(self.port) : true"
												}]
											}
											maxItems: 16
											type:     "array"
										}
										filters: {
											description: """
	Filters define the filters that are applied to requests that match
	this rule.


	Wherever possible, implementations SHOULD implement filters in the order
	they are specified.


	Implementations MAY choose to implement this ordering strictly, rejecting
	any combination or order of filters that can not be supported. If implementations
	choose a strict interpretation of filter ordering, they MUST clearly document
	that behavior.


	To reject an invalid combination or order of filters, implementations SHOULD
	consider the Route Rules with this configuration invalid. If all Route Rules
	in a Route are invalid, the entire Route would be considered invalid. If only
	a portion of Route Rules are invalid, implementations MUST set the
	"PartiallyInvalid" condition for the Route.


	Conformance-levels at this level are defined based on the type of filter:


	- ALL core filters MUST be supported by all implementations.
	- Implementers are encouraged to support extended filters.
	- Implementation-specific custom filters have no API guarantees across
	  implementations.


	Specifying the same filter multiple times is not supported unless explicitly
	indicated in the filter.


	All filters are expected to be compatible with each other except for the
	URLRewrite and RequestRedirect filters, which may not be combined. If an
	implementation can not support other combinations of filters, they must clearly
	document that limitation. In cases where incompatible or unsupported
	filters are specified and cause the `Accepted` condition to be set to status
	`False`, implementations may use the `IncompatibleFilters` reason to specify
	this configuration error.


	Support: Core
	"""
											items: {
												description: """
	HTTPRouteFilter defines processing steps that must be completed during the
	request or response lifecycle. HTTPRouteFilters are meant as an extension
	point to express processing that may be done in Gateway implementations. Some
	examples include request or response modification, implementing
	authentication strategies, rate-limiting, and traffic shaping. API
	guarantee/conformance is defined based on the type of the filter.
	"""
												properties: {
													extensionRef: {
														description: """
	ExtensionRef is an optional, implementation-specific extension to the
	"filter" behavior.  For example, resource "myroutefilter" in group
	"networking.example.net"). ExtensionRef MUST NOT be used for core and
	extended filters.


	This filter can be used multiple times within the same rule.


	Support: Implementation-specific
	"""
														properties: {
															group: {
																description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																maxLength: 253
																pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															kind: {
																description: "Kind is kind of the referent. For example \"HTTPRoute\" or \"Service\"."
																maxLength:   63
																minLength:   1
																pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																type:        "string"
															}
															name: {
																description: "Name is the name of the referent."
																maxLength:   253
																minLength:   1
																type:        "string"
															}
														}
														required: [
															"group",
															"kind",
															"name",
														]
														type: "object"
													}
													requestHeaderModifier: {
														description: """
	RequestHeaderModifier defines a schema for a filter that modifies request
	headers.


	Support: Core
	"""
														properties: {
															add: {
																description: """
	Add adds the given header(s) (name, value) to the request
	before the action. It appends to any existing values associated
	with the header name.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  add:
	  - name: "my-header"
	    value: "bar,baz"


	Output:
	  GET /foo HTTP/1.1
	  my-header: foo,bar,baz
	"""
																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																	properties: {
																		name: {
																			description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."
																			maxLength:   4096
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
															remove: {
																description: """
	Remove the given header(s) from the HTTP request before the action. The
	value of Remove is a list of HTTP header names. Note that the header
	names are case-insensitive (see
	https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).


	Input:
	  GET /foo HTTP/1.1
	  my-header1: foo
	  my-header2: bar
	  my-header3: baz


	Config:
	  remove: ["my-header1", "my-header3"]


	Output:
	  GET /foo HTTP/1.1
	  my-header2: bar
	"""
																items: type: "string"
																maxItems:                 16
																type:                     "array"
																"x-kubernetes-list-type": "set"
															}
															set: {
																description: """
	Set overwrites the request with the given header (name, value)
	before the action.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  set:
	  - name: "my-header"
	    value: "bar"


	Output:
	  GET /foo HTTP/1.1
	  my-header: bar
	"""
																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																	properties: {
																		name: {
																			description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."
																			maxLength:   4096
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
														}
														type: "object"
													}
													requestMirror: {
														description: """
	RequestMirror defines a schema for a filter that mirrors requests.
	Requests are sent to the specified destination, but responses from
	that destination are ignored.


	This filter can be used multiple times within the same rule. Note that
	not all implementations will be able to support mirroring to multiple
	backends.


	Support: Extended
	"""
														properties: backendRef: {
															description: """
	BackendRef references a resource where mirrored requests are sent.


	Mirrored requests must be sent only to a single destination endpoint
	within this BackendRef, irrespective of how many endpoints are present
	within this BackendRef.


	If the referent cannot be found, this BackendRef is invalid and must be
	dropped from the Gateway. The controller must ensure the "ResolvedRefs"
	condition on the Route status is set to `status: False` and not configure
	this backend in the underlying implementation.


	If there is a cross-namespace reference to an *existing* object
	that is not allowed by a ReferenceGrant, the controller must ensure the
	"ResolvedRefs"  condition on the Route is set to `status: False`,
	with the "RefNotPermitted" reason and not configure this backend in the
	underlying implementation.


	In either error case, the Message of the `ResolvedRefs` Condition
	should be used to provide more detail about the problem.


	Support: Extended for Kubernetes Service


	Support: Implementation-specific for any other resource
	"""
															properties: {
																group: {
																	default: ""
																	description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
																	maxLength: 253
																	pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																	type:      "string"
																}
																kind: {
																	default: "Service"
																	description: """
	Kind is the Kubernetes resource kind of the referent. For example
	"Service".


	Defaults to "Service" when not specified.


	ExternalName services can refer to CNAME DNS records that may live
	outside of the cluster and as such are difficult to reason about in
	terms of conformance. They also may not be safe to forward to (see
	CVE-2021-25740 for more information). Implementations SHOULD NOT
	support ExternalName Services.


	Support: Core (Services with a type other than ExternalName)


	Support: Implementation-specific (Services with type ExternalName)
	"""
																	maxLength: 63
																	minLength: 1
																	pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																	type:      "string"
																}
																name: {
																	description: "Name is the name of the referent."
																	maxLength:   253
																	minLength:   1
																	type:        "string"
																}
																namespace: {
																	description: """
	Namespace is the namespace of the backend. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
																	maxLength: 63
																	minLength: 1
																	pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
																	type:      "string"
																}
																port: {
																	description: """
	Port specifies the destination port number to use for this resource.
	Port is required when the referent is a Kubernetes Service. In this
	case, the port number is the service port number, not the target port.
	For other resources, destination port might be derived from the referent
	resource or this field.
	"""
																	format:  "int32"
																	maximum: 65535
																	minimum: 1
																	type:    "integer"
																}
															}
															required: ["name"]
															type: "object"
															"x-kubernetes-validations": [{
																message: "Must have port for Service reference"
																rule:    "(size(self.group) == 0 && self.kind == 'Service') ? has(self.port) : true"
															}]
														}
														required: ["backendRef"]
														type: "object"
													}
													requestRedirect: {
														description: """
	RequestRedirect defines a schema for a filter that responds to the
	request with an HTTP redirection.


	Support: Core
	"""
														properties: {
															hostname: {
																description: """
	Hostname is the hostname to be used in the value of the `Location`
	header in the response.
	When empty, the hostname in the `Host` header of the request is used.


	Support: Core
	"""
																maxLength: 253
																minLength: 1
																pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															path: {
																description: """
	Path defines parameters used to modify the path of the incoming request.
	The modified path is then used to construct the `Location` header. When
	empty, the request path is used as-is.


	Support: Extended
	"""
																properties: {
																	replaceFullPath: {
																		description: """
	ReplaceFullPath specifies the value with which to replace the full path
	of a request during a rewrite or redirect.
	"""
																		maxLength: 1024
																		type:      "string"
																	}
																	replacePrefixMatch: {
																		description: """
	ReplacePrefixMatch specifies the value with which to replace the prefix
	match of a request during a rewrite or redirect. For example, a request
	to "/foo/bar" with a prefix match of "/foo" and a ReplacePrefixMatch
	of "/xyz" would be modified to "/xyz/bar".


	Note that this matches the behavior of the PathPrefix match type. This
	matches full path elements. A path element refers to the list of labels
	in the path split by the `/` separator. When specified, a trailing `/` is
	ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all
	match the prefix `/abc`, but the path `/abcd` would not.


	ReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.
	Using any other HTTPRouteMatch type on the same HTTPRouteRule will result in
	the implementation setting the Accepted Condition for the Route to `status: False`.


	Request Path | Prefix Match | Replace Prefix | Modified Path
	-------------|--------------|----------------|----------
	/foo/bar     | /foo         | /xyz           | /xyz/bar
	/foo/bar     | /foo         | /xyz/          | /xyz/bar
	/foo/bar     | /foo/        | /xyz           | /xyz/bar
	/foo/bar     | /foo/        | /xyz/          | /xyz/bar
	/foo         | /foo         | /xyz           | /xyz
	/foo/        | /foo         | /xyz           | /xyz/
	/foo/bar     | /foo         | <empty string> | /bar
	/foo/        | /foo         | <empty string> | /
	/foo         | /foo         | <empty string> | /
	/foo/        | /foo         | /              | /
	/foo         | /foo         | /              | /
	"""
																		maxLength: 1024
																		type:      "string"
																	}
																	type: {
																		description: """
	Type defines the type of path modifier. Additional types may be
	added in a future release of the API.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.
	"""
																		enum: [
																			"ReplaceFullPath",
																			"ReplacePrefixMatch",
																		]
																		type: "string"
																	}
																}
																required: ["type"]
																type: "object"
																"x-kubernetes-validations": [{
																	message: "replaceFullPath must be specified when type is set to 'ReplaceFullPath'"
																	rule:    "self.type == 'ReplaceFullPath' ? has(self.replaceFullPath) : true"
																}, {
																	message: "type must be 'ReplaceFullPath' when replaceFullPath is set"
																	rule:    "has(self.replaceFullPath) ? self.type == 'ReplaceFullPath' : true"
																}, {
																	message: "replacePrefixMatch must be specified when type is set to 'ReplacePrefixMatch'"
																	rule:    "self.type == 'ReplacePrefixMatch' ? has(self.replacePrefixMatch) : true"
																}, {
																	message: "type must be 'ReplacePrefixMatch' when replacePrefixMatch is set"
																	rule:    "has(self.replacePrefixMatch) ? self.type == 'ReplacePrefixMatch' : true"
																}]
															}
															port: {
																description: """
	Port is the port to be used in the value of the `Location`
	header in the response.


	If no port is specified, the redirect port MUST be derived using the
	following rules:


	* If redirect scheme is not-empty, the redirect port MUST be the well-known
	  port associated with the redirect scheme. Specifically "http" to port 80
	  and "https" to port 443. If the redirect scheme does not have a
	  well-known port, the listener port of the Gateway SHOULD be used.
	* If redirect scheme is empty, the redirect port MUST be the Gateway
	  Listener port.


	Implementations SHOULD NOT add the port number in the 'Location'
	header in the following cases:


	* A Location header that will use HTTP (whether that is determined via
	  the Listener protocol or the Scheme field) _and_ use port 80.
	* A Location header that will use HTTPS (whether that is determined via
	  the Listener protocol or the Scheme field) _and_ use port 443.


	Support: Extended
	"""
																format:  "int32"
																maximum: 65535
																minimum: 1
																type:    "integer"
															}
															scheme: {
																description: """
	Scheme is the scheme to be used in the value of the `Location` header in
	the response. When empty, the scheme of the request is used.


	Scheme redirects can affect the port of the redirect, for more information,
	refer to the documentation for the port field of this filter.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.


	Support: Extended
	"""
																enum: [
																	"http",
																	"https",
																]
																type: "string"
															}
															statusCode: {
																default: 302
																description: """
	StatusCode is the HTTP status code to be used in response.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.


	Support: Core
	"""
																enum: [
																	301,
																	302,
																]
																type: "integer"
															}
														}
														type: "object"
													}
													responseHeaderModifier: {
														description: """
	ResponseHeaderModifier defines a schema for a filter that modifies response
	headers.


	Support: Extended
	"""
														properties: {
															add: {
																description: """
	Add adds the given header(s) (name, value) to the request
	before the action. It appends to any existing values associated
	with the header name.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  add:
	  - name: "my-header"
	    value: "bar,baz"


	Output:
	  GET /foo HTTP/1.1
	  my-header: foo,bar,baz
	"""
																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																	properties: {
																		name: {
																			description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."
																			maxLength:   4096
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
															remove: {
																description: """
	Remove the given header(s) from the HTTP request before the action. The
	value of Remove is a list of HTTP header names. Note that the header
	names are case-insensitive (see
	https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).


	Input:
	  GET /foo HTTP/1.1
	  my-header1: foo
	  my-header2: bar
	  my-header3: baz


	Config:
	  remove: ["my-header1", "my-header3"]


	Output:
	  GET /foo HTTP/1.1
	  my-header2: bar
	"""
																items: type: "string"
																maxItems:                 16
																type:                     "array"
																"x-kubernetes-list-type": "set"
															}
															set: {
																description: """
	Set overwrites the request with the given header (name, value)
	before the action.


	Input:
	  GET /foo HTTP/1.1
	  my-header: foo


	Config:
	  set:
	  - name: "my-header"
	    value: "bar"


	Output:
	  GET /foo HTTP/1.1
	  my-header: bar
	"""
																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."
																	properties: {
																		name: {
																			description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, the first entry with
	an equivalent name MUST be considered for a match. Subsequent entries
	with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.
	"""
																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."
																			maxLength:   4096
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
														}
														type: "object"
													}
													type: {
														description: """
	Type identifies the type of filter to apply. As with other API fields,
	types are classified into three conformance levels:


	- Core: Filter types and their corresponding configuration defined by
	  "Support: Core" in this package, e.g. "RequestHeaderModifier". All
	  implementations must support core filters.


	- Extended: Filter types and their corresponding configuration defined by
	  "Support: Extended" in this package, e.g. "RequestMirror". Implementers
	  are encouraged to support extended filters.


	- Implementation-specific: Filters that are defined and supported by
	  specific vendors.
	  In the future, filters showing convergence in behavior across multiple
	  implementations will be considered for inclusion in extended or core
	  conformance levels. Filter-specific configuration for such filters
	  is specified using the ExtensionRef field. `Type` should be set to
	  "ExtensionRef" for custom filters.


	Implementers are encouraged to define custom implementation types to
	extend the core API with implementation-specific behavior.


	If a reference to a custom filter type cannot be resolved, the filter
	MUST NOT be skipped. Instead, requests that would have been processed by
	that filter MUST receive a HTTP error response.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.
	"""
														enum: [
															"RequestHeaderModifier",
															"ResponseHeaderModifier",
															"RequestMirror",
															"RequestRedirect",
															"URLRewrite",
															"ExtensionRef",
														]
														type: "string"
													}
													urlRewrite: {
														description: """
	URLRewrite defines a schema for a filter that modifies a request during forwarding.


	Support: Extended
	"""
														properties: {
															hostname: {
																description: """
	Hostname is the value to be used to replace the Host header value during
	forwarding.


	Support: Extended
	"""
																maxLength: 253
																minLength: 1
																pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															path: {
																description: """
	Path defines a path rewrite.


	Support: Extended
	"""
																properties: {
																	replaceFullPath: {
																		description: """
	ReplaceFullPath specifies the value with which to replace the full path
	of a request during a rewrite or redirect.
	"""
																		maxLength: 1024
																		type:      "string"
																	}
																	replacePrefixMatch: {
																		description: """
	ReplacePrefixMatch specifies the value with which to replace the prefix
	match of a request during a rewrite or redirect. For example, a request
	to "/foo/bar" with a prefix match of "/foo" and a ReplacePrefixMatch
	of "/xyz" would be modified to "/xyz/bar".


	Note that this matches the behavior of the PathPrefix match type. This
	matches full path elements. A path element refers to the list of labels
	in the path split by the `/` separator. When specified, a trailing `/` is
	ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all
	match the prefix `/abc`, but the path `/abcd` would not.


	ReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.
	Using any other HTTPRouteMatch type on the same HTTPRouteRule will result in
	the implementation setting the Accepted Condition for the Route to `status: False`.


	Request Path | Prefix Match | Replace Prefix | Modified Path
	-------------|--------------|----------------|----------
	/foo/bar     | /foo         | /xyz           | /xyz/bar
	/foo/bar     | /foo         | /xyz/          | /xyz/bar
	/foo/bar     | /foo/        | /xyz           | /xyz/bar
	/foo/bar     | /foo/        | /xyz/          | /xyz/bar
	/foo         | /foo         | /xyz           | /xyz
	/foo/        | /foo         | /xyz           | /xyz/
	/foo/bar     | /foo         | <empty string> | /bar
	/foo/        | /foo         | <empty string> | /
	/foo         | /foo         | <empty string> | /
	/foo/        | /foo         | /              | /
	/foo         | /foo         | /              | /
	"""
																		maxLength: 1024
																		type:      "string"
																	}
																	type: {
																		description: """
	Type defines the type of path modifier. Additional types may be
	added in a future release of the API.


	Note that values may be added to this enum, implementations
	must ensure that unknown values will not cause a crash.


	Unknown values here must result in the implementation setting the
	Accepted Condition for the Route to `status: False`, with a
	Reason of `UnsupportedValue`.
	"""
																		enum: [
																			"ReplaceFullPath",
																			"ReplacePrefixMatch",
																		]
																		type: "string"
																	}
																}
																required: ["type"]
																type: "object"
																"x-kubernetes-validations": [{
																	message: "replaceFullPath must be specified when type is set to 'ReplaceFullPath'"
																	rule:    "self.type == 'ReplaceFullPath' ? has(self.replaceFullPath) : true"
																}, {
																	message: "type must be 'ReplaceFullPath' when replaceFullPath is set"
																	rule:    "has(self.replaceFullPath) ? self.type == 'ReplaceFullPath' : true"
																}, {
																	message: "replacePrefixMatch must be specified when type is set to 'ReplacePrefixMatch'"
																	rule:    "self.type == 'ReplacePrefixMatch' ? has(self.replacePrefixMatch) : true"
																}, {
																	message: "type must be 'ReplacePrefixMatch' when replacePrefixMatch is set"
																	rule:    "has(self.replacePrefixMatch) ? self.type == 'ReplacePrefixMatch' : true"
																}]
															}
														}
														type: "object"
													}
												}
												required: ["type"]
												type: "object"
												"x-kubernetes-validations": [{
													message: "filter.requestHeaderModifier must be nil if the filter.type is not RequestHeaderModifier"
													rule:    "!(has(self.requestHeaderModifier) && self.type != 'RequestHeaderModifier')"
												}, {
													message: "filter.requestHeaderModifier must be specified for RequestHeaderModifier filter.type"
													rule:    "!(!has(self.requestHeaderModifier) && self.type == 'RequestHeaderModifier')"
												}, {
													message: "filter.responseHeaderModifier must be nil if the filter.type is not ResponseHeaderModifier"
													rule:    "!(has(self.responseHeaderModifier) && self.type != 'ResponseHeaderModifier')"
												}, {
													message: "filter.responseHeaderModifier must be specified for ResponseHeaderModifier filter.type"
													rule:    "!(!has(self.responseHeaderModifier) && self.type == 'ResponseHeaderModifier')"
												}, {
													message: "filter.requestMirror must be nil if the filter.type is not RequestMirror"
													rule:    "!(has(self.requestMirror) && self.type != 'RequestMirror')"
												}, {
													message: "filter.requestMirror must be specified for RequestMirror filter.type"
													rule:    "!(!has(self.requestMirror) && self.type == 'RequestMirror')"
												}, {
													message: "filter.requestRedirect must be nil if the filter.type is not RequestRedirect"
													rule:    "!(has(self.requestRedirect) && self.type != 'RequestRedirect')"
												}, {
													message: "filter.requestRedirect must be specified for RequestRedirect filter.type"
													rule:    "!(!has(self.requestRedirect) && self.type == 'RequestRedirect')"
												}, {
													message: "filter.urlRewrite must be nil if the filter.type is not URLRewrite"
													rule:    "!(has(self.urlRewrite) && self.type != 'URLRewrite')"
												}, {
													message: "filter.urlRewrite must be specified for URLRewrite filter.type"
													rule:    "!(!has(self.urlRewrite) && self.type == 'URLRewrite')"
												}, {
													message: "filter.extensionRef must be nil if the filter.type is not ExtensionRef"
													rule:    "!(has(self.extensionRef) && self.type != 'ExtensionRef')"
												}, {
													message: "filter.extensionRef must be specified for ExtensionRef filter.type"
													rule:    "!(!has(self.extensionRef) && self.type == 'ExtensionRef')"
												}]
											}
											maxItems: 16
											type:     "array"
											"x-kubernetes-validations": [{
												message: "May specify either httpRouteFilterRequestRedirect or httpRouteFilterRequestRewrite, but not both"
												rule:    "!(self.exists(f, f.type == 'RequestRedirect') && self.exists(f, f.type == 'URLRewrite'))"
											}, {
												message: "RequestHeaderModifier filter cannot be repeated"
												rule:    "self.filter(f, f.type == 'RequestHeaderModifier').size() <= 1"
											}, {
												message: "ResponseHeaderModifier filter cannot be repeated"
												rule:    "self.filter(f, f.type == 'ResponseHeaderModifier').size() <= 1"
											}, {
												message: "RequestRedirect filter cannot be repeated"
												rule:    "self.filter(f, f.type == 'RequestRedirect').size() <= 1"
											}, {
												message: "URLRewrite filter cannot be repeated"
												rule:    "self.filter(f, f.type == 'URLRewrite').size() <= 1"
											}]
										}
										matches: {
											default: [{
												path: {
													type:  "PathPrefix"
													value: "/"
												}
											}]
											description: """
	Matches define conditions used for matching the rule against incoming
	HTTP requests. Each match is independent, i.e. this rule will be matched
	if **any** one of the matches is satisfied.


	For example, take the following matches configuration:


	```
	matches:
	- path:
	    value: "/foo"
	  headers:
	  - name: "version"
	    value: "v2"
	- path:
	    value: "/v2/foo"
	```


	For a request to match against this rule, a request must satisfy
	EITHER of the two conditions:


	- path prefixed with `/foo` AND contains the header `version: v2`
	- path prefix of `/v2/foo`


	See the documentation for HTTPRouteMatch on how to specify multiple
	match conditions that should be ANDed together.


	If no matches are specified, the default is a prefix
	path match on "/", which has the effect of matching every
	HTTP request.


	Proxy or Load Balancer routing configuration generated from HTTPRoutes
	MUST prioritize matches based on the following criteria, continuing on
	ties. Across all rules specified on applicable Routes, precedence must be
	given to the match having:


	* "Exact" path match.
	* "Prefix" path match with largest number of characters.
	* Method match.
	* Largest number of header matches.
	* Largest number of query param matches.


	Note: The precedence of RegularExpression path matches are implementation-specific.


	If ties still exist across multiple Routes, matching precedence MUST be
	determined in order of the following criteria, continuing on ties:


	* The oldest Route based on creation timestamp.
	* The Route appearing first in alphabetical order by
	  "{namespace}/{name}".


	If ties still exist within an HTTPRoute, matching precedence MUST be granted
	to the FIRST matching rule (in list order) with a match meeting the above
	criteria.


	When no rules matching a request have been successfully attached to the
	parent a request is coming from, a HTTP 404 status code MUST be returned.
	"""
											items: {
												description: """
	HTTPRouteMatch defines the predicate used to match requests to a given
	action. Multiple match types are ANDed together, i.e. the match will
	evaluate to true only if all conditions are satisfied.


	For example, the match below will match a HTTP request only if its path
	starts with `/foo` AND it contains the `version: v1` header:


	```
	match:


	\tpath:
	\t  value: "/foo"
	\theaders:
	\t- name: "version"
	\t  value "v1"


	```
	"""
												properties: {
													headers: {
														description: """
	Headers specifies HTTP request header matchers. Multiple match values are
	ANDed together, meaning, a request must match all the specified headers
	to select the route.
	"""
														items: {
															description: """
	HTTPHeaderMatch describes how to select a HTTP route by matching HTTP request
	headers.
	"""
															properties: {
																name: {
																	description: """
	Name is the name of the HTTP Header to be matched. Name matching MUST be
	case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).


	If multiple entries specify equivalent header names, only the first
	entry with an equivalent name MUST be considered for a match. Subsequent
	entries with an equivalent header name MUST be ignored. Due to the
	case-insensitivity of header names, "foo" and "Foo" are considered
	equivalent.


	When a header is repeated in an HTTP request, it is
	implementation-specific behavior as to how this is represented.
	Generally, proxies should follow the guidance from the RFC:
	https://www.rfc-editor.org/rfc/rfc7230.html#section-3.2.2 regarding
	processing a repeated header, with special handling for "Set-Cookie".
	"""
																	maxLength: 256
																	minLength: 1
																	pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																	type:      "string"
																}
																type: {
																	default: "Exact"
																	description: """
	Type specifies how to match against the value of the header.


	Support: Core (Exact)


	Support: Implementation-specific (RegularExpression)


	Since RegularExpression HeaderMatchType has implementation-specific
	conformance, implementations can support POSIX, PCRE or any other dialects
	of regular expressions. Please read the implementation's documentation to
	determine the supported dialect.
	"""
																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of HTTP Header to be matched."
																	maxLength:   4096
																	minLength:   1
																	type:        "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
													method: {
														description: """
	Method specifies HTTP method matcher.
	When specified, this route will be matched only if the request has the
	specified method.


	Support: Extended
	"""
														enum: [
															"GET",
															"HEAD",
															"POST",
															"PUT",
															"DELETE",
															"CONNECT",
															"OPTIONS",
															"TRACE",
															"PATCH",
														]
														type: "string"
													}
													path: {
														default: {
															type:  "PathPrefix"
															value: "/"
														}
														description: """
	Path specifies a HTTP request path matcher. If this field is not
	specified, a default prefix match on the "/" path is provided.
	"""
														properties: {
															type: {
																default: "PathPrefix"
																description: """
	Type specifies how to match against the path Value.


	Support: Core (Exact, PathPrefix)


	Support: Implementation-specific (RegularExpression)
	"""
																enum: [
																	"Exact",
																	"PathPrefix",
																	"RegularExpression",
																]
																type: "string"
															}
															value: {
																default:     "/"
																description: "Value of the HTTP path to match against."
																maxLength:   1024
																type:        "string"
															}
														}
														type: "object"
														"x-kubernetes-validations": [{
															message: "value must be an absolute path and start with '/' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? self.value.startsWith('/') : true"
														}, {
															message: "must not contain '//' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? !self.value.contains('//') : true"
														}, {
															message: "must not contain '/./' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? !self.value.contains('/./') : true"
														}, {
															message: "must not contain '/../' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? !self.value.contains('/../') : true"
														}, {
															message: "must not contain '%2f' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? !self.value.contains('%2f') : true"
														}, {
															message: "must not contain '%2F' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? !self.value.contains('%2F') : true"
														}, {
															message: "must not contain '#' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? !self.value.contains('#') : true"
														}, {
															message: "must not end with '/..' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? !self.value.endsWith('/..') : true"
														}, {
															message: "must not end with '/.' when type one of ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? !self.value.endsWith('/.') : true"
														}, {
															message: "type must be one of ['Exact', 'PathPrefix', 'RegularExpression']"
															rule:    "self.type in ['Exact','PathPrefix'] || self.type == 'RegularExpression'"
														}, {
															message: "must only contain valid characters (matching ^(?:[-A-Za-z0-9/._~!$&'()*+,;=:@]|[%][0-9a-fA-F]{2})+$) for types ['Exact', 'PathPrefix']"
															rule:    "(self.type in ['Exact','PathPrefix']) ? self.value.matches(r\"\"\"^(?:[-A-Za-z0-9/._~!$&'()*+,;=:@]|[%][0-9a-fA-F]{2})+$\"\"\") : true"
														}]
													}
													queryParams: {
														description: """
	QueryParams specifies HTTP query parameter matchers. Multiple match
	values are ANDed together, meaning, a request must match all the
	specified query parameters to select the route.


	Support: Extended
	"""
														items: {
															description: """
	HTTPQueryParamMatch describes how to select a HTTP route by matching HTTP
	query parameters.
	"""
															properties: {
																name: {
																	description: """
	Name is the name of the HTTP query param to be matched. This must be an
	exact string match. (See
	https://tools.ietf.org/html/rfc7230#section-2.7.3).


	If multiple entries specify equivalent query param names, only the first
	entry with an equivalent name MUST be considered for a match. Subsequent
	entries with an equivalent query param name MUST be ignored.


	If a query param is repeated in an HTTP request, the behavior is
	purposely left undefined, since different data planes have different
	capabilities. However, it is *recommended* that implementations should
	match against the first value of the param if the data plane supports it,
	as this behavior is expected in other load balancing contexts outside of
	the Gateway API.


	Users SHOULD NOT route traffic based on repeated query params to guard
	themselves against potential differences in the implementations.
	"""
																	maxLength: 256
																	minLength: 1
																	pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																	type:      "string"
																}
																type: {
																	default: "Exact"
																	description: """
	Type specifies how to match against the value of the query parameter.


	Support: Extended (Exact)


	Support: Implementation-specific (RegularExpression)


	Since RegularExpression QueryParamMatchType has Implementation-specific
	conformance, implementations can support POSIX, PCRE or any other
	dialects of regular expressions. Please read the implementation's
	documentation to determine the supported dialect.
	"""
																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of HTTP query param to be matched."
																	maxLength:   1024
																	minLength:   1
																	type:        "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
												}
												type: "object"
											}
											maxItems: 8
											type:     "array"
										}
										sessionPersistence: {
											description: """
	SessionPersistence defines and configures session persistence
	for the route rule.


	Support: Extended



	"""
											properties: {
												absoluteTimeout: {
													description: """
	AbsoluteTimeout defines the absolute timeout of the persistent
	session. Once the AbsoluteTimeout duration has elapsed, the
	session becomes invalid.


	Support: Extended
	"""
													pattern: "^([0-9]{1,5}(h|m|s|ms)){1,4}$"
													type:    "string"
												}
												cookieConfig: {
													description: """
	CookieConfig provides configuration settings that are specific
	to cookie-based session persistence.


	Support: Core
	"""
													properties: lifetimeType: {
														default: "Session"
														description: """
	LifetimeType specifies whether the cookie has a permanent or
	session-based lifetime. A permanent cookie persists until its
	specified expiry time, defined by the Expires or Max-Age cookie
	attributes, while a session cookie is deleted when the current
	session ends.


	When set to "Permanent", AbsoluteTimeout indicates the
	cookie's lifetime via the Expires or Max-Age cookie attributes
	and is required.


	When set to "Session", AbsoluteTimeout indicates the
	absolute lifetime of the cookie tracked by the gateway and
	is optional.


	Support: Core for "Session" type


	Support: Extended for "Permanent" type
	"""
														enum: [
															"Permanent",
															"Session",
														]
														type: "string"
													}
													type: "object"
												}
												idleTimeout: {
													description: """
	IdleTimeout defines the idle timeout of the persistent session.
	Once the session has been idle for more than the specified
	IdleTimeout duration, the session becomes invalid.


	Support: Extended
	"""
													pattern: "^([0-9]{1,5}(h|m|s|ms)){1,4}$"
													type:    "string"
												}
												sessionName: {
													description: """
	SessionName defines the name of the persistent session token
	which may be reflected in the cookie or the header. Users
	should avoid reusing session names to prevent unintended
	consequences, such as rejection or unpredictable behavior.


	Support: Implementation-specific
	"""
													maxLength: 128
													type:      "string"
												}
												type: {
													default: "Cookie"
													description: """
	Type defines the type of session persistence such as through
	the use a header or cookie. Defaults to cookie based session
	persistence.


	Support: Core for "Cookie" type


	Support: Extended for "Header" type
	"""
													enum: [
														"Cookie",
														"Header",
													]
													type: "string"
												}
											}
											type: "object"
											"x-kubernetes-validations": [{
												message: "AbsoluteTimeout must be specified when cookie lifetimeType is Permanent"
												rule:    "!has(self.cookieConfig.lifetimeType) || self.cookieConfig.lifetimeType != 'Permanent' || has(self.absoluteTimeout)"
											}]
										}
										timeouts: {
											description: """
	Timeouts defines the timeouts that can be configured for an HTTP request.


	Support: Extended



	"""
											properties: {
												backendRequest: {
													description: """
	BackendRequest specifies a timeout for an individual request from the gateway
	to a backend. This covers the time from when the request first starts being
	sent from the gateway to when the full response has been received from the backend.


	Setting a timeout to the zero duration (e.g. "0s") SHOULD disable the timeout
	completely. Implementations that cannot completely disable the timeout MUST
	instead interpret the zero duration as the longest possible value to which
	the timeout can be set.


	An entire client HTTP transaction with a gateway, covered by the Request timeout,
	may result in more than one call from the gateway to the destination backend,
	for example, if automatic retries are supported.


	Because the Request timeout encompasses the BackendRequest timeout, the value of
	BackendRequest must be <= the value of Request timeout.


	Support: Extended
	"""
													pattern: "^([0-9]{1,5}(h|m|s|ms)){1,4}$"
													type:    "string"
												}
												request: {
													description: """
	Request specifies the maximum duration for a gateway to respond to an HTTP request.
	If the gateway has not been able to respond before this deadline is met, the gateway
	MUST return a timeout error.


	For example, setting the `rules.timeouts.request` field to the value `10s` in an
	`HTTPRoute` will cause a timeout if a client request is taking longer than 10 seconds
	to complete.


	Setting a timeout to the zero duration (e.g. "0s") SHOULD disable the timeout
	completely. Implementations that cannot completely disable the timeout MUST
	instead interpret the zero duration as the longest possible value to which
	the timeout can be set.


	This timeout is intended to cover as close to the whole request-response transaction
	as possible although an implementation MAY choose to start the timeout after the entire
	request stream has been received instead of immediately after the transaction is
	initiated by the client.


	When this field is unspecified, request timeout behavior is implementation-specific.


	Support: Extended
	"""
													pattern: "^([0-9]{1,5}(h|m|s|ms)){1,4}$"
													type:    "string"
												}
											}
											type: "object"
											"x-kubernetes-validations": [{
												message: "backendRequest timeout cannot be longer than request timeout"
												rule:    "!(has(self.request) && has(self.backendRequest) && duration(self.request) != duration('0s') && duration(self.backendRequest) > duration(self.request))"
											}]
										}
									}
									type: "object"
									"x-kubernetes-validations": [{
										message: "RequestRedirect filter must not be used together with backendRefs"
										rule:    "(has(self.backendRefs) && size(self.backendRefs) > 0) ? (!has(self.filters) || self.filters.all(f, !has(f.requestRedirect))): true"
									}, {
										message: "When using RequestRedirect filter with path.replacePrefixMatch, exactly one PathPrefix match must be specified"
										rule:    "(has(self.filters) && self.filters.exists_one(f, has(f.requestRedirect) && has(f.requestRedirect.path) && f.requestRedirect.path.type == 'ReplacePrefixMatch' && has(f.requestRedirect.path.replacePrefixMatch))) ? ((size(self.matches) != 1 || !has(self.matches[0].path) || self.matches[0].path.type != 'PathPrefix') ? false : true) : true"
									}, {
										message: "When using URLRewrite filter with path.replacePrefixMatch, exactly one PathPrefix match must be specified"
										rule:    "(has(self.filters) && self.filters.exists_one(f, has(f.urlRewrite) && has(f.urlRewrite.path) && f.urlRewrite.path.type == 'ReplacePrefixMatch' && has(f.urlRewrite.path.replacePrefixMatch))) ? ((size(self.matches) != 1 || !has(self.matches[0].path) || self.matches[0].path.type != 'PathPrefix') ? false : true) : true"
									}, {
										message: "Within backendRefs, when using RequestRedirect filter with path.replacePrefixMatch, exactly one PathPrefix match must be specified"
										rule:    "(has(self.backendRefs) && self.backendRefs.exists_one(b, (has(b.filters) && b.filters.exists_one(f, has(f.requestRedirect) && has(f.requestRedirect.path) && f.requestRedirect.path.type == 'ReplacePrefixMatch' && has(f.requestRedirect.path.replacePrefixMatch))) )) ? ((size(self.matches) != 1 || !has(self.matches[0].path) || self.matches[0].path.type != 'PathPrefix') ? false : true) : true"
									}, {
										message: "Within backendRefs, When using URLRewrite filter with path.replacePrefixMatch, exactly one PathPrefix match must be specified"
										rule:    "(has(self.backendRefs) && self.backendRefs.exists_one(b, (has(b.filters) && b.filters.exists_one(f, has(f.urlRewrite) && has(f.urlRewrite.path) && f.urlRewrite.path.type == 'ReplacePrefixMatch' && has(f.urlRewrite.path.replacePrefixMatch))) )) ? ((size(self.matches) != 1 || !has(self.matches[0].path) || self.matches[0].path.type != 'PathPrefix') ? false : true) : true"
									}]
								}
								maxItems: 16
								type:     "array"
							}
						}
						type: "object"
					}
					status: {
						description: "Status defines the current state of HTTPRoute."
						properties: parents: {
							description: """
	Parents is a list of parent resources (usually Gateways) that are
	associated with the route, and the status of the route with respect to
	each parent. When this route attaches to a parent, the controller that
	manages the parent must add an entry to this list when the controller
	first sees the route and should update the entry as appropriate when the
	route or gateway is modified.


	Note that parent references that cannot be resolved by an implementation
	of this API will not be added to this list. Implementations of this API
	can only populate Route status for the Gateways/parent resources they are
	responsible for.


	A maximum of 32 Gateways will be represented in this list. An empty list
	means the route has not been attached to any Gateway.
	"""
							items: {
								description: """
	RouteParentStatus describes the status of a route with respect to an
	associated Parent.
	"""
								properties: {
									conditions: {
										description: """
	Conditions describes the status of the route with respect to the Gateway.
	Note that the route's availability is also subject to the Gateway's own
	status conditions and listener status.


	If the Route's ParentRef specifies an existing Gateway that supports
	Routes of this kind AND that Gateway's controller has sufficient access,
	then that Gateway's controller MUST set the "Accepted" condition on the
	Route, to indicate whether the route has been accepted or rejected by the
	Gateway, and why.


	A Route MUST be considered "Accepted" if at least one of the Route's
	rules is implemented by the Gateway.


	There are a number of cases where the "Accepted" condition may not be set
	due to lack of controller visibility, that includes when:


	* The Route refers to a non-existent parent.
	* The Route is of a type that the controller does not support.
	* The Route is in a namespace the controller does not have access to.
	"""
										items: {
											description: """
	Condition contains details for one aspect of the current state of this API Resource.
	---
	This struct is intended for direct use as an array at the field path .status.conditions.  For example,


	\ttype FooStatus struct{
	\t    // Represents the observations of a foo's current state.
	\t    // Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
	\t    // +patchMergeKey=type
	\t    // +patchStrategy=merge
	\t    // +listType=map
	\t    // +listMapKey=type
	\t    Conditions []metav1.Condition `json:"conditions,omitempty" patchStrategy:"merge" patchMergeKey:"type" protobuf:"bytes,1,rep,name=conditions"`


	\t    // other fields
	\t}
	"""
											properties: {
												lastTransitionTime: {
													description: """
	lastTransitionTime is the last time the condition transitioned from one status to another.
	This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
	"""
													format: "date-time"
													type:   "string"
												}
												message: {
													description: """
	message is a human readable message indicating details about the transition.
	This may be an empty string.
	"""
													maxLength: 32768
													type:      "string"
												}
												observedGeneration: {
													description: """
	observedGeneration represents the .metadata.generation that the condition was set based upon.
	For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
	with respect to the current state of the instance.
	"""
													format:  "int64"
													minimum: 0
													type:    "integer"
												}
												reason: {
													description: """
	reason contains a programmatic identifier indicating the reason for the condition's last transition.
	Producers of specific condition types may define expected values and meanings for this field,
	and whether the values are considered a guaranteed API.
	The value should be a CamelCase string.
	This field may not be empty.
	"""
													maxLength: 1024
													minLength: 1
													pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
													type:      "string"
												}
												status: {
													description: "status of the condition, one of True, False, Unknown."
													enum: [
														"True",
														"False",
														"Unknown",
													]
													type: "string"
												}
												type: {
													description: """
	type of condition in CamelCase or in foo.example.com/CamelCase.
	---
	Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be
	useful (see .node.status.conditions), the ability to deconflict is important.
	The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)
	"""
													maxLength: 316
													pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
													type:      "string"
												}
											}
											required: [
												"lastTransitionTime",
												"message",
												"reason",
												"status",
												"type",
											]
											type: "object"
										}
										maxItems: 8
										minItems: 1
										type:     "array"
										"x-kubernetes-list-map-keys": ["type"]
										"x-kubernetes-list-type": "map"
									}
									controllerName: {
										description: """
	ControllerName is a domain/path string that indicates the name of the
	controller that wrote this status. This corresponds with the
	controllerName field on GatewayClass.


	Example: "example.net/gateway-controller".


	The format of this field is DOMAIN "/" PATH, where DOMAIN and PATH are
	valid Kubernetes names
	(https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).


	Controllers MUST populate this field when writing status. Controllers should ensure that
	entries to status populated with their ControllerName are cleaned up when they are no
	longer necessary.
	"""
										maxLength: 253
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
										type:      "string"
									}
									parentRef: {
										description: """
	ParentRef corresponds with a ParentRef in the spec that this
	RouteParentStatus struct describes the status of.
	"""
										properties: {
											group: {
												default: "gateway.networking.k8s.io"
												description: """
	Group is the group of the referent.
	When unspecified, "gateway.networking.k8s.io" is inferred.
	To set the core API group (such as for a "Service" kind referent),
	Group must be explicitly set to "" (empty string).


	Support: Core
	"""
												maxLength: 253
												pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
											kind: {
												default: "Gateway"
												description: """
	Kind is kind of the referent.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	Support for other resources is Implementation-Specific.
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:      "string"
											}
											name: {
												description: """
	Name is the name of the referent.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												type:      "string"
											}
											namespace: {
												description: """
	Namespace is the namespace of the referent. When unspecified, this refers
	to the local namespace of the Route.


	Note that there are specific rules for ParentRefs which cross namespace
	boundaries. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example:
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable any other kind of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.



	Support: Core
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
												type:      "string"
											}
											port: {
												description: """
	Port is the network port this Route targets. It can be interpreted
	differently based on the type of parent resource.


	When the parent resource is a Gateway, this targets all listeners
	listening on the specified port that also support this kind of Route(and
	select this Route). It's not recommended to set `Port` unless the
	networking behaviors specified in a Route must apply to a specific port
	as opposed to a listener(s) whose port(s) may be changed. When both Port
	and SectionName are specified, the name and port of the selected listener
	must match both specified values.



	When the parent resource is a Service, this targets a specific port in the
	Service spec. When both Port (experimental) and SectionName are specified,
	the name and port of the selected port must match both specified values.



	Implementations MAY choose to support other parent resources.
	Implementations supporting other types of parent resources MUST clearly
	document how/if Port is interpreted.


	For the purpose of status, an attachment is considered successful as
	long as the parent resource accepts it partially. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
	from the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route,
	the Route MUST be considered detached from the Gateway.


	Support: Extended
	"""
												format:  "int32"
												maximum: 65535
												minimum: 1
												type:    "integer"
											}
											sectionName: {
												description: """
	SectionName is the name of a section within the target resource. In the
	following resources, SectionName is interpreted as the following:


	* Gateway: Listener name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.
	* Service: Port name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.


	Implementations MAY choose to support attaching Routes to other resources.
	If that is the case, they MUST clearly document how SectionName is
	interpreted.


	When unspecified (empty string), this will reference the entire resource.
	For the purpose of status, an attachment is considered successful if at
	least one section in the parent resource accepts it. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
	the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route, the
	Route MUST be considered detached from the Gateway.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
										}
										required: ["name"]
										type: "object"
									}
								}
								required: [
									"controllerName",
									"parentRef",
								]
								type: "object"
							}
							maxItems: 32
							type:     "array"
						}
						required: ["parents"]
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}]
	}
}, {
	metadata: {
		name: "referencegrants.gateway.networking.k8s.io"
		annotations: {
			"api-approved.kubernetes.io":               "https://github.com/kubernetes-sigs/gateway-api/pull/2997"
			"gateway.networking.k8s.io/bundle-version": "v1.1.0"
			"gateway.networking.k8s.io/channel":        "experimental"
		}
	}
	spec: {
		group: "gateway.networking.k8s.io"
		names: {
			categories: ["gateway-api"]
			kind:     "ReferenceGrant"
			listKind: "ReferenceGrantList"
			plural:   "referencegrants"
			shortNames: ["refgrant"]
			singular: "referencegrant"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			deprecated:         true
			deprecationWarning: "The v1alpha2 version of ReferenceGrant has been deprecated and will be removed in a future release of the API. Please upgrade to v1beta1."
			name:               "v1alpha2"
			schema: openAPIV3Schema: {
				description: """
					ReferenceGrant identifies kinds of resources in other namespaces that are
					trusted to reference the specified kinds of resources in the same namespace
					as the policy.


					Each ReferenceGrant can be used to represent a unique trust relationship.
					Additional Reference Grants can be used to add to the set of trusted
					sources of inbound references for the namespace they are defined within.


					A ReferenceGrant is required for all cross-namespace references in Gateway API
					(with the exception of cross-namespace Route-Gateway attachment, which is
					governed by the AllowedRoutes configuration on the Gateway, and cross-namespace
					Service ParentRefs on a "consumer" mesh Route, which defines routing rules
					applicable only to workloads in the Route namespace). ReferenceGrants allowing
					a reference from a Route to a Service are only applicable to BackendRefs.


					ReferenceGrant is a form of runtime verification allowing users to assert
					which cross-namespace object references are permitted. Implementations that
					support ReferenceGrant MUST NOT permit cross-namespace references which have
					no grant, and MUST respond to the removal of a grant by revoking the access
					that the grant allowed.
					"""
				properties: {
					apiVersion: {
						description: """
	APIVersion defines the versioned schema of this representation of an object.
	Servers should convert recognized schemas to the latest internal value, and
	may reject unrecognized values.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	"""
						type: "string"
					}
					kind: {
						description: """
	Kind is a string value representing the REST resource this object represents.
	Servers may infer this from the endpoint the client submits requests to.
	Cannot be updated.
	In CamelCase.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	"""
						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec defines the desired state of ReferenceGrant."
						properties: {
							from: {
								description: """
	From describes the trusted namespaces and kinds that can reference the
	resources described in "To". Each entry in this list MUST be considered
	to be an additional place that references can be valid from, or to put
	this another way, entries MUST be combined using OR.


	Support: Core
	"""
								items: {
									description: "ReferenceGrantFrom describes trusted namespaces and kinds."
									properties: {
										group: {
											description: """
	Group is the group of the referent.
	When empty, the Kubernetes core API group is inferred.


	Support: Core
	"""
											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											description: """
	Kind is the kind of the referent. Although implementations may support
	additional resources, the following types are part of the "Core"
	support level for this field.


	When used to permit a SecretObjectReference:


	* Gateway


	When used to permit a BackendObjectReference:


	* GRPCRoute
	* HTTPRoute
	* TCPRoute
	* TLSRoute
	* UDPRoute
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										namespace: {
											description: """
	Namespace is the namespace of the referent.


	Support: Core
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
											type:      "string"
										}
									}
									required: [
										"group",
										"kind",
										"namespace",
									]
									type: "object"
								}
								maxItems: 16
								minItems: 1
								type:     "array"
							}
							to: {
								description: """
	To describes the resources that may be referenced by the resources
	described in "From". Each entry in this list MUST be considered to be an
	additional place that references can be valid to, or to put this another
	way, entries MUST be combined using OR.


	Support: Core
	"""
								items: {
									description: """
	ReferenceGrantTo describes what Kinds are allowed as targets of the
	references.
	"""
									properties: {
										group: {
											description: """
	Group is the group of the referent.
	When empty, the Kubernetes core API group is inferred.


	Support: Core
	"""
											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											description: """
	Kind is the kind of the referent. Although implementations may support
	additional resources, the following types are part of the "Core"
	support level for this field:


	* Secret when used to permit a SecretObjectReference
	* Service when used to permit a BackendObjectReference
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										name: {
											description: """
	Name is the name of the referent. When unspecified, this policy
	refers to all resources of the specified Group and Kind in the local
	namespace.
	"""
											maxLength: 253
											minLength: 1
											type:      "string"
										}
									}
									required: [
										"group",
										"kind",
									]
									type: "object"
								}
								maxItems: 16
								minItems: 1
								type:     "array"
							}
						}
						required: [
							"from",
							"to",
						]
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: """
					ReferenceGrant identifies kinds of resources in other namespaces that are
					trusted to reference the specified kinds of resources in the same namespace
					as the policy.


					Each ReferenceGrant can be used to represent a unique trust relationship.
					Additional Reference Grants can be used to add to the set of trusted
					sources of inbound references for the namespace they are defined within.


					All cross-namespace references in Gateway API (with the exception of cross-namespace
					Gateway-route attachment) require a ReferenceGrant.


					ReferenceGrant is a form of runtime verification allowing users to assert
					which cross-namespace object references are permitted. Implementations that
					support ReferenceGrant MUST NOT permit cross-namespace references which have
					no grant, and MUST respond to the removal of a grant by revoking the access
					that the grant allowed.
					"""
				properties: {
					apiVersion: {
						description: """
	APIVersion defines the versioned schema of this representation of an object.
	Servers should convert recognized schemas to the latest internal value, and
	may reject unrecognized values.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	"""
						type: "string"
					}
					kind: {
						description: """
	Kind is a string value representing the REST resource this object represents.
	Servers may infer this from the endpoint the client submits requests to.
	Cannot be updated.
	In CamelCase.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	"""
						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec defines the desired state of ReferenceGrant."
						properties: {
							from: {
								description: """
	From describes the trusted namespaces and kinds that can reference the
	resources described in "To". Each entry in this list MUST be considered
	to be an additional place that references can be valid from, or to put
	this another way, entries MUST be combined using OR.


	Support: Core
	"""
								items: {
									description: "ReferenceGrantFrom describes trusted namespaces and kinds."
									properties: {
										group: {
											description: """
	Group is the group of the referent.
	When empty, the Kubernetes core API group is inferred.


	Support: Core
	"""
											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											description: """
	Kind is the kind of the referent. Although implementations may support
	additional resources, the following types are part of the "Core"
	support level for this field.


	When used to permit a SecretObjectReference:


	* Gateway


	When used to permit a BackendObjectReference:


	* GRPCRoute
	* HTTPRoute
	* TCPRoute
	* TLSRoute
	* UDPRoute
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										namespace: {
											description: """
	Namespace is the namespace of the referent.


	Support: Core
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
											type:      "string"
										}
									}
									required: [
										"group",
										"kind",
										"namespace",
									]
									type: "object"
								}
								maxItems: 16
								minItems: 1
								type:     "array"
							}
							to: {
								description: """
	To describes the resources that may be referenced by the resources
	described in "From". Each entry in this list MUST be considered to be an
	additional place that references can be valid to, or to put this another
	way, entries MUST be combined using OR.


	Support: Core
	"""
								items: {
									description: """
	ReferenceGrantTo describes what Kinds are allowed as targets of the
	references.
	"""
									properties: {
										group: {
											description: """
	Group is the group of the referent.
	When empty, the Kubernetes core API group is inferred.


	Support: Core
	"""
											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											description: """
	Kind is the kind of the referent. Although implementations may support
	additional resources, the following types are part of the "Core"
	support level for this field:


	* Secret when used to permit a SecretObjectReference
	* Service when used to permit a BackendObjectReference
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										name: {
											description: """
	Name is the name of the referent. When unspecified, this policy
	refers to all resources of the specified Group and Kind in the local
	namespace.
	"""
											maxLength: 253
											minLength: 1
											type:      "string"
										}
									}
									required: [
										"group",
										"kind",
									]
									type: "object"
								}
								maxItems: 16
								minItems: 1
								type:     "array"
							}
						}
						required: [
							"from",
							"to",
						]
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
}, {
	metadata: {
		name: "tcproutes.gateway.networking.k8s.io"
		annotations: {
			"api-approved.kubernetes.io":               "https://github.com/kubernetes-sigs/gateway-api/pull/2997"
			"gateway.networking.k8s.io/bundle-version": "v1.1.0"
			"gateway.networking.k8s.io/channel":        "experimental"
		}
	}
	spec: {
		group: "gateway.networking.k8s.io"
		names: {
			categories: ["gateway-api"]
			kind:     "TCPRoute"
			listKind: "TCPRouteList"
			plural:   "tcproutes"
			singular: "tcproute"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1alpha2"
			schema: openAPIV3Schema: {
				description: """
					TCPRoute provides a way to route TCP requests. When combined with a Gateway
					listener, it can be used to forward connections on the port specified by the
					listener to a set of backends specified by the TCPRoute.
					"""
				properties: {
					apiVersion: {
						description: """
	APIVersion defines the versioned schema of this representation of an object.
	Servers should convert recognized schemas to the latest internal value, and
	may reject unrecognized values.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	"""
						type: "string"
					}
					kind: {
						description: """
	Kind is a string value representing the REST resource this object represents.
	Servers may infer this from the endpoint the client submits requests to.
	Cannot be updated.
	In CamelCase.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	"""
						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec defines the desired state of TCPRoute."
						properties: {
							parentRefs: {
								description: """
	ParentRefs references the resources (usually Gateways) that a Route wants
	to be attached to. Note that the referenced parent resource needs to
	allow this for the attachment to be complete. For Gateways, that means
	the Gateway needs to allow attachment from Routes of this kind and
	namespace. For Services, that means the Service must either be in the same
	namespace for a "producer" route, or the mesh implementation must support
	and allow "consumer" routes for the referenced Service. ReferenceGrant is
	not applicable for governing ParentRefs to Services - it is not possible to
	create a "producer" route for a Service in a different namespace from the
	Route.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	This API may be extended in the future to support additional kinds of parent
	resources.


	ParentRefs must be _distinct_. This means either that:


	* They select different objects.  If this is the case, then parentRef
	  entries are distinct. In terms of fields, this means that the
	  multi-part key defined by `group`, `kind`, `namespace`, and `name` must
	  be unique across all parentRef entries in the Route.
	* They do not select different objects, but for each optional field used,
	  each ParentRef that selects the same object must set the same set of
	  optional fields to different values. If one ParentRef sets a
	  combination of optional fields, all must set the same combination.


	Some examples:


	* If one ParentRef sets `sectionName`, all ParentRefs referencing the
	  same object must also set `sectionName`.
	* If one ParentRef sets `port`, all ParentRefs referencing the same
	  object must also set `port`.
	* If one ParentRef sets `sectionName` and `port`, all ParentRefs
	  referencing the same object must also set `sectionName` and `port`.


	It is possible to separately reference multiple distinct objects that may
	be collapsed by an implementation. For example, some implementations may
	choose to merge compatible Gateway Listeners together. If that is the
	case, the list of routes attached to those resources should also be
	merged.


	Note that for ParentRefs that cross namespace boundaries, there are specific
	rules. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example,
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable other kinds of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.







	"""
								items: {
									description: """
	ParentReference identifies an API object (usually a Gateway) that can be considered
	a parent of this resource (usually a route). There are two kinds of parent resources
	with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	This API may be extended in the future to support additional kinds of parent
	resources.


	The API object must be valid in the cluster; the Group and Kind must
	be registered in the cluster for this reference to be valid.
	"""
									properties: {
										group: {
											default: "gateway.networking.k8s.io"
											description: """
	Group is the group of the referent.
	When unspecified, "gateway.networking.k8s.io" is inferred.
	To set the core API group (such as for a "Service" kind referent),
	Group must be explicitly set to "" (empty string).


	Support: Core
	"""
											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											default: "Gateway"
											description: """
	Kind is kind of the referent.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	Support for other resources is Implementation-Specific.
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										name: {
											description: """
	Name is the name of the referent.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: """
	Namespace is the namespace of the referent. When unspecified, this refers
	to the local namespace of the Route.


	Note that there are specific rules for ParentRefs which cross namespace
	boundaries. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example:
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable any other kind of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.



	Support: Core
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
											type:      "string"
										}
										port: {
											description: """
	Port is the network port this Route targets. It can be interpreted
	differently based on the type of parent resource.


	When the parent resource is a Gateway, this targets all listeners
	listening on the specified port that also support this kind of Route(and
	select this Route). It's not recommended to set `Port` unless the
	networking behaviors specified in a Route must apply to a specific port
	as opposed to a listener(s) whose port(s) may be changed. When both Port
	and SectionName are specified, the name and port of the selected listener
	must match both specified values.



	When the parent resource is a Service, this targets a specific port in the
	Service spec. When both Port (experimental) and SectionName are specified,
	the name and port of the selected port must match both specified values.



	Implementations MAY choose to support other parent resources.
	Implementations supporting other types of parent resources MUST clearly
	document how/if Port is interpreted.


	For the purpose of status, an attachment is considered successful as
	long as the parent resource accepts it partially. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
	from the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route,
	the Route MUST be considered detached from the Gateway.


	Support: Extended
	"""
											format:  "int32"
											maximum: 65535
											minimum: 1
											type:    "integer"
										}
										sectionName: {
											description: """
	SectionName is the name of a section within the target resource. In the
	following resources, SectionName is interpreted as the following:


	* Gateway: Listener name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.
	* Service: Port name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.


	Implementations MAY choose to support attaching Routes to other resources.
	If that is the case, they MUST clearly document how SectionName is
	interpreted.


	When unspecified (empty string), this will reference the entire resource.
	For the purpose of status, an attachment is considered successful if at
	least one section in the parent resource accepts it. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
	the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route, the
	Route MUST be considered detached from the Gateway.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								maxItems: 32
								type:     "array"
								"x-kubernetes-validations": [{
									message: "sectionName or port must be specified when parentRefs includes 2 or more references to the same parent"
									rule:    "self.all(p1, self.all(p2, p1.group == p2.group && p1.kind == p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) || p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ == '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__ == p2.__namespace__)) ? ((!has(p1.sectionName) || p1.sectionName == '') == (!has(p2.sectionName) || p2.sectionName == '') && (!has(p1.port) || p1.port == 0) == (!has(p2.port) || p2.port == 0)): true))"
								}, {
									message: "sectionName or port must be unique when parentRefs includes 2 or more references to the same parent"
									rule:    "self.all(p1, self.exists_one(p2, p1.group == p2.group && p1.kind == p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) || p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ == '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__ == p2.__namespace__ )) && (((!has(p1.sectionName) || p1.sectionName == '') && (!has(p2.sectionName) || p2.sectionName == '')) || ( has(p1.sectionName) && has(p2.sectionName) && p1.sectionName == p2.sectionName)) && (((!has(p1.port) || p1.port == 0) && (!has(p2.port) || p2.port == 0)) || (has(p1.port) && has(p2.port) && p1.port == p2.port))))"
								}]
							}
							rules: {
								description: "Rules are a list of TCP matchers and actions."
								items: {
									description: "TCPRouteRule is the configuration for a given rule."
									properties: backendRefs: {
										description: """
	BackendRefs defines the backend(s) where matching requests should be
	sent. If unspecified or invalid (refers to a non-existent resource or a
	Service with no endpoints), the underlying implementation MUST actively
	reject connection attempts to this backend. Connection rejections must
	respect weight; if an invalid backend is requested to have 80% of
	connections, then 80% of connections must be rejected instead.


	Support: Core for Kubernetes Service


	Support: Extended for Kubernetes ServiceImport


	Support: Implementation-specific for any other resource


	Support for weight: Extended
	"""
										items: {
											description: """
	BackendRef defines how a Route should forward a request to a Kubernetes
	resource.


	Note that when a namespace different than the local namespace is specified, a
	ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	<gateway:experimental:description>


	When the BackendRef points to a Kubernetes Service, implementations SHOULD
	honor the appProtocol field if it is set for the target Service Port.


	Implementations supporting appProtocol SHOULD recognize the Kubernetes
	Standard Application Protocols defined in KEP-3726.


	If a Service appProtocol isn't specified, an implementation MAY infer the
	backend protocol through its own means. Implementations MAY infer the
	protocol from the Route type referring to the backend Service.


	If a Route is not able to send traffic to the backend using the specified
	protocol then the backend is considered invalid. Implementations MUST set the
	"ResolvedRefs" condition to "False" with the "UnsupportedProtocol" reason.


	</gateway:experimental:description>


	Note that when the BackendTLSPolicy object is enabled by the implementation,
	there are some extra rules about validity to consider here. See the fields
	where this struct is used for more information about the exact behavior.
	"""
											properties: {
												group: {
													default: ""
													description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
													maxLength: 253
													pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
													type:      "string"
												}
												kind: {
													default: "Service"
													description: """
	Kind is the Kubernetes resource kind of the referent. For example
	"Service".


	Defaults to "Service" when not specified.


	ExternalName services can refer to CNAME DNS records that may live
	outside of the cluster and as such are difficult to reason about in
	terms of conformance. They also may not be safe to forward to (see
	CVE-2021-25740 for more information). Implementations SHOULD NOT
	support ExternalName Services.


	Support: Core (Services with a type other than ExternalName)


	Support: Implementation-specific (Services with type ExternalName)
	"""
													maxLength: 63
													minLength: 1
													pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
													type:      "string"
												}
												name: {
													description: "Name is the name of the referent."
													maxLength:   253
													minLength:   1
													type:        "string"
												}
												namespace: {
													description: """
	Namespace is the namespace of the backend. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
													maxLength: 63
													minLength: 1
													pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
													type:      "string"
												}
												port: {
													description: """
	Port specifies the destination port number to use for this resource.
	Port is required when the referent is a Kubernetes Service. In this
	case, the port number is the service port number, not the target port.
	For other resources, destination port might be derived from the referent
	resource or this field.
	"""
													format:  "int32"
													maximum: 65535
													minimum: 1
													type:    "integer"
												}
												weight: {
													default: 1
													description: """
	Weight specifies the proportion of requests forwarded to the referenced
	backend. This is computed as weight/(sum of all weights in this
	BackendRefs list). For non-zero values, there may be some epsilon from
	the exact proportion defined here depending on the precision an
	implementation supports. Weight is not a percentage and the sum of
	weights does not need to equal 100.


	If only one backend is specified and it has a weight greater than 0, 100%
	of the traffic is forwarded to that backend. If weight is set to 0, no
	traffic should be forwarded for this entry. If unspecified, weight
	defaults to 1.


	Support for this field varies based on the context where used.
	"""
													format:  "int32"
													maximum: 1000000
													minimum: 0
													type:    "integer"
												}
											}
											required: ["name"]
											type: "object"
											"x-kubernetes-validations": [{
												message: "Must have port for Service reference"
												rule:    "(size(self.group) == 0 && self.kind == 'Service') ? has(self.port) : true"
											}]
										}
										maxItems: 16
										minItems: 1
										type:     "array"
									}
									type: "object"
								}
								maxItems: 16
								minItems: 1
								type:     "array"
							}
						}
						required: ["rules"]
						type: "object"
					}
					status: {
						description: "Status defines the current state of TCPRoute."
						properties: parents: {
							description: """
	Parents is a list of parent resources (usually Gateways) that are
	associated with the route, and the status of the route with respect to
	each parent. When this route attaches to a parent, the controller that
	manages the parent must add an entry to this list when the controller
	first sees the route and should update the entry as appropriate when the
	route or gateway is modified.


	Note that parent references that cannot be resolved by an implementation
	of this API will not be added to this list. Implementations of this API
	can only populate Route status for the Gateways/parent resources they are
	responsible for.


	A maximum of 32 Gateways will be represented in this list. An empty list
	means the route has not been attached to any Gateway.
	"""
							items: {
								description: """
	RouteParentStatus describes the status of a route with respect to an
	associated Parent.
	"""
								properties: {
									conditions: {
										description: """
	Conditions describes the status of the route with respect to the Gateway.
	Note that the route's availability is also subject to the Gateway's own
	status conditions and listener status.


	If the Route's ParentRef specifies an existing Gateway that supports
	Routes of this kind AND that Gateway's controller has sufficient access,
	then that Gateway's controller MUST set the "Accepted" condition on the
	Route, to indicate whether the route has been accepted or rejected by the
	Gateway, and why.


	A Route MUST be considered "Accepted" if at least one of the Route's
	rules is implemented by the Gateway.


	There are a number of cases where the "Accepted" condition may not be set
	due to lack of controller visibility, that includes when:


	* The Route refers to a non-existent parent.
	* The Route is of a type that the controller does not support.
	* The Route is in a namespace the controller does not have access to.
	"""
										items: {
											description: """
	Condition contains details for one aspect of the current state of this API Resource.
	---
	This struct is intended for direct use as an array at the field path .status.conditions.  For example,


	\ttype FooStatus struct{
	\t    // Represents the observations of a foo's current state.
	\t    // Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
	\t    // +patchMergeKey=type
	\t    // +patchStrategy=merge
	\t    // +listType=map
	\t    // +listMapKey=type
	\t    Conditions []metav1.Condition `json:"conditions,omitempty" patchStrategy:"merge" patchMergeKey:"type" protobuf:"bytes,1,rep,name=conditions"`


	\t    // other fields
	\t}
	"""
											properties: {
												lastTransitionTime: {
													description: """
	lastTransitionTime is the last time the condition transitioned from one status to another.
	This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
	"""
													format: "date-time"
													type:   "string"
												}
												message: {
													description: """
	message is a human readable message indicating details about the transition.
	This may be an empty string.
	"""
													maxLength: 32768
													type:      "string"
												}
												observedGeneration: {
													description: """
	observedGeneration represents the .metadata.generation that the condition was set based upon.
	For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
	with respect to the current state of the instance.
	"""
													format:  "int64"
													minimum: 0
													type:    "integer"
												}
												reason: {
													description: """
	reason contains a programmatic identifier indicating the reason for the condition's last transition.
	Producers of specific condition types may define expected values and meanings for this field,
	and whether the values are considered a guaranteed API.
	The value should be a CamelCase string.
	This field may not be empty.
	"""
													maxLength: 1024
													minLength: 1
													pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
													type:      "string"
												}
												status: {
													description: "status of the condition, one of True, False, Unknown."
													enum: [
														"True",
														"False",
														"Unknown",
													]
													type: "string"
												}
												type: {
													description: """
	type of condition in CamelCase or in foo.example.com/CamelCase.
	---
	Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be
	useful (see .node.status.conditions), the ability to deconflict is important.
	The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)
	"""
													maxLength: 316
													pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
													type:      "string"
												}
											}
											required: [
												"lastTransitionTime",
												"message",
												"reason",
												"status",
												"type",
											]
											type: "object"
										}
										maxItems: 8
										minItems: 1
										type:     "array"
										"x-kubernetes-list-map-keys": ["type"]
										"x-kubernetes-list-type": "map"
									}
									controllerName: {
										description: """
	ControllerName is a domain/path string that indicates the name of the
	controller that wrote this status. This corresponds with the
	controllerName field on GatewayClass.


	Example: "example.net/gateway-controller".


	The format of this field is DOMAIN "/" PATH, where DOMAIN and PATH are
	valid Kubernetes names
	(https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).


	Controllers MUST populate this field when writing status. Controllers should ensure that
	entries to status populated with their ControllerName are cleaned up when they are no
	longer necessary.
	"""
										maxLength: 253
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
										type:      "string"
									}
									parentRef: {
										description: """
	ParentRef corresponds with a ParentRef in the spec that this
	RouteParentStatus struct describes the status of.
	"""
										properties: {
											group: {
												default: "gateway.networking.k8s.io"
												description: """
	Group is the group of the referent.
	When unspecified, "gateway.networking.k8s.io" is inferred.
	To set the core API group (such as for a "Service" kind referent),
	Group must be explicitly set to "" (empty string).


	Support: Core
	"""
												maxLength: 253
												pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
											kind: {
												default: "Gateway"
												description: """
	Kind is kind of the referent.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	Support for other resources is Implementation-Specific.
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:      "string"
											}
											name: {
												description: """
	Name is the name of the referent.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												type:      "string"
											}
											namespace: {
												description: """
	Namespace is the namespace of the referent. When unspecified, this refers
	to the local namespace of the Route.


	Note that there are specific rules for ParentRefs which cross namespace
	boundaries. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example:
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable any other kind of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.



	Support: Core
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
												type:      "string"
											}
											port: {
												description: """
	Port is the network port this Route targets. It can be interpreted
	differently based on the type of parent resource.


	When the parent resource is a Gateway, this targets all listeners
	listening on the specified port that also support this kind of Route(and
	select this Route). It's not recommended to set `Port` unless the
	networking behaviors specified in a Route must apply to a specific port
	as opposed to a listener(s) whose port(s) may be changed. When both Port
	and SectionName are specified, the name and port of the selected listener
	must match both specified values.



	When the parent resource is a Service, this targets a specific port in the
	Service spec. When both Port (experimental) and SectionName are specified,
	the name and port of the selected port must match both specified values.



	Implementations MAY choose to support other parent resources.
	Implementations supporting other types of parent resources MUST clearly
	document how/if Port is interpreted.


	For the purpose of status, an attachment is considered successful as
	long as the parent resource accepts it partially. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
	from the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route,
	the Route MUST be considered detached from the Gateway.


	Support: Extended
	"""
												format:  "int32"
												maximum: 65535
												minimum: 1
												type:    "integer"
											}
											sectionName: {
												description: """
	SectionName is the name of a section within the target resource. In the
	following resources, SectionName is interpreted as the following:


	* Gateway: Listener name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.
	* Service: Port name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.


	Implementations MAY choose to support attaching Routes to other resources.
	If that is the case, they MUST clearly document how SectionName is
	interpreted.


	When unspecified (empty string), this will reference the entire resource.
	For the purpose of status, an attachment is considered successful if at
	least one section in the parent resource accepts it. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
	the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route, the
	Route MUST be considered detached from the Gateway.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
										}
										required: ["name"]
										type: "object"
									}
								}
								required: [
									"controllerName",
									"parentRef",
								]
								type: "object"
							}
							maxItems: 32
							type:     "array"
						}
						required: ["parents"]
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}, {
	metadata: {
		name: "tlsroutes.gateway.networking.k8s.io"
		annotations: {
			"api-approved.kubernetes.io":               "https://github.com/kubernetes-sigs/gateway-api/pull/2997"
			"gateway.networking.k8s.io/bundle-version": "v1.1.0"
			"gateway.networking.k8s.io/channel":        "experimental"
		}
	}
	spec: {
		group: "gateway.networking.k8s.io"
		names: {
			categories: ["gateway-api"]
			kind:     "TLSRoute"
			listKind: "TLSRouteList"
			plural:   "tlsroutes"
			singular: "tlsroute"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1alpha2"
			schema: openAPIV3Schema: {
				description: """
					The TLSRoute resource is similar to TCPRoute, but can be configured
					to match against TLS-specific metadata. This allows more flexibility
					in matching streams for a given TLS listener.


					If you need to forward traffic to a single target for a TLS listener, you
					could choose to use a TCPRoute with a TLS listener.
					"""
				properties: {
					apiVersion: {
						description: """
	APIVersion defines the versioned schema of this representation of an object.
	Servers should convert recognized schemas to the latest internal value, and
	may reject unrecognized values.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	"""
						type: "string"
					}
					kind: {
						description: """
	Kind is a string value representing the REST resource this object represents.
	Servers may infer this from the endpoint the client submits requests to.
	Cannot be updated.
	In CamelCase.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	"""
						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec defines the desired state of TLSRoute."
						properties: {
							hostnames: {
								description: """
	Hostnames defines a set of SNI names that should match against the
	SNI attribute of TLS ClientHello message in TLS handshake. This matches
	the RFC 1123 definition of a hostname with 2 notable exceptions:


	1. IPs are not allowed in SNI names per RFC 6066.
	2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard
	   label must appear by itself as the first label.


	If a hostname is specified by both the Listener and TLSRoute, there
	must be at least one intersecting hostname for the TLSRoute to be
	attached to the Listener. For example:


	* A Listener with `test.example.com` as the hostname matches TLSRoutes
	  that have either not specified any hostnames, or have specified at
	  least one of `test.example.com` or `*.example.com`.
	* A Listener with `*.example.com` as the hostname matches TLSRoutes
	  that have either not specified any hostnames or have specified at least
	  one hostname that matches the Listener hostname. For example,
	  `test.example.com` and `*.example.com` would both match. On the other
	  hand, `example.com` and `test.example.net` would not match.


	If both the Listener and TLSRoute have specified hostnames, any
	TLSRoute hostnames that do not match the Listener hostname MUST be
	ignored. For example, if a Listener specified `*.example.com`, and the
	TLSRoute specified `test.example.com` and `test.example.net`,
	`test.example.net` must not be considered for a match.


	If both the Listener and TLSRoute have specified hostnames, and none
	match with the criteria above, then the TLSRoute is not accepted. The
	implementation must raise an 'Accepted' Condition with a status of
	`False` in the corresponding RouteParentStatus.


	Support: Core
	"""
								items: {
									description: """
	Hostname is the fully qualified domain name of a network host. This matches
	the RFC 1123 definition of a hostname with 2 notable exceptions:


	 1. IPs are not allowed.
	 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard
	    label must appear by itself as the first label.


	Hostname can be "precise" which is a domain name without the terminating
	dot of a network host (e.g. "foo.example.com") or "wildcard", which is a
	domain name prefixed with a single wildcard label (e.g. `*.example.com`).


	Note that as per RFC1035 and RFC1123, a *label* must consist of lower case
	alphanumeric characters or '-', and must start and end with an alphanumeric
	character. No other punctuation is allowed.
	"""
									maxLength: 253
									minLength: 1
									pattern:   "^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
									type:      "string"
								}
								maxItems: 16
								type:     "array"
							}
							parentRefs: {
								description: """
	ParentRefs references the resources (usually Gateways) that a Route wants
	to be attached to. Note that the referenced parent resource needs to
	allow this for the attachment to be complete. For Gateways, that means
	the Gateway needs to allow attachment from Routes of this kind and
	namespace. For Services, that means the Service must either be in the same
	namespace for a "producer" route, or the mesh implementation must support
	and allow "consumer" routes for the referenced Service. ReferenceGrant is
	not applicable for governing ParentRefs to Services - it is not possible to
	create a "producer" route for a Service in a different namespace from the
	Route.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	This API may be extended in the future to support additional kinds of parent
	resources.


	ParentRefs must be _distinct_. This means either that:


	* They select different objects.  If this is the case, then parentRef
	  entries are distinct. In terms of fields, this means that the
	  multi-part key defined by `group`, `kind`, `namespace`, and `name` must
	  be unique across all parentRef entries in the Route.
	* They do not select different objects, but for each optional field used,
	  each ParentRef that selects the same object must set the same set of
	  optional fields to different values. If one ParentRef sets a
	  combination of optional fields, all must set the same combination.


	Some examples:


	* If one ParentRef sets `sectionName`, all ParentRefs referencing the
	  same object must also set `sectionName`.
	* If one ParentRef sets `port`, all ParentRefs referencing the same
	  object must also set `port`.
	* If one ParentRef sets `sectionName` and `port`, all ParentRefs
	  referencing the same object must also set `sectionName` and `port`.


	It is possible to separately reference multiple distinct objects that may
	be collapsed by an implementation. For example, some implementations may
	choose to merge compatible Gateway Listeners together. If that is the
	case, the list of routes attached to those resources should also be
	merged.


	Note that for ParentRefs that cross namespace boundaries, there are specific
	rules. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example,
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable other kinds of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.







	"""
								items: {
									description: """
	ParentReference identifies an API object (usually a Gateway) that can be considered
	a parent of this resource (usually a route). There are two kinds of parent resources
	with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	This API may be extended in the future to support additional kinds of parent
	resources.


	The API object must be valid in the cluster; the Group and Kind must
	be registered in the cluster for this reference to be valid.
	"""
									properties: {
										group: {
											default: "gateway.networking.k8s.io"
											description: """
	Group is the group of the referent.
	When unspecified, "gateway.networking.k8s.io" is inferred.
	To set the core API group (such as for a "Service" kind referent),
	Group must be explicitly set to "" (empty string).


	Support: Core
	"""
											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											default: "Gateway"
											description: """
	Kind is kind of the referent.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	Support for other resources is Implementation-Specific.
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										name: {
											description: """
	Name is the name of the referent.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: """
	Namespace is the namespace of the referent. When unspecified, this refers
	to the local namespace of the Route.


	Note that there are specific rules for ParentRefs which cross namespace
	boundaries. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example:
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable any other kind of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.



	Support: Core
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
											type:      "string"
										}
										port: {
											description: """
	Port is the network port this Route targets. It can be interpreted
	differently based on the type of parent resource.


	When the parent resource is a Gateway, this targets all listeners
	listening on the specified port that also support this kind of Route(and
	select this Route). It's not recommended to set `Port` unless the
	networking behaviors specified in a Route must apply to a specific port
	as opposed to a listener(s) whose port(s) may be changed. When both Port
	and SectionName are specified, the name and port of the selected listener
	must match both specified values.



	When the parent resource is a Service, this targets a specific port in the
	Service spec. When both Port (experimental) and SectionName are specified,
	the name and port of the selected port must match both specified values.



	Implementations MAY choose to support other parent resources.
	Implementations supporting other types of parent resources MUST clearly
	document how/if Port is interpreted.


	For the purpose of status, an attachment is considered successful as
	long as the parent resource accepts it partially. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
	from the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route,
	the Route MUST be considered detached from the Gateway.


	Support: Extended
	"""
											format:  "int32"
											maximum: 65535
											minimum: 1
											type:    "integer"
										}
										sectionName: {
											description: """
	SectionName is the name of a section within the target resource. In the
	following resources, SectionName is interpreted as the following:


	* Gateway: Listener name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.
	* Service: Port name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.


	Implementations MAY choose to support attaching Routes to other resources.
	If that is the case, they MUST clearly document how SectionName is
	interpreted.


	When unspecified (empty string), this will reference the entire resource.
	For the purpose of status, an attachment is considered successful if at
	least one section in the parent resource accepts it. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
	the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route, the
	Route MUST be considered detached from the Gateway.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								maxItems: 32
								type:     "array"
								"x-kubernetes-validations": [{
									message: "sectionName or port must be specified when parentRefs includes 2 or more references to the same parent"
									rule:    "self.all(p1, self.all(p2, p1.group == p2.group && p1.kind == p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) || p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ == '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__ == p2.__namespace__)) ? ((!has(p1.sectionName) || p1.sectionName == '') == (!has(p2.sectionName) || p2.sectionName == '') && (!has(p1.port) || p1.port == 0) == (!has(p2.port) || p2.port == 0)): true))"
								}, {
									message: "sectionName or port must be unique when parentRefs includes 2 or more references to the same parent"
									rule:    "self.all(p1, self.exists_one(p2, p1.group == p2.group && p1.kind == p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) || p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ == '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__ == p2.__namespace__ )) && (((!has(p1.sectionName) || p1.sectionName == '') && (!has(p2.sectionName) || p2.sectionName == '')) || ( has(p1.sectionName) && has(p2.sectionName) && p1.sectionName == p2.sectionName)) && (((!has(p1.port) || p1.port == 0) && (!has(p2.port) || p2.port == 0)) || (has(p1.port) && has(p2.port) && p1.port == p2.port))))"
								}]
							}
							rules: {
								description: "Rules are a list of TLS matchers and actions."
								items: {
									description: "TLSRouteRule is the configuration for a given rule."
									properties: backendRefs: {
										description: """
	BackendRefs defines the backend(s) where matching requests should be
	sent. If unspecified or invalid (refers to a non-existent resource or
	a Service with no endpoints), the rule performs no forwarding; if no
	filters are specified that would result in a response being sent, the
	underlying implementation must actively reject request attempts to this
	backend, by rejecting the connection or returning a 500 status code.
	Request rejections must respect weight; if an invalid backend is
	requested to have 80% of requests, then 80% of requests must be rejected
	instead.


	Support: Core for Kubernetes Service


	Support: Extended for Kubernetes ServiceImport


	Support: Implementation-specific for any other resource


	Support for weight: Extended
	"""
										items: {
											description: """
	BackendRef defines how a Route should forward a request to a Kubernetes
	resource.


	Note that when a namespace different than the local namespace is specified, a
	ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	<gateway:experimental:description>


	When the BackendRef points to a Kubernetes Service, implementations SHOULD
	honor the appProtocol field if it is set for the target Service Port.


	Implementations supporting appProtocol SHOULD recognize the Kubernetes
	Standard Application Protocols defined in KEP-3726.


	If a Service appProtocol isn't specified, an implementation MAY infer the
	backend protocol through its own means. Implementations MAY infer the
	protocol from the Route type referring to the backend Service.


	If a Route is not able to send traffic to the backend using the specified
	protocol then the backend is considered invalid. Implementations MUST set the
	"ResolvedRefs" condition to "False" with the "UnsupportedProtocol" reason.


	</gateway:experimental:description>


	Note that when the BackendTLSPolicy object is enabled by the implementation,
	there are some extra rules about validity to consider here. See the fields
	where this struct is used for more information about the exact behavior.
	"""
											properties: {
												group: {
													default: ""
													description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
													maxLength: 253
													pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
													type:      "string"
												}
												kind: {
													default: "Service"
													description: """
	Kind is the Kubernetes resource kind of the referent. For example
	"Service".


	Defaults to "Service" when not specified.


	ExternalName services can refer to CNAME DNS records that may live
	outside of the cluster and as such are difficult to reason about in
	terms of conformance. They also may not be safe to forward to (see
	CVE-2021-25740 for more information). Implementations SHOULD NOT
	support ExternalName Services.


	Support: Core (Services with a type other than ExternalName)


	Support: Implementation-specific (Services with type ExternalName)
	"""
													maxLength: 63
													minLength: 1
													pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
													type:      "string"
												}
												name: {
													description: "Name is the name of the referent."
													maxLength:   253
													minLength:   1
													type:        "string"
												}
												namespace: {
													description: """
	Namespace is the namespace of the backend. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
													maxLength: 63
													minLength: 1
													pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
													type:      "string"
												}
												port: {
													description: """
	Port specifies the destination port number to use for this resource.
	Port is required when the referent is a Kubernetes Service. In this
	case, the port number is the service port number, not the target port.
	For other resources, destination port might be derived from the referent
	resource or this field.
	"""
													format:  "int32"
													maximum: 65535
													minimum: 1
													type:    "integer"
												}
												weight: {
													default: 1
													description: """
	Weight specifies the proportion of requests forwarded to the referenced
	backend. This is computed as weight/(sum of all weights in this
	BackendRefs list). For non-zero values, there may be some epsilon from
	the exact proportion defined here depending on the precision an
	implementation supports. Weight is not a percentage and the sum of
	weights does not need to equal 100.


	If only one backend is specified and it has a weight greater than 0, 100%
	of the traffic is forwarded to that backend. If weight is set to 0, no
	traffic should be forwarded for this entry. If unspecified, weight
	defaults to 1.


	Support for this field varies based on the context where used.
	"""
													format:  "int32"
													maximum: 1000000
													minimum: 0
													type:    "integer"
												}
											}
											required: ["name"]
											type: "object"
											"x-kubernetes-validations": [{
												message: "Must have port for Service reference"
												rule:    "(size(self.group) == 0 && self.kind == 'Service') ? has(self.port) : true"
											}]
										}
										maxItems: 16
										minItems: 1
										type:     "array"
									}
									type: "object"
								}
								maxItems: 16
								minItems: 1
								type:     "array"
							}
						}
						required: ["rules"]
						type: "object"
					}
					status: {
						description: "Status defines the current state of TLSRoute."
						properties: parents: {
							description: """
	Parents is a list of parent resources (usually Gateways) that are
	associated with the route, and the status of the route with respect to
	each parent. When this route attaches to a parent, the controller that
	manages the parent must add an entry to this list when the controller
	first sees the route and should update the entry as appropriate when the
	route or gateway is modified.


	Note that parent references that cannot be resolved by an implementation
	of this API will not be added to this list. Implementations of this API
	can only populate Route status for the Gateways/parent resources they are
	responsible for.


	A maximum of 32 Gateways will be represented in this list. An empty list
	means the route has not been attached to any Gateway.
	"""
							items: {
								description: """
	RouteParentStatus describes the status of a route with respect to an
	associated Parent.
	"""
								properties: {
									conditions: {
										description: """
	Conditions describes the status of the route with respect to the Gateway.
	Note that the route's availability is also subject to the Gateway's own
	status conditions and listener status.


	If the Route's ParentRef specifies an existing Gateway that supports
	Routes of this kind AND that Gateway's controller has sufficient access,
	then that Gateway's controller MUST set the "Accepted" condition on the
	Route, to indicate whether the route has been accepted or rejected by the
	Gateway, and why.


	A Route MUST be considered "Accepted" if at least one of the Route's
	rules is implemented by the Gateway.


	There are a number of cases where the "Accepted" condition may not be set
	due to lack of controller visibility, that includes when:


	* The Route refers to a non-existent parent.
	* The Route is of a type that the controller does not support.
	* The Route is in a namespace the controller does not have access to.
	"""
										items: {
											description: """
	Condition contains details for one aspect of the current state of this API Resource.
	---
	This struct is intended for direct use as an array at the field path .status.conditions.  For example,


	\ttype FooStatus struct{
	\t    // Represents the observations of a foo's current state.
	\t    // Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
	\t    // +patchMergeKey=type
	\t    // +patchStrategy=merge
	\t    // +listType=map
	\t    // +listMapKey=type
	\t    Conditions []metav1.Condition `json:"conditions,omitempty" patchStrategy:"merge" patchMergeKey:"type" protobuf:"bytes,1,rep,name=conditions"`


	\t    // other fields
	\t}
	"""
											properties: {
												lastTransitionTime: {
													description: """
	lastTransitionTime is the last time the condition transitioned from one status to another.
	This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
	"""
													format: "date-time"
													type:   "string"
												}
												message: {
													description: """
	message is a human readable message indicating details about the transition.
	This may be an empty string.
	"""
													maxLength: 32768
													type:      "string"
												}
												observedGeneration: {
													description: """
	observedGeneration represents the .metadata.generation that the condition was set based upon.
	For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
	with respect to the current state of the instance.
	"""
													format:  "int64"
													minimum: 0
													type:    "integer"
												}
												reason: {
													description: """
	reason contains a programmatic identifier indicating the reason for the condition's last transition.
	Producers of specific condition types may define expected values and meanings for this field,
	and whether the values are considered a guaranteed API.
	The value should be a CamelCase string.
	This field may not be empty.
	"""
													maxLength: 1024
													minLength: 1
													pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
													type:      "string"
												}
												status: {
													description: "status of the condition, one of True, False, Unknown."
													enum: [
														"True",
														"False",
														"Unknown",
													]
													type: "string"
												}
												type: {
													description: """
	type of condition in CamelCase or in foo.example.com/CamelCase.
	---
	Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be
	useful (see .node.status.conditions), the ability to deconflict is important.
	The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)
	"""
													maxLength: 316
													pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
													type:      "string"
												}
											}
											required: [
												"lastTransitionTime",
												"message",
												"reason",
												"status",
												"type",
											]
											type: "object"
										}
										maxItems: 8
										minItems: 1
										type:     "array"
										"x-kubernetes-list-map-keys": ["type"]
										"x-kubernetes-list-type": "map"
									}
									controllerName: {
										description: """
	ControllerName is a domain/path string that indicates the name of the
	controller that wrote this status. This corresponds with the
	controllerName field on GatewayClass.


	Example: "example.net/gateway-controller".


	The format of this field is DOMAIN "/" PATH, where DOMAIN and PATH are
	valid Kubernetes names
	(https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).


	Controllers MUST populate this field when writing status. Controllers should ensure that
	entries to status populated with their ControllerName are cleaned up when they are no
	longer necessary.
	"""
										maxLength: 253
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
										type:      "string"
									}
									parentRef: {
										description: """
	ParentRef corresponds with a ParentRef in the spec that this
	RouteParentStatus struct describes the status of.
	"""
										properties: {
											group: {
												default: "gateway.networking.k8s.io"
												description: """
	Group is the group of the referent.
	When unspecified, "gateway.networking.k8s.io" is inferred.
	To set the core API group (such as for a "Service" kind referent),
	Group must be explicitly set to "" (empty string).


	Support: Core
	"""
												maxLength: 253
												pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
											kind: {
												default: "Gateway"
												description: """
	Kind is kind of the referent.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	Support for other resources is Implementation-Specific.
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:      "string"
											}
											name: {
												description: """
	Name is the name of the referent.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												type:      "string"
											}
											namespace: {
												description: """
	Namespace is the namespace of the referent. When unspecified, this refers
	to the local namespace of the Route.


	Note that there are specific rules for ParentRefs which cross namespace
	boundaries. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example:
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable any other kind of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.



	Support: Core
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
												type:      "string"
											}
											port: {
												description: """
	Port is the network port this Route targets. It can be interpreted
	differently based on the type of parent resource.


	When the parent resource is a Gateway, this targets all listeners
	listening on the specified port that also support this kind of Route(and
	select this Route). It's not recommended to set `Port` unless the
	networking behaviors specified in a Route must apply to a specific port
	as opposed to a listener(s) whose port(s) may be changed. When both Port
	and SectionName are specified, the name and port of the selected listener
	must match both specified values.



	When the parent resource is a Service, this targets a specific port in the
	Service spec. When both Port (experimental) and SectionName are specified,
	the name and port of the selected port must match both specified values.



	Implementations MAY choose to support other parent resources.
	Implementations supporting other types of parent resources MUST clearly
	document how/if Port is interpreted.


	For the purpose of status, an attachment is considered successful as
	long as the parent resource accepts it partially. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
	from the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route,
	the Route MUST be considered detached from the Gateway.


	Support: Extended
	"""
												format:  "int32"
												maximum: 65535
												minimum: 1
												type:    "integer"
											}
											sectionName: {
												description: """
	SectionName is the name of a section within the target resource. In the
	following resources, SectionName is interpreted as the following:


	* Gateway: Listener name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.
	* Service: Port name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.


	Implementations MAY choose to support attaching Routes to other resources.
	If that is the case, they MUST clearly document how SectionName is
	interpreted.


	When unspecified (empty string), this will reference the entire resource.
	For the purpose of status, an attachment is considered successful if at
	least one section in the parent resource accepts it. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
	the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route, the
	Route MUST be considered detached from the Gateway.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
										}
										required: ["name"]
										type: "object"
									}
								}
								required: [
									"controllerName",
									"parentRef",
								]
								type: "object"
							}
							maxItems: 32
							type:     "array"
						}
						required: ["parents"]
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}, {
	metadata: {
		name: "udproutes.gateway.networking.k8s.io"
		annotations: {
			"api-approved.kubernetes.io":               "https://github.com/kubernetes-sigs/gateway-api/pull/2997"
			"gateway.networking.k8s.io/bundle-version": "v1.1.0"
			"gateway.networking.k8s.io/channel":        "experimental"
		}
	}
	spec: {
		group: "gateway.networking.k8s.io"
		names: {
			categories: ["gateway-api"]
			kind:     "UDPRoute"
			listKind: "UDPRouteList"
			plural:   "udproutes"
			singular: "udproute"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1alpha2"
			schema: openAPIV3Schema: {
				description: """
					UDPRoute provides a way to route UDP traffic. When combined with a Gateway
					listener, it can be used to forward traffic on the port specified by the
					listener to a set of backends specified by the UDPRoute.
					"""
				properties: {
					apiVersion: {
						description: """
	APIVersion defines the versioned schema of this representation of an object.
	Servers should convert recognized schemas to the latest internal value, and
	may reject unrecognized values.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	"""
						type: "string"
					}
					kind: {
						description: """
	Kind is a string value representing the REST resource this object represents.
	Servers may infer this from the endpoint the client submits requests to.
	Cannot be updated.
	In CamelCase.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	"""
						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec defines the desired state of UDPRoute."
						properties: {
							parentRefs: {
								description: """
	ParentRefs references the resources (usually Gateways) that a Route wants
	to be attached to. Note that the referenced parent resource needs to
	allow this for the attachment to be complete. For Gateways, that means
	the Gateway needs to allow attachment from Routes of this kind and
	namespace. For Services, that means the Service must either be in the same
	namespace for a "producer" route, or the mesh implementation must support
	and allow "consumer" routes for the referenced Service. ReferenceGrant is
	not applicable for governing ParentRefs to Services - it is not possible to
	create a "producer" route for a Service in a different namespace from the
	Route.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	This API may be extended in the future to support additional kinds of parent
	resources.


	ParentRefs must be _distinct_. This means either that:


	* They select different objects.  If this is the case, then parentRef
	  entries are distinct. In terms of fields, this means that the
	  multi-part key defined by `group`, `kind`, `namespace`, and `name` must
	  be unique across all parentRef entries in the Route.
	* They do not select different objects, but for each optional field used,
	  each ParentRef that selects the same object must set the same set of
	  optional fields to different values. If one ParentRef sets a
	  combination of optional fields, all must set the same combination.


	Some examples:


	* If one ParentRef sets `sectionName`, all ParentRefs referencing the
	  same object must also set `sectionName`.
	* If one ParentRef sets `port`, all ParentRefs referencing the same
	  object must also set `port`.
	* If one ParentRef sets `sectionName` and `port`, all ParentRefs
	  referencing the same object must also set `sectionName` and `port`.


	It is possible to separately reference multiple distinct objects that may
	be collapsed by an implementation. For example, some implementations may
	choose to merge compatible Gateway Listeners together. If that is the
	case, the list of routes attached to those resources should also be
	merged.


	Note that for ParentRefs that cross namespace boundaries, there are specific
	rules. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example,
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable other kinds of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.







	"""
								items: {
									description: """
	ParentReference identifies an API object (usually a Gateway) that can be considered
	a parent of this resource (usually a route). There are two kinds of parent resources
	with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	This API may be extended in the future to support additional kinds of parent
	resources.


	The API object must be valid in the cluster; the Group and Kind must
	be registered in the cluster for this reference to be valid.
	"""
									properties: {
										group: {
											default: "gateway.networking.k8s.io"
											description: """
	Group is the group of the referent.
	When unspecified, "gateway.networking.k8s.io" is inferred.
	To set the core API group (such as for a "Service" kind referent),
	Group must be explicitly set to "" (empty string).


	Support: Core
	"""
											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											default: "Gateway"
											description: """
	Kind is kind of the referent.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	Support for other resources is Implementation-Specific.
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										name: {
											description: """
	Name is the name of the referent.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: """
	Namespace is the namespace of the referent. When unspecified, this refers
	to the local namespace of the Route.


	Note that there are specific rules for ParentRefs which cross namespace
	boundaries. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example:
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable any other kind of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.



	Support: Core
	"""
											maxLength: 63
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
											type:      "string"
										}
										port: {
											description: """
	Port is the network port this Route targets. It can be interpreted
	differently based on the type of parent resource.


	When the parent resource is a Gateway, this targets all listeners
	listening on the specified port that also support this kind of Route(and
	select this Route). It's not recommended to set `Port` unless the
	networking behaviors specified in a Route must apply to a specific port
	as opposed to a listener(s) whose port(s) may be changed. When both Port
	and SectionName are specified, the name and port of the selected listener
	must match both specified values.



	When the parent resource is a Service, this targets a specific port in the
	Service spec. When both Port (experimental) and SectionName are specified,
	the name and port of the selected port must match both specified values.



	Implementations MAY choose to support other parent resources.
	Implementations supporting other types of parent resources MUST clearly
	document how/if Port is interpreted.


	For the purpose of status, an attachment is considered successful as
	long as the parent resource accepts it partially. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
	from the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route,
	the Route MUST be considered detached from the Gateway.


	Support: Extended
	"""
											format:  "int32"
											maximum: 65535
											minimum: 1
											type:    "integer"
										}
										sectionName: {
											description: """
	SectionName is the name of a section within the target resource. In the
	following resources, SectionName is interpreted as the following:


	* Gateway: Listener name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.
	* Service: Port name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.


	Implementations MAY choose to support attaching Routes to other resources.
	If that is the case, they MUST clearly document how SectionName is
	interpreted.


	When unspecified (empty string), this will reference the entire resource.
	For the purpose of status, an attachment is considered successful if at
	least one section in the parent resource accepts it. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
	the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route, the
	Route MUST be considered detached from the Gateway.


	Support: Core
	"""
											maxLength: 253
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								maxItems: 32
								type:     "array"
								"x-kubernetes-validations": [{
									message: "sectionName or port must be specified when parentRefs includes 2 or more references to the same parent"
									rule:    "self.all(p1, self.all(p2, p1.group == p2.group && p1.kind == p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) || p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ == '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__ == p2.__namespace__)) ? ((!has(p1.sectionName) || p1.sectionName == '') == (!has(p2.sectionName) || p2.sectionName == '') && (!has(p1.port) || p1.port == 0) == (!has(p2.port) || p2.port == 0)): true))"
								}, {
									message: "sectionName or port must be unique when parentRefs includes 2 or more references to the same parent"
									rule:    "self.all(p1, self.exists_one(p2, p1.group == p2.group && p1.kind == p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) || p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ == '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__ == p2.__namespace__ )) && (((!has(p1.sectionName) || p1.sectionName == '') && (!has(p2.sectionName) || p2.sectionName == '')) || ( has(p1.sectionName) && has(p2.sectionName) && p1.sectionName == p2.sectionName)) && (((!has(p1.port) || p1.port == 0) && (!has(p2.port) || p2.port == 0)) || (has(p1.port) && has(p2.port) && p1.port == p2.port))))"
								}]
							}
							rules: {
								description: "Rules are a list of UDP matchers and actions."
								items: {
									description: "UDPRouteRule is the configuration for a given rule."
									properties: backendRefs: {
										description: """
	BackendRefs defines the backend(s) where matching requests should be
	sent. If unspecified or invalid (refers to a non-existent resource or a
	Service with no endpoints), the underlying implementation MUST actively
	reject connection attempts to this backend. Packet drops must
	respect weight; if an invalid backend is requested to have 80% of
	the packets, then 80% of packets must be dropped instead.


	Support: Core for Kubernetes Service


	Support: Extended for Kubernetes ServiceImport


	Support: Implementation-specific for any other resource


	Support for weight: Extended
	"""
										items: {
											description: """
	BackendRef defines how a Route should forward a request to a Kubernetes
	resource.


	Note that when a namespace different than the local namespace is specified, a
	ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	<gateway:experimental:description>


	When the BackendRef points to a Kubernetes Service, implementations SHOULD
	honor the appProtocol field if it is set for the target Service Port.


	Implementations supporting appProtocol SHOULD recognize the Kubernetes
	Standard Application Protocols defined in KEP-3726.


	If a Service appProtocol isn't specified, an implementation MAY infer the
	backend protocol through its own means. Implementations MAY infer the
	protocol from the Route type referring to the backend Service.


	If a Route is not able to send traffic to the backend using the specified
	protocol then the backend is considered invalid. Implementations MUST set the
	"ResolvedRefs" condition to "False" with the "UnsupportedProtocol" reason.


	</gateway:experimental:description>


	Note that when the BackendTLSPolicy object is enabled by the implementation,
	there are some extra rules about validity to consider here. See the fields
	where this struct is used for more information about the exact behavior.
	"""
											properties: {
												group: {
													default: ""
													description: """
	Group is the group of the referent. For example, "gateway.networking.k8s.io".
	When unspecified or empty string, core API group is inferred.
	"""
													maxLength: 253
													pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
													type:      "string"
												}
												kind: {
													default: "Service"
													description: """
	Kind is the Kubernetes resource kind of the referent. For example
	"Service".


	Defaults to "Service" when not specified.


	ExternalName services can refer to CNAME DNS records that may live
	outside of the cluster and as such are difficult to reason about in
	terms of conformance. They also may not be safe to forward to (see
	CVE-2021-25740 for more information). Implementations SHOULD NOT
	support ExternalName Services.


	Support: Core (Services with a type other than ExternalName)


	Support: Implementation-specific (Services with type ExternalName)
	"""
													maxLength: 63
													minLength: 1
													pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
													type:      "string"
												}
												name: {
													description: "Name is the name of the referent."
													maxLength:   253
													minLength:   1
													type:        "string"
												}
												namespace: {
													description: """
	Namespace is the namespace of the backend. When unspecified, the local
	namespace is inferred.


	Note that when a namespace different than the local namespace is specified,
	a ReferenceGrant object is required in the referent namespace to allow that
	namespace's owner to accept the reference. See the ReferenceGrant
	documentation for details.


	Support: Core
	"""
													maxLength: 63
													minLength: 1
													pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
													type:      "string"
												}
												port: {
													description: """
	Port specifies the destination port number to use for this resource.
	Port is required when the referent is a Kubernetes Service. In this
	case, the port number is the service port number, not the target port.
	For other resources, destination port might be derived from the referent
	resource or this field.
	"""
													format:  "int32"
													maximum: 65535
													minimum: 1
													type:    "integer"
												}
												weight: {
													default: 1
													description: """
	Weight specifies the proportion of requests forwarded to the referenced
	backend. This is computed as weight/(sum of all weights in this
	BackendRefs list). For non-zero values, there may be some epsilon from
	the exact proportion defined here depending on the precision an
	implementation supports. Weight is not a percentage and the sum of
	weights does not need to equal 100.


	If only one backend is specified and it has a weight greater than 0, 100%
	of the traffic is forwarded to that backend. If weight is set to 0, no
	traffic should be forwarded for this entry. If unspecified, weight
	defaults to 1.


	Support for this field varies based on the context where used.
	"""
													format:  "int32"
													maximum: 1000000
													minimum: 0
													type:    "integer"
												}
											}
											required: ["name"]
											type: "object"
											"x-kubernetes-validations": [{
												message: "Must have port for Service reference"
												rule:    "(size(self.group) == 0 && self.kind == 'Service') ? has(self.port) : true"
											}]
										}
										maxItems: 16
										minItems: 1
										type:     "array"
									}
									type: "object"
								}
								maxItems: 16
								minItems: 1
								type:     "array"
							}
						}
						required: ["rules"]
						type: "object"
					}
					status: {
						description: "Status defines the current state of UDPRoute."
						properties: parents: {
							description: """
	Parents is a list of parent resources (usually Gateways) that are
	associated with the route, and the status of the route with respect to
	each parent. When this route attaches to a parent, the controller that
	manages the parent must add an entry to this list when the controller
	first sees the route and should update the entry as appropriate when the
	route or gateway is modified.


	Note that parent references that cannot be resolved by an implementation
	of this API will not be added to this list. Implementations of this API
	can only populate Route status for the Gateways/parent resources they are
	responsible for.


	A maximum of 32 Gateways will be represented in this list. An empty list
	means the route has not been attached to any Gateway.
	"""
							items: {
								description: """
	RouteParentStatus describes the status of a route with respect to an
	associated Parent.
	"""
								properties: {
									conditions: {
										description: """
	Conditions describes the status of the route with respect to the Gateway.
	Note that the route's availability is also subject to the Gateway's own
	status conditions and listener status.


	If the Route's ParentRef specifies an existing Gateway that supports
	Routes of this kind AND that Gateway's controller has sufficient access,
	then that Gateway's controller MUST set the "Accepted" condition on the
	Route, to indicate whether the route has been accepted or rejected by the
	Gateway, and why.


	A Route MUST be considered "Accepted" if at least one of the Route's
	rules is implemented by the Gateway.


	There are a number of cases where the "Accepted" condition may not be set
	due to lack of controller visibility, that includes when:


	* The Route refers to a non-existent parent.
	* The Route is of a type that the controller does not support.
	* The Route is in a namespace the controller does not have access to.
	"""
										items: {
											description: """
	Condition contains details for one aspect of the current state of this API Resource.
	---
	This struct is intended for direct use as an array at the field path .status.conditions.  For example,


	\ttype FooStatus struct{
	\t    // Represents the observations of a foo's current state.
	\t    // Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
	\t    // +patchMergeKey=type
	\t    // +patchStrategy=merge
	\t    // +listType=map
	\t    // +listMapKey=type
	\t    Conditions []metav1.Condition `json:"conditions,omitempty" patchStrategy:"merge" patchMergeKey:"type" protobuf:"bytes,1,rep,name=conditions"`


	\t    // other fields
	\t}
	"""
											properties: {
												lastTransitionTime: {
													description: """
	lastTransitionTime is the last time the condition transitioned from one status to another.
	This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
	"""
													format: "date-time"
													type:   "string"
												}
												message: {
													description: """
	message is a human readable message indicating details about the transition.
	This may be an empty string.
	"""
													maxLength: 32768
													type:      "string"
												}
												observedGeneration: {
													description: """
	observedGeneration represents the .metadata.generation that the condition was set based upon.
	For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
	with respect to the current state of the instance.
	"""
													format:  "int64"
													minimum: 0
													type:    "integer"
												}
												reason: {
													description: """
	reason contains a programmatic identifier indicating the reason for the condition's last transition.
	Producers of specific condition types may define expected values and meanings for this field,
	and whether the values are considered a guaranteed API.
	The value should be a CamelCase string.
	This field may not be empty.
	"""
													maxLength: 1024
													minLength: 1
													pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
													type:      "string"
												}
												status: {
													description: "status of the condition, one of True, False, Unknown."
													enum: [
														"True",
														"False",
														"Unknown",
													]
													type: "string"
												}
												type: {
													description: """
	type of condition in CamelCase or in foo.example.com/CamelCase.
	---
	Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be
	useful (see .node.status.conditions), the ability to deconflict is important.
	The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)
	"""
													maxLength: 316
													pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
													type:      "string"
												}
											}
											required: [
												"lastTransitionTime",
												"message",
												"reason",
												"status",
												"type",
											]
											type: "object"
										}
										maxItems: 8
										minItems: 1
										type:     "array"
										"x-kubernetes-list-map-keys": ["type"]
										"x-kubernetes-list-type": "map"
									}
									controllerName: {
										description: """
	ControllerName is a domain/path string that indicates the name of the
	controller that wrote this status. This corresponds with the
	controllerName field on GatewayClass.


	Example: "example.net/gateway-controller".


	The format of this field is DOMAIN "/" PATH, where DOMAIN and PATH are
	valid Kubernetes names
	(https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).


	Controllers MUST populate this field when writing status. Controllers should ensure that
	entries to status populated with their ControllerName are cleaned up when they are no
	longer necessary.
	"""
										maxLength: 253
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
										type:      "string"
									}
									parentRef: {
										description: """
	ParentRef corresponds with a ParentRef in the spec that this
	RouteParentStatus struct describes the status of.
	"""
										properties: {
											group: {
												default: "gateway.networking.k8s.io"
												description: """
	Group is the group of the referent.
	When unspecified, "gateway.networking.k8s.io" is inferred.
	To set the core API group (such as for a "Service" kind referent),
	Group must be explicitly set to "" (empty string).


	Support: Core
	"""
												maxLength: 253
												pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
											kind: {
												default: "Gateway"
												description: """
	Kind is kind of the referent.


	There are two kinds of parent resources with "Core" support:


	* Gateway (Gateway conformance profile)
	* Service (Mesh conformance profile, ClusterIP Services only)


	Support for other resources is Implementation-Specific.
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:      "string"
											}
											name: {
												description: """
	Name is the name of the referent.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												type:      "string"
											}
											namespace: {
												description: """
	Namespace is the namespace of the referent. When unspecified, this refers
	to the local namespace of the Route.


	Note that there are specific rules for ParentRefs which cross namespace
	boundaries. Cross-namespace references are only valid if they are explicitly
	allowed by something in the namespace they are referring to. For example:
	Gateway has the AllowedRoutes field, and ReferenceGrant provides a
	generic way to enable any other kind of cross-namespace reference.



	ParentRefs from a Route to a Service in the same namespace are "producer"
	routes, which apply default routing rules to inbound connections from
	any namespace to the Service.


	ParentRefs from a Route to a Service in a different namespace are
	"consumer" routes, and these routing rules are only applied to outbound
	connections originating from the same namespace as the Route, for which
	the intended destination of the connections are a Service targeted as a
	ParentRef of the Route.



	Support: Core
	"""
												maxLength: 63
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
												type:      "string"
											}
											port: {
												description: """
	Port is the network port this Route targets. It can be interpreted
	differently based on the type of parent resource.


	When the parent resource is a Gateway, this targets all listeners
	listening on the specified port that also support this kind of Route(and
	select this Route). It's not recommended to set `Port` unless the
	networking behaviors specified in a Route must apply to a specific port
	as opposed to a listener(s) whose port(s) may be changed. When both Port
	and SectionName are specified, the name and port of the selected listener
	must match both specified values.



	When the parent resource is a Service, this targets a specific port in the
	Service spec. When both Port (experimental) and SectionName are specified,
	the name and port of the selected port must match both specified values.



	Implementations MAY choose to support other parent resources.
	Implementations supporting other types of parent resources MUST clearly
	document how/if Port is interpreted.


	For the purpose of status, an attachment is considered successful as
	long as the parent resource accepts it partially. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
	from the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route,
	the Route MUST be considered detached from the Gateway.


	Support: Extended
	"""
												format:  "int32"
												maximum: 65535
												minimum: 1
												type:    "integer"
											}
											sectionName: {
												description: """
	SectionName is the name of a section within the target resource. In the
	following resources, SectionName is interpreted as the following:


	* Gateway: Listener name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.
	* Service: Port name. When both Port (experimental) and SectionName
	are specified, the name and port of the selected listener must match
	both specified values.


	Implementations MAY choose to support attaching Routes to other resources.
	If that is the case, they MUST clearly document how SectionName is
	interpreted.


	When unspecified (empty string), this will reference the entire resource.
	For the purpose of status, an attachment is considered successful if at
	least one section in the parent resource accepts it. For example, Gateway
	listeners can restrict which Routes can attach to them by Route kind,
	namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
	the referencing Route, the Route MUST be considered successfully
	attached. If no Gateway listeners accept attachment from this Route, the
	Route MUST be considered detached from the Gateway.


	Support: Core
	"""
												maxLength: 253
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
										}
										required: ["name"]
										type: "object"
									}
								}
								required: [
									"controllerName",
									"parentRef",
								]
								type: "object"
							}
							maxItems: 32
							type:     "array"
						}
						required: ["parents"]
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}]
