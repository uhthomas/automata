package unwind

import "k8s.io/api/core/v1"

serverList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "metal.sidero.dev/v1alpha1"
		kind:       "Server"
	}]
}

serverList: items: [...{
	metadata: finalizers: ["storage.finalizers.server.k8s.io"]
	spec: {
		// All the servers should be accepted.
		accepted: true
		// All the servers should have exactly one interface; A 20Gbe bond. They should
		// all be using DHCP and the same virtual IP.
		configPatches: [...{
			value: network: interfaces: [{
				bond: {
					downdelay:      200
					lacpRate:       "fast"
					miimon:         100
					mode:           "802.3ad"
					updelay:        200
					xmitHashPolicy: "layer3+4"
				}
				dhcp:      true
				interface: "bond0"
				vip: ip: "10.0.0.100"
			}]
		}]
	}
}]

// Servers are ordered by their physical location.
serverList: items: [{
	metadata: name: "4c4c4544-0054-3010-8056-c7c04f424232"
	spec: {
		bmc: {
			endpoint: "192.168.1.61"
			passFrom: secretKeyRef: {
				key:       "pass"
				name:      "4c4c4544-0054-3010-8056-c7c04f424232-bmc"
				namespace: "default"
			}
			port: 623
			userFrom: secretKeyRef: {
				key:       "user"
				name:      "4c4c4544-0054-3010-8056-c7c04f424232-bmc"
				namespace: "default"
			}
		}
		configPatches: [{
			op:   "add"
			path: "/machine"
			value: {
				install: diskSelector: wwid: "naa.50026b7381885d08"
				network: interfaces: [{
					addresses: ["10.0.0.110"]
					bond: interfaces: ["eth4", "eth5"]
				}]
			}
		}]
		cpu: {
			manufacturer: "Intel"
			version:      "Intel(R) Xeon(R) CPU E5-2640 v3 @ 2.60GHz"
		}
		hostname: "10.0.0.248"
		system: {
			family:       "Unknown"
			manufacturer: "Dell Inc."
			productName:  "PowerEdge R430"
			serialNumber: "SKU=NotProvided;ModelName=PowerEdge R430"
			skuNumber:    "Unknown"
			version:      "GT0VBB2"
		}
	}
}, {
	metadata: name: "4c4c4544-0054-3510-8057-c7c04f424232"
	spec: {
		bmc: {
			endpoint: "192.168.1.61"
			passFrom: secretKeyRef: {
				key:       "pass"
				name:      "4c4c4544-0054-3510-8057-c7c04f424232-bmc"
				namespace: "default"
			}
			port: 623
			userFrom: secretKeyRef: {
				key:       "user"
				name:      "4c4c4544-0054-3510-8057-c7c04f424232-bmc"
				namespace: "default"
			}
		}
		configPatches: [{
			op:   "add"
			path: "/machine"
			value: {
				install: diskSelector: wwid: "naa.50026b7381886726"
				network: interfaces: [{
					addresses: ["10.0.0.120"]
					bond: interfaces: ["eth4", "eth5"]
				}]
			}
		}]
		cpu: {
			manufacturer: "Intel"
			version:      "Intel(R) Xeon(R) CPU E5-2640 v3 @ 2.60GHz"
		}
		hostname: "10.0.0.249"
		system: {
			family:       "Unknown"
			manufacturer: "Dell Inc."
			productName:  "PowerEdge R430"
			serialNumber: "SKU=NotProvided;ModelName=PowerEdge R430"
			skuNumber:    "Unknown"
			version:      "GT5WBB2"
		}
	}
}, {
	metadata: name: "4c4c4544-0057-4210-804c-c7c04f423432"
	spec: {
		cpu: {
			manufacturer: "Intel"
			version:      "Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz"
		}
		configPatches: [{
			op:   "add"
			path: "/machine"
			value: {
				install: diskSelector: wwid: "naa.50025388a035cb0e"
				network: interfaces: [{
					addresses: ["10.0.0.130"]
					bond: interfaces: ["eth0", "eth1"]
				}]
			}
		}]
		hostname: "10.0.0.246"
		system: {
			family:       "SKU=NotProvided;ModelName=PowerEdge R720"
			manufacturer: "Dell Inc."
			skuNumber:    "GWBLB42"
			version:      "PowerEdge R720"
		}
	}
}, {
	metadata: name: "4c4c4544-0042-5610-804b-b8c04f445831"
	spec: {
		bmc: {
			endpoint: "0.0.0.0"
			passFrom: secretKeyRef: {
				key:       "pass"
				name:      "4c4c4544-0042-5610-804b-b8c04f445831-bmc"
				namespace: "default"
			}
			port: 623
			userFrom: secretKeyRef: {
				key:       "user"
				name:      "4c4c4544-0042-5610-804b-b8c04f445831-bmc"
				namespace: "default"
			}
		}
		cpu: {
			manufacturer: "Intel"
			version:      "Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz"
		}
		configPatches: [{
			op:   "add"
			path: "/machine"
			value: {
				install: diskSelector: wwid: "naa.5002538550025450"
				network: interfaces: [{
					addresses: ["10.0.0.140"]
					bond: interfaces: ["eth0", "eth1"]
				}]
			}
		}]
		hostname: "10.0.0.243"
		system: {
			family:       "SKU=NotProvided;ModelName=PowerEdge R720"
			manufacturer: "Dell Inc."
			skuNumber:    "8BVKDX1"
			version:      "PowerEdge R720"
		}
	}
}, {
	metadata: name: "4c4c4544-0047-4410-8034-b9c04f575631"
	spec: {
		cpu: {
			manufacturer: "Intel"
			version:      "Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz"
		}
		configPatches: [{
			op:   "add"
			path: "/machine"
			value: {
				install: diskSelector: wwid: "naa.50025388a015a68d"
				network: interfaces: [{
					addresses: ["10.0.0.150"]
					bond: interfaces: ["eth0", "eth1"]
				}]
			}
		}]
		hostname: "10.0.0.242"
		system: {
			family:       "SKU=NotProvided;ModelName=PowerEdge R720"
			manufacturer: "Dell Inc."
			skuNumber:    "9GD4WV1"
			version:      "PowerEdge R720"
		}
	}
}]
