// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go sigs.k8s.io/external-dns/endpoint

package endpoint

#MatchAllDomainFilters: [...null | #DomainFilter]

// DomainFilter holds a lists of valid domain names
#DomainFilter: _

// domainFilterSerde is a helper type for serializing and deserializing DomainFilter.
_#domainFilterSerde: {
	include?: [...string] @go(Include,[]string)
	exclude?: [...string] @go(Exclude,[]string)
	regexInclude?: string @go(RegexInclude)
	regexExclude?: string @go(RegexExclude)
}
