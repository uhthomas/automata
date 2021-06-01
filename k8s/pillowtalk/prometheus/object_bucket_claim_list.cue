package prometheus

import "k8s.io/api/core/v1"

objectBucketClaimList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "objectbucket.io/v1alpha1"
		kind:       "ObjectBucketClaim"
	}]
}

objectBucketClaimList: items: [{
	metadata: name: "thanos-bucket"
	spec: {
		bucketName:       "thanos"
		storageClassName: "rook-ceph-replica-retain-bucket"
	}
}]
