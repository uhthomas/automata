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
		encryptedData: "credentials.json": "AgBabz2o7xgZ83cWuctdC9xw8SimL965UI/1NitiWCG328rHALFKY9kctiIT5jdxIn2g3BvE0NqFN4qWQIjV60cPOYLML/mnnBwUsVK9hHMy4r+NjFnX6Nf3vUb/SOAH+N9T2iViX5yzq26eHpdozaxDE1vN0oZQ4Ug4MJmCKGus7Xf7HzoX/GvAq8nJueprlF9Zd5WyfEDH5yiSQb/LNlisCkYxjAaGQ03pmvVEdQXZ6Jvw2YPcYEFGln2Zu/78W/kSroouLLQW251CT868aqCI9dH/EduMmh6S0DDNZvG27KiXZRSgSqBPesF11hFaSqcEqBwinz9mOLADuorhCROadRVSMdTjEnZJkSZhqpv03jGuDU0IbpQc/gsIi/pAIY0PwLu2NmjfC7AIz0r263CHIGfQORso+GUJymnPWna99IgSBpbaWZwXn3SByT4OkjjvnC/qvC0xSaQon8JZApbrPd8Mril8OCVKfSUmstqz1kQHkcJ37xnkW45lQTya2kJeD/zOzLE1q+1zF6c1cFkClgjCAnXsdPzOTo3cZoE/X82YRABTzU+wDOMCZYbQw34lz97ZwthmRehoXaS2cnQXZnfkTPreggrviLTwaG5uNPFc5Ob1c8aA1ZVABskB2e+a0qzMsFwpldQoUoYdX+0Ygba70HC1RqwPEa45yPDqzJvrev8tCD535+ZGOny3wl2UKOojxCr/BGcQFtUKeJgCrPnyaYg5QyZNdDpSo7dHzAoCrVlPQgXku7I9tJn+Q/+stV2d1yMfhjj+qedaKgXqoltw4ZFIUGug05mXcU7//oL6EAXZvxgg4plCBeOR7435/Ng/6VnvRsubwdBNF2mFBB8Dj/QjNbqI5PB97rjdnTThEVozqcvShPVhl3vbYRzvRWxS5hMWbR3CRWRNNTwdTRPi0YeBlZiEIB/W5AxeOsTi6Iw9WOdHMkyZ"
		template: metadata: {
			name:      "tunnel-credentials"
			namespace: "cloudflared"
		}
	}
}]
