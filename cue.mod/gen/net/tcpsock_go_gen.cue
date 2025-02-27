// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go net

package net

// TCPAddr represents the address of a TCP end point.
#TCPAddr: {
	IP:   string @go(,IP)
	Port: int
	Zone: string
}

// KeepAliveConfig contains TCP keep-alive options.
//
// If the Idle, Interval, or Count fields are zero, a default value is chosen.
// If a field is negative, the corresponding socket-level option will be left unchanged.
//
// Note that prior to Windows 10 version 1709, neither setting Idle and Interval
// separately nor changing Count (which is usually 10) is supported.
// Therefore, it's recommended to set both Idle and Interval to non-negative values
// in conjunction with a -1 for Count on those old Windows if you intend to customize
// the TCP keep-alive settings.
// By contrast, if only one of Idle and Interval is set to a non-negative value,
// the other will be set to the system default value, and ultimately,
// set both Idle and Interval to negative values if you want to leave them unchanged.
//
// Note that Solaris and its derivatives do not support setting Interval to a non-negative value
// and Count to a negative value, or vice-versa.
#KeepAliveConfig: {
	// If Enable is true, keep-alive probes are enabled.
	Enable: bool

	// Idle is the time that the connection must be idle before
	// the first keep-alive probe is sent.
	// If zero, a default value of 15 seconds is used.
	Idle: int @go(,time.Duration)

	// Interval is the time between keep-alive probes.
	// If zero, a default value of 15 seconds is used.
	Interval: int @go(,time.Duration)

	// Count is the maximum number of keep-alive probes that
	// can go unanswered before dropping a connection.
	// If zero, a default value of 9 is used.
	Count: int
}
