package mimir

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "mimir"
#Namespace: #Name
#Version:   "2.7.1"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":     #Name
				"app.kubernetes.io/instance": #Name
				"app.kubernetes.io/version":  #Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ConfigMapList.items,
	#DeploymentList.items,
	#NamespaceList.items,
	#ObjectBucketClaimList.items,
	#PodDisruptionBudgetList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]

_#BucketEnvironmentVariables: [{
	name: "MIMIR_BLOCKS_BUCKET_HOST"
	valueFrom: configMapKeyRef: {
		name: "mimir-blocks-bucket"
		key:  "BUCKET_HOST"
	}
}, {
	name: "MIMIR_BLOCKS_BUCKET_NAME"
	valueFrom: configMapKeyRef: {
		name: "mimir-blocks-bucket"
		key:  "BUCKET_NAME"
	}
}, {
	name: "MIMIR_BLOCKS_AWS_ACCESS_KEY_ID"
	valueFrom: secretKeyRef: {
		name: "mimir-blocks-bucket"
		key:  "AWS_ACCESS_KEY_ID"
	}
}, {
	name: "MIMIR_BLOCKS_AWS_SECRET_ACCESS_KEY"
	valueFrom: secretKeyRef: {
		name: "mimir-blocks-bucket"
		key:  "AWS_SECRET_ACCESS_KEY"
	}
}, {
	name: "MIMIR_RULER_BUCKET_HOST"
	valueFrom: configMapKeyRef: {
		name: "mimir-ruler-bucket"
		key:  "BUCKET_HOST"
	}
}, {
	name: "MIMIR_RULER_BUCKET_NAME"
	valueFrom: configMapKeyRef: {
		name: "mimir-ruler-bucket"
		key:  "BUCKET_NAME"
	}
}, {
	name: "MIMIR_RULER_AWS_ACCESS_KEY_ID"
	valueFrom: secretKeyRef: {
		name: "mimir-ruler-bucket"
		key:  "AWS_ACCESS_KEY_ID"
	}
}, {
	name: "MIMIR_RULER_AWS_SECRET_ACCESS_KEY"
	valueFrom: secretKeyRef: {
		name: "mimir-ruler-bucket"
		key:  "AWS_SECRET_ACCESS_KEY"
	}
}]
