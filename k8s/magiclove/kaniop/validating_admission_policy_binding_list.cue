package kaniop

import admissionregistrationv1 "k8s.io/api/admissionregistration/v1"

#ValidatingAdmissionPolicyBindingList: admissionregistrationv1.#ValidatingAdmissionPolicyBindingList & {
	apiVersion: "admissionregistration.k8s.io/v1"
	kind:       "ValidatingAdmissionPolicyBindingList"
	items: [...{
		apiVersion: "admissionregistration.k8s.io/v1"
		kind:       "ValidatingAdmissionPolicyBinding"
	}]
}

#ValidatingAdmissionPolicyBindingList: items: [{
	metadata: name: "kanidm-group-validation-binding"
	spec: {
		policyName: "kanidm-group-validation-policy"
		validationActions: [admissionregistrationv1.#Deny]
	}
}, {
	metadata: name: "kanidm-oauth2-client-validation-binding"
	spec: {
		policyName: "kanidm-oauth2-client-validation-policy"
		validationActions: [admissionregistrationv1.#Deny]
	}
}, {
	metadata: name: "kanidm-person-validation-binding"
	spec: {
		policyName: "kanidm-person-validation-policy"
		validationActions: [admissionregistrationv1.#Deny]
	}
}, {
	metadata: name: "kanidm-service-account-validation-binding"
	spec: {
		policyName: "kanidm-service-account-validation-policy"
		validationActions: [admissionregistrationv1.#Deny]
	}
}, {
	metadata: name: "kanidm-validation-binding"
	spec: {
		policyName: "kanidm-validation-policy"
		validationActions: [admissionregistrationv1.#Deny]
	}
}]
