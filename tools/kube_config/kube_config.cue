import clientcmdapiv1 "k8s.io/client-go/tools/clientcmd/api/v1"

clientcmdapiv1.#Config & {
	apiVersion: "v1"
	kind:       "Config"
	clusters: [{
		name: "mahalo"
		cluster: {
			"certificate-authority-data": ''
			server:                       ""
		}
	}, {
		name: "pillowtalk"
		cluster: {
			"certificate-authority-data": ''
			server:                       ""
		}
	}]
	users: [{
		name: "mahalo"
		user: token: ""
	}, {
		name: "pillowtalk"
		user: token: ""
	}]
	contexts: [ {
		name: "mahalo"
		context: {
			cluster: "mahalo"
			user:    "mahalo"
		}
	}, {
		name: "pillowtalk"
		context: {
			cluster: "pillowtalk"
			user:    "pillowtalk"
		}
	}]
	// overriden by k8s_object
	"current-context": ""
}
