// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// ReportSchedule report schedule
//
// swagger:model ReportSchedule
#ReportSchedule: {
	// day
	day?: string @go(Day)

	// day of month
	dayOfMonth?: string @go(DayOfMonth)

	// frequency
	frequency?: string @go(Frequency)

	// hour
	hour?: int64 @go(Hour)

	// interval amount
	intervalAmount?: int64 @go(IntervalAmount)

	// interval frequency
	intervalFrequency?: string @go(IntervalFrequency)

	// minute
	minute?: int64 @go(Minute)

	// time zone
	timeZone?: string @go(TimeZone)

	// workdays only
	workdaysOnly?: bool @go(WorkdaysOnly)
}