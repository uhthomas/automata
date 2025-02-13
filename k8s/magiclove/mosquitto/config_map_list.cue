package mosquitto

import "k8s.io/api/core/v1"

#ConfigMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

#ConfigMapList: items: [{
	data: {
		"mosquitto.conf": """
			persistence true
			persistence_location /mosquitto/data
			log_dest stdout

			listener 1883
			password_file /etc/mosquitto/password_file
			"""
		password_file: """
			home-assistant:$7$101$EsZQb9vdwAKxnmgb$nkv8Rl6aRLhbKA0Jiqdv8+FPa2bu85pnAbAUZYiezGY9FFdKZYN1idqfgQoadIBxKA4TLKwIoZT1vCHrFw/9qg==
			frigate:$7$101$NOwVKq8gORt2UkeB$gfoa2/jCF8EdDZ225eAYqchLQtMa4ypDr4r+CiUT38LQypbJhgCRZqmBCOg578bZZj2HQZEayW+3DW0T4ff7wg==
			"""
	}
}]
