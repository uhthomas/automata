package grafana

sealed_secret: [{
	apiVersion: "bitnami.com/v1alpha1"
	kind:       "SealedSecret"
	metadata: name: "grafana"
	spec: {
		encryptedData: {
			database_password: "AgBgdhGpvvYoNNb3DNZv/+G69VNNR3AYdCX0oP3b6ael2Y9iwb+b0aNHLPhtg4vVImVoNuuOfvUwcNtkfNN+eWJns7nufMKyyVnf7RaATe2lvUQAW64roaaf89tuLsUN4EzES2c7uRpE6mPtUpZb4S1ANqy9hC/ESgFKDWThb3iKbxegkRBnzHXnjXUX2W1q6wclZD96JKKvpdwMhWRXGsyogI4aYDov5gSsZjLpRAYA8et3eFtntYWvlz5cQe5xJmP4VIx8Ow/6BYLKeJW2sIrNfP/6Gskq4SOEcmp/gEWeA3h3sE6B2SDyHzaNWV2OdPo49u87CHxI1nrxhBhvWwBcwW6bMl+s5TJ2Z8Ums6r3tygIpeYwk4k/SeWyiVZFBP/rPmHiEL6X/6C3A7wisyT2EBRE7GGbDc/CKhJPUXUFU9enR7CLKCl5Ba/gIRxoOdvpvFBSl23h+lmG07v+WB8SfXCW5XDrSvOxFHrtLNHIuONtGbccm2DXVA6bg/ZTa4oW1TUcnihWD/mk5KIeSLAKEvY4SK/FA9bJGMg5SfABUbZkHW90rjbqZMkYzxkjPUrW2zeyoLOZ/z0Nz1VtkFNzemdVZ0TprWD1SdPSQ+lGwTowofAa4ovIncFk42cgUtHgNvD5RmpXeiU1ud9WWQsbs6gG4+8cJ3Ip0vF+cf3vvxtPbAQXDJelwuivEWOJZ5GmF+ySJY+wEiAO0vmRwPJNTXRjIg=="
			database_url:      "AgAQWiUe38YelRE37ObCCLYp4OVVpl2Vo6RmCclMY/VHbmoLWyF9AJQcaEGVSGJIoxlATc2IHIQZk/9SEDT1IUjy7JAF60ZtfHIn6gJNWMNgfTQKznHxjL8H9QURel2GnUDQhJwuigRXoATOSzhjw+374UyZnBWkzqd5Q7Ee/cjPAMA5U8QJCtTpIijjlJ5wQF3JgynaR0WYsx3E1NPYUT8vnOiYdaopQEyDjcN12AQFNEeE0eLRlbUNWMnOxKcDfBUOcloqOqIhrOCrJSe87O823L+s8gytPSfvlLB3ocjkQahLfbwHHxUVGf75dLEMnGz6BDWZbAd/oJZHDw7IjtUKi1n4yMqGWL47NNTYLV/qvMeLEXLev6KUbMqAwvERyH+7ZlisptdoynaeCmh8KnnUd5KA53PSYv3LIcXFJHOPc7qfXkLMuva89NI3RA4TtcN+ObVfMXeWohg3ol9hGh4p62JYWHLGeQ3xQ15obBi/BPiuvozv+N16PKkm1Kwk61OhrRztQ2TmCgMuYzhHLgEhgp4NLyof/7tSLZDIyMsrElGmpY29340dKZy9JAd/pV92auDVkZxNCDFsrk9iu88jWJbDU9XK/1ImXLjZqSzkCNJdeWSNqBhwIRpRFg9nim2k8hfYrD5H0/TW+1fyAYmmJbD9CfeDVPbGDGnrUeg+o/UD4UPGnb4IpZ1ZKXD6ettpeBrmZdZykNv1QxPhquvuFZdqmDR1EInNbIikyUAsGXjBgd4e21tRNGFGUIUGnrY="
		}
		template: {
			metadata: {
				name:      "grafana"
				namespace: "grafana"
				labels: {
					"app.kubernetes.io/name":      "grafana"
					"app.kubernetes.io/instance":  "grafana"
					"app.kubernetes.io/version":   "7.4.3"
					"app.kubernetes.io/component": "grafana"
				}
			}
			type: "Opaque"
		}
	}
}]
