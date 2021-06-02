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
		encryptedData: "credentials.json": "AgBYys/UTpDhI5QS1NYhMhK69JykTX395ZJNU/eSpT/hKTpt4OhoZCkvHAfKFOeRsyXPTBL541L1bbEL0TuflyYJui0lNRXGFSTG3QsynSH7DwziNolIPDcxh+JiCJSrPRtGZNkHWifj5MNgDYTxYsa+8WqG/nU7EYmSQLWy29E9D6tiZwdGnG+btsoCnWNshUpujyK0G0FQEAwTbGWJfwUPmKhxXw4Ok6mT3x8kXPANJUdnQHae8olacvZrQNDCljVAWsBMbYL6exjYvSRCy9VTGT07vQ6K4h/hruW8GEwqOTC3SqOZ7lLTV6L5bXWzzOfL5AnDfKrZutZzDVtWJRTlWMx5e6KtkrQzv/8FLAfaGzs8n1Zb+cRUQjFRKWCsXFlYUcBVLCcu3OiqDdu6bpkxd0xaNM/TMgqOWk2RYYYGC8f+n3kO4d/OhG4OUPocAEJaBXT++YI+r+m+fsBeYNY0Jt34boDQ0h10WGv3QyyqXTbVCWuyjGmBNuirv1I0JxKa/z085KKhSvc8wqxj8FZNKTd33QGq3hWodmKCGiytcdRVpjAb9THpbMMP1H3Y7Hjq+1QKTRpeYZk4sMtARcK2eEoSR1jWk6+3dbNRdfdM5Sc01pSpw9PaVpa7EtH+WG/GRXSccNFg8OlYNZafjtMnxwbx/sKdUNnmsQuTzHOOUQK365vuV7BdaXk7qRM0e1S8rDqm0FIbWi6O35riLAqZ5AOgJmPsMV+ye7IF4baVcBmgarf9O3dbi4WtjDMtHYsPB4LfrDH14ZjASZKSOHMO4X2LmF76BVwM8ad1rMCy+6R2GIjFfOokZ2cha+6FOyVqPMKAnFlFGNzg671Bv4VybzFCCR9I2zm9J8Od7ZSC452C9TkpMkCkWuBUErsjpHN52IRNCdXlhxM4nBmb7Yed0qxH/MozpPpueKLIXj0elSxcnsoJ5Vhrd9N8"
		template: metadata: {
			name:      "tunnel-credentials"
			namespace: "cloudflared"
		}
	}
}]
