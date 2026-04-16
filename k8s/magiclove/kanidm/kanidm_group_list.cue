package kanidm

#KanidmGroupList: {
	apiVersion: "kaniop.rs/v1beta1"
	kind:       "KanidmGroupList"
	items: [...{
		apiVersion: "kaniop.rs/v1beta1"
		kind:       "KanidmGroup"
	}]
}

#KanidmGroupList: items: [{
	metadata: name: "grafana-users"
	spec: {
		kanidmRef: name: #Name
		members: ["thomas"]
	}
}, {
	metadata: name: "immich-users"
	spec: {
		kanidmRef: name: #Name
		members: ["thomas", "grace"]
	}
}]
