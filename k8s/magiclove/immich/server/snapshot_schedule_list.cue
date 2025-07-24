package server

import snapschedulerv1 "github.com/backube/snapscheduler/api/v1"

#SnapshotScheduleList: snapschedulerv1.#SnapshotScheduleList & {
	apiVersion: "snapscheduler.backube/v1"
	kind:       "SnapshotScheduleList"
	items: [...{
		apiVersion: "snapscheduler.backube/v1"
		kind:       "SnapshotSchedule"
	}]
}

// TODO: Use time.FormatDuration.
//
//	time.FormatDuration(24 * 365 * time.Hour)
//
// https://github.com/backube/snapscheduler/issues/788

#SnapshotScheduleList: items: [{
	metadata: name: "\(#Name)-hourly"
	spec: {
		claimSelector: matchLabels: "app.kubernetes.io/name": #Name
		// Retain hourly snapshots for 24 hours.
		retention: {
			expires:  "24h"
			maxCount: 24
		}
		schedule: "@hourly"
	}
}, {
	metadata: name: "\(#Name)-daily"
	spec: {
		claimSelector: matchLabels: "app.kubernetes.io/name": #Name
		// Retain daily snapshots for 7 days.
		retention: {
			expires:  "\(24*7)h"
			maxCount: 7
		}
		schedule: "@daily"
	}
}, {
	metadata: name: "\(#Name)-weekly"
	spec: {
		claimSelector: matchLabels: "app.kubernetes.io/name": #Name
		// Retain weekly snapshots for 28 days.
		retention: {
			expires:  "\(24*28)h"
			maxCount: 4
		}
		schedule: "@weekly"
	}
}, {
	metadata: name: "\(#Name)-monthly"
	spec: {
		claimSelector: matchLabels: "app.kubernetes.io/name": #Name
		// Retain monthly snapshots for 365 days.
		retention: {
			expires:  "\(24*365)h"
			maxCount: 12
		}
		schedule: "@monthly"
	}
}]
