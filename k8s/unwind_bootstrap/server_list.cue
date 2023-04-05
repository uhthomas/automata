package unwind_bootstrap

import (
	"list"

	"github.com/uhthomas/automata/tools/jsonpatch"
	"k8s.io/api/core/v1"
)

serverList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "metal.sidero.dev/v1alpha1"
		kind:       "Server"
	}]
}

serverList: items: [...{
	spec: {
		accepted:      true
		configPatches: jsonpatch.#PatchList
	}
}]

_baseConfigPatches: jsonpatch.#PatchList & [jsonpatch.#Add & {
	path:  "/machine/install/image"
	value: "ghcr.io/uhthomas/talos-installer:v1.4.0-alpha.4@sha256:81dc40e8e462c583caff5eddce14fa86158f2ca18f46b41404caeedb5052b19b"
}, jsonpatch.#Add & {
	path: "/machine/install/extensions"
	value: [ for x in [
		"ghcr.io/siderolabs/gvisor:20221107.0-v1.3.6",
		"ghcr.io/siderolabs/i915-ucode:20230310",
		"ghcr.io/siderolabs/intel-ucode:20220809",
	] {
		image: x
	}]
}]

#InstallDiskSelectorConfigPatch: jsonpatch.#Add & {
	path: "/machine/install/diskSelector"
	value: wwid: string
}

// All the servers should have exactly one interface; A 20Gbe bond. They should
// all have the same network configuration and the same virtual IP.
#NetworkConfigPatch: jsonpatch.#Add & {
	path: "/machine/network"
	value: {
		interfaces: [{
			interface: "bond0"
			bond: {
				downdelay:      200
				lacpRate:       "fast"
				miimon:         100
				mode:           "802.3ad"
				updelay:        200
				xmitHashPolicy: "layer3+4"
				...
			}
			dhcp: true
			vip: ip: "10.0.0.100"
			...
		}]
		extraHostEntries: [{
			// The static host entry is served by
			// the DHCP server, but this local entry
			// may allow us to remove that
			// dependency.
			ip: "10.0.0.100"
			aliases: ["unwind.starjunk.net"]
			...
		}]
	}
}

// Servers are ordered by their physical location.
serverList: items: [{
	// PowerEdge R430 (GT0VBB2)
	metadata: name:      "4c4c4544-0054-3010-8056-c7c04f424232"
	spec: configPatches: list.Concat([_baseConfigPatches, [#InstallDiskSelectorConfigPatch & {
		value: wwid: "naa.50026b7381885d08"
	}, #NetworkConfigPatch & {
		value: interfaces: [{
			addresses: ["10.0.0.101"]
			bond: interfaces: ["eth4", "eth5"]
		}]
	}]])
}, {
	// PowerEdge R430 (GT5WBB2)
	metadata: name:      "4c4c4544-0054-3510-8057-c7c04f424232"
	spec: configPatches: list.Concat([_baseConfigPatches, [#InstallDiskSelectorConfigPatch & {
		value: wwid: "naa.50026b7381886726"
	}, #NetworkConfigPatch & {
		value: interfaces: [{
			addresses: ["10.0.0.102"]
			bond: interfaces: ["eth4", "eth5"]
		}]
	}]])
}, {
	// PowerEdge R720 (JSBJ132)
	metadata: name:      "4c4c4544-0053-4210-804a-cac04f313332"
	spec: configPatches: list.Concat([_baseConfigPatches + [#InstallDiskSelectorConfigPatch & {
		value: wwid: "naa.50025388a035cb0e"
	}, #NetworkConfigPatch & {
		value: interfaces: [{
			addresses: ["10.0.0.103"]
			bond: interfaces: ["eth4", "eth5"]
		}]
	}]])
}, {
	// PowerEdge R720 (8BVKDX1)
	metadata: name:      "4c4c4544-0042-5610-804b-b8c04f445831"
	spec: configPatches: list.Concat([_baseConfigPatches + [#InstallDiskSelectorConfigPatch & {
		value: wwid: "naa.5002538550025450"
	}, #NetworkConfigPatch & {
		value: interfaces: [{
			addresses: ["10.0.0.104"]
			bond: interfaces: ["eth0", "eth1"]
			// bond: deviceSelectors: [{hardwareAddr: "e4:11:5b:62:f2:f8"}]
		}]
	}]])
}, {
	// PowerEdge R720 (9GD4WV1)
	metadata: name:      "4c4c4544-0047-4410-8034-b9c04f575631"
	spec: configPatches: list.Concat([_baseConfigPatches + [#InstallDiskSelectorConfigPatch & {
		value: wwid: "naa.50025388a015a68d"
	}, #NetworkConfigPatch & {
		value: interfaces: [{
			addresses: ["10.0.0.105"]
			bond: interfaces: ["eth0", "eth1"]
		}]
	}]])
}]
