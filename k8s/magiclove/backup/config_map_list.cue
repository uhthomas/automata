package backup

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
	metadata: name: "smb"
	data: "smb.conf": """
		[global]
		netbios name = backup
		server role = standalone server
		workgroup = WORKGROUP
		security = user
		map to guest = Never
		load printers = no
		disable spoolss = yes
		smb ports = 445
		server min protocol = SMB3_00
		server multi channel support = yes
		# Advertise the reachable service IP, with multiple channels on this interface.
		# Keep wildcard listening: the LoadBalancer IP is not assigned inside the pod.
		interfaces = "192.168.135.24/24;if_index=65,capability=RSS"
		passdb backend = tdbsam
		private dir = /var/lib/samba/private
		state directory = /var/lib/samba/state
		cache directory = /var/lib/samba/cache
		lock directory = /var/lib/samba/run
		pid directory = /var/lib/samba/run
		ncalrpc dir = /var/lib/samba/run/ncalrpc

		[data]
		path = /data
		browseable = yes
		read only = yes
		guest ok = no
		valid users = smbuser
		create mask = 0666
		directory mask = 0775
		"""
}]
