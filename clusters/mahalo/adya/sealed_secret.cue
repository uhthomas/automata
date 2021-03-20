package adya

sealed_secret: [{
	apiVersion: "bitnami.com/v1alpha1"
	kind:       "SealedSecret"
	spec: {
		encryptedData: token: "AgDbv5xL8QjTY/h+sSclb8n8SsBhvaZ8wwVPRhxOr05HfBM2JE0GtJJaf7fzkCwTs1h0CEtr4+DQC+2x2aZflpWQYeyq1YbFZVz0QNh+BfhumWEgYV1cQXeSxnn5AQmDqPPPKSdazfaRV10FP/iXVfwztuR+lYDwTV9yUXPFcjKbsiazuBGrkyzSHyQyZ1wmEBBCPStNR1NyA7ymJm0Mx+u2G9Jfg3mZuTk4DHMo+KXdWnMzGppsSR3vRtchZ6ZrxXvcZ9644HX5bMe/MapjyM8MUoslzg7J4IXMUJtwRFU4X5soC2PkrDxOjhCT/3BiWnJhiqwj/eT5wNWSFWT9GAWJYGjcxJN9efBydA/nd63wTJzTcthR7++FYlwNJlA7C9Q253A/wn89J9VjSR2DTtpOu9mvJM0Rzm3skReobpeAtwbkt3Jx3Wi6M1n1PFFK77TeFC9aUnMMqBKBrA+mjy34m9bt9asDU65tiXq70gZHHwHSUTB9CgxuQ81lAYyI+/zxJegPIlqYp5F/hXkgIJXpmLr44U6NDKxxp2h2zkOst/NghVBbR8NSOuDtuNUn1LqiG5d98Sf3/U0rKU+16L9gskJJvrFnnk7HFVyqCFuRgYTj8VwoWRImKdEsnPx++/vWQmMb+DSVdqcA21caOFi9pLMHeJcJDlzokZ9WEUGmzH0jD+VnIUgjOph92q4vMn5S3t3E18wJnn99dIorgFjxarY4wOzla+I8+2enWsYnwQ39w1ocaWT7qq2k6tB7ScUhXeoy0JMtXN5FQHbeKxI="
		template: {
			metadata: {
				name:      "adya"
				namespace: "adya"
			}
			type: "Opaque"
		}
	}
}]
