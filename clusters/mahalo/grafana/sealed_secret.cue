package grafana

sealed_secret: [{
	apiVersion: "bitnami.com/v1alpha1"
	kind:       "SealedSecret"
	metadata: name: "grafana"
	spec: {
		encryptedData: {
			database_password: "AgA2l3CPhv+z9YC/T99U+qyDkgsPFmgj18iYYFe0QhlRR6MBQTusoN6hFDzZUv9efOWoJXgb3OD7qJ8qwo9h3amQrnJa748yhT89s7nvklWaAnJ0zbceqtP2JRHrPYRL8De2m/LEcJCkYu2FECtuyOkUgHBy6FGSD5YyyLyQlGZ4WIl+m9Z0VDsk7t0OlR1xh1tTmsWLGeT3FrJqLlLGkysgpWYe3w2vCpWzkVXyxhWvEkmZz0+auFRrdcdeOKnK8zOqX4fE/J9d6/IOc83lwQL+9iYO/OHERu50snUXCL5Izfwpscvs53Ak/O+uvF8js6C9Ljf2cAhaWALjLHr8pynD/gjUuCHqQa/A6iMMxxi1vcnMlQ5NCpI55gBgejmkXKu9R2YFeYJAT0ikfq23eLkv2iwMbGU7PBMHe366hP+SX+Z5x8noxtzaskmFU7R9UUXi6aE018Cty1Ygnskb0S6VNEbzPC4YfgvV6otx8q0diX8GT8IMFXq5JU+0xfCQSYkmjKzTXCaEcCxoSCIiPjdVLA6uTRV94hGwnGM8MSI4Cd6Ye8zSofjoHL2MFmOkviup4GYCqQV/CUS9QIp1S82fTc4KTCPnLdu0SXaTBuAyBGA3AzNTjWHBSJNgqMKoXBgLApdvSonrNL9GRtEVaeBPN8wPoLK27lt5qKvECt8NZlu91OGDEaVo1/6HjBa5qljkH54j4txf7CUsMeCxs5jHj4gxpg=="
			database_url:      "AgAlCfVA4azEvDI2xDiVHqICLO4SJnPMSRaDYgGGxA3/o+KabzdBcc/wiktahv0cSEi1BmZoxXbOF6Fq3ykeB8FZNy9silQ7oJVahXFcFEP2aUiIyczbgnIdyrYcdP4TLyJKSrEkTAelO2pmkw73uwXk5A5HbXbyrM2a7HEsV0IkiIU2gr/wJ51jFTwJhsGll/Fby7kOg/Ye9K7Ri8y4Lxj3rX8Zb9M9pEH+qQquKfA+w7kbrgwU2TNpi+vyZyrJN9FVFEJM3cMOLAewoh3Ulpe65C9CJRSgGAFRVsQJcBLN0azWqjrJHHgZcdICeIDDCAY/EGfLdmNiTUjbe59kOrBOl9iQ0Bx3rAEERaUCUBv6ayqRXEtwyIw9VNIxNioeJ1W5TtofIWgWBZSmQ4YzjP4EvRBfrcwPh6W7zEgiqA2krtvnLC0AmOy0QuM784jiLVb3x5Jj+Hanvr6aU5SvjU0gSuTp69AdWZj8zGZuYHcS2r7Z50ErHvA8EBJqFyB2ana9FlKWGTuuFsqz4Bph76liMb8jtSFk0RC6clEYEekjpLJr7KjkZXgQdzq2bbtccjmzVoq8EJIm6+x2MdIn8/NtFsI3m5Nxq2vV38vNYgrObWXjFR7fbmanMiMn08wvD8UhDCTT9c4vn+dyGGzQIs3yAHNNZSC1aurf3uRFj8BSnAbCI8M+B10Mla5iJJb8BW/2I7GmR3PqIZ2STAWn9f6XIud232+q61ss3HfLWRxPTpKS2LF7lotDN9rq69pkqtE="
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
