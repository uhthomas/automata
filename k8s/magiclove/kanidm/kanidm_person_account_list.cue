package kanidm

#KanidmPersonAccountList: {
	apiVersion: "kaniop.rs/v1beta1"
	kind:       "KanidmPersonAccountList"
	items: [...{
		apiVersion: "kaniop.rs/v1beta1"
		kind:       "KanidmPersonAccount"
	}]
}

#KanidmPersonAccountList: items: [{
	metadata: name: "thomas"
	spec: {
		kanidmRef: name: #Name
		personAttributes: {
			displayname: "thomas"
			mail: ["thomas@6f.io"]
		}
	}
}]
