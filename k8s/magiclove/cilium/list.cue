package cilium

import (
	"list"

	"github.com/uhthomas/automata/k8s/magiclove/cilium/envoy"
	"github.com/uhthomas/automata/k8s/magiclove/cilium/hubble_relay"
	"github.com/uhthomas/automata/k8s/magiclove/cilium/hubble_ui"
	"k8s.io/api/core/v1"
)

#Name:      "cilium"
#Namespace: #Name

// renovate: datasource=github-releases depName=cilium/cilium extractVersion=^v(?<version>.*)$
#Version: "1.16.1"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{metadata: namespace: #Namespace}]
}

#List: items: list.Concat(_items)

_items: [
	#CertificateList.items,
	#CiliumL2AnnouncementPolicyList.items,
	#CiliumLoadBalancerIPPoolList.items,
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#ConfigMapList.items,
	#DaemonSetList.items,
	#DeploymentList.items,
	#IssuerList.items,
	#NamespaceList.items,
	#RoleBindingList.items,
	#RoleList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#VMPodScrapeList.items,
	envoy.#List.items,
	hubble_relay.#List.items,
	hubble_ui.#List.items,
]
