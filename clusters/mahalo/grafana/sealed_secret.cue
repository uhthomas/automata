package grafana

sealed_secret: [{
	apiVersion: "bitnami.com/v1alpha1"
	kind:       "SealedSecret"
	metadata: name: "grafana"
	spec: {
		encryptedData: {
			database_password: "AgAHnxSDbFuhQdP8S5U8SP7d91xrHfJNgQ0lUeTi2MDX2vhLGzvmP0dKuMDJBudyudwoknUfHmITOyvrQ21jBucqE4whjiIYQzCgcFmpoC/YXFTuOUm0e9SR6rBhfUEbfiJbnRvuB3nxVNlcf/rqoMwOprDRCJFIrvpwB/ehzWxUqq9nxVweEAt9hKv81FcLDDnfmsIedBZvilzfUOvNGQ7plhCdIuLPjnYOlXspnyQaFRR4KgKfXz7D6QEz1BXYi5xUooymDUVGh3PgDd2IoN0nemRUSdNqbcKeP2bYJQQXTGtB6y3Rin2XPG1EXfsQu0PiBERmEHalcK09tjsKrKWSvdphiahy9Eqy/GmZ4tx5WFMcruc2ftr842zeZIuHzWne/aG1iAddwg/yAtTrqrwFM+dKa1+o1gVwjtHO2PUYp1JV9273gAfCIDFW7oLXFBCqbTteoKni0FtnC5YBTlRT4OJZy1c+/pEh1PzRji3I21LX25WRZACjVJdkHHQ2PsrlEtuIIakHOm52F9uuG6t2+B6lt/2DsuVxi7qYhY9wkkzjA1923PhRO2Sv152aTuz+FgTcAWN9CUxZl1nqDijC1kTq81BNELHDUTuiuTd3DnaWnIg5lUkD4o0RfdCgGrJGaGPJotHeAYPyaJ9ElowNhPr0qsnEyL8dGWGbFkl7wTxcqY3Txy2C5zFamQe6i2qXZtdhAG0xQIdnmzs7nYF+mug59g=="
			database_url:      "AgBck7ZRxKv/2LS/L+oyvQ2l8kHNLYSeEpQc3tuZ0EF/rMw3XlVLrDHBs6qXNg6gJvS8+anee2Mv6rkq7jyhFpgbhElK25r2Kci0Rpx7RfSkEkiEczGcDeAQYbV4qv54vrI4hjddUD2bTqiDlYWF+g0QRyQ0FMaCGY6G4keahvHZE+MicvCj8CKheuBVkNlbk9Ud+O39+nLBK/x9bF4JA8kW+COmlHtcspbxdC6LxpUVQquSGALGf/8HQvb8Ii9Ncmf0hOLT8CvyBCuSiHdBdTttn2qxNibsWqYpxxqJCRf2EpQhb2u3vrsWEb5/Lgd+U52zliZ3ZAuVJ+Gwc2hk1ag0r6XjIkPK5H4SOQ72C/rLQ/Ssy/7PxBwcBxMbSTtOskxAdeo0a6BeYI84/CFDokeG1Zbhr1XFcVmjKVdUycIrnL9f6/vR8hcXvRPn0ilL7Q1xDJwaZK51Q3v9JM6/QkfsQZkok8mofngSuHAb6SV2/8K1mvT3QLa9ZNlU5uBM5GgLCHmzTE0rMgZPDQO0y0+5cC7ozZS9sYGc0VQ6eXG2s5DHTMrZ9A6JIA7OqqwO1hXHgPh/ETgfjFsa1D+Q1DWMmEmWa1NCfAvo8c5S43s+pq6FP8WnJMbtRBbydqEiMEIoR7ids0mEHCrN1RQ+JAkkCSlG6lflyWYDclSWXZPhSfFCkOjsFJCTDd83LFkzIYobNHMqRsG/1XDNmQotE+s1EUGAYFB4KCT8+SSnOmY5aIWcR4dbQINzjyOWNQKfLcDbOM9yJRc6wmPyffuWcw=="
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
