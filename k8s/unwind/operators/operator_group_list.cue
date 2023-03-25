package operators

import "k8s.io/api/core/v1"

#OperatorGroupList: v1.#List & {
	apiVersion: "operators.coreos.com/v1"
	kind:       "OperatorGroupList"
	items: [...{
		apiVersion: "operators.coreos.com/v1"
		kind:       "OperatorGroup"
	}]
}

#OperatorGroupList: items: [{metadata: name: "global-operators"}]
