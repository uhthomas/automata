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
	metadata: name: "admins"
	spec: {
		kanidmRef: name: #Name
		members: ["thomas"]
	}
}]
