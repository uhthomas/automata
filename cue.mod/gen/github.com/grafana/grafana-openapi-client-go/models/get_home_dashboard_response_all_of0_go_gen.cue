// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// GetHomeDashboardResponseAllOf0 get home dashboard response all of0
//
// swagger:model getHomeDashboardResponseAllOf0
#GetHomeDashboardResponseAllOf0: {
	// dashboard
	dashboard?: #JSON @go(Dashboard)

	// meta
	meta?: null | #DashboardMeta @go(Meta,*DashboardMeta)
}
