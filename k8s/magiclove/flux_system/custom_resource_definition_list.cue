package flux_system

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
		name: "buckets.source.toolkit.fluxcd.io"
		labels: "app.kubernetes.io/component": "source-controller"
		annotations: {
			"controller-gen.kubebuilder.io/version":  "v0.21.0"
			"kustomize.toolkit.fluxcd.io/substitute": "disabled"
		}
	}
	spec: {
		group: "source.toolkit.fluxcd.io"
		names: {
			plural:   "buckets"
			singular: "bucket"
			kind:     "Bucket"
			listKind: "BucketList"
			categories: ["all", "fluxcd", "fluxcd-sources"]
		}
		scope: "Namespaced"
		versions: [{
			name:    "v1"
			served:  true
			storage: true
			schema: openAPIV3Schema: {
				description: "Bucket is the Schema for the buckets API."
				type:        "object"
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
						description: """
											BucketSpec specifies the required configuration to produce an Artifact for
											an object storage bucket.
											"""
						type: "object"
						required: ["bucketName", "endpoint", "interval"]
						properties: {
							bucketName: {
								description: "BucketName is the name of the object storage bucket."
								type:        "string"
							}
							certSecretRef: {
								description: """
													CertSecretRef can be given the name of a Secret containing
													either or both of

													- a PEM-encoded client certificate (`tls.crt`) and private
													key (`tls.key`);
													- a PEM-encoded CA certificate (`ca.crt`)

													and whichever are supplied, will be used for connecting to the
													bucket. The client cert and key are useful if you are
													authenticating with a certificate; the CA cert is useful if
													you are using a self-signed server certificate. The Secret must
													be of type `Opaque` or `kubernetes.io/tls`.

													This field is only supported for the `generic` provider.
													"""
								type: "object"
								required: ["name"]
								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
							}
							endpoint: {
								description: "Endpoint is the object storage address the BucketName is located at."
								type:        "string"
							}
							ignore: {
								description: """
													Ignore overrides the set of excluded patterns in the .sourceignore format
													(which is the same as .gitignore). If not provided, a default will be used,
													consult the documentation for your version to find out what those are.
													"""
								type: "string"
							}
							insecure: {
								description: "Insecure allows connecting to a non-TLS HTTP Endpoint."
								type:        "boolean"
							}
							interval: {
								description: """
													Interval at which the Bucket Endpoint is checked for updates.
													This interval is approximate and may be subject to jitter to ensure
													efficient use of resources.
													"""
								type:    "string"
								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
							}
							prefix: {
								description: "Prefix to use for server-side filtering of files in the Bucket."
								type:        "string"
							}
							provider: {
								description: """
													Provider of the object storage bucket.
													Defaults to 'generic', which expects an S3 (API) compatible object
													storage.
													"""
								type:    "string"
								default: "generic"
								enum: ["generic", "aws", "gcp", "azure"]
							}
							proxySecretRef: {
								description: """
													ProxySecretRef specifies the Secret containing the proxy configuration
													to use while communicating with the Bucket server.
													"""
								type: "object"
								required: ["name"]
								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
							}
							region: {
								description: "Region of the Endpoint where the BucketName is located in."
								type:        "string"
							}
							secretRef: {
								description: """
													SecretRef specifies the Secret containing authentication credentials
													for the Bucket.
													"""
								type: "object"
								required: ["name"]
								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
							}
							serviceAccountName: {
								description: """
													ServiceAccountName is the name of the Kubernetes ServiceAccount used to authenticate
													the bucket. This field is only supported for the 'gcp' and 'aws' providers.
													For more information about workload identity:
													https://fluxcd.io/flux/components/source/buckets/#workload-identity
													"""
								type: "string"
							}
							sts: {
								description: """
													STS specifies the required configuration to use a Security Token
													Service for fetching temporary credentials to authenticate in a
													Bucket provider.

													This field is only supported for the `aws` and `generic` providers.
													"""
								type: "object"
								required: ["endpoint", "provider"]
								properties: {
									certSecretRef: {
										description: """
															CertSecretRef can be given the name of a Secret containing
															either or both of

															- a PEM-encoded client certificate (`tls.crt`) and private
															key (`tls.key`);
															- a PEM-encoded CA certificate (`ca.crt`)

															and whichever are supplied, will be used for connecting to the
															STS endpoint. The client cert and key are useful if you are
															authenticating with a certificate; the CA cert is useful if
															you are using a self-signed server certificate. The Secret must
															be of type `Opaque` or `kubernetes.io/tls`.

															This field is only supported for the `ldap` provider.
															"""
										type: "object"
										required: ["name"]
										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
									}
									endpoint: {
										description: """
															Endpoint is the HTTP/S endpoint of the Security Token Service from
															where temporary credentials will be fetched.
															"""
										type:    "string"
										pattern: "^(http|https)://.*$"
									}
									provider: {
										description: "Provider of the Security Token Service."
										type:        "string"
										enum: ["aws", "ldap"]
									}
									secretRef: {
										description: """
															SecretRef specifies the Secret containing authentication credentials
															for the STS endpoint. This Secret must contain the fields `username`
															and `password` and is supported only for the `ldap` provider.
															"""
										type: "object"
										required: ["name"]
										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
									}
								}
							}
							suspend: {
								description: """
													Suspend tells the controller to suspend the reconciliation of this
													Bucket.
													"""
								type: "boolean"
							}
							timeout: {
								description: "Timeout for fetch operations, defaults to 60s."
								type:        "string"
								default:     "60s"
								pattern:     "^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
							}
						}
						"x-kubernetes-validations": [{
							rule:    "self.provider == 'aws' || self.provider == 'generic' || !has(self.sts)"
							message: "STS configuration is only supported for the 'aws' and 'generic' Bucket providers"
						}, {
							rule:    "self.provider != 'aws' || !has(self.sts) || self.sts.provider == 'aws'"
							message: "'aws' is the only supported STS provider for the 'aws' Bucket provider"
						}, {
							rule:    "self.provider != 'generic' || !has(self.sts) || self.sts.provider == 'ldap'"
							message: "'ldap' is the only supported STS provider for the 'generic' Bucket provider"
						}, {
							rule:    "!has(self.sts) || self.sts.provider != 'aws' || !has(self.sts.secretRef)"
							message: "spec.sts.secretRef is not required for the 'aws' STS provider"
						}, {
							rule:    "!has(self.sts) || self.sts.provider != 'aws' || !has(self.sts.certSecretRef)"
							message: "spec.sts.certSecretRef is not required for the 'aws' STS provider"
						}, {
							rule:    "self.provider != 'generic' || !has(self.serviceAccountName)"
							message: "ServiceAccountName is not supported for the 'generic' Bucket provider"
						}, {
							rule:    "!has(self.secretRef) || !has(self.serviceAccountName)"
							message: "cannot set both .spec.secretRef and .spec.serviceAccountName"
						}]
					}
					status: {
						description: "BucketStatus records the observed state of a Bucket."
						type:        "object"
						default: observedGeneration: -1
						properties: {
							artifact: {
								description: "Artifact represents the last successful Bucket reconciliation."
								type:        "object"
								required: ["digest", "lastUpdateTime", "path", "revision", "url"]
								properties: {
									digest: {
										description: "Digest is the digest of the file in the form of '<algorithm>:<checksum>'."
										type:        "string"
										pattern:     "^[a-z0-9]+(?:[.+_-][a-z0-9]+)*:[a-zA-Z0-9=_-]+$"
									}
									lastUpdateTime: {
										description: """
															LastUpdateTime is the timestamp corresponding to the last update of the
															Artifact.
															"""
										type:   "string"
										format: "date-time"
									}
									metadata: {
										description: "Metadata holds upstream information such as OCI annotations."
										type:        "object"
										additionalProperties: type: "string"
									}
									path: {
										description: """
															Path is the relative file path of the Artifact. It can be used to locate
															the file in the root of the Artifact storage on the local file system of
															the controller managing the Source.
															"""
										type: "string"
									}
									revision: {
										description: """
															Revision is a human-readable identifier traceable in the origin source
															system. It can be a Git commit SHA, Git tag, a Helm chart version, etc.
															"""
										type: "string"
									}
									size: {
										description: "Size is the number of bytes in the file."
										type:        "integer"
										format:      "int64"
									}
									url: {
										description: """
															URL is the HTTP address of the Artifact as exposed by the controller
															managing the Source. It can be used to retrieve the Artifact for
															consumption, e.g. by another controller applying the Artifact contents.
															"""
										type: "string"
									}
								}
							}
							conditions: {
								description: "Conditions holds the conditions for the Bucket."
								type:        "array"
								items: {
									description: "Condition contains details for one aspect of the current state of this API Resource."
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
											enum: ["True", "False", "Unknown"]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase."
											maxLength:   316
											pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:        "string"
										}
									}
									required: ["lastTransitionTime", "message", "reason", "status", "type"]
									type: "object"
								}
							}
							lastHandledReconcileAt: {
								description: """
													LastHandledReconcileAt holds the value of the most recent
													reconcile request value, so a change of the annotation value
													can be detected.
													"""
								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation of the Bucket object."
								type:        "integer"
								format:      "int64"
							}
							observedIgnore: {
								description: """
													ObservedIgnore is the observed exclusion patterns used for constructing
													the source artifact.
													"""
								type: "string"
							}
							url: {
								description: """
													URL is the dynamic fetch link for the latest Artifact.
													It is provided on a "best effort" basis, and using the precise
													BucketStatus.Artifact data is recommended.
													"""
								type: "string"
							}
						}
					}
				}
			}
			subresources: status: {}
			additionalPrinterColumns: [{
				name:     "Endpoint"
				type:     "string"
				jsonPath: ".spec.endpoint"
			}, {
				name:     "Age"
				type:     "date"
				jsonPath: ".metadata.creationTimestamp"
			}, {
				name:     "Ready"
				type:     "string"
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
			}, {
				name:     "Status"
				type:     "string"
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
			}]
		}]
	}
}, {
	metadata: {
		name: "externalartifacts.source.toolkit.fluxcd.io"
		labels: "app.kubernetes.io/component": "source-controller"
		annotations: {
			"controller-gen.kubebuilder.io/version":  "v0.21.0"
			"kustomize.toolkit.fluxcd.io/substitute": "disabled"
		}
	}
	spec: {
		group: "source.toolkit.fluxcd.io"
		names: {
			plural:   "externalartifacts"
			singular: "externalartifact"
			shortNames: [
				"ea",
			]
			kind:     "ExternalArtifact"
			listKind: "ExternalArtifactList"
			categories: ["all", "fluxcd", "fluxcd-sources"]
		}
		scope: "Namespaced"
		versions: [{
			name:    "v1"
			served:  true
			storage: true
			schema: openAPIV3Schema: {
				description: "ExternalArtifact is the Schema for the external artifacts API"
				type:        "object"
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
						description: "ExternalArtifactSpec defines the desired state of ExternalArtifact"
						type:        "object"
						properties: sourceRef: {
							description: """
													SourceRef points to the Kubernetes custom resource for
													which the artifact is generated.
													"""
							type: "object"
							required: ["kind", "name"]
							properties: {
								apiVersion: {
									description: "API version of the referent, if not specified the Kubernetes preferred version will be used."
									type:        "string"
								}
								kind: {
									description: "Kind of the referent."
									type:        "string"
								}
								name: {
									description: "Name of the referent."
									type:        "string"
								}
								namespace: {
									description: "Namespace of the referent, when not specified it acts as LocalObjectReference."
									type:        "string"
								}
							}
						}
					}
					status: {
						description: "ExternalArtifactStatus defines the observed state of ExternalArtifact"
						type:        "object"
						properties: {
							artifact: {
								description: "Artifact represents the output of an ExternalArtifact reconciliation."
								type:        "object"
								required: ["digest", "lastUpdateTime", "path", "revision", "url"]
								properties: {
									digest: {
										description: "Digest is the digest of the file in the form of '<algorithm>:<checksum>'."
										type:        "string"
										pattern:     "^[a-z0-9]+(?:[.+_-][a-z0-9]+)*:[a-zA-Z0-9=_-]+$"
									}
									lastUpdateTime: {
										description: """
															LastUpdateTime is the timestamp corresponding to the last update of the
															Artifact.
															"""
										type:   "string"
										format: "date-time"
									}
									metadata: {
										description: "Metadata holds upstream information such as OCI annotations."
										type:        "object"
										additionalProperties: type: "string"
									}
									path: {
										description: """
															Path is the relative file path of the Artifact. It can be used to locate
															the file in the root of the Artifact storage on the local file system of
															the controller managing the Source.
															"""
										type: "string"
									}
									revision: {
										description: """
															Revision is a human-readable identifier traceable in the origin source
															system. It can be a Git commit SHA, Git tag, a Helm chart version, etc.
															"""
										type: "string"
									}
									size: {
										description: "Size is the number of bytes in the file."
										type:        "integer"
										format:      "int64"
									}
									url: {
										description: """
															URL is the HTTP address of the Artifact as exposed by the controller
															managing the Source. It can be used to retrieve the Artifact for
															consumption, e.g. by another controller applying the Artifact contents.
															"""
										type: "string"
									}
								}
							}
							conditions: {
								description: "Conditions holds the conditions for the ExternalArtifact."
								type:        "array"
								items: {
									description: "Condition contains details for one aspect of the current state of this API Resource."
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
											enum: ["True", "False", "Unknown"]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase."
											maxLength:   316
											pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:        "string"
										}
									}
									required: ["lastTransitionTime", "message", "reason", "status", "type"]
									type: "object"
								}
							}
						}
					}
				}
			}
			subresources: status: {}
			additionalPrinterColumns: [{
				name:     "Age"
				type:     "date"
				jsonPath: ".metadata.creationTimestamp"
			}, {
				name:     "Ready"
				type:     "string"
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
			}, {
				name:     "Status"
				type:     "string"
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
			}, {
				name:     "Source"
				type:     "string"
				jsonPath: ".spec.sourceRef.name"
			}]
		}]
	}
}, {
	metadata: {
		name: "gitrepositories.source.toolkit.fluxcd.io"
		labels: "app.kubernetes.io/component": "source-controller"
		annotations: {
			"controller-gen.kubebuilder.io/version":  "v0.21.0"
			"kustomize.toolkit.fluxcd.io/substitute": "disabled"
		}
	}
	spec: {
		group: "source.toolkit.fluxcd.io"
		names: {
			plural:   "gitrepositories"
			singular: "gitrepository"
			shortNames: [
				"gitrepo",
			]
			kind:     "GitRepository"
			listKind: "GitRepositoryList"
			categories: ["all", "fluxcd", "fluxcd-sources"]
		}
		scope: "Namespaced"
		versions: [{
			name:    "v1"
			served:  true
			storage: true
			schema: openAPIV3Schema: {
				description: "GitRepository is the Schema for the gitrepositories API."
				type:        "object"
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
						description: """
											GitRepositorySpec specifies the required configuration to produce an
											Artifact for a Git repository.
											"""
						type: "object"
						required: ["interval", "url"]
						properties: {
							ignore: {
								description: """
													Ignore overrides the set of excluded patterns in the .sourceignore format
													(which is the same as .gitignore). If not provided, a default will be used,
													consult the documentation for your version to find out what those are.
													"""
								type: "string"
							}
							include: {
								description: """
													Include specifies a list of GitRepository resources which Artifacts
													should be included in the Artifact produced for this GitRepository.
													"""
								type: "array"
								items: {
									description: """
														GitRepositoryInclude specifies a local reference to a GitRepository which
														Artifact (sub-)contents must be included, and where they should be placed.
														"""
									properties: {
										fromPath: {
											description: """
																FromPath specifies the path to copy contents from, defaults to the root
																of the Artifact.
																"""
											type: "string"
										}
										repository: {
											description: """
																GitRepositoryRef specifies the GitRepository which Artifact contents
																must be included.
																"""
											properties: name: {
												description: "Name of the referent."
												type:        "string"
											}
											required: ["name"]
											type: "object"
										}
										toPath: {
											description: """
																ToPath specifies the path to copy contents to, defaults to the name of
																the GitRepositoryRef.
																"""
											type: "string"
										}
									}
									required: ["repository"]
									type: "object"
								}
							}
							interval: {
								description: """
													Interval at which the GitRepository URL is checked for updates.
													This interval is approximate and may be subject to jitter to ensure
													efficient use of resources.
													"""
								type:    "string"
								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
							}
							provider: {
								description: """
													Provider used for authentication, can be 'aws', 'azure', 'github', 'generic'.
													When not specified, defaults to 'generic'.
													"""
								type: "string"
								enum: ["generic", "aws", "azure", "github"]
							}
							proxySecretRef: {
								description: """
													ProxySecretRef specifies the Secret containing the proxy configuration
													to use while communicating with the Git server.
													"""
								type: "object"
								required: ["name"]
								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
							}
							recurseSubmodules: {
								description: """
													RecurseSubmodules enables the initialization of all submodules within
													the GitRepository as cloned from the URL, using their default settings.
													"""
								type: "boolean"
							}
							ref: {
								description: """
													Reference specifies the Git reference to resolve and monitor for
													changes, defaults to the 'master' branch.
													"""
								type: "object"
								properties: {
									branch: {
										description: "Branch to check out, defaults to 'master' if no other field is defined."
										type:        "string"
									}
									commit: {
										description: """
															Commit SHA to check out, takes precedence over all reference fields.

															This can be combined with Branch to shallow clone the branch, in which
															the commit is expected to exist.
															"""
										type: "string"
									}
									name: {
										description: """
															Name of the reference to check out; takes precedence over Branch, Tag and SemVer.

															It must be a valid Git reference: https://git-scm.com/docs/git-check-ref-format#_description
															Examples: "refs/heads/main", "refs/tags/v0.1.0", "refs/pull/420/head", "refs/merge-requests/1/head"
															"""
										type: "string"
									}
									semver: {
										description: "SemVer tag expression to check out, takes precedence over Tag."
										type:        "string"
									}
									tag: {
										description: "Tag to check out, takes precedence over Branch."
										type:        "string"
									}
								}
							}
							secretRef: {
								description: """
													SecretRef specifies the Secret containing authentication credentials for
													the GitRepository.
													For HTTPS repositories the Secret must contain 'username' and 'password'
													fields for basic auth or 'bearerToken' field for token auth.
													For SSH repositories the Secret must contain 'identity'
													and 'known_hosts' fields.
													"""
								type: "object"
								required: ["name"]
								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
							}
							serviceAccountName: {
								description: """
													ServiceAccountName is the name of the Kubernetes ServiceAccount used to
													authenticate to the GitRepository. This field is only supported for 'azure' and 'aws' providers.
													"""
								type: "string"
							}
							sparseCheckout: {
								description: """
													SparseCheckout specifies a list of directories to checkout when cloning
													the repository. If specified, only these directories are included in the
													Artifact produced for this GitRepository.
													"""
								type: "array"
								items: type: "string"
							}
							suspend: {
								description: """
													Suspend tells the controller to suspend the reconciliation of this
													GitRepository.
													"""
								type: "boolean"
							}
							timeout: {
								description: "Timeout for Git operations like cloning, defaults to 60s."
								type:        "string"
								default:     "60s"
								pattern:     "^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
							}
							url: {
								description: "URL specifies the Git repository URL, it can be an HTTP/S or SSH address."
								type:        "string"
								pattern:     "^(http|https|ssh)://.*$"
							}
							verify: {
								description: """
													Verification specifies the configuration to verify the Git commit
													signature(s).
													"""
								type: "object"
								required: ["secretRef"]
								properties: {
									mode: {
										description: """
															Mode specifies which Git object(s) should be verified.

															The variants "head" and "HEAD" both imply the same thing, i.e. verify
															the commit that the HEAD of the Git repository points to. The variant
															"head" solely exists to ensure backwards compatibility.
															"""
										type:    "string"
										default: "HEAD"
										enum: ["head", "HEAD", "Tag", "TagAndHEAD"]
									}
									secretRef: {
										description: """
															SecretRef specifies the Secret containing the public keys of trusted Git
															authors. PGP public keys must be stored under keys with the .asc suffix,
															and SSH public keys must be stored under keys with the .sshpub suffix.
															"""
										type: "object"
										required: ["name"]
										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
									}
								}
							}
						}
						"x-kubernetes-validations": [{
							rule:    "!has(self.serviceAccountName) || (has(self.provider) && (self.provider == 'azure' || self.provider == 'aws'))"
							message: "serviceAccountName can only be set when provider is 'azure' or 'aws'"
						}]
					}
					status: {
						description: "GitRepositoryStatus records the observed state of a Git repository."
						type:        "object"
						default: observedGeneration: -1
						properties: {
							artifact: {
								description: "Artifact represents the last successful GitRepository reconciliation."
								type:        "object"
								required: ["digest", "lastUpdateTime", "path", "revision", "url"]
								properties: {
									digest: {
										description: "Digest is the digest of the file in the form of '<algorithm>:<checksum>'."
										type:        "string"
										pattern:     "^[a-z0-9]+(?:[.+_-][a-z0-9]+)*:[a-zA-Z0-9=_-]+$"
									}
									lastUpdateTime: {
										description: """
															LastUpdateTime is the timestamp corresponding to the last update of the
															Artifact.
															"""
										type:   "string"
										format: "date-time"
									}
									metadata: {
										description: "Metadata holds upstream information such as OCI annotations."
										type:        "object"
										additionalProperties: type: "string"
									}
									path: {
										description: """
															Path is the relative file path of the Artifact. It can be used to locate
															the file in the root of the Artifact storage on the local file system of
															the controller managing the Source.
															"""
										type: "string"
									}
									revision: {
										description: """
															Revision is a human-readable identifier traceable in the origin source
															system. It can be a Git commit SHA, Git tag, a Helm chart version, etc.
															"""
										type: "string"
									}
									size: {
										description: "Size is the number of bytes in the file."
										type:        "integer"
										format:      "int64"
									}
									url: {
										description: """
															URL is the HTTP address of the Artifact as exposed by the controller
															managing the Source. It can be used to retrieve the Artifact for
															consumption, e.g. by another controller applying the Artifact contents.
															"""
										type: "string"
									}
								}
							}
							conditions: {
								description: "Conditions holds the conditions for the GitRepository."
								type:        "array"
								items: {
									description: "Condition contains details for one aspect of the current state of this API Resource."
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
											enum: ["True", "False", "Unknown"]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase."
											maxLength:   316
											pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:        "string"
										}
									}
									required: ["lastTransitionTime", "message", "reason", "status", "type"]
									type: "object"
								}
							}
							includedArtifacts: {
								description: """
													IncludedArtifacts contains a list of the last successfully included
													Artifacts as instructed by GitRepositorySpec.Include.
													"""
								type: "array"
								items: {
									description: "Artifact represents the output of a Source reconciliation."
									properties: {
										digest: {
											description: "Digest is the digest of the file in the form of '<algorithm>:<checksum>'."
											pattern:     "^[a-z0-9]+(?:[.+_-][a-z0-9]+)*:[a-zA-Z0-9=_-]+$"
											type:        "string"
										}
										lastUpdateTime: {
											description: """
																LastUpdateTime is the timestamp corresponding to the last update of the
																Artifact.
																"""
											format: "date-time"
											type:   "string"
										}
										metadata: {
											additionalProperties: type: "string"
											description: "Metadata holds upstream information such as OCI annotations."
											type:        "object"
										}
										path: {
											description: """
																Path is the relative file path of the Artifact. It can be used to locate
																the file in the root of the Artifact storage on the local file system of
																the controller managing the Source.
																"""
											type: "string"
										}
										revision: {
											description: """
																Revision is a human-readable identifier traceable in the origin source
																system. It can be a Git commit SHA, Git tag, a Helm chart version, etc.
																"""
											type: "string"
										}
										size: {
											description: "Size is the number of bytes in the file."
											format:      "int64"
											type:        "integer"
										}
										url: {
											description: """
																URL is the HTTP address of the Artifact as exposed by the controller
																managing the Source. It can be used to retrieve the Artifact for
																consumption, e.g. by another controller applying the Artifact contents.
																"""
											type: "string"
										}
									}
									required: ["digest", "lastUpdateTime", "path", "revision", "url"]
									type: "object"
								}
							}
							lastHandledReconcileAt: {
								description: """
													LastHandledReconcileAt holds the value of the most recent
													reconcile request value, so a change of the annotation value
													can be detected.
													"""
								type: "string"
							}
							observedGeneration: {
								description: """
													ObservedGeneration is the last observed generation of the GitRepository
													object.
													"""
								type:   "integer"
								format: "int64"
							}
							observedIgnore: {
								description: """
													ObservedIgnore is the observed exclusion patterns used for constructing
													the source artifact.
													"""
								type: "string"
							}
							observedInclude: {
								description: """
													ObservedInclude is the observed list of GitRepository resources used to
													produce the current Artifact.
													"""
								type: "array"
								items: {
									description: """
														GitRepositoryInclude specifies a local reference to a GitRepository which
														Artifact (sub-)contents must be included, and where they should be placed.
														"""
									properties: {
										fromPath: {
											description: """
																FromPath specifies the path to copy contents from, defaults to the root
																of the Artifact.
																"""
											type: "string"
										}
										repository: {
											description: """
																GitRepositoryRef specifies the GitRepository which Artifact contents
																must be included.
																"""
											properties: name: {
												description: "Name of the referent."
												type:        "string"
											}
											required: ["name"]
											type: "object"
										}
										toPath: {
											description: """
																ToPath specifies the path to copy contents to, defaults to the name of
																the GitRepositoryRef.
																"""
											type: "string"
										}
									}
									required: ["repository"]
									type: "object"
								}
							}
							observedRecurseSubmodules: {
								description: """
													ObservedRecurseSubmodules is the observed resource submodules
													configuration used to produce the current Artifact.
													"""
								type: "boolean"
							}
							observedSparseCheckout: {
								description: """
													ObservedSparseCheckout is the observed list of directories used to
													produce the current Artifact.
													"""
								type: "array"
								items: type: "string"
							}
							sourceVerificationMode: {
								description: """
													SourceVerificationMode is the last used verification mode indicating
													which Git object(s) have been verified.
													"""
								type: "string"
							}
						}
					}
				}
			}
			subresources: status: {}
			additionalPrinterColumns: [{
				name:     "URL"
				type:     "string"
				jsonPath: ".spec.url"
			}, {
				name:     "Age"
				type:     "date"
				jsonPath: ".metadata.creationTimestamp"
			}, {
				name:     "Ready"
				type:     "string"
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
			}, {
				name:     "Status"
				type:     "string"
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
			}]
		}]
	}
}, {
	metadata: {
		name: "helmcharts.source.toolkit.fluxcd.io"
		labels: "app.kubernetes.io/component": "source-controller"
		annotations: {
			"controller-gen.kubebuilder.io/version":  "v0.21.0"
			"kustomize.toolkit.fluxcd.io/substitute": "disabled"
		}
	}
	spec: {
		group: "source.toolkit.fluxcd.io"
		names: {
			plural:   "helmcharts"
			singular: "helmchart"
			shortNames: [
				"hc",
			]
			kind:     "HelmChart"
			listKind: "HelmChartList"
			categories: ["all", "fluxcd", "fluxcd-sources"]
		}
		scope: "Namespaced"
		versions: [{
			name:    "v1"
			served:  true
			storage: true
			schema: openAPIV3Schema: {
				description: "HelmChart is the Schema for the helmcharts API."
				type:        "object"
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
						description: "HelmChartSpec specifies the desired state of a Helm chart."
						type:        "object"
						required: ["chart", "interval", "sourceRef"]
						properties: {
							chart: {
								description: """
													Chart is the name or path the Helm chart is available at in the
													SourceRef.
													"""
								type: "string"
							}
							ignoreMissingValuesFiles: {
								description: """
													IgnoreMissingValuesFiles controls whether to silently ignore missing values
													files rather than failing.
													"""
								type: "boolean"
							}
							interval: {
								description: """
													Interval at which the HelmChart SourceRef is checked for updates.
													This interval is approximate and may be subject to jitter to ensure
													efficient use of resources.
													"""
								type:    "string"
								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
							}
							reconcileStrategy: {
								description: """
													ReconcileStrategy determines what enables the creation of a new artifact.
													Valid values are ('ChartVersion', 'Revision').
													See the documentation of the values for an explanation on their behavior.
													Defaults to ChartVersion when omitted.
													"""
								type:    "string"
								default: "ChartVersion"
								enum: ["ChartVersion", "Revision"]
							}
							sourceRef: {
								description: "SourceRef is the reference to the Source the chart is available at."
								type:        "object"
								required: ["kind", "name"]
								properties: {
									apiVersion: {
										description: "APIVersion of the referent."
										type:        "string"
									}
									kind: {
										description: """
															Kind of the referent, valid values are ('HelmRepository', 'GitRepository',
															'Bucket').
															"""
										type: "string"
										enum: ["HelmRepository", "GitRepository", "Bucket"]
									}
									name: {
										description: "Name of the referent."
										type:        "string"
									}
								}
							}
							suspend: {
								description: """
													Suspend tells the controller to suspend the reconciliation of this
													source.
													"""
								type: "boolean"
							}
							valuesFiles: {
								description: """
													ValuesFiles is an alternative list of values files to use as the chart
													values (values.yaml is not included by default), expected to be a
													relative path in the SourceRef.
													Values files are merged in the order of this list with the last file
													overriding the first. Ignored when omitted.
													"""
								type: "array"
								items: type: "string"
							}
							verify: {
								description: """
													Verify contains the secret name containing the trusted public keys
													used to verify the signature and specifies which provider to use to check
													whether OCI image is authentic.
													This field is only supported when using HelmRepository source with spec.type 'oci'.
													Chart dependencies, which are not bundled in the umbrella chart artifact, are not verified.
													"""
								type: "object"
								required: ["provider"]
								properties: {
									matchOIDCIdentity: {
										description: """
															MatchOIDCIdentity specifies the identity matching criteria to use
															while verifying an OCI artifact which was signed using Cosign keyless
															signing. The artifact's identity is deemed to be verified if any of the
															specified matchers match against the identity.
															"""
										type: "array"
										items: {
											description: """
																OIDCIdentityMatch specifies options for verifying the certificate identity,
																i.e. the issuer and the subject of the certificate.
																"""
											properties: {
												issuer: {
													description: """
																		Issuer specifies the regex pattern to match against to verify
																		the OIDC issuer in the Fulcio certificate. The pattern must be a
																		valid Go regular expression.
																		"""
													type: "string"
												}
												subject: {
													description: """
																		Subject specifies the regex pattern to match against to verify
																		the identity subject in the Fulcio certificate. The pattern must
																		be a valid Go regular expression.
																		"""
													type: "string"
												}
											}
											required: ["issuer", "subject"]
											type: "object"
										}
									}
									provider: {
										description: "Provider specifies the technology used to sign the OCI Artifact."
										type:        "string"
										default:     "cosign"
										enum: ["cosign", "notation"]
									}
									secretRef: {
										description: """
															SecretRef specifies the Kubernetes Secret containing the
															trusted public keys.
															"""
										type: "object"
										required: ["name"]
										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
									}
								}
							}
							version: {
								description: """
													Version is the chart version semver expression, ignored for charts from
													GitRepository and Bucket sources. Defaults to latest when omitted.
													"""
								type:    "string"
								default: "*"
							}
						}
						"x-kubernetes-validations": [{
							rule:    "!has(self.verify) || self.sourceRef.kind == 'HelmRepository'"
							message: "spec.verify is only supported when spec.sourceRef.kind is 'HelmRepository'"
						}]
					}
					status: {
						description: "HelmChartStatus records the observed state of the HelmChart."
						type:        "object"
						default: observedGeneration: -1
						properties: {
							artifact: {
								description: "Artifact represents the output of the last successful reconciliation."
								type:        "object"
								required: ["digest", "lastUpdateTime", "path", "revision", "url"]
								properties: {
									digest: {
										description: "Digest is the digest of the file in the form of '<algorithm>:<checksum>'."
										type:        "string"
										pattern:     "^[a-z0-9]+(?:[.+_-][a-z0-9]+)*:[a-zA-Z0-9=_-]+$"
									}
									lastUpdateTime: {
										description: """
															LastUpdateTime is the timestamp corresponding to the last update of the
															Artifact.
															"""
										type:   "string"
										format: "date-time"
									}
									metadata: {
										description: "Metadata holds upstream information such as OCI annotations."
										type:        "object"
										additionalProperties: type: "string"
									}
									path: {
										description: """
															Path is the relative file path of the Artifact. It can be used to locate
															the file in the root of the Artifact storage on the local file system of
															the controller managing the Source.
															"""
										type: "string"
									}
									revision: {
										description: """
															Revision is a human-readable identifier traceable in the origin source
															system. It can be a Git commit SHA, Git tag, a Helm chart version, etc.
															"""
										type: "string"
									}
									size: {
										description: "Size is the number of bytes in the file."
										type:        "integer"
										format:      "int64"
									}
									url: {
										description: """
															URL is the HTTP address of the Artifact as exposed by the controller
															managing the Source. It can be used to retrieve the Artifact for
															consumption, e.g. by another controller applying the Artifact contents.
															"""
										type: "string"
									}
								}
							}
							conditions: {
								description: "Conditions holds the conditions for the HelmChart."
								type:        "array"
								items: {
									description: "Condition contains details for one aspect of the current state of this API Resource."
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
											enum: ["True", "False", "Unknown"]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase."
											maxLength:   316
											pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:        "string"
										}
									}
									required: ["lastTransitionTime", "message", "reason", "status", "type"]
									type: "object"
								}
							}
							lastHandledReconcileAt: {
								description: """
													LastHandledReconcileAt holds the value of the most recent
													reconcile request value, so a change of the annotation value
													can be detected.
													"""
								type: "string"
							}
							observedChartName: {
								description: """
													ObservedChartName is the last observed chart name as specified by the
													resolved chart reference.
													"""
								type: "string"
							}
							observedGeneration: {
								description: """
													ObservedGeneration is the last observed generation of the HelmChart
													object.
													"""
								type:   "integer"
								format: "int64"
							}
							observedSourceArtifactRevision: {
								description: """
													ObservedSourceArtifactRevision is the last observed Artifact.Revision
													of the HelmChartSpec.SourceRef.
													"""
								type: "string"
							}
							observedValuesFiles: {
								description: """
													ObservedValuesFiles are the observed value files of the last successful
													reconciliation.
													It matches the chart in the last successfully reconciled artifact.
													"""
								type: "array"
								items: type: "string"
							}
							url: {
								description: """
													URL is the dynamic fetch link for the latest Artifact.
													It is provided on a "best effort" basis, and using the precise
													HelmChartStatus.Artifact data is recommended.
													"""
								type: "string"
							}
						}
					}
				}
			}
			subresources: status: {}
			additionalPrinterColumns: [{
				name:     "Chart"
				type:     "string"
				jsonPath: ".spec.chart"
			}, {
				name:     "Version"
				type:     "string"
				jsonPath: ".spec.version"
			}, {
				name:     "Source Kind"
				type:     "string"
				jsonPath: ".spec.sourceRef.kind"
			}, {
				name:     "Source Name"
				type:     "string"
				jsonPath: ".spec.sourceRef.name"
			}, {
				name:     "Age"
				type:     "date"
				jsonPath: ".metadata.creationTimestamp"
			}, {
				name:     "Ready"
				type:     "string"
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
			}, {
				name:     "Status"
				type:     "string"
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
			}]
		}]
	}
}, {
	metadata: {
		name: "helmrepositories.source.toolkit.fluxcd.io"
		labels: "app.kubernetes.io/component": "source-controller"
		annotations: {
			"controller-gen.kubebuilder.io/version":  "v0.21.0"
			"kustomize.toolkit.fluxcd.io/substitute": "disabled"
		}
	}
	spec: {
		group: "source.toolkit.fluxcd.io"
		names: {
			plural:   "helmrepositories"
			singular: "helmrepository"
			shortNames: [
				"helmrepo",
			]
			kind:     "HelmRepository"
			listKind: "HelmRepositoryList"
			categories: ["all", "fluxcd", "fluxcd-sources"]
		}
		scope: "Namespaced"
		versions: [{
			name:    "v1"
			served:  true
			storage: true
			schema: openAPIV3Schema: {
				description: "HelmRepository is the Schema for the helmrepositories API."
				type:        "object"
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
						description: """
											HelmRepositorySpec specifies the required configuration to produce an
											Artifact for a Helm repository index YAML.
											"""
						type: "object"
						required: ["url"]
						properties: {
							accessFrom: {
								description: """
													AccessFrom specifies an Access Control List for allowing cross-namespace
													references to this object.
													NOTE: Not implemented, provisional as of https://github.com/fluxcd/flux2/pull/2092
													"""
								type: "object"
								required: ["namespaceSelectors"]
								properties: namespaceSelectors: {
									description: """
															NamespaceSelectors is the list of namespace selectors to which this ACL applies.
															Items in this list are evaluated using a logical OR operation.
															"""
									type: "array"
									items: {
										description: """
																NamespaceSelector selects the namespaces to which this ACL applies.
																An empty map of MatchLabels matches all namespaces in a cluster.
																"""
										properties: matchLabels: {
											additionalProperties: type: "string"
											description: """
																		MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels
																		map is equivalent to an element of matchExpressions, whose key field is "key", the
																		operator is "In", and the values array contains only "value". The requirements are ANDed.
																		"""
											type: "object"
										}
										type: "object"
									}
								}
							}
							certSecretRef: {
								description: """
													CertSecretRef can be given the name of a Secret containing
													either or both of

													- a PEM-encoded client certificate (`tls.crt`) and private
													key (`tls.key`);
													- a PEM-encoded CA certificate (`ca.crt`)

													and whichever are supplied, will be used for connecting to the
													registry. The client cert and key are useful if you are
													authenticating with a certificate; the CA cert is useful if
													you are using a self-signed server certificate. The Secret must
													be of type `Opaque` or `kubernetes.io/tls`.

													It takes precedence over the values specified in the Secret referred
													to by `.spec.secretRef`.
													"""
								type: "object"
								required: ["name"]
								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
							}
							insecure: {
								description: """
													Insecure allows connecting to a non-TLS HTTP container registry.
													This field is only taken into account if the .spec.type field is set to 'oci'.
													"""
								type: "boolean"
							}
							interval: {
								description: """
													Interval at which the HelmRepository URL is checked for updates.
													This interval is approximate and may be subject to jitter to ensure
													efficient use of resources.
													"""
								type:    "string"
								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
							}
							passCredentials: {
								description: """
													PassCredentials allows the credentials from the SecretRef to be passed
													on to a host that does not match the host as defined in URL.
													This may be required if the host of the advertised chart URLs in the
													index differ from the defined URL.
													Enabling this should be done with caution, as it can potentially result
													in credentials getting stolen in a MITM-attack.
													"""
								type: "boolean"
							}
							provider: {
								description: """
													Provider used for authentication, can be 'aws', 'azure', 'gcp' or 'generic'.
													This field is optional, and only taken into account if the .spec.type field is set to 'oci'.
													When not specified, defaults to 'generic'.
													"""
								type:    "string"
								default: "generic"
								enum: ["generic", "aws", "azure", "gcp"]
							}
							secretRef: {
								description: """
													SecretRef specifies the Secret containing authentication credentials
													for the HelmRepository.
													For HTTP/S basic auth the secret must contain 'username' and 'password'
													fields.
													Support for TLS auth using the 'certFile' and 'keyFile', and/or 'caFile'
													keys is deprecated. Please use `.spec.certSecretRef` instead.
													"""
								type: "object"
								required: ["name"]
								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
							}
							suspend: {
								description: """
													Suspend tells the controller to suspend the reconciliation of this
													HelmRepository.
													"""
								type: "boolean"
							}
							timeout: {
								description: """
													Timeout is used for the index fetch operation for an HTTPS helm repository,
													and for remote OCI Repository operations like pulling for an OCI helm
													chart by the associated HelmChart.
													Its default value is 60s.
													"""
								type:    "string"
								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
							}
							type: {
								description: """
													Type of the HelmRepository.
													When this field is set to  "oci", the URL field value must be prefixed with "oci://".
													"""
								type: "string"
								enum: ["default", "oci"]
							}
							url: {
								description: """
													URL of the Helm repository, a valid URL contains at least a protocol and
													host.
													"""
								type:    "string"
								pattern: "^(http|https|oci)://.*$"
							}
						}
					}
					status: {
						description: "HelmRepositoryStatus records the observed state of the HelmRepository."
						type:        "object"
						default: observedGeneration: -1
						properties: {
							artifact: {
								description: "Artifact represents the last successful HelmRepository reconciliation."
								type:        "object"
								required: ["digest", "lastUpdateTime", "path", "revision", "url"]
								properties: {
									digest: {
										description: "Digest is the digest of the file in the form of '<algorithm>:<checksum>'."
										type:        "string"
										pattern:     "^[a-z0-9]+(?:[.+_-][a-z0-9]+)*:[a-zA-Z0-9=_-]+$"
									}
									lastUpdateTime: {
										description: """
															LastUpdateTime is the timestamp corresponding to the last update of the
															Artifact.
															"""
										type:   "string"
										format: "date-time"
									}
									metadata: {
										description: "Metadata holds upstream information such as OCI annotations."
										type:        "object"
										additionalProperties: type: "string"
									}
									path: {
										description: """
															Path is the relative file path of the Artifact. It can be used to locate
															the file in the root of the Artifact storage on the local file system of
															the controller managing the Source.
															"""
										type: "string"
									}
									revision: {
										description: """
															Revision is a human-readable identifier traceable in the origin source
															system. It can be a Git commit SHA, Git tag, a Helm chart version, etc.
															"""
										type: "string"
									}
									size: {
										description: "Size is the number of bytes in the file."
										type:        "integer"
										format:      "int64"
									}
									url: {
										description: """
															URL is the HTTP address of the Artifact as exposed by the controller
															managing the Source. It can be used to retrieve the Artifact for
															consumption, e.g. by another controller applying the Artifact contents.
															"""
										type: "string"
									}
								}
							}
							conditions: {
								description: "Conditions holds the conditions for the HelmRepository."
								type:        "array"
								items: {
									description: "Condition contains details for one aspect of the current state of this API Resource."
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
											enum: ["True", "False", "Unknown"]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase."
											maxLength:   316
											pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:        "string"
										}
									}
									required: ["lastTransitionTime", "message", "reason", "status", "type"]
									type: "object"
								}
							}
							lastHandledReconcileAt: {
								description: """
													LastHandledReconcileAt holds the value of the most recent
													reconcile request value, so a change of the annotation value
													can be detected.
													"""
								type: "string"
							}
							observedGeneration: {
								description: """
													ObservedGeneration is the last observed generation of the HelmRepository
													object.
													"""
								type:   "integer"
								format: "int64"
							}
							url: {
								description: """
													URL is the dynamic fetch link for the latest Artifact.
													It is provided on a "best effort" basis, and using the precise
													HelmRepositoryStatus.Artifact data is recommended.
													"""
								type: "string"
							}
						}
					}
				}
			}
			subresources: status: {}
			additionalPrinterColumns: [{
				name:     "URL"
				type:     "string"
				jsonPath: ".spec.url"
			}, {
				name:     "Age"
				type:     "date"
				jsonPath: ".metadata.creationTimestamp"
			}, {
				name:     "Ready"
				type:     "string"
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
			}, {
				name:     "Status"
				type:     "string"
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
			}]
		}]
	}
}, {
	metadata: {
		name: "ocirepositories.source.toolkit.fluxcd.io"
		labels: "app.kubernetes.io/component": "source-controller"
		annotations: {
			"controller-gen.kubebuilder.io/version":  "v0.21.0"
			"kustomize.toolkit.fluxcd.io/substitute": "disabled"
		}
	}
	spec: {
		group: "source.toolkit.fluxcd.io"
		names: {
			plural:   "ocirepositories"
			singular: "ocirepository"
			shortNames: [
				"ocirepo",
			]
			kind:     "OCIRepository"
			listKind: "OCIRepositoryList"
			categories: ["all", "fluxcd", "fluxcd-sources"]
		}
		scope: "Namespaced"
		versions: [{
			name:    "v1"
			served:  true
			storage: true
			schema: openAPIV3Schema: {
				description: "OCIRepository is the Schema for the ocirepositories API"
				type:        "object"
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
						description: "OCIRepositorySpec defines the desired state of OCIRepository"
						type:        "object"
						required: ["interval", "url"]
						properties: {
							certSecretRef: {
								description: """
													CertSecretRef can be given the name of a Secret containing
													either or both of

													- a PEM-encoded client certificate (`tls.crt`) and private
													key (`tls.key`);
													- a PEM-encoded CA certificate (`ca.crt`)

													and whichever are supplied, will be used for connecting to the
													registry. The client cert and key are useful if you are
													authenticating with a certificate; the CA cert is useful if
													you are using a self-signed server certificate. The Secret must
													be of type `Opaque` or `kubernetes.io/tls`.
													"""
								type: "object"
								required: ["name"]
								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
							}
							ignore: {
								description: """
													Ignore overrides the set of excluded patterns in the .sourceignore format
													(which is the same as .gitignore). If not provided, a default will be used,
													consult the documentation for your version to find out what those are.
													"""
								type: "string"
							}
							insecure: {
								description: "Insecure allows connecting to a non-TLS HTTP container registry."
								type:        "boolean"
							}
							interval: {
								description: """
													Interval at which the OCIRepository URL is checked for updates.
													This interval is approximate and may be subject to jitter to ensure
													efficient use of resources.
													"""
								type:    "string"
								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
							}
							layerSelector: {
								description: """
													LayerSelector specifies which layer should be extracted from the OCI artifact.
													When not specified, the first layer found in the artifact is selected.
													"""
								type: "object"
								properties: {
									mediaType: {
										description: """
															MediaType specifies the OCI media type of the layer
															which should be extracted from the OCI Artifact. The
															first layer matching this type is selected.
															"""
										type: "string"
									}
									operation: {
										description: """
															Operation specifies how the selected layer should be processed.
															By default, the layer compressed content is extracted to storage.
															When the operation is set to 'copy', the layer compressed content
															is persisted to storage as it is.
															"""
										type: "string"
										enum: ["extract", "copy"]
									}
								}
							}
							provider: {
								description: """
													The provider used for authentication, can be 'aws', 'azure', 'gcp' or 'generic'.
													When not specified, defaults to 'generic'.
													"""
								type:    "string"
								default: "generic"
								enum: ["generic", "aws", "azure", "gcp"]
							}
							proxySecretRef: {
								description: """
													ProxySecretRef specifies the Secret containing the proxy configuration
													to use while communicating with the container registry.
													"""
								type: "object"
								required: ["name"]
								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
							}
							ref: {
								description: """
													The OCI reference to pull and monitor for changes,
													defaults to the latest tag.
													"""
								type: "object"
								properties: {
									digest: {
										description: """
															Digest is the image digest to pull, takes precedence over SemVer.
															The value should be in the format 'sha256:<HASH>'.
															"""
										type: "string"
									}
									semver: {
										description: """
															SemVer is the range of tags to pull selecting the latest within
															the range, takes precedence over Tag.
															"""
										type: "string"
									}
									semverFilter: {
										description: "SemverFilter is a regex pattern to filter the tags within the SemVer range."
										type:        "string"
									}
									tag: {
										description: "Tag is the image tag to pull, defaults to latest."
										type:        "string"
									}
								}
							}
							secretRef: {
								description: """
													SecretRef contains the secret name containing the registry login
													credentials to resolve image metadata.
													The secret must be of type kubernetes.io/dockerconfigjson.
													"""
								type: "object"
								required: ["name"]
								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
							}
							serviceAccountName: {
								description: """
													ServiceAccountName is the name of the Kubernetes ServiceAccount used to authenticate
													the image pull if the service account has attached pull secrets. For more information:
													https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#add-imagepullsecrets-to-a-service-account
													"""
								type: "string"
							}
							suspend: {
								description: "This flag tells the controller to suspend the reconciliation of this source."
								type:        "boolean"
							}
							timeout: {
								description: "The timeout for remote OCI Repository operations like pulling, defaults to 60s."
								type:        "string"
								default:     "60s"
								pattern:     "^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
							}
							url: {
								description: """
													URL is a reference to an OCI artifact repository hosted
													on a remote container registry.
													"""
								type:    "string"
								pattern: "^oci://.*$"
							}
							verify: {
								description: """
													Verify contains the secret name containing the trusted public keys
													used to verify the signature and specifies which provider to use to check
													whether OCI image is authentic.
													"""
								type: "object"
								required: ["provider"]
								properties: {
									matchOIDCIdentity: {
										description: """
															MatchOIDCIdentity specifies the identity matching criteria to use
															while verifying an OCI artifact which was signed using Cosign keyless
															signing. The artifact's identity is deemed to be verified if any of the
															specified matchers match against the identity.
															"""
										type: "array"
										items: {
											description: """
																OIDCIdentityMatch specifies options for verifying the certificate identity,
																i.e. the issuer and the subject of the certificate.
																"""
											properties: {
												issuer: {
													description: """
																		Issuer specifies the regex pattern to match against to verify
																		the OIDC issuer in the Fulcio certificate. The pattern must be a
																		valid Go regular expression.
																		"""
													type: "string"
												}
												subject: {
													description: """
																		Subject specifies the regex pattern to match against to verify
																		the identity subject in the Fulcio certificate. The pattern must
																		be a valid Go regular expression.
																		"""
													type: "string"
												}
											}
											required: ["issuer", "subject"]
											type: "object"
										}
									}
									provider: {
										description: "Provider specifies the technology used to sign the OCI Artifact."
										type:        "string"
										default:     "cosign"
										enum: ["cosign", "notation"]
									}
									secretRef: {
										description: """
															SecretRef specifies the Kubernetes Secret containing the
															trusted public keys.
															"""
										type: "object"
										required: ["name"]
										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
									}
									trustedRootSecretRef: {
										description: """
															TrustedRootSecretRef specifies the Kubernetes Secret containing a
															Sigstore trusted_root.json file. This enables verification against
															self-hosted Sigstore infrastructure (custom Fulcio CA, self-hosted
															Rekor instance). The Secret must contain a key named "trusted_root.json".
															"""
										type: "object"
										required: ["name"]
										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
									}
								}
							}
						}
					}
					status: {
						description: "OCIRepositoryStatus defines the observed state of OCIRepository"
						type:        "object"
						default: observedGeneration: -1
						properties: {
							artifact: {
								description: "Artifact represents the output of the last successful OCI Repository sync."
								type:        "object"
								required: ["digest", "lastUpdateTime", "path", "revision", "url"]
								properties: {
									digest: {
										description: "Digest is the digest of the file in the form of '<algorithm>:<checksum>'."
										type:        "string"
										pattern:     "^[a-z0-9]+(?:[.+_-][a-z0-9]+)*:[a-zA-Z0-9=_-]+$"
									}
									lastUpdateTime: {
										description: """
															LastUpdateTime is the timestamp corresponding to the last update of the
															Artifact.
															"""
										type:   "string"
										format: "date-time"
									}
									metadata: {
										description: "Metadata holds upstream information such as OCI annotations."
										type:        "object"
										additionalProperties: type: "string"
									}
									path: {
										description: """
															Path is the relative file path of the Artifact. It can be used to locate
															the file in the root of the Artifact storage on the local file system of
															the controller managing the Source.
															"""
										type: "string"
									}
									revision: {
										description: """
															Revision is a human-readable identifier traceable in the origin source
															system. It can be a Git commit SHA, Git tag, a Helm chart version, etc.
															"""
										type: "string"
									}
									size: {
										description: "Size is the number of bytes in the file."
										type:        "integer"
										format:      "int64"
									}
									url: {
										description: """
															URL is the HTTP address of the Artifact as exposed by the controller
															managing the Source. It can be used to retrieve the Artifact for
															consumption, e.g. by another controller applying the Artifact contents.
															"""
										type: "string"
									}
								}
							}
							conditions: {
								description: "Conditions holds the conditions for the OCIRepository."
								type:        "array"
								items: {
									description: "Condition contains details for one aspect of the current state of this API Resource."
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
											enum: ["True", "False", "Unknown"]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase."
											maxLength:   316
											pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:        "string"
										}
									}
									required: ["lastTransitionTime", "message", "reason", "status", "type"]
									type: "object"
								}
							}
							lastHandledReconcileAt: {
								description: """
													LastHandledReconcileAt holds the value of the most recent
													reconcile request value, so a change of the annotation value
													can be detected.
													"""
								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation."
								type:        "integer"
								format:      "int64"
							}
							observedIgnore: {
								description: """
													ObservedIgnore is the observed exclusion patterns used for constructing
													the source artifact.
													"""
								type: "string"
							}
							observedLayerSelector: {
								description: """
													ObservedLayerSelector is the observed layer selector used for constructing
													the source artifact.
													"""
								type: "object"
								properties: {
									mediaType: {
										description: """
															MediaType specifies the OCI media type of the layer
															which should be extracted from the OCI Artifact. The
															first layer matching this type is selected.
															"""
										type: "string"
									}
									operation: {
										description: """
															Operation specifies how the selected layer should be processed.
															By default, the layer compressed content is extracted to storage.
															When the operation is set to 'copy', the layer compressed content
															is persisted to storage as it is.
															"""
										type: "string"
										enum: ["extract", "copy"]
									}
								}
							}
							url: {
								description: "URL is the download link for the artifact output of the last OCI Repository sync."
								type:        "string"
							}
						}
					}
				}
			}
			subresources: status: {}
			additionalPrinterColumns: [{
				name:     "URL"
				type:     "string"
				jsonPath: ".spec.url"
			}, {
				name:     "Ready"
				type:     "string"
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
			}, {
				name:     "Status"
				type:     "string"
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
			}, {
				name:     "Age"
				type:     "date"
				jsonPath: ".metadata.creationTimestamp"
			}]
		}]
	}
}, {
	metadata: {
		name: "kustomizations.kustomize.toolkit.fluxcd.io"
		labels: "app.kubernetes.io/component": "kustomize-controller"
		annotations: {
			"controller-gen.kubebuilder.io/version":  "v0.21.0"
			"kustomize.toolkit.fluxcd.io/substitute": "disabled"
		}
	}
	spec: {
		group: "kustomize.toolkit.fluxcd.io"
		names: {
			plural:   "kustomizations"
			singular: "kustomization"
			shortNames: [
				"ks",
			]
			kind:     "Kustomization"
			listKind: "KustomizationList"
			categories: ["all", "fluxcd", "fluxcd-appliers"]
		}
		scope: "Namespaced"
		versions: [{
			name:    "v1"
			served:  true
			storage: true
			schema: openAPIV3Schema: {
				description: "Kustomization is the Schema for the kustomizations API."
				type:        "object"
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
						description: """
											KustomizationSpec defines the configuration to calculate the desired state
											from a Source using Kustomize.
											"""
						type: "object"
						required: ["interval", "prune", "sourceRef"]
						properties: {
							buildMetadata: {
								description: """
													BuildMetadata specifies which kustomize build metadata should be added
													to the built resources. The allowed values are 'originAnnotations' to
													annotate resources with their source origin, and 'transformerAnnotations'
													to annotate resources with the transformers that produced them.
													"""
								type: "array"
								items: {
									description: "BuildMetadataOption defines the supported buildMetadata options."
									enum: ["originAnnotations", "transformerAnnotations"]
									type: "string"
								}
							}
							commonMetadata: {
								description: """
													CommonMetadata specifies the common labels and annotations that are
													applied to all resources. Any existing label or annotation will be
													overridden if its key matches a common one.
													"""
								type: "object"
								properties: {
									annotations: {
										description: "Annotations to be added to the object's metadata."
										type:        "object"
										additionalProperties: type: "string"
									}
									labels: {
										description: "Labels to be added to the object's metadata."
										type:        "object"
										additionalProperties: type: "string"
									}
								}
							}
							components: {
								description: "Components specifies relative paths to kustomize Components."
								type:        "array"
								items: type: "string"
							}
							decryption: {
								description: "Decrypt Kubernetes secrets before applying them on the cluster."
								type:        "object"
								required: ["provider"]
								properties: {
									provider: {
										description: "Provider is the name of the decryption engine."
										type:        "string"
										enum: ["sops"]
									}
									secretRef: {
										description: """
															The secret name containing the private OpenPGP keys used for decryption.
															A static credential for a cloud provider defined inside the Secret
															takes priority to secret-less authentication with the ServiceAccountName
															field.
															"""
										type: "object"
										required: ["name"]
										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
									}
									serviceAccountName: {
										description: """
															ServiceAccountName is the name of the service account used to
															authenticate with KMS services from cloud providers. If a
															static credential for a given cloud provider is defined
															inside the Secret referenced by SecretRef, that static
															credential takes priority.
															"""
										type: "string"
									}
								}
							}
							deletionPolicy: {
								description: """
													DeletionPolicy can be used to control garbage collection when this
													Kustomization is deleted. Valid values are ('MirrorPrune', 'Delete',
													'WaitForTermination', 'Orphan'). 'MirrorPrune' mirrors the Prune field
													(orphan if false, delete if true). Defaults to 'MirrorPrune'.
													"""
								type: "string"
								enum: ["MirrorPrune", "Delete", "WaitForTermination", "Orphan"]
							}
							dependsOn: {
								description: """
													DependsOn may contain a DependencyReference slice
													with references to Kustomization resources that must be ready before this
													Kustomization can be reconciled.
													"""
								type: "array"
								items: {
									description: """
														DependencyReference contains enough information to locate the referenced Kubernetes resource object
														and optional CEL expression to assess its readiness.
														"""
									properties: {
										name: {
											description: "Name of the referent."
											type:        "string"
										}
										namespace: {
											description: """
																Namespace of the referent, defaults to the namespace of the resource
																object that contains the reference.
																"""
											type: "string"
										}
										readyExpr: {
											description: """
																ReadyExpr is a CEL expression that can be used to assess the readiness
																of a dependency. When specified, the built-in readiness check
																is replaced by the logic defined in the CEL expression.
																To make the CEL expression additive to the built-in readiness check,
																the feature gate `AdditiveCELDependencyCheck` must be set to `true`.
																"""
											type: "string"
										}
									}
									required: ["name"]
									type: "object"
								}
							}
							force: {
								description: """
													Force instructs the controller to recreate resources
													when patching fails due to an immutable field change.
													"""
								type:    "boolean"
								default: false
							}
							healthCheckExprs: {
								description: """
													HealthCheckExprs is a list of healthcheck expressions for evaluating the
													health of custom resources using Common Expression Language (CEL).
													The expressions are evaluated only when Wait or HealthChecks are specified.
													"""
								type: "array"
								items: {
									description: "CustomHealthCheck defines the health check for custom resources."
									properties: {
										apiVersion: {
											description: "APIVersion of the custom resource under evaluation."
											type:        "string"
										}
										current: {
											description: """
																Current is the CEL expression that determines if the status
																of the custom resource has reached the desired state.
																"""
											type: "string"
										}
										failed: {
											description: """
																Failed is the CEL expression that determines if the status
																of the custom resource has failed to reach the desired state.
																"""
											type: "string"
										}
										inProgress: {
											description: """
																InProgress is the CEL expression that determines if the status
																of the custom resource has not yet reached the desired state.
																"""
											type: "string"
										}
										kind: {
											description: "Kind of the custom resource under evaluation."
											type:        "string"
										}
									}
									required: ["apiVersion", "current"]
									type: "object"
								}
							}
							healthChecks: {
								description: "A list of resources to be included in the health assessment."
								type:        "array"
								items: {
									description: """
														NamespacedObjectKindReference contains enough information to locate the typed referenced Kubernetes resource object
														in any namespace.
														"""
									properties: {
										apiVersion: {
											description: "API version of the referent, if not specified the Kubernetes preferred version will be used."
											type:        "string"
										}
										kind: {
											description: "Kind of the referent."
											type:        "string"
										}
										name: {
											description: "Name of the referent."
											type:        "string"
										}
										namespace: {
											description: "Namespace of the referent, when not specified it acts as LocalObjectReference."
											type:        "string"
										}
									}
									required: ["kind", "name"]
									type: "object"
								}
							}
							ignore: {
								description: """
													Ignore is a list of rules for specifying which changes to ignore
													during drift detection. These rules are applied to the resources managed
													by the Kustomization and are used to exclude specific JSON pointer paths
													from the drift detection and apply process.
													"""
								type: "array"
								items: {
									description: """
														IgnoreRule defines a rule to selectively disregard specific changes during
														the drift detection process.
														"""
									properties: {
										paths: {
											description: """
																Paths is a list of JSON Pointer (RFC 6901) paths to be excluded from
																consideration in a Kubernetes object.
																"""
											items: type: "string"
											type: "array"
										}
										target: {
											description: """
																Target is a selector for specifying Kubernetes objects to which this
																rule applies.
																If Target is not set, the Paths will be ignored for all Kubernetes
																objects within the manifest of the Kustomization.
																"""
											properties: {
												annotationSelector: {
													description: """
																		AnnotationSelector is a string that follows the label selection expression
																		https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api
																		It matches with the resource annotations.
																		"""
													type: "string"
												}
												group: {
													description: """
																		Group is the API group to select resources from.
																		Together with Version and Kind it is capable of unambiguously identifying and/or selecting resources.
																		https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md
																		"""
													type: "string"
												}
												kind: {
													description: """
																		Kind of the API Group to select resources from.
																		Together with Group and Version it is capable of unambiguously
																		identifying and/or selecting resources.
																		https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md
																		"""
													type: "string"
												}
												labelSelector: {
													description: """
																		LabelSelector is a string that follows the label selection expression
																		https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api
																		It matches with the resource labels.
																		"""
													type: "string"
												}
												name: {
													description: "Name to match resources with."
													type:        "string"
												}
												namespace: {
													description: "Namespace to select resources from."
													type:        "string"
												}
												version: {
													description: """
																		Version of the API Group to select resources from.
																		Together with Group and Kind it is capable of unambiguously identifying and/or selecting resources.
																		https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md
																		"""
													type: "string"
												}
											}
											type: "object"
										}
									}
									required: ["paths"]
									type: "object"
								}
							}
							ignoreMissingComponents: {
								description: """
													IgnoreMissingComponents instructs the controller to ignore Components paths
													not found in source by removing them from the generated kustomization.yaml
													before running kustomize build.
													"""
								type: "boolean"
							}
							images: {
								description: """
													Images is a list of (image name, new name, new tag or digest)
													for changing image names, tags or digests. This can also be achieved with a
													patch, but this operator is simpler to specify.
													"""
								type: "array"
								items: {
									description: "Image contains an image name, a new name, a new tag or digest, which will replace the original name and tag."
									properties: {
										digest: {
											description: """
																Digest is the value used to replace the original image tag.
																If digest is present NewTag value is ignored.
																"""
											type: "string"
										}
										name: {
											description: "Name is a tag-less image name."
											type:        "string"
										}
										newName: {
											description: "NewName is the value used to replace the original name."
											type:        "string"
										}
										newTag: {
											description: "NewTag is the value used to replace the original tag."
											type:        "string"
										}
									}
									required: ["name"]
									type: "object"
								}
							}
							interval: {
								description: """
													The interval at which to reconcile the Kustomization.
													This interval is approximate and may be subject to jitter to ensure
													efficient use of resources.
													"""
								type:    "string"
								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
							}
							kubeConfig: {
								description: """
													The KubeConfig for reconciling the Kustomization on a remote cluster.
													When used in combination with KustomizationSpec.ServiceAccountName,
													forces the controller to act on behalf of that Service Account at the
													target cluster.
													If the --default-service-account flag is set, its value will be used as
													a controller level fallback for when KustomizationSpec.ServiceAccountName
													is empty.
													"""
								type: "object"
								properties: {
									configMapRef: {
										description: """
															ConfigMapRef holds an optional name of a ConfigMap that contains
															the following keys:

															- `provider`: the provider to use. One of `aws`, `azure`, `gcp`, or
															   `generic`. Required.
															- `cluster`: the fully qualified resource name of the Kubernetes
															   cluster in the cloud provider API. Not used by the `generic`
															   provider. Required when one of `address` or `ca.crt` is not set.
															- `address`: the address of the Kubernetes API server. Required
															   for `generic`. For the other providers, if not specified, the
															   first address in the cluster resource will be used, and if
															   specified, it must match one of the addresses in the cluster
															   resource.
															   If audiences is not set, will be used as the audience for the
															   `generic` provider.
															- `ca.crt`: the optional PEM-encoded CA certificate for the
															   Kubernetes API server. If not set, the controller will use the
															   CA certificate from the cluster resource.
															- `audiences`: the optional audiences as a list of
															   line-break-separated strings for the Kubernetes ServiceAccount
															   token. Defaults to the `address` for the `generic` provider, or
															   to specific values for the other providers depending on the
															   provider.
															-  `serviceAccountName`: the optional name of the Kubernetes
															   ServiceAccount in the same namespace that should be used
															   for authentication. If not specified, the controller
															   ServiceAccount will be used.

															Mutually exclusive with SecretRef.
															"""
										type: "object"
										required: ["name"]
										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
									}
									secretRef: {
										description: """
															SecretRef holds an optional name of a secret that contains a key with
															the kubeconfig file as the value. If no key is set, the key will default
															to 'value'. Mutually exclusive with ConfigMapRef.
															It is recommended that the kubeconfig is self-contained, and the secret
															is regularly updated if credentials such as a cloud-access-token expire.
															Cloud specific `cmd-path` auth helpers will not function without adding
															binaries and credentials to the Pod that is responsible for reconciling
															Kubernetes resources. Supported only for the generic provider.
															"""
										type: "object"
										required: ["name"]
										properties: {
											key: {
												description: "Key in the Secret, when not specified an implementation-specific default key is used."
												type:        "string"
											}
											name: {
												description: "Name of the Secret."
												type:        "string"
											}
										}
									}
								}
								"x-kubernetes-validations": [{
									rule:    "has(self.configMapRef) || has(self.secretRef)"
									message: "exactly one of spec.kubeConfig.configMapRef or spec.kubeConfig.secretRef must be specified"
								}, {
									rule:    "!has(self.configMapRef) || !has(self.secretRef)"
									message: "exactly one of spec.kubeConfig.configMapRef or spec.kubeConfig.secretRef must be specified"
								}]
							}
							namePrefix: {
								description: "NamePrefix will prefix the names of all managed resources."
								type:        "string"
								maxLength:   200
								minLength:   1
							}
							nameSuffix: {
								description: "NameSuffix will suffix the names of all managed resources."
								type:        "string"
								maxLength:   200
								minLength:   1
							}
							patches: {
								description: """
													Strategic merge and JSON patches, defined as inline YAML objects,
													capable of targeting objects based on kind, label and annotation selectors.
													"""
								type: "array"
								items: {
									description: """
														Patch contains an inline StrategicMerge or JSON6902 patch, and the target the patch should
														be applied to.
														"""
									properties: {
										patch: {
											description: """
																Patch contains an inline StrategicMerge patch or an inline JSON6902 patch with
																an array of operation objects.
																"""
											type: "string"
										}
										target: {
											description: "Target points to the resources that the patch document should be applied to."
											properties: {
												annotationSelector: {
													description: """
																		AnnotationSelector is a string that follows the label selection expression
																		https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api
																		It matches with the resource annotations.
																		"""
													type: "string"
												}
												group: {
													description: """
																		Group is the API group to select resources from.
																		Together with Version and Kind it is capable of unambiguously identifying and/or selecting resources.
																		https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md
																		"""
													type: "string"
												}
												kind: {
													description: """
																		Kind of the API Group to select resources from.
																		Together with Group and Version it is capable of unambiguously
																		identifying and/or selecting resources.
																		https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md
																		"""
													type: "string"
												}
												labelSelector: {
													description: """
																		LabelSelector is a string that follows the label selection expression
																		https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api
																		It matches with the resource labels.
																		"""
													type: "string"
												}
												name: {
													description: "Name to match resources with."
													type:        "string"
												}
												namespace: {
													description: "Namespace to select resources from."
													type:        "string"
												}
												version: {
													description: """
																		Version of the API Group to select resources from.
																		Together with Group and Kind it is capable of unambiguously identifying and/or selecting resources.
																		https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md
																		"""
													type: "string"
												}
											}
											type: "object"
										}
									}
									required: ["patch"]
									type: "object"
								}
							}
							path: {
								description: """
													Path to the directory containing the kustomization.yaml file, or the
													set of plain YAMLs a kustomization.yaml should be generated for.
													Defaults to 'None', which translates to the root path of the SourceRef.
													"""
								type: "string"
							}
							postBuild: {
								description: """
													PostBuild describes which actions to perform on the YAML manifest
													generated by building the kustomize overlay.
													"""
								type: "object"
								properties: {
									substitute: {
										description: """
															Substitute holds a map of key/value pairs.
															The variables defined in your YAML manifests that match any of the keys
															defined in the map will be substituted with the set value.
															Includes support for bash string replacement functions
															e.g. ${var:=default}, ${var:position} and ${var/substring/replacement}.
															"""
										type: "object"
										additionalProperties: type: "string"
									}
									substituteFrom: {
										description: """
															SubstituteFrom holds references to ConfigMaps and Secrets containing
															the variables and their values to be substituted in the YAML manifests.
															The ConfigMap and the Secret data keys represent the var names, and they
															must match the vars declared in the manifests for the substitution to
															happen.
															"""
										type: "array"
										items: {
											description: """
																SubstituteReference contains a reference to a resource containing
																the variables name and value.
																"""
											properties: {
												kind: {
													description: "Kind of the values referent, valid values are ('Secret', 'ConfigMap')."
													enum: ["Secret", "ConfigMap"]
													type: "string"
												}
												name: {
													description: """
																		Name of the values referent. Should reside in the same namespace as the
																		referring resource.
																		"""
													maxLength: 253
													minLength: 1
													type:      "string"
												}
												optional: {
													default: false
													description: """
																		Optional indicates whether the referenced resource must exist, or whether to
																		tolerate its absence. If true and the referenced resource is absent, proceed
																		as if the resource was present but empty, without any variables defined.
																		"""
													type: "boolean"
												}
											}
											required: ["kind", "name"]
											type: "object"
										}
									}
									substituteStrategy: {
										description: """
															SubstituteStrategy defines the strategy for substituting variables in the YAML manifests.
															Valid values are:

															 - WithVariables (the default): require at least one variable to be defined,
															   either through the inline map or through the resolved references to ConfigMaps
															   and Secrets.
															 - Always: perform the substitution even if no variables are defined.
															"""
										type: "string"
										enum: ["WithVariables", "Always"]
									}
								}
							}
							prune: {
								description: "Prune enables garbage collection."
								type:        "boolean"
							}
							retryInterval: {
								description: """
													The interval at which to retry a previously failed reconciliation.
													When not specified, the controller uses the KustomizationSpec.Interval
													value to retry failures.
													"""
								type:    "string"
								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
							}
							serviceAccountName: {
								description: """
													The name of the Kubernetes service account to impersonate
													when reconciling this Kustomization.
													"""
								type: "string"
							}
							sourceRef: {
								description: "Reference of the source where the kustomization file is."
								type:        "object"
								required: ["kind", "name"]
								properties: {
									apiVersion: {
										description: "API version of the referent."
										type:        "string"
									}
									kind: {
										description: "Kind of the referent."
										type:        "string"
										enum: ["OCIRepository", "GitRepository", "Bucket", "ExternalArtifact"]
									}
									name: {
										description: "Name of the referent."
										type:        "string"
									}
									namespace: {
										description: """
															Namespace of the referent, defaults to the namespace of the Kubernetes
															resource object that contains the reference.
															"""
										type: "string"
									}
								}
							}
							suspend: {
								description: """
													This flag tells the controller to suspend subsequent kustomize executions,
													it does not apply to already started executions. Defaults to false.
													"""
								type: "boolean"
							}
							targetNamespace: {
								description: """
													TargetNamespace sets or overrides the namespace in the
													kustomization.yaml file.
													"""
								type:      "string"
								maxLength: 63
								minLength: 1
							}
							timeout: {
								description: """
													Timeout for validation, apply and health checking operations.
													Defaults to 'Interval' duration.
													"""
								type:    "string"
								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
							}
							wait: {
								description: """
													Wait instructs the controller to check the health of all the reconciled
													resources. When enabled, the HealthChecks are ignored. Defaults to false.
													"""
								type: "boolean"
							}
						}
					}
					status: {
						description: "KustomizationStatus defines the observed state of a kustomization."
						type:        "object"
						default: observedGeneration: -1
						properties: {
							conditions: {
								type: "array"
								items: {
									description: "Condition contains details for one aspect of the current state of this API Resource."
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
											enum: ["True", "False", "Unknown"]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase."
											maxLength:   316
											pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:        "string"
										}
									}
									required: ["lastTransitionTime", "message", "reason", "status", "type"]
									type: "object"
								}
							}
							history: {
								description: """
													History contains a set of snapshots of the last reconciliation attempts
													tracking the revision, the state and the duration of each attempt.
													"""
								type: "array"
								items: {
									description: """
														Snapshot represents a point-in-time record of a group of resources reconciliation,
														including timing information, status, and a unique digest identifier.
														"""
									properties: {
										digest: {
											description: "Digest is the checksum in the format `<algo>:<hex>` of the resources in this snapshot."
											type:        "string"
										}
										firstReconciled: {
											description: "FirstReconciled is the time when this revision was first reconciled to the cluster."
											format:      "date-time"
											type:        "string"
										}
										lastReconciled: {
											description: "LastReconciled is the time when this revision was last reconciled to the cluster."
											format:      "date-time"
											type:        "string"
										}
										lastReconciledDuration: {
											description: "LastReconciledDuration is time it took to reconcile the resources in this revision."
											type:        "string"
										}
										lastReconciledStatus: {
											description: "LastReconciledStatus is the status of the last reconciliation."
											type:        "string"
										}
										metadata: {
											additionalProperties: type: "string"
											description: "Metadata contains additional information about the snapshot."
											type:        "object"
										}
										totalReconciliations: {
											description: "TotalReconciliations is the total number of reconciliations that have occurred for this snapshot."
											format:      "int64"
											type:        "integer"
										}
									}
									required: ["digest", "firstReconciled", "lastReconciled", "lastReconciledDuration", "lastReconciledStatus", "totalReconciliations"]
									type: "object"
								}
							}
							inventory: {
								description: """
													Inventory contains the list of Kubernetes resource object references that
													have been successfully applied.
													"""
								type: "object"
								required: ["entries"]
								properties: entries: {
									description: "Entries of Kubernetes resource object references."
									type:        "array"
									items: {
										description: "ResourceRef contains the information necessary to locate a resource within a cluster."
										properties: {
											id: {
												description: """
																		ID is the string representation of the Kubernetes resource object's metadata,
																		in the format '<namespace>_<name>_<group>_<kind>'.
																		"""
												type: "string"
											}
											v: {
												description: "Version is the API version of the Kubernetes resource object's kind."
												type:        "string"
											}
										}
										required: ["id", "v"]
										type: "object"
									}
								}
							}
							lastAppliedOriginRevision: {
								description: """
													The last successfully applied origin revision.
													Equals the origin revision of the applied Artifact from the referenced Source.
													Usually present on the Metadata of the applied Artifact and depends on the
													Source type, e.g. for OCI it's the value associated with the key
													"org.opencontainers.image.revision".
													"""
								type: "string"
							}
							lastAppliedRevision: {
								description: """
													The last successfully applied revision.
													Equals the Revision of the applied Artifact from the referenced Source.
													"""
								type: "string"
							}
							lastAttemptedRevision: {
								description: "LastAttemptedRevision is the revision of the last reconciliation attempt."
								type:        "string"
							}
							lastHandledReconcileAt: {
								description: """
													LastHandledReconcileAt holds the value of the most recent
													reconcile request value, so a change of the annotation value
													can be detected.
													"""
								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last reconciled generation."
								type:        "integer"
								format:      "int64"
							}
						}
					}
				}
			}
			subresources: status: {}
			additionalPrinterColumns: [{
				name:     "Age"
				type:     "date"
				jsonPath: ".metadata.creationTimestamp"
			}, {
				name:     "Ready"
				type:     "string"
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
			}, {
				name:     "Status"
				type:     "string"
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
			}]
		}]
	}
}]
