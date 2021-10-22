package kipp2

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
		encryptedData: {
			"aws-config": "AgB6M+S264vN9YVSrqxnNUDZV8NCqYEEo1DtQBsjOY917zwMDWK3ZRqQ8kQM+Kd7P/AgIejqBgjCfoN2Ui3LX/CXb7YDCw0l5Phobjjlf2cI2Aqn4YpSO46/83MrP+KF/k2t+Fm0JCMjkgIZGv5dlUdYYCmAvKzxj7ve/ssT/r5XJ2OxMLu9JPjvXO/T51ncRS/lrfG+tTJoLiUyWePPaUsVD4nSs+LubTMAGcM7BIqd/3+MQzysO4ihbKtL7dnhXvFTH7Q4qoX54IjzG/GS/FH3gPBI4KaZhW14WC7PVjXbyJjGDMHPtGsHUmfFxSwyfS3QA0jFZjJwyySl6ExzL0AiVJLy6N2dimPcyXcLR/ZRKElSsNeFTCyA5kSKzPYf1YQYr1+EZytuBbJf/+1rt4hRfsPf04okM4B0hKnF+oMAEfJuAGNOcZFBwPcyMAbhXZ37ifOpSnrJjv+Wh5M0bvxz2fzee9I9flB9IGMUDRTk+KOmEcog9mKVjmTG6IeM6/y1AtPQUPHgugAuxUTVNYgZJsXfTjM1em8djrcIqviyNFUBB3VCcRjYLR6H4uWzlc/+LpfCgq97Z6aLKPv2kw/VH6XQXHUlVILPFKO04b8ZGQdBO3dZ9B6NVNCQ9wbnTitu+vauRnjrf85Zes7tUQlaPi4dQr7zNCoysKqNksor0v9vuUJ2n1W2ChCbfusadmREHoUzViKmkBWg73rEhojEHzIIh6bXftTa9INTZV1V1cue9OTMo9vuyighoo+fR7yIrOx36GZKusND8pBCtW5npfDitdvP+p4Ii6tlHjs+FQiiBg9NsN/letaUOEEWVZVprl6nenixwEm+XGw/xuw="
			database:     "AgBkMkMUxOCJvoxYlJtKzHe2fZQ2Ga5FAsNEXIxLUhON13aXE29V2ZZAFoSJZP6W3+dKVA/ggB30Kvui5vgmwAv0qm32DWjH+Eo+p/8gNwSSB4xCv2B//xF3vk3UKQgd8c5V1Qp/BVagjlyc5ctX/0oTMbP188mMEOx0OeKVfq1dwLXpl5hl4TzelDO011AwK8iGvMm9wMEFlTOcbg8LmDhE7JrFoqcJbNa8aFClPcU+ctUBqYW6ic/wYxnFTBE2LIoHCXV+khRHlBN/J2fG/53XvI+xtozcWZlUyBycy+Ybc5QXSD7dmZhchF4MeJtUbjrTqXKd5Ob4QgScBlZyGKqpG0iMZ7ueQx+wLF82J704/vzCRBz6qNm0jPBLyceGIO8tHVSVfS7iiG7IzGr0m6DpoI3d+cDdOJ98YoSXb6BjqtTy03ZP6j2olLjDJ+QXwbxrhjRp7BaxasV2xjQAjlRIzcENkNC1XaIbLqvksTSFKH/2MADCme83eSoJNA3jo7WhwfgTB+dJ/BZB/ABf6d5SnV/xJ7BI3Qkk9u0ncfny2uQO0ZzqSIvx+p5/KUG2R6LBceBLkT1B1MgD+fRpgtg9KxT1KbAea7kvFXr7t7elO1tYdOGWOQf07ld9X6fleQ+OK0uQEmeNj4wMwHLt9BwIur14hXkw5K2+P/8il4E6VxwXF1FqhqNKbFMfoTQ5pe6MYjuvTgGTZXdYqAqeiBPu1JdTv8CjeWFCkgFtgI7KRejUIjsYAgvxCALcMYtqlQYQUVd25C2h9vuK+rluwRGygGLFaMN/fv9berEz8wopTJ783r7M"
		}
		template: metadata: {
			name:      "kipp2"
			namespace: "kipp2"
		}
	}
}, {
	metadata: name: "basic-auth"
	spec: {
		encryptedData: auth: "AgByIqNsSoItYBSaAq9U75UvsscExW9zlh8s8N2km7dzQ5g/OmgCfZGityam7epJmS9tZLzD4CgQ4ex8J59QIjUqyPgZwma9r7XzjMEuJXfi17GcB6R09a0A6e72e1CaAk/NsBcitgbmKxnLxRWP7L6Sy7s/VLRaweS4++L5azhWN+J1zTPpwn8+pqXk5Ik/iHI2G5tC02sYKzewrsIUlU410jbBMssnLKym5nNH25al3AqPQXbumipJwVT8iRZnqfEaUPPRl3p1+kgAMHE9hGZzOfqn3T4HLgCxzYQaP6DsyYtkP2hs7GQYsus7dWWqs5xafD/ICyLPhRvH1Lk4SqK9bO8pFTgoMHvsYEl/JzoqdiV+03K2RgUcmucgtDQrTGMiVEhJKiWZS3UrBJJIUvgMmc7UH+ph49QJlOj8Ovw6N5q4xxMyh4QoR/2FCJHud8fXbzRlzdU02EoU4lD/QpFZ+ElUpVvD9YeZ6uj0lD60nNdALSlmEu0p03VieTnOcmECm0bkxzoDrmZ86rN0Spq4DqQn+z3Kvy9ztmE4hawMm7xTLdwiCVS5BKs4I3GtHG7kNk3CroqXLztDT6zlosytAWxh7xdLPK19c7vuJwSwf1Hd4zlXG8laq+pW7Zl8biRmvtxrLrvLrxPRdYBghbQrFK6eeAWkp+Ela+67dIMZwLSDX4SZXXd8ded2xh8YlvKY3dn4xVQ3S5xi2dn/M3Q24tCA/OI0MnK/ytJoWU5sREt5MCo7+u5jvBidIA=="
		template: metadata: {
			name:      "basic-auth"
			namespace: "kipp2"
		}
	}
}]
