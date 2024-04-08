// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// NotificationPolicyExport NotificationPolicyExport is the provisioned file export of alerting.NotificiationPolicyV1.
//
// swagger:model NotificationPolicyExport
#NotificationPolicyExport: {
	// continue
	continue?: bool @go(Continue)

	// group by
	group_by: [...string] @go(GroupBy,[]string)

	// group interval
	group_interval?: string @go(GroupInterval)

	// group wait
	group_wait?: string @go(GroupWait)

	// Deprecated. Remove before v1.0 release.
	match?: {[string]: string} @go(Match,map[string]string)

	// match re
	match_re?: #MatchRegexps @go(MatchRe)

	// matchers
	matchers?: #Matchers @go(Matchers)

	// mute time intervals
	mute_time_intervals: [...string] @go(MuteTimeIntervals,[]string)

	// object matchers
	object_matchers?: #ObjectMatchers @go(ObjectMatchers)

	// org Id
	orgId?: int64 @go(OrgID)

	// receiver
	receiver?: string @go(Receiver)

	// repeat interval
	repeat_interval?: string @go(RepeatInterval)

	// routes
	routes: [...null | #RouteExport] @go(Routes,[]*RouteExport)
}