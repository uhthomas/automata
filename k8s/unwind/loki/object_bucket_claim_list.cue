package loki

import "k8s.io/api/core/v1"

#ObjectBucketClaimList: v1.#List & {
	apiVersion: "objectbucket.io/v1alpha1"
	kind:       "ObjectBucketClaimList"
	items: [...{
		apiVersion: "objectbucket.io/v1alpha1"
		kind:       "ObjectBucketClaim"
	}]
}

#ObjectBucketClaimList: items: [{
	metadata: name: "loki-bucket"
	spec: {
		generateBucketName: "loki"
		storageClassName:   "rook-ceph-loki-bucket"
	}
}]
