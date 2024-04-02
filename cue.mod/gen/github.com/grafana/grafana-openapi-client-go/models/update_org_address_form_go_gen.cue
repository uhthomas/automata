// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// UpdateOrgAddressForm update org address form
//
// swagger:model UpdateOrgAddressForm
#UpdateOrgAddressForm: {
	// address1
	address1?: string @go(Address1)

	// address2
	address2?: string @go(Address2)

	// city
	city?: string @go(City)

	// country
	country?: string @go(Country)

	// state
	state?: string @go(State)

	// zipcode
	zipcode?: string @go(Zipcode)
}
