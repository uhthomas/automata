package thanos

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
	spec: {
		encryptedData: "objstore.yaml": "AgC9il9McUP8nt8OnhoQIuOZIUGYQev9VmUzrXzkeYiEPb6AED5Ee3Hm7wAvHIIvW37mr/WzYZ9K9xVP5r6zu3oYrRkZxZY5gDe8NJPfkQXIPUzwXqZqP/5WMIx67A9DV6VSzKfnq+B/Lw3k152Nsf4FwqhRm435SZtTTZEksr0XRhBt+Qhsg2piY/wRpbmuCQt9v4jMkFIn1D6xJmg3HPahjwiW8EVrAAjoDydaAzJJCyi9OamzIIrhKO1tSW+MlD2hYMDGMVBjvlXL/REf9VQr/sPp4NPlVCrHSEZ28/XEwl7uCoCF8A4JrfRUJBPzdpUrvzYQ+jA6WJM9KKBA/7+51oaMrUqi0KnDhbYCr0uxZR0YhuqC9jPNVNwir4nxA/p++lmoQiNTlvz3s1gyvm6ff/nc5dgPiiyDUzqRuNWV9psnOSoHnoGzkVgkjgaeKpyxBNRYNZzOkdYLuDaEkKNOd3bW2+AAHDobQkjIjfp3pyUdneOZpsSUp58sif1BCri6vAWqH7YLBL5TejIns4zNeowrTOCamtxuKK/6851XUjRdaoQ7yx50Y9Nz0ipU0P9AqI5VF8CmkGlDiOVYPSaMypiaiROnxdyU5iN+o3SqlL1yCxjx/KlKZwKl5Il6xofpj+qNxhvuQcJcUq2UHmNbZm33vS/nGJ2bCuCzFJptdsdJtKg/SUnFeWEW4v+KM42P6WB17R+q2rwxJgGe4orqdP9j29PANGYHNFGnXWyRPfB/jnsWS0B2NMdW7DjpFevSKIypBMkLXzvOPJRQEIs3U+5JfvuTFA1aWHLpOfnHtX1g69R5J63kYKRMCF2jEEXyNfsxzGlixjvrY2+BlggZxp3hsClnOsS9xcEyfm5Y5k1ugIOocV3OJ/S8uE/75B5n8mSEvbgWDwfYGBKT87BNXes5Nvs2lLHJiPSv2B2e6Q=="
		template: metadata: {
			name:      "thanos"
			namespace: "thanos"
		}
	}
}]
