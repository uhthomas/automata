package grafana

sealed_secret: [{
	apiVersion: "bitnami.com/v1alpha1"
	kind:       "SealedSecret"
	metadata: name: "grafana"
	spec: {
		encryptedData: {
			database_password: "AgDW7BzuMgAEemMRCxnthw4D+dB7lj+Y9H9KKp2qZmBfit7Iz8aUhzIgMQFLIt6jOQ9fELlUIG/RT7LJUHgcJxWbCRkt9MXgc/t0ESlPL+jRQdZubBGimWfAx4HPEjVSuASD95Po6UHMDXge14Sinw12halQInYBwntrdqpl6tovssQfMzrzRk8Q8ElGmCTwJS34KMJV8iEVPSASTjs/dqh+WJ2AE52yY4CMXvkycchBS0YM/Y4iaj1PR0a/YAJUXqBwXZvByZbEDViClMwVF/5OJmov6oUj92u/G1OpjObtOMzp+t2XU/07VIh8xIt5h+79+W/neBGmkzC7Y0SzNHCHQR5JCXuCdr2B7yo5FSfiUBqTH4vTeEO8Ch/7rwE4CGaH0CU9TG8EpkDhxdqXosYqR0qvL/8g/frHK9Hkm35f1KSK2WPs39sJ/t/653KP6yasDtgJ+ytBjYjQt+BR9dZeP1PnrTvYHU8HNUes03Ex0dO92ysPvphxQWafMGHz3QJdhIpTn0VwoNgBvN00AeCstyCy7YXrIN4XQuGfmB624O304+62ZlUfk6n6N73kZQemLhDYyy+sJ4jI5Lzm43WiT3Zbx6aBnveZ7L6BSkscRTBjcw+i3vN+ihGp52p46+kqb8o6qNrCgiREJ52E2xAfoaPqaACzWm8YIDi89H6HdcpQ5YdCIQNN+st0ziG2gXZg+qC4DQQwallOgXvwoi7uorBFQA=="
			database_url:      "AgDeQ8ZmldHtPc14A+712aumYItQdPWcYLEUqLzKieAsqPsUz0ej14aZfaNsWb7PQH9O44TNo+cm229h/FiFffowQSjR20Ybq+brSx67UrMkbHDVBL6NTsT8xOEed/XFDwHXHc9+aV3GX1fidOXkVP5r3AXWZNON1DE8OfM0S0RKVc7KLvnRSbHw924rpASCHjPVjPINltPyLm08gEK6FJCjVscNqgLMS696WaI52HtL2xSBdC30PA8T7BGdqSICtc3MjT5RmVPlrHk6cDOSvAu9CsFj9OBni02tcua/gm1hqvCDF+HTopy7nOJLnXfIi42XtJTERZjpKQsNYZ4uV3QagZlxgcwQfyw7/el3UMV0EIxopt5XfoTxNtiRn2rieTHNeXLJhIKcU8OAOcpSQNt3vokhVhEv0TnHyms4I05yeBR1RbgBJVFb8jlvWvCkkH4MAGrEd+Bm6oq6522oyAbGSTtxajN3WLxkBwadgM0cTqwir41jWukfyG10LvEDd0izarCIBs4I+dQ9HizAb+9dRpaOzXX+1o0hOyPRL3byOcm3Kfuw/7h/ighW0rRrOCOuNxTbk0JqHh1IIasXRjNNQfqfDbvxuM+b3j94aFWRR2qjb8N4lww2HoldhEDkkIdW1/PH8IF7KvBGjhwpaXoRQM+R/aL+bWSXy+CotGrBm1Da6Yv5UooqKQ9YwrW00qV8D8agxxXFLgtSM0iVt3DHH5KhzXBm4mTfMqA3tdgw3oZlZRKqX4zGuYoLgStPMBFsBtjSpA=="
			database_user:     "AgCN892M+DFptYH/8beCNHzs+O/a/B8VQ4CVPanm3jift3EnkwpHvY2IHpyVy0jJMDy++yLXwribB6n44phZ1HKnN5sbcD/WdVrQof3HZKQ3xQZEiIVfD+eG6kE7kjV3JD4vLNi7YTi9d+0qCeNzcshmJxzXB7BcvoXjoPwCZZfVUMRTYbnSNc756epD1WxZ8EBxuVfc2eZfcvbOBNCURCNn6vLKd+/wm+gmg5xXC0XTu3ugqhxkh0uL3jULwMUGTe/Rif1JyZrDJQCB4NzebUlai+v5fvoRgJwd4gYgxDc8NPLPPekjwkrrIslEaoJpnnD86t6zbu1+jnbU03wczMk2w+LMlOEjyy7jK7+f8XgsgezYK195UW6D+g+TOvoVzTohrJ+4UYVx398itx0B1Yi7YX1/277/ZIU97pqptTEwkk+waXpDf1rduntucmpvlk8SoPzRA4+0vjJUFB+AEMoORDhxINVmAAuDhwX0+DVXwok5O4PAo3KhHKzUKyPYDKpaVX3SXY2HuMNXGEGyy79X+purVEHQmCmFw121WgnWL45ISU8/TJWJUrIPoPPXGCxrl89MHsAyrNl+uH5BqI1Uc2YgUYQc0dZrlnsFEFKvzkN/wma40Lphakoy/ziG6fFy2l3ehQ+IxEaOe4F6yT7YsY6GBEsQfMfzDxJY58lwa4ScPPw8fc9D4nMUdISg97sFX7csRxF6"
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
