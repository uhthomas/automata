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
			"aws-config": "AgCcaKC/SikfQvuZzFFQI65MGZgdh1tImTAKLAOX1bRc6Qwd2NOXmu4c4Ujy+BuYow8yQfg3K6pPtWemC3TTwI1Dg+4A9IDBgosvUUVPoU0mNL9bX/xs7Fc9yS7jnt9KjQypg284WY09Jv7xH95GGxtCiqNJSHQXq70n+7+X9Ibi+ThNLDN/Amrzr8NtWVhQj6Xq9Qs6BRpIR5VKLBHsnGIW/e9kt87K1Oi/Nuxkwgth1Exnx62ntJjAf4LV7BSqBnc89v1bhJjZ8lGtCq+fUP9MStJhj27dBLvPlnKzzBmd3szI7iHSQ6cw/sSVLPsOOiQPOV3qIusdvPTmUCEf0Y49WacwHjC66jVkL/G49w/cBZAmteWXmZIzvEVFoDyTF73i7la9n+Wj6XykXAffDZ9GnVx1xrBSah1czuoPNasy3xU3HsglRRYD5dALdpf/0qki6w++1yIfLxCctaHKfKTWZGgo819wYndqqE1A4PBtBaXAgEhAclLvrrPIY3rSmv/CiQq/ZiWZQzm3DBAsYSsXM0eaMn18L9hJ/hhq3y1WwQGGViJbehbSvmje3/wxmA7O1ey7cKuNHLr71tClu8PuUt/m8bWrTDSxLhyTXuFp2pimmfEXHfbW6XtCrdleYF0zetEzMRYeG6EZrrF+tOia86ktLVhZHUyOfbsElKWUjxZQp4C4GLYUvFTMcSUHkkpr6aAQj9t1iA8d6vwCDeQphHohS21TSh2HtdIY4ODyKP/AsaSPWsDBXW6OVXoSQTfWnWSkG9M6/sRvnoulJza2MW+PNlUHbk42iqKI3c+/setsz3cI/GBgalVC1l83bIGDnMmzx9QuwUOle40BE+c="
			database:     "AgBPkPkSWD6QvCV0zfSmGj677Tel3FxLXx08QNrmtGtAA7ScY/yeh+7oL2ly66BEE7mTK0Jgkz8XGkeB/TjVx7zoynHDW+1BDlP7YzKf2fod79cIFSjDe4CDxY9USzzobZlqWB5UIuMsaqDnEKds5n0F6zDIpZ0bShZk28Dyoh7KmULRIxQ7SsM0uDBtF8/oMO2A1JhjnraFOJxaVzFlxr3Qh/z3LbrZq0JEiyKbFUw9TYamE8mfU+XmSDpOekVvlw5cX0wtZbyqr2Z2n2RKdtaBdrIz+YJH+voI5NRhmKYlcuGL/sVgHDmKScZXCLqvFaEy6wCf/N0kdlwM7rwboxZmfVLwycU5uzbI56KhtyaPeFuvaesvCaX+CNWmbvCl0JAAXmLs1/ODuradajnkmlb1CTdJWCowaJo2f2wy1l/11HE3Mq0pJ6Pc/dBnEZKgzDK2kBwjI0aTeF+rDjdEDEzLGHoLhZyqODlKh1yAW5M+aoxvMsA9aV1mEPVxF8C9ES8gIferRBY4xqbAdrkpxUOW7+41EJ7JdlH3oAvrdI5zA2g4PhA38vZABH7HaytVORSEeZnLItQfTUwHchE7luh7EFKfOZcY8e6yrHAMfobgMh1aKTD06fkCND2nZWW+JEOt7/acCExFcer24J7BrgQ8GzhlUhvW9CNn3vpcXVAZT8f1t8FBPLAjb1cQzTRLgbiZ6XVZZryC8gE8NBN3K0Z7/wSa8622yyHcFhg+1C2qb/G3v4EgsqheH0ChxEZVyhFMv+fOUpYnvs+5atOq3Wj59CwzWJY5UdiHGqwi+g=="
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
