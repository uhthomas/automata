package prometheus

sealed_secret: {
	apiVersion: "bitnami.com/v1alpha1"
	kind:       "SealedSecret"
	metadata: name: "thanos"
	spec: {
		encryptedData: "objstore.yaml": "AgAWZcAQQxRM6EqJ9q7FR9YucjcX0c5wCW90EJU3jBr5InF+n666Ifs3fhaNAHSeiVty2KaBrFniFdnH6ACzqtURN5E+AebuD806aMo75e9iXG0IQzZcvU8Y8P38u1OpLD9soDkkD9E5RTWt6BmKO8lbTfQ5XPzhFuPCr0EusAUYydiGvvIpkeuZAu1ZLeFiUXQu0G23M0CThdh3bFi0fz9PFrfgf0t6yfFVuYe6jQBqZrtSXGPOvXMqT/ZbfGgFipKsfzt8ZBygtFvdPD9exA9PYVVRYMzgtuCrAeZo6AX67rBNlgFMEqA7H5o/MdFq7Id8W2KtvjYIgR0erXvF2hhYYbIi3tkUDgaZ+0e70+TzqQgbayuYUCgsE+e3ZWaDzm5XLxoqikOzIiKbmX/h0dpAAzhm7mOVnyT9bI8z8f62/ohxHflIvUI/r53Vmh9lkiN/byd8kS+2TRA8P1NGzkb6ZMG7/HNXGlW2eXfn6YuS97BD2Te5ux282H0meXGx1Z37l8PzfhAqCXY05IHgGtKldw/fNl+2qn7p5vyKJPvqNkPVDJicJCAHd+yO4qjl9+7d1Q4+Wxvy/askoF3SXarcSe48RDJtfLtgjDV/hyOXx9almy4LckDVVfB5DHmxduClPxytkQr0qH3M25aM3fWDkAq442A90NNuCkWA04sgEWYKuUyqvIjTf4WaSDl6qK8Q73bemZgKT8Ij58aEG7xwehlGyza6LtHQgay0gr/8zxbllbR5HuLxSJd+mMSYZjVJdlfqi7y9Ld5fefbQAZAspZaQ9Y3eaNYpDWjmtghj7KlY3FszFbK30hvxwvgCtNTDtl3aqR71JvjwmNg0XWrCnR2l/nAEFsrn1FUlxY4aD6ri5NAh78X8wBGA9Lq34tlA1YhLHNJQLlyyyol1Pi41qSYU84/HZ+YWP7tGXfO3dg=="
		template: {
			metadata: {
				name:      "thanos"
				namespace: "telemetry"
			}
			type: "Opaque"
		}
	}
}
