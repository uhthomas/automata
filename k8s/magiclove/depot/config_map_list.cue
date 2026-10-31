package depot

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
	data: "smb.conf": """
		[global]
		netbios name = depot
		server role = standalone server
		workgroup = WORKGROUP
		security = user
		map to guest = Never
		load printers = no
		disable spoolss = yes
		smb ports = 445
		server min protocol = SMB3_00
		server multi channel support = yes
		passdb backend = tdbsam
		private dir = /var/lib/samba/private
		state directory = /var/lib/samba/state
		cache directory = /var/lib/samba/cache
		lock directory = /var/lib/samba/run
		pid directory = /var/lib/samba/run
		ncalrpc dir = /var/lib/samba/run/ncalrpc

		[depot]
		path = /data
		browseable = yes
		read only = no
		guest ok = no
		valid users = smbuser
		create mask = 0660
		directory mask = 0770
		"""
}]
