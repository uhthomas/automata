// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go net

package net

// An SRV represents a single DNS SRV record.
#SRV: {
	Target:   string
	Port:     uint16
	Priority: uint16
	Weight:   uint16
}

// byPriorityWeight sorts SRV records by ascending priority and weight.
_#byPriorityWeight: [...null | #SRV]

// An MX represents a single DNS MX record.
#MX: {
	Host: string
	Pref: uint16
}

// byPref sorts MX records by preference
_#byPref: [...null | #MX]

// An NS represents a single DNS NS record.
#NS: {
	Host: string
}
