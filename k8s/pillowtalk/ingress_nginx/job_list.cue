package ingress_nginx

import (
	"k8s.io/api/core/v1"
	batchv1 "k8s.io/api/batch/v1"
)

jobList: batchv1.#JobList & {
	apiVersion: "batch/v1"
	kind:       "JobList"
	items: [...{
		apiVersion: "batch/v1"
		kind:       "Job"
	}]
}

jobList: items: [{
	metadata: {
		name: "ingress-nginx-admission-create"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/component": "admission-webhook"
		}
	}
	spec: template: {
		metadata: {
			name: "ingress-nginx-admission-create"
			labels: {
				"app.kubernetes.io/name":      "ingress-nginx"
				"app.kubernetes.io/instance":  "ingress-nginx"
				"app.kubernetes.io/version":   "0.44.0"
				"app.kubernetes.io/component": "admission-webhook"
			}
		}
		spec: {
			containers: [{
				name:            "create"
				image:           "docker.io/jettech/kube-webhook-certgen:v1.5.1"
				imagePullPolicy: v1.#PullIfNotPresent
				args: [
					"create",
					"--host=ingress-nginx-controller-admission,ingress-nginx-controller-admission.$(POD_NAMESPACE).svc",
					"--namespace=$(POD_NAMESPACE)",
					"--secret-name=ingress-nginx-admission",
				]
				env: [{
					name: "POD_NAMESPACE"
					valueFrom: fieldRef: fieldPath: "metadata.namespace"
				}]
			}]
			restartPolicy:      v1.#RestartPolicyOnFailure
			serviceAccountName: "ingress-nginx-admission"
			securityContext: {
				runAsNonRoot: true
				runAsUser:    2000
			}
		}
	}
}, {
	metadata: {
		name: "ingress-nginx-admission-patch"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/component": "admission-webhook"
		}
	}
	spec: template: {
		metadata: {
			name: "ingress-nginx-admission-patch"
			labels: {
				"app.kubernetes.io/name":      "ingress-nginx"
				"app.kubernetes.io/instance":  "ingress-nginx"
				"app.kubernetes.io/version":   "0.44.0"
				"app.kubernetes.io/component": "admission-webhook"
			}
		}
		spec: {
			containers: [{
				name:            "patch"
				image:           "docker.io/jettech/kube-webhook-certgen:v1.5.1"
				imagePullPolicy: v1.#PullIfNotPresent
				args: [
					"patch",
					"--webhook-name=ingress-nginx-admission",
					"--namespace=$(POD_NAMESPACE)",
					"--patch-mutating=false",
					"--secret-name=ingress-nginx-admission",
					"--patch-failure-policy=Fail",
				]
				env: [{
					name: "POD_NAMESPACE"
					valueFrom: fieldRef: fieldPath: "metadata.namespace"
				}]
			}]
			restartPolicy:      v1.#RestartPolicyOnFailure
			serviceAccountName: "ingress-nginx-admission"
			securityContext: {
				runAsNonRoot: true
				runAsUser:    2000
			}
		}
	}
}]
