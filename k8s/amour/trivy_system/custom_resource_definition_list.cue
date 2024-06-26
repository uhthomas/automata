package trivy_system

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
	metadata: name: "clustercompliancereports.aquasecurity.github.io"
	spec: {
		group: "aquasecurity.github.io"
		names: {
			kind:     "ClusterComplianceReport"
			listKind: "ClusterComplianceReportList"
			plural:   "clustercompliancereports"
			shortNames: ["compliance"]
			singular: "clustercompliancereport"
		}
		scope: apiextensionsv1.#ClusterScoped
		versions: [{
			additionalPrinterColumns: [{
				description: "The age of the report"
				jsonPath:    ".metadata.creationTimestamp"
				name:        "Age"
				type:        "date"
			}, {
				description: "The number of checks that failed"
				jsonPath:    ".status.summary.failCount"
				name:        "Fail"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of checks that passed"
				jsonPath:    ".status.summary.passCount"
				name:        "Pass"
				priority:    1
				type:        "integer"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "ClusterComplianceReport is a specification for the ClusterComplianceReport resource."

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "ReportSpec represent the compliance specification"
						properties: {
							compliance: {
								properties: {
									controls: {
										description: "Control represent the cps controls data and mapping checks"

										items: {
											description: "Control represent the cps controls data and mapping checks"

											properties: {
												checks: {
													items: {
														description: "SpecCheck represent the scanner who perform the control check"

														properties: id: {
															description: "id define the check id as produced by scanner"

															type: "string"
														}
														required: ["id"]
														type: "object"
													}
													type: "array"
												}
												defaultStatus: {
													description: "define the default value for check status in case resource not found"

													enum: [
														"PASS",
														"WARN",
														"FAIL",
													]
													type: "string"
												}
												description: type: "string"
												id: {
													description: "id define the control check id"
													type:        "string"
												}
												name: type: "string"
												severity: {
													description: "define the severity of the control"
													enum: [
														"CRITICAL",
														"HIGH",
														"MEDIUM",
														"LOW",
														"UNKNOWN",
													]
													type: "string"
												}
											}
											required: [
												"id",
												"name",
												"severity",
											]
											type: "object"
										}
										type: "array"
									}
									description: type: "string"
									id: type:          "string"
									relatedResources: {
										items: type: "string"
										type: "array"
									}
									title: type:   "string"
									version: type: "string"
								}
								required: [
									"controls",
									"description",
									"id",
									"relatedResources",
									"title",
									"version",
								]
								type: "object"
							}
							cron: {
								description: "cron define the intervals for report generation"
								pattern:     "^(((([\\*]{1}){1})|((\\*\\/){0,1}(([0-9]{1}){1}|(([1-5]{1}){1}([0-9]{1}){1}){1}))) ((([\\*]{1}){1})|((\\*\\/){0,1}(([0-9]{1}){1}|(([1]{1}){1}([0-9]{1}){1}){1}|([2]{1}){1}([0-3]{1}){1}))) ((([\\*]{1}){1})|((\\*\\/){0,1}(([1-9]{1}){1}|(([1-2]{1}){1}([0-9]{1}){1}){1}|([3]{1}){1}([0-1]{1}){1}))) ((([\\*]{1}){1})|((\\*\\/){0,1}(([1-9]{1}){1}|(([1-2]{1}){1}([0-9]{1}){1}){1}|([3]{1}){1}([0-1]{1}){1}))|(jan|feb|mar|apr|may|jun|jul|aug|sep|okt|nov|dec)) ((([\\*]{1}){1})|((\\*\\/){0,1}(([0-7]{1}){1}))|(sun|mon|tue|wed|thu|fri|sat)))$"

								type: "string"
							}
							reportType: {
								enum: [
									"summary",
									"all",
								]
								type: "string"
							}
						}
						required: [
							"compliance",
							"cron",
							"reportType",
						]
						type: "object"
					}
					status: {
						properties: {
							detailReport: {
								description: "ComplianceReport represents a kubernetes scan report"
								properties: {
									description: type: "string"
									id: type:          "string"
									relatedVersion: {
										items: type: "string"
										type: "array"
									}
									results: {
										items: {
											properties: {
												checks: {
													items: {
														description: "ComplianceCheck provides the result of conducting a single compliance step."

														properties: {
															category: type:    "string"
															checkID: type:     "string"
															description: type: "string"
															messages: {
																items: type: "string"
																type: "array"
															}
															remediation: {
																description: "Remediation provides description or links to external resources to remediate failing check."

																type: "string"
															}
															severity: {
																description: "Severity level of a vulnerability or a configuration audit check."

																type: "string"
															}
															success: type: "boolean"
															target: type:  "string"
															title: type:   "string"
														}
														required: [
															"checkID",
															"severity",
															"success",
														]
														type: "object"
													}
													type: "array"
												}
												description: type: "string"
												id: type:          "string"
												name: type:        "string"
												severity: type:    "string"
												status: type:      "string"
											}
											required: ["checks"]
											type: "object"
										}
										type: "array"
									}
									title: type:   "string"
									version: type: "string"
								}
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							summary: {
								properties: {
									failCount: type: "integer"
									passCount: type: "integer"
								}
								type: "object"
							}
							summaryReport: {
								description: "SummaryReport represents a kubernetes scan report with consolidated findings"

								properties: {
									controlCheck: {
										items: {
											properties: {
												id: type:        "string"
												name: type:      "string"
												severity: type:  "string"
												totalFail: type: "integer"
											}
											type: "object"
										}
										type: "array"
									}
									id: type:    "string"
									title: type: "string"
								}
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							updateTimestamp: {
								format: "date-time"
								type:   "string"
							}
						}
						required: ["updateTimestamp"]
						type: "object"
					}
				}
				type:                                   "object"
				"x-kubernetes-preserve-unknown-fields": true
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}, {
	metadata: name: "clusterconfigauditreports.aquasecurity.github.io"
	spec: {
		group: "aquasecurity.github.io"
		names: {
			kind:     "ClusterConfigAuditReport"
			listKind: "ClusterConfigAuditReportList"
			plural:   "clusterconfigauditreports"
			shortNames: ["clusterconfigaudit"]
			singular: "clusterconfigauditreport"
		}
		scope: apiextensionsv1.#ClusterScoped
		versions: [{
			additionalPrinterColumns: [{
				description: "The name of the config audit scanner"
				jsonPath:    ".report.scanner.name"
				name:        "Scanner"
				type:        "string"
			}, {
				description: "The age of the report"
				jsonPath:    ".metadata.creationTimestamp"
				name:        "Age"
				type:        "date"
			}, {
				description: "The number of failed checks with critical severity"
				jsonPath:    ".report.summary.criticalCount"
				name:        "Critical"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with high severity"
				jsonPath:    ".report.summary.highCount"
				name:        "High"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with medium severity"
				jsonPath:    ".report.summary.mediumCount"
				name:        "Medium"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with low severity"
				jsonPath:    ".report.summary.lowCount"
				name:        "Low"
				priority:    1
				type:        "integer"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "ClusterConfigAuditReport is a specification for the ClusterConfigAuditReport resource."

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					report: {
						properties: {
							checks: {
								description: "Checks provides results of conducting audit steps."
								items: {
									description: "Check provides the result of conducting a single audit step."

									properties: {
										category: type:    "string"
										checkID: type:     "string"
										description: type: "string"
										messages: {
											items: type: "string"
											type: "array"
										}
										remediation: {
											description: "Remediation provides description or links to external resources to remediate failing check."

											type: "string"
										}
										scope: {
											description: "Scope indicates the section of config that was audited."

											properties: {
												type: {
													description: "Type indicates type of this scope, e.g. Container, ConfigMapKey or JSONPath."

													type: "string"
												}
												value: {
													description: "Value indicates value of this scope that depends on Type, e.g. container name, ConfigMap key or JSONPath expression"

													type: "string"
												}
											}
											required: [
												"type",
												"value",
											]
											type: "object"
										}
										severity: {
											description: "Severity level of a vulnerability or a configuration audit check."

											type: "string"
										}
										success: type: "boolean"
										title: type:   "string"
									}
									required: [
										"checkID",
										"severity",
										"success",
									]
									type: "object"
								}
								type: "array"
							}
							scanner: {
								description: "Scanner is the spec for a scanner generating a security assessment report."

								properties: {
									name: {
										description: "Name the name of the scanner."
										type:        "string"
									}
									vendor: {
										description: "Vendor the name of the vendor providing the scanner."
										type:        "string"
									}
									version: {
										description: "Version the version of the scanner."
										type:        "string"
									}
								}
								required: [
									"name",
									"vendor",
									"version",
								]
								type: "object"
							}
							summary: {
								description: "ConfigAuditSummary counts failed checks by severity."
								properties: {
									criticalCount: {
										description: "CriticalCount is the number of failed checks with critical severity."

										type: "integer"
									}
									highCount: {
										description: "HighCount is the number of failed checks with high severity."

										type: "integer"
									}
									lowCount: {
										description: "LowCount is the number of failed check with low severity."
										type:        "integer"
									}
									mediumCount: {
										description: "MediumCount is the number of failed checks with medium severity."

										type: "integer"
									}
								}
								required: [
									"criticalCount",
									"highCount",
									"lowCount",
									"mediumCount",
								]
								type: "object"
							}
							updateTimestamp: {
								format: "date-time"
								type:   "string"
							}
						}
						required: ["checks"]
						type: "object"
					}
				}
				required: ["report"]
				type:                                   "object"
				"x-kubernetes-preserve-unknown-fields": true
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
}, {
	metadata: name: "clusterinfraassessmentreports.aquasecurity.github.io"
	spec: {
		group: "aquasecurity.github.io"
		names: {
			kind:     "ClusterInfraAssessmentReport"
			listKind: "ClusterInfraAssessmentReportList"
			plural:   "clusterinfraassessmentreports"
			shortNames: ["clusterinfraassessment"]
			singular: "clusterinfraassessmentreport"
		}
		scope: apiextensionsv1.#ClusterScoped
		versions: [{
			additionalPrinterColumns: [{
				description: "The name of the infra assessement scanner"
				jsonPath:    ".report.scanner.name"
				name:        "Scanner"
				type:        "string"
			}, {
				description: "The age of the report"
				jsonPath:    ".metadata.creationTimestamp"
				name:        "Age"
				type:        "date"
			}, {
				description: "The number of failed checks with critical severity"
				jsonPath:    ".report.summary.criticalCount"
				name:        "Critical"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with high severity"
				jsonPath:    ".report.summary.highCount"
				name:        "High"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with medium severity"
				jsonPath:    ".report.summary.mediumCount"
				name:        "Medium"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with low severity"
				jsonPath:    ".report.summary.lowCount"
				name:        "Low"
				priority:    1
				type:        "integer"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "ClusterInfraAssessmentReport is a specification for the ClusterInfraAssessmentReport resource."

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					report: {
						properties: {
							checks: {
								description: "Checks provides results of conducting audit steps."
								items: {
									description: "Check provides the result of conducting a single audit step."

									properties: {
										category: type:    "string"
										checkID: type:     "string"
										description: type: "string"
										messages: {
											items: type: "string"
											type: "array"
										}
										remediation: {
											description: "Remediation provides description or links to external resources to remediate failing check."

											type: "string"
										}
										scope: {
											description: "Scope indicates the section of config that was audited."

											properties: {
												type: {
													description: "Type indicates type of this scope, e.g. Container, ConfigMapKey or JSONPath."

													type: "string"
												}
												value: {
													description: "Value indicates value of this scope that depends on Type, e.g. container name, ConfigMap key or JSONPath expression"

													type: "string"
												}
											}
											required: [
												"type",
												"value",
											]
											type: "object"
										}
										severity: {
											description: "Severity level of a vulnerability or a configuration audit check."

											type: "string"
										}
										success: type: "boolean"
										title: type:   "string"
									}
									required: [
										"checkID",
										"severity",
										"success",
									]
									type: "object"
								}
								type: "array"
							}
							scanner: {
								description: "Scanner is the spec for a scanner generating a security assessment report."

								properties: {
									name: {
										description: "Name the name of the scanner."
										type:        "string"
									}
									vendor: {
										description: "Vendor the name of the vendor providing the scanner."
										type:        "string"
									}
									version: {
										description: "Version the version of the scanner."
										type:        "string"
									}
								}
								required: [
									"name",
									"vendor",
									"version",
								]
								type: "object"
							}
							summary: {
								description: "InfraAssessmentSummary counts failed checks by severity."
								properties: {
									criticalCount: {
										description: "CriticalCount is the number of failed checks with critical severity."

										type: "integer"
									}
									highCount: {
										description: "HighCount is the number of failed checks with high severity."

										type: "integer"
									}
									lowCount: {
										description: "LowCount is the number of failed check with low severity."
										type:        "integer"
									}
									mediumCount: {
										description: "MediumCount is the number of failed checks with medium severity."

										type: "integer"
									}
								}
								required: [
									"criticalCount",
									"highCount",
									"lowCount",
									"mediumCount",
								]
								type: "object"
							}
						}
						required: [
							"checks",
							"scanner",
							"summary",
						]
						type: "object"
					}
				}
				required: ["report"]
				type:                                   "object"
				"x-kubernetes-preserve-unknown-fields": true
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
}, {
	metadata: name: "clusterrbacassessmentreports.aquasecurity.github.io"
	spec: {
		group: "aquasecurity.github.io"
		names: {
			kind:     "ClusterRbacAssessmentReport"
			listKind: "ClusterRbacAssessmentReportList"
			plural:   "clusterrbacassessmentreports"
			shortNames: ["clusterrbacassessmentreport"]
			singular: "clusterrbacassessmentreport"
		}
		scope: apiextensionsv1.#ClusterScoped
		versions: [{
			additionalPrinterColumns: [{
				description: "The name of the rbac assessment scanner"
				jsonPath:    ".report.scanner.name"
				name:        "Scanner"
				type:        "string"
			}, {
				description: "The age of the report"
				jsonPath:    ".metadata.creationTimestamp"
				name:        "Age"
				type:        "date"
			}, {
				description: "The number of failed checks with critical severity"
				jsonPath:    ".report.summary.criticalCount"
				name:        "Critical"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with high severity"
				jsonPath:    ".report.summary.highCount"
				name:        "High"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with medium severity"
				jsonPath:    ".report.summary.mediumCount"
				name:        "Medium"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with low severity"
				jsonPath:    ".report.summary.lowCount"
				name:        "Low"
				priority:    1
				type:        "integer"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "ClusterRbacAssessmentReport is a specification for the ClusterRbacAssessmentReport resource."

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					report: {
						properties: {
							checks: {
								description: "Checks provides results of conducting audit steps."
								items: {
									description: "Check provides the result of conducting a single audit step."

									properties: {
										category: type:    "string"
										checkID: type:     "string"
										description: type: "string"
										messages: {
											items: type: "string"
											type: "array"
										}
										remediation: {
											description: "Remediation provides description or links to external resources to remediate failing check."

											type: "string"
										}
										scope: {
											description: "Scope indicates the section of config that was audited."

											properties: {
												type: {
													description: "Type indicates type of this scope, e.g. Container, ConfigMapKey or JSONPath."

													type: "string"
												}
												value: {
													description: "Value indicates value of this scope that depends on Type, e.g. container name, ConfigMap key or JSONPath expression"

													type: "string"
												}
											}
											required: [
												"type",
												"value",
											]
											type: "object"
										}
										severity: {
											description: "Severity level of a vulnerability or a configuration audit check."

											type: "string"
										}
										success: type: "boolean"
										title: type:   "string"
									}
									required: [
										"checkID",
										"severity",
										"success",
									]
									type: "object"
								}
								type: "array"
							}
							scanner: {
								description: "Scanner is the spec for a scanner generating a security assessment report."

								properties: {
									name: {
										description: "Name the name of the scanner."
										type:        "string"
									}
									vendor: {
										description: "Vendor the name of the vendor providing the scanner."
										type:        "string"
									}
									version: {
										description: "Version the version of the scanner."
										type:        "string"
									}
								}
								required: [
									"name",
									"vendor",
									"version",
								]
								type: "object"
							}
							summary: {
								description: "RbacAssessmentSummary counts failed checks by severity."
								properties: {
									criticalCount: {
										description: "CriticalCount is the number of failed checks with critical severity."

										type: "integer"
									}
									highCount: {
										description: "HighCount is the number of failed checks with high severity."

										type: "integer"
									}
									lowCount: {
										description: "LowCount is the number of failed check with low severity."
										type:        "integer"
									}
									mediumCount: {
										description: "MediumCount is the number of failed checks with medium severity."

										type: "integer"
									}
								}
								required: [
									"criticalCount",
									"highCount",
									"lowCount",
									"mediumCount",
								]
								type: "object"
							}
						}
						required: [
							"checks",
							"scanner",
							"summary",
						]
						type: "object"
					}
				}
				required: ["report"]
				type:                                   "object"
				"x-kubernetes-preserve-unknown-fields": true
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
}, {
	metadata: name: "clustersbomreports.aquasecurity.github.io"
	spec: {
		group: "aquasecurity.github.io"
		names: {
			kind:     "ClusterSbomReport"
			listKind: "ClusterSbomReportList"
			plural:   "clustersbomreports"
			shortNames: ["clustersbom"]
			singular: "clustersbomreport"
		}
		scope: apiextensionsv1.#ClusterScoped
		versions: [{
			additionalPrinterColumns: [{
				description: "The name of image repository"
				jsonPath:    ".report.artifact.repository"
				name:        "Repository"
				type:        "string"
			}, {
				description: "The name of image tag"
				jsonPath:    ".report.artifact.tag"
				name:        "Tag"
				type:        "string"
			}, {
				description: "The name of the sbom generation scanner"
				jsonPath:    ".report.scanner.name"
				name:        "Scanner"
				type:        "string"
			}, {
				description: "The age of the report"
				jsonPath:    ".metadata.creationTimestamp"
				name:        "Age"
				type:        "date"
			}, {
				description: "The number of dependencies in bom"
				jsonPath:    ".report.summary.componentsCount"
				name:        "Components"
				priority:    1
				type:        "integer"
			}, {
				description: "The the number of components in bom"
				jsonPath:    ".report.summary.dependenciesCount"
				name:        "Dependencies"
				priority:    1
				type:        "integer"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "ClusterSbomReport summarizes components and dependencies found in container image"

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					report: {
						description: "Report is the actual sbom report data."
						properties: {
							artifact: {
								description: "Artifact represents a standalone, executable package of software that includes everything needed to run an application."

								properties: {
									digest: {
										description: "Digest is a unique and immutable identifier of an Artifact."

										type: "string"
									}
									mimeType: {
										description: "MimeType represents a type and format of an Artifact."
										type:        "string"
									}
									repository: {
										description: "Repository is the name of the repository in the Artifact registry."

										type: "string"
									}
									tag: {
										description: "Tag is a mutable, human-readable string used to identify an Artifact."

										type: "string"
									}
								}
								type: "object"
							}
							components: {
								description: "Bom is artifact bill of materials."
								properties: {
									bomFormat: type: "string"
									components: {
										items: {
											properties: {
												"bom-ref": type: "string"
												group: type:     "string"
												hashes: {
													items: {
														properties: {
															alg: type:     "string"
															content: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												licenses: {
													items: {
														properties: {
															expression: type: "string"
															license: {
																properties: {
																	id: type:   "string"
																	name: type: "string"
																	url: type:  "string"
																}
																type: "object"
															}
														}
														type: "object"
													}
													type: "array"
												}
												name: type: "string"
												properties: {
													items: {
														properties: {
															name: type:  "string"
															value: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												purl: type: "string"
												supplier: {
													properties: {
														contact: {
															items: {
																properties: {
																	email: type: "string"
																	name: type:  "string"
																	phone: type: "string"
																}
																type: "object"
															}
															type: "array"
														}
														name: type: "string"
														url: {
															items: type: "string"
															type: "array"
														}
													}
													type: "object"
												}
												type: type:    "string"
												version: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									dependencies: {
										items: {
											properties: {
												dependsOn: {
													items: type: "string"
													type: "array"
												}
												ref: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									metadata: {
										properties: {
											component: {
												properties: {
													"bom-ref": type: "string"
													group: type:     "string"
													hashes: {
														items: {
															properties: {
																alg: type:     "string"
																content: type: "string"
															}
															type: "object"
														}
														type: "array"
													}
													licenses: {
														items: {
															properties: {
																expression: type: "string"
																license: {
																	properties: {
																		id: type:   "string"
																		name: type: "string"
																		url: type:  "string"
																	}
																	type: "object"
																}
															}
															type: "object"
														}
														type: "array"
													}
													name: type: "string"
													properties: {
														items: {
															properties: {
																name: type:  "string"
																value: type: "string"
															}
															type: "object"
														}
														type: "array"
													}
													purl: type: "string"
													supplier: {
														properties: {
															contact: {
																items: {
																	properties: {
																		email: type: "string"
																		name: type:  "string"
																		phone: type: "string"
																	}
																	type: "object"
																}
																type: "array"
															}
															name: type: "string"
															url: {
																items: type: "string"
																type: "array"
															}
														}
														type: "object"
													}
													type: type:    "string"
													version: type: "string"
												}
												type: "object"
											}
											timestamp: type: "string"
											tools: {
												properties: components: {
													items: {
														properties: {
															"bom-ref": type: "string"
															group: type:     "string"
															hashes: {
																items: {
																	properties: {
																		alg: type:     "string"
																		content: type: "string"
																	}
																	type: "object"
																}
																type: "array"
															}
															licenses: {
																items: {
																	properties: {
																		expression: type: "string"
																		license: {
																			properties: {
																				id: type:   "string"
																				name: type: "string"
																				url: type:  "string"
																			}
																			type: "object"
																		}
																	}
																	type: "object"
																}
																type: "array"
															}
															name: type: "string"
															properties: {
																items: {
																	properties: {
																		name: type:  "string"
																		value: type: "string"
																	}
																	type: "object"
																}
																type: "array"
															}
															purl: type: "string"
															supplier: {
																properties: {
																	contact: {
																		items: {
																			properties: {
																				email: type: "string"
																				name: type:  "string"
																				phone: type: "string"
																			}
																			type: "object"
																		}
																		type: "array"
																	}
																	name: type: "string"
																	url: {
																		items: type: "string"
																		type: "array"
																	}
																}
																type: "object"
															}
															type: type:    "string"
															version: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												type: "object"
											}
										}
										type: "object"
									}
									serialNumber: type: "string"
									specVersion: type:  "string"
									version: type:      "integer"
								}
								required: [
									"bomFormat",
									"specVersion",
								]
								type: "object"
							}
							registry: {
								description: "Registry is the registry the Artifact was pulled from."
								properties: server: {
									description: "Server the FQDN of registry server."
									type:        "string"
								}
								type: "object"
							}
							scanner: {
								description: "Scanner is the scanner that generated this report."
								properties: {
									name: {
										description: "Name the name of the scanner."
										type:        "string"
									}
									vendor: {
										description: "Vendor the name of the vendor providing the scanner."
										type:        "string"
									}
									version: {
										description: "Version the version of the scanner."
										type:        "string"
									}
								}
								required: [
									"name",
									"vendor",
									"version",
								]
								type: "object"
							}
							summary: {
								description: "Summary is a summary of sbom report."
								properties: {
									componentsCount: {
										description: "ComponentsCount is the number of components in bom."
										minimum:     0
										type:        "integer"
									}
									dependenciesCount: {
										description: "DependenciesCount is the number of dependencies in bom."

										minimum: 0
										type:    "integer"
									}
								}
								required: [
									"componentsCount",
									"dependenciesCount",
								]
								type: "object"
							}
							updateTimestamp: {
								description: "UpdateTimestamp is a timestamp representing the server time in UTC when this report was updated."

								format: "date-time"
								type:   "string"
							}
						}
						required: [
							"artifact",
							"components",
							"scanner",
							"summary",
							"updateTimestamp",
						]
						type: "object"
					}
				}
				required: ["report"]
				type: "object"
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
}, {
	metadata: name: "clustervulnerabilityreports.aquasecurity.github.io"
	spec: {
		group: "aquasecurity.github.io"
		names: {
			kind:     "ClusterVulnerabilityReport"
			listKind: "ClusterVulnerabilityReportList"
			plural:   "clustervulnerabilityreports"
			shortNames: ["clustervuln"]
			singular: "clustervulnerabilityreport"
		}
		scope: apiextensionsv1.#ClusterScoped
		versions: [{
			additionalPrinterColumns: [{
				description: "The name of image repository"
				jsonPath:    ".report.artifact.repository"
				name:        "Repository"
				type:        "string"
			}, {
				description: "The name of image tag"
				jsonPath:    ".report.artifact.tag"
				name:        "Tag"
				type:        "string"
			}, {
				description: "The name of the vulnerability scanner"
				jsonPath:    ".report.scanner.name"
				name:        "Scanner"
				type:        "string"
			}, {
				description: "The age of the report"
				jsonPath:    ".metadata.creationTimestamp"
				name:        "Age"
				type:        "date"
			}, {
				description: "The number of critical vulnerabilities"
				jsonPath:    ".report.summary.criticalCount"
				name:        "Critical"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of high vulnerabilities"
				jsonPath:    ".report.summary.highCount"
				name:        "High"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of medium vulnerabilities"
				jsonPath:    ".report.summary.mediumCount"
				name:        "Medium"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of low vulnerabilities"
				jsonPath:    ".report.summary.lowCount"
				name:        "Low"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of unknown vulnerabilities"
				jsonPath:    ".report.summary.unknownCount"
				name:        "Unknown"
				priority:    1
				type:        "integer"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "ClusterVulnerabilityReport summarizes vulnerabilities in application dependencies and operating system packages built into container images."

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					report: {
						description: "Report is the actual vulnerability report data."
						properties: {
							artifact: {
								description: "Artifact represents a standalone, executable package of software that includes everything needed to run an application."

								properties: {
									digest: {
										description: "Digest is a unique and immutable identifier of an Artifact."

										type: "string"
									}
									mimeType: {
										description: "MimeType represents a type and format of an Artifact."
										type:        "string"
									}
									repository: {
										description: "Repository is the name of the repository in the Artifact registry."

										type: "string"
									}
									tag: {
										description: "Tag is a mutable, human-readable string used to identify an Artifact."

										type: "string"
									}
								}
								type: "object"
							}
							os: {
								description: "OS information of the artifact"
								properties: {
									eosl: {
										description: "Eosl is true if OS version has reached end of service life"

										type: "boolean"
									}
									family: {
										description: "Operating System Family"
										type:        "string"
									}
									name: {
										description: "Name or version of the OS"
										type:        "string"
									}
								}
								type: "object"
							}
							registry: {
								description: "Registry is the registry the Artifact was pulled from."
								properties: server: {
									description: "Server the FQDN of registry server."
									type:        "string"
								}
								type: "object"
							}
							scanner: {
								description: "Scanner is the scanner that generated this report."
								properties: {
									name: {
										description: "Name the name of the scanner."
										type:        "string"
									}
									vendor: {
										description: "Vendor the name of the vendor providing the scanner."
										type:        "string"
									}
									version: {
										description: "Version the version of the scanner."
										type:        "string"
									}
								}
								required: [
									"name",
									"vendor",
									"version",
								]
								type: "object"
							}
							summary: {
								description: "Summary is a summary of Vulnerability counts grouped by Severity."

								properties: {
									criticalCount: {
										description: "CriticalCount is the number of vulnerabilities with Critical Severity."

										minimum: 0
										type:    "integer"
									}
									highCount: {
										description: "HighCount is the number of vulnerabilities with High Severity."

										minimum: 0
										type:    "integer"
									}
									lowCount: {
										description: "LowCount is the number of vulnerabilities with Low Severity."

										minimum: 0
										type:    "integer"
									}
									mediumCount: {
										description: "MediumCount is the number of vulnerabilities with Medium Severity."

										minimum: 0
										type:    "integer"
									}
									noneCount: {
										description: "NoneCount is the number of packages without any vulnerability."
										minimum:     0
										type:        "integer"
									}
									unknownCount: {
										description: "UnknownCount is the number of vulnerabilities with unknown severity."

										minimum: 0
										type:    "integer"
									}
								}
								required: [
									"criticalCount",
									"highCount",
									"lowCount",
									"mediumCount",
									"unknownCount",
								]
								type: "object"
							}
							updateTimestamp: {
								description: "UpdateTimestamp is a timestamp representing the server time in UTC when this report was updated."

								format: "date-time"
								type:   "string"
							}
							vulnerabilities: {
								description: "Vulnerabilities is a list of operating system (OS) or application software Vulnerability items found in the Artifact."

								items: {
									description: "Vulnerability is the spec for a vulnerability record."
									properties: {
										class: type: "string"
										cvss: {
											additionalProperties: {
												properties: {
													V2Score: type:  "number"
													V2Vector: type: "string"
													V3Score: type:  "number"
													V3Vector: type: "string"
												}
												type: "object"
											}
											type: "object"
										}
										cvsssource: type:  "string"
										description: type: "string"
										fixedVersion: {
											description: "FixedVersion indicates the version of the Resource in which this vulnerability has been fixed."

											type: "string"
										}
										installedVersion: {
											description: "InstalledVersion indicates the installed version of the Resource."

											type: "string"
										}
										lastModifiedDate: {
											description: "LastModifiedDate indicates the last date CVE has been modified."

											type: "string"
										}
										links: {
											items: type: "string"
											type: "array"
										}
										packagePath: type: "string"
										packageType: type: "string"
										primaryLink: type: "string"
										publishedDate: {
											description: "PublishedDate indicates the date of published CVE."
											type:        "string"
										}
										resource: {
											description: "Resource is a vulnerable package, application, or library."

											type: "string"
										}
										score: type: "number"
										severity: {
											description: "Severity level of a vulnerability or a configuration audit check."

											enum: [
												"CRITICAL",
												"HIGH",
												"MEDIUM",
												"LOW",
												"UNKNOWN",
											]
											type: "string"
										}
										target: type: "string"
										title: type:  "string"
										vulnerabilityID: {
											description: "VulnerabilityID the vulnerability identifier."
											type:        "string"
										}
									}
									required: [
										"fixedVersion",
										"installedVersion",
										"lastModifiedDate",
										"publishedDate",
										"resource",
										"severity",
										"title",
										"vulnerabilityID",
									]
									type: "object"
								}
								type: "array"
							}
						}
						required: [
							"artifact",
							"os",
							"scanner",
							"summary",
							"updateTimestamp",
							"vulnerabilities",
						]
						type: "object"
					}
				}
				required: ["report"]
				type:                                   "object"
				"x-kubernetes-preserve-unknown-fields": true
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
}, {
	metadata: name: "configauditreports.aquasecurity.github.io"
	spec: {
		group: "aquasecurity.github.io"
		names: {
			kind:     "ConfigAuditReport"
			listKind: "ConfigAuditReportList"
			plural:   "configauditreports"
			shortNames: [
				"configaudit",
				"configaudits",
			]
			singular: "configauditreport"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				description: "The name of the config audit scanner"
				jsonPath:    ".report.scanner.name"
				name:        "Scanner"
				type:        "string"
			}, {
				description: "The age of the report"
				jsonPath:    ".metadata.creationTimestamp"
				name:        "Age"
				type:        "date"
			}, {
				description: "The number of failed checks with critical severity"
				jsonPath:    ".report.summary.criticalCount"
				name:        "Critical"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with high severity"
				jsonPath:    ".report.summary.highCount"
				name:        "High"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with medium severity"
				jsonPath:    ".report.summary.mediumCount"
				name:        "Medium"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with low severity"
				jsonPath:    ".report.summary.lowCount"
				name:        "Low"
				priority:    1
				type:        "integer"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "ConfigAuditReport is a specification for the ConfigAuditReport resource."

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					report: {
						properties: {
							checks: {
								description: "Checks provides results of conducting audit steps."
								items: {
									description: "Check provides the result of conducting a single audit step."

									properties: {
										category: type:    "string"
										checkID: type:     "string"
										description: type: "string"
										messages: {
											items: type: "string"
											type: "array"
										}
										remediation: {
											description: "Remediation provides description or links to external resources to remediate failing check."

											type: "string"
										}
										scope: {
											description: "Scope indicates the section of config that was audited."

											properties: {
												type: {
													description: "Type indicates type of this scope, e.g. Container, ConfigMapKey or JSONPath."

													type: "string"
												}
												value: {
													description: "Value indicates value of this scope that depends on Type, e.g. container name, ConfigMap key or JSONPath expression"

													type: "string"
												}
											}
											required: [
												"type",
												"value",
											]
											type: "object"
										}
										severity: {
											description: "Severity level of a vulnerability or a configuration audit check."

											type: "string"
										}
										success: type: "boolean"
										title: type:   "string"
									}
									required: [
										"checkID",
										"severity",
										"success",
									]
									type: "object"
								}
								type: "array"
							}
							scanner: {
								description: "Scanner is the spec for a scanner generating a security assessment report."

								properties: {
									name: {
										description: "Name the name of the scanner."
										type:        "string"
									}
									vendor: {
										description: "Vendor the name of the vendor providing the scanner."
										type:        "string"
									}
									version: {
										description: "Version the version of the scanner."
										type:        "string"
									}
								}
								required: [
									"name",
									"vendor",
									"version",
								]
								type: "object"
							}
							summary: {
								description: "ConfigAuditSummary counts failed checks by severity."
								properties: {
									criticalCount: {
										description: "CriticalCount is the number of failed checks with critical severity."

										type: "integer"
									}
									highCount: {
										description: "HighCount is the number of failed checks with high severity."

										type: "integer"
									}
									lowCount: {
										description: "LowCount is the number of failed check with low severity."
										type:        "integer"
									}
									mediumCount: {
										description: "MediumCount is the number of failed checks with medium severity."

										type: "integer"
									}
								}
								required: [
									"criticalCount",
									"highCount",
									"lowCount",
									"mediumCount",
								]
								type: "object"
							}
							updateTimestamp: {
								format: "date-time"
								type:   "string"
							}
						}
						required: ["checks"]
						type: "object"
					}
				}
				required: ["report"]
				type:                                   "object"
				"x-kubernetes-preserve-unknown-fields": true
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
}, {
	metadata: name: "exposedsecretreports.aquasecurity.github.io"
	spec: {
		group: "aquasecurity.github.io"
		names: {
			kind:     "ExposedSecretReport"
			listKind: "ExposedSecretReportList"
			plural:   "exposedsecretreports"
			shortNames: [
				"exposedsecret",
				"exposedsecrets",
			]
			singular: "exposedsecretreport"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				description: "The name of image repository"
				jsonPath:    ".report.artifact.repository"
				name:        "Repository"
				type:        "string"
			}, {
				description: "The name of image tag"
				jsonPath:    ".report.artifact.tag"
				name:        "Tag"
				type:        "string"
			}, {
				description: "The name of the exposed secret scanner"
				jsonPath:    ".report.scanner.name"
				name:        "Scanner"
				type:        "string"
			}, {
				description: "The age of the report"
				jsonPath:    ".metadata.creationTimestamp"
				name:        "Age"
				type:        "date"
			}, {
				description: "The number of critical exposed secrets"
				jsonPath:    ".report.summary.criticalCount"
				name:        "Critical"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of high exposed secrets"
				jsonPath:    ".report.summary.highCount"
				name:        "High"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of medium exposed secrets"
				jsonPath:    ".report.summary.mediumCount"
				name:        "Medium"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of low exposed secrets"
				jsonPath:    ".report.summary.lowCount"
				name:        "Low"
				priority:    1
				type:        "integer"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "ExposedSecretReport summarizes exposed secrets in plaintext files built into container images."

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					report: {
						description: "Report is the actual exposed secret report data."
						properties: {
							artifact: {
								description: "Artifact represents a standalone, executable package of software that includes everything needed to run an application."

								properties: {
									digest: {
										description: "Digest is a unique and immutable identifier of an Artifact."

										type: "string"
									}
									mimeType: {
										description: "MimeType represents a type and format of an Artifact."
										type:        "string"
									}
									repository: {
										description: "Repository is the name of the repository in the Artifact registry."

										type: "string"
									}
									tag: {
										description: "Tag is a mutable, human-readable string used to identify an Artifact."

										type: "string"
									}
								}
								type: "object"
							}
							registry: {
								description: "Registry is the registry the Artifact was pulled from."
								properties: server: {
									description: "Server the FQDN of registry server."
									type:        "string"
								}
								type: "object"
							}
							scanner: {
								description: "Scanner is the scanner that generated this report."
								properties: {
									name: {
										description: "Name the name of the scanner."
										type:        "string"
									}
									vendor: {
										description: "Vendor the name of the vendor providing the scanner."
										type:        "string"
									}
									version: {
										description: "Version the version of the scanner."
										type:        "string"
									}
								}
								required: [
									"name",
									"vendor",
									"version",
								]
								type: "object"
							}
							secrets: {
								description: "Exposed secrets is a list of passwords, api keys, tokens and others items found in the Artifact."

								items: {
									description: "ExposedSecret is the spec for a exposed secret record."
									properties: {
										category: type: "string"
										match: {
											description: "Match where the exposed rule matched."
											type:        "string"
										}
										ruleID: {
											description: "RuleID is rule the identifier."
											type:        "string"
										}
										severity: {
											description: "Severity level of a vulnerability or a configuration audit check."

											enum: [
												"CRITICAL",
												"HIGH",
												"MEDIUM",
												"LOW",
											]
											type: "string"
										}
										target: {
											description: "Target is where the exposed secret was found."
											type:        "string"
										}
										title: type: "string"
									}
									required: [
										"category",
										"match",
										"ruleID",
										"severity",
										"target",
										"title",
									]
									type: "object"
								}
								type: "array"
							}
							summary: {
								description: "Summary is the exposed secrets counts grouped by Severity."
								properties: {
									criticalCount: {
										description: "CriticalCount is the number of exposed secrets with Critical Severity."

										minimum: 0
										type:    "integer"
									}
									highCount: {
										description: "HighCount is the number of exposed secrets with High Severity."

										minimum: 0
										type:    "integer"
									}
									lowCount: {
										description: "LowCount is the number of exposed secrets with Low Severity."

										minimum: 0
										type:    "integer"
									}
									mediumCount: {
										description: "MediumCount is the number of exposed secrets with Medium Severity."

										minimum: 0
										type:    "integer"
									}
								}
								required: [
									"criticalCount",
									"highCount",
									"lowCount",
									"mediumCount",
								]
								type: "object"
							}
							updateTimestamp: {
								description: "UpdateTimestamp is a timestamp representing the server time in UTC when this report was updated."

								format: "date-time"
								type:   "string"
							}
						}
						required: [
							"artifact",
							"scanner",
							"secrets",
							"summary",
							"updateTimestamp",
						]
						type: "object"
					}
				}
				required: ["report"]
				type:                                   "object"
				"x-kubernetes-preserve-unknown-fields": true
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
}, {
	metadata: name: "infraassessmentreports.aquasecurity.github.io"
	spec: {
		group: "aquasecurity.github.io"
		names: {
			kind:     "InfraAssessmentReport"
			listKind: "InfraAssessmentReportList"
			plural:   "infraassessmentreports"
			shortNames: [
				"infraassessment",
				"infraassessments",
			]
			singular: "infraassessmentreport"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				description: "The name of the infra assessment scanner"
				jsonPath:    ".report.scanner.name"
				name:        "Scanner"
				type:        "string"
			}, {
				description: "The age of the report"
				jsonPath:    ".metadata.creationTimestamp"
				name:        "Age"
				type:        "date"
			}, {
				description: "The number of failed checks with critical severity"
				jsonPath:    ".report.summary.criticalCount"
				name:        "Critical"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with high severity"
				jsonPath:    ".report.summary.highCount"
				name:        "High"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with medium severity"
				jsonPath:    ".report.summary.mediumCount"
				name:        "Medium"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with low severity"
				jsonPath:    ".report.summary.lowCount"
				name:        "Low"
				priority:    1
				type:        "integer"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "InfraAssessmentReport is a specification for the InfraAssessmentReport resource."

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					report: {
						properties: {
							checks: {
								description: "Checks provides results of conducting audit steps."
								items: {
									description: "Check provides the result of conducting a single audit step."

									properties: {
										category: type:    "string"
										checkID: type:     "string"
										description: type: "string"
										messages: {
											items: type: "string"
											type: "array"
										}
										remediation: {
											description: "Remediation provides description or links to external resources to remediate failing check."

											type: "string"
										}
										scope: {
											description: "Scope indicates the section of config that was audited."

											properties: {
												type: {
													description: "Type indicates type of this scope, e.g. Container, ConfigMapKey or JSONPath."

													type: "string"
												}
												value: {
													description: "Value indicates value of this scope that depends on Type, e.g. container name, ConfigMap key or JSONPath expression"

													type: "string"
												}
											}
											required: [
												"type",
												"value",
											]
											type: "object"
										}
										severity: {
											description: "Severity level of a vulnerability or a configuration audit check."

											type: "string"
										}
										success: type: "boolean"
										title: type:   "string"
									}
									required: [
										"checkID",
										"severity",
										"success",
									]
									type: "object"
								}
								type: "array"
							}
							scanner: {
								description: "Scanner is the spec for a scanner generating a security assessment report."

								properties: {
									name: {
										description: "Name the name of the scanner."
										type:        "string"
									}
									vendor: {
										description: "Vendor the name of the vendor providing the scanner."
										type:        "string"
									}
									version: {
										description: "Version the version of the scanner."
										type:        "string"
									}
								}
								required: [
									"name",
									"vendor",
									"version",
								]
								type: "object"
							}
							summary: {
								description: "InfraAssessmentSummary counts failed checks by severity."
								properties: {
									criticalCount: {
										description: "CriticalCount is the number of failed checks with critical severity."

										type: "integer"
									}
									highCount: {
										description: "HighCount is the number of failed checks with high severity."

										type: "integer"
									}
									lowCount: {
										description: "LowCount is the number of failed check with low severity."
										type:        "integer"
									}
									mediumCount: {
										description: "MediumCount is the number of failed checks with medium severity."

										type: "integer"
									}
								}
								required: [
									"criticalCount",
									"highCount",
									"lowCount",
									"mediumCount",
								]
								type: "object"
							}
						}
						required: [
							"checks",
							"scanner",
							"summary",
						]
						type: "object"
					}
				}
				required: ["report"]
				type: "object"
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
}, {
	metadata: name: "rbacassessmentreports.aquasecurity.github.io"
	spec: {
		group: "aquasecurity.github.io"
		names: {
			kind:     "RbacAssessmentReport"
			listKind: "RbacAssessmentReportList"
			plural:   "rbacassessmentreports"
			shortNames: [
				"rbacassessment",
				"rbacassessments",
			]
			singular: "rbacassessmentreport"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				description: "The name of the rbac assessment scanner"
				jsonPath:    ".report.scanner.name"
				name:        "Scanner"
				type:        "string"
			}, {
				description: "The age of the report"
				jsonPath:    ".metadata.creationTimestamp"
				name:        "Age"
				type:        "date"
			}, {
				description: "The number of failed checks with critical severity"
				jsonPath:    ".report.summary.criticalCount"
				name:        "Critical"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with high severity"
				jsonPath:    ".report.summary.highCount"
				name:        "High"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with medium severity"
				jsonPath:    ".report.summary.mediumCount"
				name:        "Medium"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of failed checks with low severity"
				jsonPath:    ".report.summary.lowCount"
				name:        "Low"
				priority:    1
				type:        "integer"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "RbacAssessmentReport is a specification for the RbacAssessmentReport resource."

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					report: {
						properties: {
							checks: {
								description: "Checks provides results of conducting audit steps."
								items: {
									description: "Check provides the result of conducting a single audit step."

									properties: {
										category: type:    "string"
										checkID: type:     "string"
										description: type: "string"
										messages: {
											items: type: "string"
											type: "array"
										}
										remediation: {
											description: "Remediation provides description or links to external resources to remediate failing check."

											type: "string"
										}
										scope: {
											description: "Scope indicates the section of config that was audited."

											properties: {
												type: {
													description: "Type indicates type of this scope, e.g. Container, ConfigMapKey or JSONPath."

													type: "string"
												}
												value: {
													description: "Value indicates value of this scope that depends on Type, e.g. container name, ConfigMap key or JSONPath expression"

													type: "string"
												}
											}
											required: [
												"type",
												"value",
											]
											type: "object"
										}
										severity: {
											description: "Severity level of a vulnerability or a configuration audit check."

											type: "string"
										}
										success: type: "boolean"
										title: type:   "string"
									}
									required: [
										"checkID",
										"severity",
										"success",
									]
									type: "object"
								}
								type: "array"
							}
							scanner: {
								description: "Scanner is the spec for a scanner generating a security assessment report."

								properties: {
									name: {
										description: "Name the name of the scanner."
										type:        "string"
									}
									vendor: {
										description: "Vendor the name of the vendor providing the scanner."
										type:        "string"
									}
									version: {
										description: "Version the version of the scanner."
										type:        "string"
									}
								}
								required: [
									"name",
									"vendor",
									"version",
								]
								type: "object"
							}
							summary: {
								description: "RbacAssessmentSummary counts failed checks by severity."
								properties: {
									criticalCount: {
										description: "CriticalCount is the number of failed checks with critical severity."

										type: "integer"
									}
									highCount: {
										description: "HighCount is the number of failed checks with high severity."

										type: "integer"
									}
									lowCount: {
										description: "LowCount is the number of failed check with low severity."
										type:        "integer"
									}
									mediumCount: {
										description: "MediumCount is the number of failed checks with medium severity."

										type: "integer"
									}
								}
								required: [
									"criticalCount",
									"highCount",
									"lowCount",
									"mediumCount",
								]
								type: "object"
							}
						}
						required: [
							"checks",
							"scanner",
							"summary",
						]
						type: "object"
					}
				}
				required: ["report"]
				type:                                   "object"
				"x-kubernetes-preserve-unknown-fields": true
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
}, {
	metadata: name: "sbomreports.aquasecurity.github.io"
	spec: {
		group: "aquasecurity.github.io"
		names: {
			kind:     "SbomReport"
			listKind: "SbomReportList"
			plural:   "sbomreports"
			shortNames: [
				"sbom",
				"sboms",
			]
			singular: "sbomreport"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				description: "The name of image repository"
				jsonPath:    ".report.artifact.repository"
				name:        "Repository"
				type:        "string"
			}, {
				description: "The name of image tag"
				jsonPath:    ".report.artifact.tag"
				name:        "Tag"
				type:        "string"
			}, {
				description: "The name of the sbom generation scanner"
				jsonPath:    ".report.scanner.name"
				name:        "Scanner"
				type:        "string"
			}, {
				description: "The age of the report"
				jsonPath:    ".metadata.creationTimestamp"
				name:        "Age"
				type:        "date"
			}, {
				description: "The number of dependencies in bom"
				jsonPath:    ".report.summary.componentsCount"
				name:        "Components"
				priority:    1
				type:        "integer"
			}, {
				description: "The the number of components in bom"
				jsonPath:    ".report.summary.dependenciesCount"
				name:        "Dependencies"
				priority:    1
				type:        "integer"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "SbomReport summarizes components and dependencies found in container image"

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					report: {
						description: "Report is the actual sbom report data."
						properties: {
							artifact: {
								description: "Artifact represents a standalone, executable package of software that includes everything needed to run an application."

								properties: {
									digest: {
										description: "Digest is a unique and immutable identifier of an Artifact."

										type: "string"
									}
									mimeType: {
										description: "MimeType represents a type and format of an Artifact."
										type:        "string"
									}
									repository: {
										description: "Repository is the name of the repository in the Artifact registry."

										type: "string"
									}
									tag: {
										description: "Tag is a mutable, human-readable string used to identify an Artifact."

										type: "string"
									}
								}
								type: "object"
							}
							components: {
								description: "Bom is artifact bill of materials."
								properties: {
									bomFormat: type: "string"
									components: {
										items: {
											properties: {
												"bom-ref": type: "string"
												group: type:     "string"
												hashes: {
													items: {
														properties: {
															alg: type:     "string"
															content: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												licenses: {
													items: {
														properties: {
															expression: type: "string"
															license: {
																properties: {
																	id: type:   "string"
																	name: type: "string"
																	url: type:  "string"
																}
																type: "object"
															}
														}
														type: "object"
													}
													type: "array"
												}
												name: type: "string"
												properties: {
													items: {
														properties: {
															name: type:  "string"
															value: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												purl: type: "string"
												supplier: {
													properties: {
														contact: {
															items: {
																properties: {
																	email: type: "string"
																	name: type:  "string"
																	phone: type: "string"
																}
																type: "object"
															}
															type: "array"
														}
														name: type: "string"
														url: {
															items: type: "string"
															type: "array"
														}
													}
													type: "object"
												}
												type: type:    "string"
												version: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									dependencies: {
										items: {
											properties: {
												dependsOn: {
													items: type: "string"
													type: "array"
												}
												ref: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									metadata: {
										properties: {
											component: {
												properties: {
													"bom-ref": type: "string"
													group: type:     "string"
													hashes: {
														items: {
															properties: {
																alg: type:     "string"
																content: type: "string"
															}
															type: "object"
														}
														type: "array"
													}
													licenses: {
														items: {
															properties: {
																expression: type: "string"
																license: {
																	properties: {
																		id: type:   "string"
																		name: type: "string"
																		url: type:  "string"
																	}
																	type: "object"
																}
															}
															type: "object"
														}
														type: "array"
													}
													name: type: "string"
													properties: {
														items: {
															properties: {
																name: type:  "string"
																value: type: "string"
															}
															type: "object"
														}
														type: "array"
													}
													purl: type: "string"
													supplier: {
														properties: {
															contact: {
																items: {
																	properties: {
																		email: type: "string"
																		name: type:  "string"
																		phone: type: "string"
																	}
																	type: "object"
																}
																type: "array"
															}
															name: type: "string"
															url: {
																items: type: "string"
																type: "array"
															}
														}
														type: "object"
													}
													type: type:    "string"
													version: type: "string"
												}
												type: "object"
											}
											timestamp: type: "string"
											tools: {
												properties: components: {
													items: {
														properties: {
															"bom-ref": type: "string"
															group: type:     "string"
															hashes: {
																items: {
																	properties: {
																		alg: type:     "string"
																		content: type: "string"
																	}
																	type: "object"
																}
																type: "array"
															}
															licenses: {
																items: {
																	properties: {
																		expression: type: "string"
																		license: {
																			properties: {
																				id: type:   "string"
																				name: type: "string"
																				url: type:  "string"
																			}
																			type: "object"
																		}
																	}
																	type: "object"
																}
																type: "array"
															}
															name: type: "string"
															properties: {
																items: {
																	properties: {
																		name: type:  "string"
																		value: type: "string"
																	}
																	type: "object"
																}
																type: "array"
															}
															purl: type: "string"
															supplier: {
																properties: {
																	contact: {
																		items: {
																			properties: {
																				email: type: "string"
																				name: type:  "string"
																				phone: type: "string"
																			}
																			type: "object"
																		}
																		type: "array"
																	}
																	name: type: "string"
																	url: {
																		items: type: "string"
																		type: "array"
																	}
																}
																type: "object"
															}
															type: type:    "string"
															version: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												type: "object"
											}
										}
										type: "object"
									}
									serialNumber: type: "string"
									specVersion: type:  "string"
									version: type:      "integer"
								}
								required: [
									"bomFormat",
									"specVersion",
								]
								type: "object"
							}
							registry: {
								description: "Registry is the registry the Artifact was pulled from."
								properties: server: {
									description: "Server the FQDN of registry server."
									type:        "string"
								}
								type: "object"
							}
							scanner: {
								description: "Scanner is the scanner that generated this report."
								properties: {
									name: {
										description: "Name the name of the scanner."
										type:        "string"
									}
									vendor: {
										description: "Vendor the name of the vendor providing the scanner."
										type:        "string"
									}
									version: {
										description: "Version the version of the scanner."
										type:        "string"
									}
								}
								required: [
									"name",
									"vendor",
									"version",
								]
								type: "object"
							}
							summary: {
								description: "Summary is a summary of sbom report."
								properties: {
									componentsCount: {
										description: "ComponentsCount is the number of components in bom."
										minimum:     0
										type:        "integer"
									}
									dependenciesCount: {
										description: "DependenciesCount is the number of dependencies in bom."

										minimum: 0
										type:    "integer"
									}
								}
								required: [
									"componentsCount",
									"dependenciesCount",
								]
								type: "object"
							}
							updateTimestamp: {
								description: "UpdateTimestamp is a timestamp representing the server time in UTC when this report was updated."

								format: "date-time"
								type:   "string"
							}
						}
						required: [
							"artifact",
							"components",
							"scanner",
							"summary",
							"updateTimestamp",
						]
						type: "object"
					}
				}
				required: ["report"]
				type:                                   "object"
				"x-kubernetes-preserve-unknown-fields": true
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
}, {
	metadata: name: "vulnerabilityreports.aquasecurity.github.io"
	spec: {
		group: "aquasecurity.github.io"
		names: {
			kind:     "VulnerabilityReport"
			listKind: "VulnerabilityReportList"
			plural:   "vulnerabilityreports"
			shortNames: [
				"vuln",
				"vulns",
			]
			singular: "vulnerabilityreport"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				description: "The name of image repository"
				jsonPath:    ".report.artifact.repository"
				name:        "Repository"
				type:        "string"
			}, {
				description: "The name of image tag"
				jsonPath:    ".report.artifact.tag"
				name:        "Tag"
				type:        "string"
			}, {
				description: "The name of the vulnerability scanner"
				jsonPath:    ".report.scanner.name"
				name:        "Scanner"
				type:        "string"
			}, {
				description: "The age of the report"
				jsonPath:    ".metadata.creationTimestamp"
				name:        "Age"
				type:        "date"
			}, {
				description: "The number of critical vulnerabilities"
				jsonPath:    ".report.summary.criticalCount"
				name:        "Critical"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of high vulnerabilities"
				jsonPath:    ".report.summary.highCount"
				name:        "High"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of medium vulnerabilities"
				jsonPath:    ".report.summary.mediumCount"
				name:        "Medium"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of low vulnerabilities"
				jsonPath:    ".report.summary.lowCount"
				name:        "Low"
				priority:    1
				type:        "integer"
			}, {
				description: "The number of unknown vulnerabilities"
				jsonPath:    ".report.summary.unknownCount"
				name:        "Unknown"
				priority:    1
				type:        "integer"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "VulnerabilityReport summarizes vulnerabilities in application dependencies and operating system packages built into container images."

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					report: {
						description: "Report is the actual vulnerability report data."
						properties: {
							artifact: {
								description: "Artifact represents a standalone, executable package of software that includes everything needed to run an application."

								properties: {
									digest: {
										description: "Digest is a unique and immutable identifier of an Artifact."

										type: "string"
									}
									mimeType: {
										description: "MimeType represents a type and format of an Artifact."
										type:        "string"
									}
									repository: {
										description: "Repository is the name of the repository in the Artifact registry."

										type: "string"
									}
									tag: {
										description: "Tag is a mutable, human-readable string used to identify an Artifact."

										type: "string"
									}
								}
								type: "object"
							}
							os: {
								description: "OS information of the artifact"
								properties: {
									eosl: {
										description: "Eosl is true if OS version has reached end of service life"

										type: "boolean"
									}
									family: {
										description: "Operating System Family"
										type:        "string"
									}
									name: {
										description: "Name or version of the OS"
										type:        "string"
									}
								}
								type: "object"
							}
							registry: {
								description: "Registry is the registry the Artifact was pulled from."
								properties: server: {
									description: "Server the FQDN of registry server."
									type:        "string"
								}
								type: "object"
							}
							scanner: {
								description: "Scanner is the scanner that generated this report."
								properties: {
									name: {
										description: "Name the name of the scanner."
										type:        "string"
									}
									vendor: {
										description: "Vendor the name of the vendor providing the scanner."
										type:        "string"
									}
									version: {
										description: "Version the version of the scanner."
										type:        "string"
									}
								}
								required: [
									"name",
									"vendor",
									"version",
								]
								type: "object"
							}
							summary: {
								description: "Summary is a summary of Vulnerability counts grouped by Severity."

								properties: {
									criticalCount: {
										description: "CriticalCount is the number of vulnerabilities with Critical Severity."

										minimum: 0
										type:    "integer"
									}
									highCount: {
										description: "HighCount is the number of vulnerabilities with High Severity."

										minimum: 0
										type:    "integer"
									}
									lowCount: {
										description: "LowCount is the number of vulnerabilities with Low Severity."

										minimum: 0
										type:    "integer"
									}
									mediumCount: {
										description: "MediumCount is the number of vulnerabilities with Medium Severity."

										minimum: 0
										type:    "integer"
									}
									noneCount: {
										description: "NoneCount is the number of packages without any vulnerability."
										minimum:     0
										type:        "integer"
									}
									unknownCount: {
										description: "UnknownCount is the number of vulnerabilities with unknown severity."

										minimum: 0
										type:    "integer"
									}
								}
								required: [
									"criticalCount",
									"highCount",
									"lowCount",
									"mediumCount",
									"unknownCount",
								]
								type: "object"
							}
							updateTimestamp: {
								description: "UpdateTimestamp is a timestamp representing the server time in UTC when this report was updated."

								format: "date-time"
								type:   "string"
							}
							vulnerabilities: {
								description: "Vulnerabilities is a list of operating system (OS) or application software Vulnerability items found in the Artifact."

								items: {
									description: "Vulnerability is the spec for a vulnerability record."
									properties: {
										class: type: "string"
										cvss: {
											additionalProperties: {
												properties: {
													V2Score: type:  "number"
													V2Vector: type: "string"
													V3Score: type:  "number"
													V3Vector: type: "string"
												}
												type: "object"
											}
											type: "object"
										}
										cvsssource: type:  "string"
										description: type: "string"
										fixedVersion: {
											description: "FixedVersion indicates the version of the Resource in which this vulnerability has been fixed."

											type: "string"
										}
										installedVersion: {
											description: "InstalledVersion indicates the installed version of the Resource."

											type: "string"
										}
										lastModifiedDate: {
											description: "LastModifiedDate indicates the last date CVE has been modified."

											type: "string"
										}
										links: {
											items: type: "string"
											type: "array"
										}
										packagePath: type: "string"
										packageType: type: "string"
										primaryLink: type: "string"
										publishedDate: {
											description: "PublishedDate indicates the date of published CVE."
											type:        "string"
										}
										resource: {
											description: "Resource is a vulnerable package, application, or library."

											type: "string"
										}
										score: type: "number"
										severity: {
											description: "Severity level of a vulnerability or a configuration audit check."

											enum: [
												"CRITICAL",
												"HIGH",
												"MEDIUM",
												"LOW",
												"UNKNOWN",
											]
											type: "string"
										}
										target: type: "string"
										title: type:  "string"
										vulnerabilityID: {
											description: "VulnerabilityID the vulnerability identifier."
											type:        "string"
										}
									}
									required: [
										"fixedVersion",
										"installedVersion",
										"lastModifiedDate",
										"publishedDate",
										"resource",
										"severity",
										"title",
										"vulnerabilityID",
									]
									type: "object"
								}
								type: "array"
							}
						}
						required: [
							"artifact",
							"os",
							"scanner",
							"summary",
							"updateTimestamp",
							"vulnerabilities",
						]
						type: "object"
					}
				}
				required: ["report"]
				type:                                   "object"
				"x-kubernetes-preserve-unknown-fields": true
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
}]
