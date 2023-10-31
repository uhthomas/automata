// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/go-openapi/strfmt

package strfmt

// RFC3339Millis represents a ISO8601 format to millis instead of to nanos
#RFC3339Millis: "2006-01-02T15:04:05.000Z07:00"

// RFC3339MillisNoColon represents a ISO8601 format to millis instead of to nanos
#RFC3339MillisNoColon: "2006-01-02T15:04:05.000Z0700"

// RFC3339Micro represents a ISO8601 format to micro instead of to nano
#RFC3339Micro: "2006-01-02T15:04:05.000000Z07:00"

// RFC3339MicroNoColon represents a ISO8601 format to micro instead of to nano
#RFC3339MicroNoColon: "2006-01-02T15:04:05.000000Z0700"

// ISO8601LocalTime represents a ISO8601 format to ISO8601 in local time (no timezone)
#ISO8601LocalTime: "2006-01-02T15:04:05"

// ISO8601TimeWithReducedPrecision represents a ISO8601 format with reduced precision (dropped secs)
#ISO8601TimeWithReducedPrecision: "2006-01-02T15:04Z"

// ISO8601TimeWithReducedPrecisionLocaltime represents a ISO8601 format with reduced precision and no timezone (dropped seconds + no timezone)
#ISO8601TimeWithReducedPrecisionLocaltime: "2006-01-02T15:04"

// ISO8601TimeUniversalSortableDateTimePattern represents a ISO8601 universal sortable date time pattern.
#ISO8601TimeUniversalSortableDateTimePattern: "2006-01-02 15:04:05"

// DateTimePattern pattern to match for the date-time format from http://tools.ietf.org/html/rfc3339#section-5.6
#DateTimePattern: "^([0-9]{2}):([0-9]{2}):([0-9]{2})(.[0-9]+)?(z|([+-][0-9]{2}:[0-9]{2}))$" // `^([0-9]{2}):([0-9]{2}):([0-9]{2})(.[0-9]+)?(z|([+-][0-9]{2}:[0-9]{2}))$`

// DateTime is a time but it serializes to ISO8601 format with millis
// It knows how to read 3 different variations of a RFC3339 date time.
// Most APIs we encounter want either millisecond or second precision times.
// This just tries to make it worry-free.
//
// swagger:strfmt date-time
#DateTime: string
