import clientcmdapiv1 "k8s.io/client-go/tools/clientcmd/api/v1"

clientcmdapiv1.#Config & {
	apiVersion: "v1"
	kind:       "Config"
	clusters: [{
		name: "desire"
		cluster: {
			"certificate-authority-data": ''
			server:                       ""
		}
	}, {
		name: "mahalo"
		cluster: {
			"certificate-authority-data": ''
			server:                       ""
		}
	}]
	users: [{
		name: "desire"
		user: token: ""
	}, {
		name: "mahalo"
		user: token: ""
	}]
	contexts: [{
		name: "desire"
		context: {
			cluster: "desire"
			user:    "desire"
		}
	}, {
		name: "mahalo"
		context: {
			cluster: "mahalo"
			user:    "mahalo"
		}
	}]
	// overriden by k8s_object
	"current-context": ""
}
