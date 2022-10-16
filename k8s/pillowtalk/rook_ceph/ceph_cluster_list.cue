package rook_ceph

import "k8s.io/api/core/v1"

cephClusterList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "ceph.rook.io/v1"
		kind:       "CephCluster"
	}]
}

cephClusterList: items: [{
	//################################################################################################################
	// Define the settings for the rook-ceph cluster with common settings for a production cluster.
	// All nodes with available raw devices will be used for the Ceph cluster. At least three nodes are required
	// in this example. See the documentation for more details on storage settings available.

	// For example, to create the cluster:
	//   kubectl create -f crds.yaml -f common.yaml -f operator.yaml
	//   kubectl create -f cluster.yaml
	//################################################################################################################
	spec: {
		cephVersion: {
			// The container image used to launch the Ceph daemon pods (mon, mgr, osd, mds, rgw).
			// v16 is Pacific, and v17 is Quincy.
			// RECOMMENDATION: In production, use a specific version tag instead of the general v17 flag, which pulls the latest release and could result in different
			// versions running within the cluster. See tags available at https://hub.docker.com/r/ceph/ceph/tags/.
			// If you want to be more precise, you can always use a timestamp tag such quay.io/ceph/ceph:v17.2.3-20220805
			// This tag might not contain a new Ceph version, just security fixes from the underlying operating system, which will reduce vulnerabilities
			image: "quay.io/ceph/ceph:v17.2.3"
			// Whether to allow unsupported versions of Ceph. Currently `pacific` and `quincy` are supported.
			// Future versions such as `reef` (v18) would require this to be set to `true`.
			// Do not set to true in production.
			allowUnsupported: false
		}
		// The path on the host where configuration files will be persisted. Must be specified.
		// Important: if you reinstall the cluster, make sure you delete this directory from each host or else the mons will fail to start on the new cluster.
		// In Minikube, the '/data' directory is configured to persist across reboots. Use "/data/rook" in Minikube environment.
		dataDirHostPath: "/var/lib/rook"
		// Whether or not upgrade should continue even if a check fails
		// This means Ceph's status could be degraded and we don't recommend upgrading but you might decide otherwise
		// Use at your OWN risk
		// To understand Rook's upgrade process of Ceph, read https://rook.io/docs/rook/latest/ceph-upgrade.html#ceph-version-upgrades
		skipUpgradeChecks: false
		// Whether or not continue if PGs are not clean during an upgrade
		continueUpgradeAfterChecksEvenIfNotHealthy: false
		// WaitTimeoutForHealthyOSDInMinutes defines the time (in minutes) the operator would wait before an OSD can be stopped for upgrade or restart.
		// If the timeout exceeds and OSD is not ok to stop, then the operator would skip upgrade for the current OSD and proceed with the next one
		// if `continueUpgradeAfterChecksEvenIfNotHealthy` is `false`. If `continueUpgradeAfterChecksEvenIfNotHealthy` is `true`, then operator would
		// continue with the upgrade of an OSD even if its not ok to stop after the timeout. This timeout won't be applied if `skipUpgradeChecks` is `true`.
		// The default wait timeout is 10 minutes.
		waitTimeoutForHealthyOSDInMinutes: 10
		mon: {
			// Set the number of mons to be started. Generally recommended to be 3.
			// For highest availability, an odd number of mons should be specified.
			count: 3
			// The mons should be on unique nodes. For production, at least 3 nodes are recommended for this reason.
			// Mons should only be allowed on the same node for test environments where data loss is acceptable.
			allowMultiplePerNode: false
		}
		mgr: {
			// When higher availability of the mgr is needed, increase the count to 2.
			// In that case, one mgr will be active and one in standby. When Ceph updates which
			// mgr is active, Rook will update the mgr services to match the active mgr.
			count:                2
			allowMultiplePerNode: false
			modules: [{
				// Several modules should not need to be included in this list. The "dashboard" and "monitoring" modules
				// are already enabled by other settings in the cluster CR.
				name:    "pg_autoscaler"
				enabled: true
			}]
		}
		// enable the ceph dashboard for viewing cluster status
		dashboard: {
			enabled: true
			// serve the dashboard under a subpath (useful when you are accessing the dashboard via a reverse proxy)
			// urlPrefix: /ceph-dashboard
			// serve the dashboard at the given port.
			// port: 8443
			// serve the dashboard using SSL
			ssl: true
		}
		// enable prometheus alerting for cluster
		monitoring: {
			// requires Prometheus to be pre-installed
			enabled: false
		}
		network: connections: {
			// Whether to encrypt the data in transit across the wire to prevent eavesdropping the data on the network.
			// The default is false. When encryption is enabled, all communication between clients and Ceph daemons, or between Ceph daemons will be encrypted.
			// When encryption is not enabled, clients still establish a strong initial authentication and data integrity is still validated with a crc check.
			// IMPORTANT: Encryption requires the 5.11 kernel for the latest nbd and cephfs drivers. Alternatively for testing only,
			// you can set the "mounter: rbd-nbd" in the rbd storage class, or "mounter: fuse" in the cephfs storage class.
			// The nbd and fuse drivers are *not* recommended in production since restarting the csi driver pod will disconnect the volumes.
			encryption: {
				enabled: false
			}
			// Whether to compress the data in transit across the wire. The default is false.
			// Requires Ceph Quincy (v17) or newer. Also see the kernel requirements above for encryption.
			compression: {
				enabled: false
			}
		}
		// enable host networking
		//provider: host
		// enable the Multus network provider
		//provider: multus
		//selectors:
		// The selector keys are required to be `public` and `cluster`.
		// Based on the configuration, the operator will do the following:
		//   1. if only the `public` selector key is specified both public_network and cluster_network Ceph settings will listen on that interface
		//   2. if both `public` and `cluster` selector keys are specified the first one will point to 'public_network' flag and the second one to 'cluster_network'
		//
		// In order to work, each selector value must match a NetworkAttachmentDefinition object in Multus
		//
		//public: public-conf --> NetworkAttachmentDefinition object name in Multus
		//cluster: cluster-conf --> NetworkAttachmentDefinition object name in Multus
		// Provide internet protocol version. IPv6, IPv4 or empty string are valid options. Empty string would mean IPv4
		//ipFamily: "IPv6"
		// Ceph daemons to listen on both IPv4 and Ipv6 networks
		//dualStack: false
		// enable the crash collector for ceph daemon crash collection
		crashCollector: {
			disable: false
		}
		// Uncomment daysToRetain to prune ceph crash entries older than the
		// specified number of days.
		//daysToRetain: 30
		// enable log collector, daemons will log on files and rotate
		// logCollector:
		//   enabled: true
		//   periodicity: daily # one of: hourly, daily, weekly, monthly
		//   maxLogSize:  500M # SUFFIX may be 'M' or 'G'. Must be at least 1M.
		// automate [data cleanup process](https://github.com/rook/rook/blob/master/Documentation/Storage-Configuration/ceph-teardown.md#delete-the-data-on-hosts) in cluster destruction.
		cleanupPolicy: {
			// Since cluster cleanup is destructive to data, confirmation is required.
			// To destroy all Rook data on hosts during uninstall, confirmation must be set to "yes-really-destroy-data".
			// This value should only be set when the cluster is about to be deleted. After the confirmation is set,
			// Rook will immediately stop configuring the cluster and only wait for the delete command.
			// If the empty string is set, Rook will not destroy any data on hosts during uninstall.
			confirmation: ""
			// sanitizeDisks represents settings for sanitizing OSD disks on cluster deletion
			sanitizeDisks: {
				// method indicates if the entire disk should be sanitized or simply ceph's metadata
				// in both case, re-install is possible
				// possible choices are 'complete' or 'quick' (default)
				method: "quick"
				// dataSource indicate where to get random bytes from to write on the disk
				// possible choices are 'zero' (default) or 'random'
				// using random sources will consume entropy from the system and will take much more time then the zero source
				dataSource: "zero"
				// iteration overwrite N times instead of the default (1)
				// takes an integer value
				iteration: 1
			}
			// allowUninstallWithVolumes defines how the uninstall should be performed
			// If set to true, cephCluster deletion does not wait for the PVs to be deleted.
			allowUninstallWithVolumes: false
		}
		// To control where various services will be scheduled by kubernetes, use the placement configuration sections below.
		// The example under 'all' would have all services scheduled on kubernetes nodes labeled with 'role=storage-node' and
		// tolerate taints with a key of 'storage-node'.
		//  placement:
		//    all:
		//      nodeAffinity:
		//        requiredDuringSchedulingIgnoredDuringExecution:
		//          nodeSelectorTerms:
		//          - matchExpressions:
		//            - key: role
		//              operator: In
		//              values:
		//              - storage-node
		//      podAffinity:
		//      podAntiAffinity:
		//      topologySpreadConstraints:
		//      tolerations:
		//      - key: storage-node
		//        operator: Exists
		// The above placement information can also be specified for mon, osd, and mgr components
		//    mon:
		// Monitor deployments may contain an anti-affinity rule for avoiding monitor
		// collocation on the same node. This is a required rule when host network is used
		// or when AllowMultiplePerNode is false. Otherwise this anti-affinity rule is a
		// preferred rule with weight: 50.
		//    osd:
		//    prepareosd:
		//    mgr:
		//    cleanup:
		annotations: null
		//    all:
		//    mon:
		//    osd:
		//    cleanup:
		//    prepareosd:
		// clusterMetadata annotations will be applied to only `rook-ceph-mon-endpoints` configmap and the `rook-ceph-mon` and `rook-ceph-admin-keyring` secrets.
		// And clusterMetadata annotations will not be merged with `all` annotations.
		//    clusterMetadata:
		//       kubed.appscode.com/sync: "true"
		// If no mgr annotations are set, prometheus scrape annotations will be set by default.
		//    mgr:
		labels: null
		//    all:
		//    mon:
		//    osd:
		//    cleanup:
		//    mgr:
		//    prepareosd:
		// monitoring is a list of key-value pairs. It is injected into all the monitoring resources created by operator.
		// These labels can be passed as LabelSelector to Prometheus
		//    monitoring:
		//    crashcollector:
		resources: null
		// The requests and limits set here, allow the mgr pod to use half of one CPU core and 1 gigabyte of memory
		//    mgr:
		//      limits:
		//        cpu: "500m"
		//        memory: "1024Mi"
		//      requests:
		//        cpu: "500m"
		//        memory: "1024Mi"
		// The above example requests/limits can also be added to the other components
		//    mon:
		//    osd:
		// For OSD it also is a possible to specify requests/limits based on device class
		//    osd-hdd:
		//    osd-ssd:
		//    osd-nvme:
		//    prepareosd:
		//    mgr-sidecar:
		//    crashcollector:
		//    logcollector:
		//    cleanup:
		// The option to automatically remove OSDs that are out and are safe to destroy.
		removeOSDsIfOutAndSafeToRemove: true
		priorityClassNames: {
			//all: rook-ceph-default-priority-class
			mon: "system-node-critical"
			osd: "system-node-critical"
			mgr: "system-cluster-critical"
		}
		//crashcollector: rook-ceph-crashcollector-priority-class
		storage: {// cluster level storage configuration and selection
			useAllNodes:   false
			useAllDevices: false
			nodes: [{
				name: "13a0a37008"
				devices: [
					// Seagate Barracuda 6TB (ST6000DM003-2CY186)
					{name: "/dev/disk/by-id/scsi-35000c500c9566239"},
					// WD Red 4TB (WDC WD40EFRX-68WT0N0)
					{name: "/dev/disk/by-id/scsi-350014ee2b3a8b3d7"},
				]
			}, {
				name: "6151c4656b"
				devices: [
					// Seagate Barracuda 6TB (ST6000DM003-2CY186)
					{name: "/dev/disk/by-id/scsi-35000c500c95641d1"},
					// WD Red 4TB (WDC WD40EFRX-68WT0N0)
					{name: "/dev/disk/by-id/scsi-350014ee2b3a8d79e"},
				]
			}, {
				name: "38aab880f5"
				devices: [
					// WD Red 4TB (WDC WD40EFRX-68WT0N0)
					{name: "/dev/disk/by-id/scsi-350014ee20a0d98d1"},
					// WD Red 4TB (WDC WD40EFRX-68WT0N0)
					{name: "/dev/disk/by-id/scsi-350014ee20a85be27"},
				]
			}]
			//deviceFilter:
			config: null
			// crushRoot: "custom-root" # specify a non-default root label for the CRUSH map
			// metadataDevice: "md0" # specify a non-rotational storage so ceph-volume will use it as block db device of bluestore.
			// databaseSizeMB: "1024" # uncomment if the disks are smaller than 100 GB
			// journalSizeMB: "1024"  # uncomment if the disks are 20 GB or smaller
			// osdsPerDevice: "1" # this value can be overridden at the node or device level
			// encryptedDevice: "true" # the default value for this option is "false"
			// Individual nodes and their config can be specified as well, but 'useAllNodes' above must be set to false. Then, only the named
			// nodes below will be used as storage resources.  Each node's 'name' field should match their 'kubernetes.io/hostname' label.
			// nodes:
			//   - name: "172.17.4.201"
			//     devices: # specific devices to use for storage can be specified for each node
			//       - name: "sdb"
			//       - name: "nvme01" # multiple osds can be created on high performance devices
			//         config:
			//           osdsPerDevice: "5"
			//       - name: "/dev/disk/by-id/ata-ST4000DM004-XXXX" # devices can be specified using full udev paths
			//     config: # configuration can be specified at the node level which overrides the cluster level config
			//   - name: "172.17.4.301"
			//     deviceFilter: "^sd."
			// when onlyApplyOSDPlacement is false, will merge both placement.All() and placement.osd
			onlyApplyOSDPlacement: false
		}
		// The section for configuring management of daemon disruptions during upgrade or fencing.
		disruptionManagement: {
			// If true, the operator will create and manage PodDisruptionBudgets for OSD, Mon, RGW, and MDS daemons. OSD PDBs are managed dynamically
			// via the strategy outlined in the [design](https://github.com/rook/rook/blob/master/design/ceph/ceph-managed-disruptionbudgets.md). The operator will
			// block eviction of OSDs by default and unblock them safely when drains are detected.
			managePodBudgets: true
			// A duration in minutes that determines how long an entire failureDomain like `region/zone/host` will be held in `noout` (in addition to the
			// default DOWN/OUT interval) when it is draining. This is only relevant when  `managePodBudgets` is `true`. The default value is `30` minutes.
			osdMaintenanceTimeout: 30
			// A duration in minutes that the operator will wait for the placement groups to become healthy (active+clean) after a drain was completed and OSDs came back up.
			// Operator will continue with the next drain if the timeout exceeds. It only works if `managePodBudgets` is `true`.
			// No values or 0 means that the operator will wait until the placement groups are healthy before unblocking the next drain.
			pgHealthCheckTimeout: 0
			// If true, the operator will create and manage MachineDisruptionBudgets to ensure OSDs are only fenced when the cluster is healthy.
			// Only available on OpenShift.
			manageMachineDisruptionBudgets: false
			// Namespace in which to watch for the MachineDisruptionBudgets.
			machineDisruptionBudgetNamespace: "openshift-machine-api"
		}

		// healthChecks
		// Valid values for daemons are 'mon', 'osd', 'status'
		healthCheck: {
			daemonHealth: {
				mon: {
					disabled: false
					interval: "45s"
				}
				osd: {
					disabled: false
					interval: "60s"
				}
				status: {
					disabled: false
					interval: "60s"
				}
			}
			// Change pod liveness probe timing or threshold values. Works for all mon,mgr,osd daemons.
			livenessProbe: {
				mon: disabled: false
				mgr: disabled: false
				osd: disabled: false
			}
			// Change pod startup probe timing or threshold values. Works for all mon,mgr,osd daemons.
			startupProbe: {
				mon: disabled: false
				mgr: disabled: false
				osd: disabled: false
			}
		}
	}
}]
