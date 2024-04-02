// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// GettableAPIAlertingConfig gettable Api alerting config
//
// swagger:model GettableApiAlertingConfig
#GettableAPIAlertingConfig: {
	// global
	global?: null | #GlobalConfig @go(Global,*GlobalConfig)

	// inhibit rules
	inhibit_rules: [...null | #InhibitRule] @go(InhibitRules,[]*InhibitRule)

	// mute time provenances
	muteTimeProvenances?: {[string]: #Provenance} @go(MuteTimeProvenances,map[string]Provenance)

	// mute time intervals
	mute_time_intervals: [...null | #MuteTimeInterval] @go(MuteTimeIntervals,[]*MuteTimeInterval)

	// Override with our superset receiver type
	receivers: [...null | #GettableAPIReceiver] @go(Receivers,[]*GettableAPIReceiver)

	// route
	route?: null | #Route @go(Route,*Route)

	// templates
	templates: [...string] @go(Templates,[]string)
}
