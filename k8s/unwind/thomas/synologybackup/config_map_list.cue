package synologybackup

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
	data: "rclone.conf": """
		[smb]
		type = smb
		host = 192.168.1.6
		user = Administrator
		pass = btNZgOKjG02AScOzGR8aq-t_UQux6LTDJg
		"""
}]
