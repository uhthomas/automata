// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// AlertPair alert pair
//
// swagger:model AlertPair
#AlertPair: {
	// alert rule
	alertRule?: null | #AlertRuleUpgrade @go(AlertRule,*AlertRuleUpgrade)

	// error
	error?: string @go(Error)

	// legacy alert
	legacyAlert?: null | #LegacyAlert @go(LegacyAlert,*LegacyAlert)
}
