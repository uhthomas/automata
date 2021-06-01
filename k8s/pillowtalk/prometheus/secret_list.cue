package prometheus

import "k8s.io/api/core/v1"

secretList: v1.#SecretList & {
	apiVersion: "v1"
	kind:       "SecretList"
	items: [...{
		apiVersion: "v1"
		kind:       "Secret"
	}]
}

secretList: items: [{
	metadata: name:                     "additional-scrape-configs"
	data: "prometheus-additional.yaml": ''
}, {
	metadata: name: "thanos"
	data: "objstore.yaml": '''
		type: S3
		config:
		  bucket: $(BUCKET_NAME)
		  endpoint: $(BUCKET_HOST):$(BUCKET_PORT)
		  region: $(BUCKET_REGION)
		  access_key: $(AWS_ACCESS_KEY_ID)
		  secret_key: $(AWS_SECRET_ACCESS_KEY)
		  insecure: true
		'''
}]
