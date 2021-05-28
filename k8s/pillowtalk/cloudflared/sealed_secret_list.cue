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
		encryptedData: "credentials.json": "AgAE8cWHzLbLp2JbW0phsP3zAw6T3uAQH7+Zvm14D/QB25O2u+Pn35NyfbWASG48qOdap7uIT0EpqQ4pP2C1JZNfaRk2Dg8StJeZBicIN3yv6XGYUuJ8NIjFuUMQBARwtsFuvh9N700YNlxhSkpLEpDgJ1qJIi/Gj6ml+MTS6B/EvThMioPeXOz29lvqFYzJ1e+Vf9xhgNH9lzDuN/0zUMULD1LXjdTc0GyAFFVMqQ9hI7M4XnVRNk50/fgPnc3NUlol5r+KBnAZ6QRazcm9BeF7U6JQM6gnNoczh4ZIoerpnXO6NaNLzFucf+oy4RMxN9+gIeDrwqQQwv6Hj+ZQZtvYrYYdZ85NhqqfSw/tOaFVIhxCfVn4TBB0ufNUnEh8bWl7hqOJ9ftCF8Ec6N4ypoOyiT53D67ehGgLX8CUIgDr8JSTLT5IcBS1HujVXD/JXVxPMfttzndH0nkFHgHSxbCaed6yTD53ddT8+biNfCq8X8HiyQrYxajRNjs874UVAPHDv0PS/RwfHr8Tfty59gQ1+BshwgUlg0bynNczYgEsdcG90rCFaIHDmT0FGd9jG8klVKgm3vllw/XZUPNrlxThpxOAFMhs3BtmMkCNF7AK+U7+RdWeIajNv2FbL1bHfF+wF9i31AHB/FDpLi/vmnHeUbpq42MnCzufAPeQURkFL0G3TYZsXY0YzJJQ61BtxBID4xLjB8gbE9tt9c7f8ItP2aOG/VqTzxRE2KaPTk6OgE5Iz6SmaXIAehkocztEWGPIJFBgPyd0/F4SPAo8uj9k6kUUuoBj+pWk7vP1hr1aLdVV+sqwdGYTavNy5yiekLJZqrRp5GObJ/M2obCSgq/yzaLAQAmbHsC8AwUj6kf/XZ1cVeQUOKnEMsu0+jTjkFHCYlDS21xz0TXWYw/Uz66GZMMum3FApqinP7z9sSzvrO/9FXPUbz8FSf+Q"
		template: metadata: {
			name:      "tunnel-credentials"
			namespace: "cloudflared"
		}
	}
}]
