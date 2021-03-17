package grafana

sealed_secret: [{
	apiVersion: "bitnami.com/v1alpha1"
	kind:       "SealedSecret"
	metadata: name: "grafana"
	spec: {
		encryptedData: {
			"database_host":     "AgC2ddAzIeDwGhR1C01cdwVc8XOykGtZpebVN8910m4LXozi4jOsrtpl6g2ATaHQ0NE6i372jhuEEWFihUbm2KsxDb+SpIXcC+sAP+ul88fiRW39wTpjt/FVPSYjncS5wlqWxjeZFbAn1GrNi+NwhZA6MPjbsZ06rjQMafWbIGS81LrWyumC7LrvN5Gy6CtiZTg4SIB2GTK1Ru+udUMKFW9NLN0Tk8wCvnMc2twqueTDxqNOzAnFMGfrO5fiaTrH7JfV4b+T0IkGyN7e3J6/+hMLxhFJk91fRD4+JOQMs+X8PevpXNSGOVqttsAjuSQa1uX6levLgMFN8ukoMRR/JdK7CRxFPwpvvhCt62Nn+EO9nlO1j8ZnUmaGYcYd2viZk/PzAFlsPA0dGtC9RVW+mB7ABx7t2L7SKD4dyTNosunwThO6BYxzeb5PCeOQpMV29X4u44a4b+nQv+KWhtAiD71UgqcwZZ0eaA7tT7gbYTX3VCSL9UUAS2BWtJz0/dlSufRnqiBDhj8nD7rAA3g7CNgsdqmHYW9tkM+lxAKGYWpnAqMxMyZyiHsFeDwptHYUo+G5uumvqvD8hKhwsxa8+AhgyCN1v8c54aeR+np24yfp+FJDlTxdKDfyIdKYVSPl6Ri/UD0jupW56gznsNEr7ID7073/XLe7y/I6iYSKlXaJmNLiYTvCjOENiMcVlwEy8kwdsWXOQnyTNelpbU9Iza1sRWA="
			"database_name":     "AgBxCQBNdpb8gLgMp9jLTOGiqBGoL2lti7zRmLKyiIsfP1nYUS9ZRhuj9M3vg0VF97B5r0YP9B2ZmCE5z2Vc1Xx9x/tDtS0omFZFr8y9+3fhouZ+q+SirDYy10Ocy0vsWXajnThjJVQj4WGl0EPs6TxKrM14I0a1oB0CJ3WhMjQbUBcR0fOZe3zRxOZhqY170szhSKax4OnvoSyytZ4HtMII00mzlOdK32xBfiO9DnEFaeH9T4Z7EruIXyQx82jlgD2MqdkyI/M8BiIHO2PTpm2ew7UXN+KuTWzcEvn9q2nLXoJLSsroSHKBSAczDGlYLDK1Zsa3d6g2cKoKJF9BV0Z2gNp5rU9lGKnOP0sNQl+WJxakEh++Xao1HeZCppfiRAwntNlh1FRCSjzD+CVLKzFSjqBGehcyGCQ5ssC/p3xXM++L/SISlqifPIPpYQR7w5PKGhYeiH7g4auDyCImyLIlE42u91K4T4bkpojox4Ms/csY4NMrr7lM84xiHJCSNyE3MtJyqoTTpCkWHd9eq1PRvWq6lQ32MdLKN+1xF4Syn9bVV+sD1zrWBdwOD4HU8+9rnWPiJKn1l1WLeH5Kj/SF+FmdoAXqSNeEWGmrJ5NlFOq6WNbgbL2x0GVPpybeHZn6s5+9vBq/INWkP2WJkoU80miu2NOkeQGfybniLjB40Qi2XmYFZRx+vCudMTu1QZA675LMFgtp"
			"database_password": "AgAw1xMKX8hN/4j1DUyAQPfaG7FxmFuU8RVLdNx1i9NUkoUr3efVDdqZ8FrjCw9ZyIEbxyHOmjLaYouBmbuiwmHvfwdy8bAp+PpJIkKWRTxzW9wQViiihYqCyuICToJs2nxoSvSRsssRCvmVgG8y6/C+mBNkfibmO9lnc6bVboWA8n8dFeIBF164MSZ88SJsQFPOza7Qol1S/h5OTaqk2d6rtZ7msG8x/U38Z2fgMEuoPkvtN6hKBIL8G8lwNwoyD7b3Y1pEr5C4/GLOWC4tzLdtlur2l7/nmeBb8VHLbFgApNYMMaFgmgthu6fq9CuVdJujbs19nMp4Mi+t6F01wtq0gymkJm0Vd6JDIsqQoT76gQ53yfFTId5stYqXVPmJBaU77HsqiMZMeGNKsUHbnXdozSpnsGjqvXyRnnDJfocXWvKHFkfjWfAyIT4cnZfkiQRUrgQDgK1rFewGWOElN2J+hBAUTHl8rvRYB8yX/7ux2sZpNzrC86Okel7J5W+rEU0XszQaxAuEE9rgzvClbN51GP6hIFx/B9jIecar+4NB4bIV1LuAqAFlrpZ/qONbhGZusRbWou4taVKpQU5+twM/IxqsPJf6Sgootv8lMN6fxG3RbU6HnY9UgR/kXDnEYepswWVN5drHQ4IsG89/ckDB9RLbeLg5d70RFMI7ujLLEYZSbTQnMEd5KTtBAYXRebAAh3hqgt+Jb1iaOd8z5ZM3lj2nvA=="
			"database_user":     "AgBQKwQ7JzCZPKPG/5qaIFTzB05+MXLo4rGeoUbSV8iALW7+dULQnBMV42ZGimfAEXz6y8+MDo0TCdXDymg6iE7fIw/0U/Bpv8dCgKkOyahmVXWdSNGCn2oxclP84C38TBANE/3F7j/1eKsdbdqKiHELjhc2b3fj+Qr55Awp3lrac4UjjcvdTZO2CYKZXVGqvtW/VKLo8bkzbMTy3VWR1BTsQB4CXbv58Ri1H4OB1RBSFYz4DsWJ3ZRA+mdZRMzZTAnQsZYHJFUAgCrp5nXa9taJIVgJJKPlYYTI5QhS0xsXDaU/norT6CdgRopiNVhz8JrC+8MM2saBTANfnMvibCIigPWfdmLaN0FxpnW5TWgQLQ6VChYYCDsN/F+RbKonMBFL7FvdVX4ftqrBiZVHjwEwwUB30ny6CP2VRNEODNc+Jt/XUJcQ+950ODPz+WyBsYVJW1ZNuKqMiYYeMDdAbqNAt7BTymhcQCTIQxDMDOJBqmQQdkYL/FwicNg1uUbAJlUHZpE0L0xgy/X1aaDScoBq0FWLZilGJnRP7S/SbaPYB2bG6xfs/7myrq+4F/I8Xag+AzvfEqbRAcWzFmZhPxrybnO5r6HjD3f7GuRmX6vkf+8yE5Ck5Dt9IuRsCnQbwfPHgAI3RpyyD3q++Kco39vZvhi+RBXWLiIc/QV04M+8qyO/xIIo59liFwJieNhBGS9/pH3NrRM2"
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
