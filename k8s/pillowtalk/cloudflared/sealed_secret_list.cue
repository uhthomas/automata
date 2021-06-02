package cloudflared

import "k8s.io/api/core/v1"

sealedSecretList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "bitnami.com/v1alpha1"
		kind:       "SealedSecret"
	}]
}

sealedSecretList: items: [{
	metadata: name: "tunnel-credentials"
	spec: {
		encryptedData: "credentials.json": "AgCRxY+IfISdXNojoN8zikkrtWRFTAOUtTXpiMtP+Gr+WROERAhb3shvRDLStDKoIrQcQipTjBNzPzlKrtk5yAfdMd3x2/hb/+yWIAkh/RRn3zMAHjHDwIvgYPHnylAch34NksL8QJJAkUCY+Xo836HA0QHPGaa/qlogzgthasHXk3geykKVdl0Sh5voPIHP/kR5rSCLcXr7BZ4ZKZAeQH8gLA5Beno/dvQLS90uedWiLEe4dr/kcfHksKiuJrl994ymLFzFj/2Eu1j7h05ogSGlD/5gVJ1XKelLjRZ29wGqp3mVaBjIJ21bCJsrvQC29wdjbkwx5PgKJ6zCTQkRtK/jnYKAPzrsbhk+mrJ5AnnYu/wb6zWd6Ncowso4WDoKSA4/sHA5UxI+Y+Zl0beoiBD6GDTkVsrqdfTPoNRaewXfCYeCx1Y9zAidl/rxZD70g4LfHBseFCeCspxoEAW7gy7DDapvNpmW0+nyCFCR1WmBtbKrCYSp+ck90S7K6sq1qLc+BJFkSHTpJoE5cvPtHw4BAkG/zV84VpT6u2lgivbGGDYgZ1tv/ykpv6hC4t//fR4QEl0yYf8mw6ZRMhLC638jMKbq0eVFAgRv+bYH3OLVe7I4oQ9wfqAvZjwwPgy55XTT2AnszoA67BBZ2QcUMK/JavIoJ3f6KKeYLqd5b5RzjlWPJOEe+uppDhPsI+AWVsP2R4wpBU3HZDWs/lq/b4rnzdPgmsft6d2WHGGoEvp4aliPDy1Fd5TeHO2HLLJrP4HkQ29rJfl5Q5JNYM8uC5pans5BSK+rhrvltJl2vN6TL6Xv3k3arrphKa/L91gu+U2uPhGuA3L9hBoF/jT2xpIN/nasjZIizGle15lUirwUbCz7Kf0UYEGlH1jAPMnbspBxaSiySgvYZwNIh32LjBq2Kiegg4vd7yxQQXAwcHDA74yUy2ffxu7QD1Mu"
		template: metadata: {
			name:      "tunnel-credentials"
			namespace: "cloudflared"
		}
	}
}]
