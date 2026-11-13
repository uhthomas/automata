package gateway_api

import admissionregistrationv1 "k8s.io/api/admissionregistration/v1"

#ValidatingAdmissionPolicyBindingList: admissionregistrationv1.#ValidatingAdmissionPolicyBindingList & {
	apiVersion: "admissionregistration.k8s.io/v1"
	kind:       "ValidatingAdmissionPolicyBindingList"
}

#ValidatingAdmissionPolicyBindingList: items: [{
	apiVersion: "admissionregistration.k8s.io/v1"
	kind:       "ValidatingAdmissionPolicyBinding"
	metadata: {
		annotations: {
			"gateway.networking.k8s.io/bundle-version": "v1.6.1"
			"gateway.networking.k8s.io/channel":        "standard"
		}
		name: "safe-upgrades.gateway.networking.k8s.io"
	}
	spec: {
		policyName: "safe-upgrades.gateway.networking.k8s.io"
		validationActions: ["Deny"]
		matchResources: resourceRules: [{
			apiGroups: ["apiextensions.k8s.io"]
			apiVersions: ["v1"]
			resources: ["customresourcedefinitions"]
			operations: ["CREATE", "UPDATE"]
		}]
	}
}]
