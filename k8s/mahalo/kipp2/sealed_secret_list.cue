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
			"aws-config": "W2RlZmF1bHRdCmF3c19hY2Nlc3Nfa2V5X2lkID0gU0NXRTYzNDM3UFAxQ0I2RFBGVDAKYXdzX3NlY3JldF9hY2Nlc3Nfa2V5ID0gNmI2ZjU0NDItYTBjNy00MDFmLTk5MTMtMjJlMzY4ZTBmMzE2"
			database:     "cG9zdGdyZXNxbDovL2tpcHAyOlZXQnppRjRUTEIwSHBMVjdoYXRsNks4MyRANTEuMTU5LjI3Ljc1OjEwMjE2L2tpcHAyP3NzbG1vZGU9cmVxdWlyZQ=="
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
