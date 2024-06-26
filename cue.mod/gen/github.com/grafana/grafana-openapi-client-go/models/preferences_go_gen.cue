// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// Preferences Spec defines user, team or org Grafana preferences
//
// swagger:model Preferences
#Preferences: {
	// cookie preferences
	cookiePreferences?: null | #CookiePreferences @go(CookiePreferences,*CookiePreferences)

	// ID for the home dashboard. This is deprecated and will be removed in a future version. Use homeDashboardUid instead.
	homeDashboardId?: int64 @go(HomeDashboardID)

	// UID for the home dashboard
	homeDashboardUID?: string @go(HomeDashboardUID)

	// Selected language (beta)
	language?: string @go(Language)

	// query history
	queryHistory?: null | #QueryHistoryPreference @go(QueryHistory,*QueryHistoryPreference)

	// Theme light, dark, empty is default
	theme?: string @go(Theme)

	// The timezone selection
	// TODO: this should use the timezone defined in common
	timezone?: string @go(Timezone)

	// WeekStart day of the week (sunday, monday, etc)
	weekStart?: string @go(WeekStart)
}
