package mimir

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
	let _name = "\(#Name)-blocks"
	metadata: name: "\(_name)-bucket"
	spec: {
		generateBucketName: _name
		storageClassName:   "rook-ceph-\(_name)-bucket"
	}
}, {
	let _name = "\(#Name)-ruler"
	metadata: name: "\(_name)-bucket"
	spec: {
		generateBucketName: _name
		storageClassName:   "rook-ceph-\(_name)-bucket"
	}
}]
