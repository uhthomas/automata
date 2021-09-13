package ingress_nginx

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			namespace: "ingress-nginx"
			labels: "app.kubernetes.io/version": "1.0.0"
		}
	}]
}

list: items:
	namespaceList.items +
	serviceAccountList.items +
	configMapList.items +
	clusterRoleList.items +
	clusterRoleBindingList.items +
	roleList.items +
	roleBindingList.items +
	serviceList.items +
	deploymentList.items +
	horizontalPodAutoscalerList.items +
	jobList.items +
	validatingWebhookConfigurationList.items +
	ingressClassList.items

// CRDs
// TODO(uhthomas): Uncomment
// serviceMonitorList.items
