// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go net

package net

_#maxProtoLength: int & 25

_#maxPortBufSize: int & 25

// A Resolver looks up names and numbers.
//
// A nil *Resolver is equivalent to a zero Resolver.
#Resolver: {
	// PreferGo controls whether Go's built-in DNS resolver is preferred
	// on platforms where it's available. It is equivalent to setting
	// GODEBUG=netdns=go, but scoped to just this resolver.
	PreferGo: bool

	// StrictErrors controls the behavior of temporary errors
	// (including timeout, socket errors, and SERVFAIL) when using
	// Go's built-in resolver. For a query composed of multiple
	// sub-queries (such as an A+AAAA address lookup, or walking the
	// DNS search list), this option causes such errors to abort the
	// whole query instead of returning a partial result. This is
	// not enabled by default because it may affect compatibility
	// with resolvers that process AAAA queries incorrectly.
	StrictErrors: bool
}

// onlyValuesCtx is a context that uses an underlying context
// for value lookup if the underlying context hasn't yet expired.
_#onlyValuesCtx: {
	Context: _
}
