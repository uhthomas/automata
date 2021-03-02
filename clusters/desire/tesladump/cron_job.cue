package tesladump

import batchv1beta1 "k8s.io/api/batch/v1beta1"

cron_job: batchv1beta1.#CronJob & {
	apiVersion: "batch/v1beta1"
	kind:       "CronJob"
	metadata: name: "tesladump-curl"
	spec: {
		schedule:                   "*/1 * * * *"
		concurrencyPolicy:          "Forbid"
		successfulJobsHistoryLimit: 1
		failedJobsHistoryLimit:     1
		suspend:                    true
		jobTemplate: spec: template: spec: {
			containers: [{
				name: "tesladump-curl"
				// buildpack-deps:curl
				image: "buildpack-deps@sha256:96642eb9fc1fd24393423fa7c3834a931f75969ab9791256b83d00e73b78a59f"
				args: [
					"curl",
					"http://tesladump",
				]
			}]
			restartPolicy: "Never"
		}
	}
}
