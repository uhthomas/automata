package vm_operator

import (
	certmanagerv1 "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"
	admissionregistrationv1 "k8s.io/api/admissionregistration/v1"
)

#ValidatingWebhookConfigurationList: admissionregistrationv1.#ValidatingWebhookConfigurationList & {
	apiVersion: "admissionregistration.k8s.io/v1"
	kind:       "ValidatingWebhookConfigurationList"
	items: [...{
		apiVersion: "admissionregistration.k8s.io/v1"
		kind:       "ValidatingWebhookConfiguration"
	}]
}

#ValidatingWebhookConfigurationList: items: [{
	metadata: annotations: (certmanagerv1.#WantInjectAnnotation): "\(#Namespace)/\(#Name)-webhook"
	webhooks: [{
		name: "vvlogs.kb.io"
		clientConfig: service: {
			namespace: #Namespace
			name:      "\(#Name)-webhook"
			path:      "/validate-operator-victoriametrics-com-v1beta1-vlogs"
		}
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["vlogs"]
		}]
		failurePolicy: admissionregistrationv1.#Fail
		sideEffects:   admissionregistrationv1.#SideEffectClassNone
		admissionReviewVersions: ["v1"]
	}, {
		name: "vvmagent.kb.io"
		clientConfig: service: {
			namespace: #Namespace
			name:      "\(#Name)-webhook"
			path:      "/validate-operator-victoriametrics-com-v1beta1-vmagent"
		}
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["vmagents"]
		}]
		failurePolicy: admissionregistrationv1.#Fail
		sideEffects:   admissionregistrationv1.#SideEffectClassNone
		admissionReviewVersions: ["v1"]
	}, {
		name: "vvmalert.kb.io"
		clientConfig: service: {
			namespace: #Namespace
			name:      "\(#Name)-webhook"
			path:      "/validate-operator-victoriametrics-com-v1beta1-vmalert"
		}
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["vmalerts"]
		}]
		failurePolicy: admissionregistrationv1.#Fail
		sideEffects:   admissionregistrationv1.#SideEffectClassNone
		admissionReviewVersions: ["v1"]
	}, {
		name: "vvmalertmanager.kb.io"
		clientConfig: service: {
			namespace: #Namespace
			name:      "\(#Name)-webhook"
			path:      "/validate-operator-victoriametrics-com-v1beta1-vmalertmanager"
		}
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["vmalertmanagers"]
		}]
		failurePolicy: admissionregistrationv1.#Fail
		sideEffects:   admissionregistrationv1.#SideEffectClassNone
		admissionReviewVersions: ["v1"]
	}, {
		name: "vvmalertmanagerconfig.kb.io"
		clientConfig: service: {
			namespace: #Namespace
			name:      "\(#Name)-webhook"
			path:      "/validate-operator-victoriametrics-com-v1beta1-vmalertmanagerconfig"
		}
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["vmalertmanagerconfigs"]
		}]
		failurePolicy: admissionregistrationv1.#Fail
		sideEffects:   admissionregistrationv1.#SideEffectClassNone
		admissionReviewVersions: ["v1"]
	}, {
		name: "vvmauth.kb.io"
		clientConfig: service: {
			namespace: #Namespace
			name:      "\(#Name)-webhook"
			path:      "/validate-operator-victoriametrics-com-v1beta1-vmauth"
		}
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["vmauths"]
		}]
		failurePolicy: admissionregistrationv1.#Fail
		sideEffects:   admissionregistrationv1.#SideEffectClassNone
		admissionReviewVersions: ["v1"]
	}, {
		name: "vvmcluster.kb.io"
		clientConfig: service: {
			namespace: #Namespace
			name:      "\(#Name)-webhook"
			path:      "/validate-operator-victoriametrics-com-v1beta1-vmcluster"
		}
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["vmclusters"]
		}]
		failurePolicy: admissionregistrationv1.#Fail
		sideEffects:   admissionregistrationv1.#SideEffectClassNone
		admissionReviewVersions: ["v1"]
	}, {
		name: "vvmrule.kb.io"
		clientConfig: service: {
			namespace: #Namespace
			name:      "\(#Name)-webhook"
			path:      "/validate-operator-victoriametrics-com-v1beta1-vmrule"
		}
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["vmrules"]
		}]
		failurePolicy: admissionregistrationv1.#Fail
		sideEffects:   admissionregistrationv1.#SideEffectClassNone
		admissionReviewVersions: ["v1"]
	}, {
		name: "vvmsingle.kb.io"
		clientConfig: service: {
			namespace: #Namespace
			name:      "\(#Name)-webhook"
			path:      "/validate-operator-victoriametrics-com-v1beta1-vmsingle"
		}
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["vmsingles"]
		}]
		failurePolicy: admissionregistrationv1.#Fail
		sideEffects:   admissionregistrationv1.#SideEffectClassNone
		admissionReviewVersions: ["v1"]
	}, {
		name: "vvmuser.kb.io"
		clientConfig: service: {
			namespace: #Namespace
			name:      "\(#Name)-webhook"
			path:      "/validate-operator-victoriametrics-com-v1beta1-vmuser"
		}
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["vmusers"]
		}]
		failurePolicy: admissionregistrationv1.#Fail
		sideEffects:   admissionregistrationv1.#SideEffectClassNone
		admissionReviewVersions: ["v1"]
	}]
}]
