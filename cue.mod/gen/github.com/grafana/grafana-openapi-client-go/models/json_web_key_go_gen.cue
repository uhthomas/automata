// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// JSONWebKey JSONWebKey represents a public or private key in JWK format.
//
// swagger:model JSONWebKey
#JSONWebKey: {
	// Key algorithm, parsed from `alg` header.
	Algorithm?: string

	// X.509 certificate thumbprint (SHA-1), parsed from `x5t` header.
	CertificateThumbprintSHA1: [...uint8] @go(,[]uint8)

	// X.509 certificate thumbprint (SHA-256), parsed from `x5t#S256` header.
	CertificateThumbprintSHA256: [...uint8] @go(,[]uint8)

	// X.509 certificate chain, parsed from `x5c` header.
	Certificates: [...null | #Certificate] @go(,[]*Certificate)

	// certificates URL
	CertificatesURL?: null | #URL @go(,*URL)

	// Cryptographic key, can be a symmetric or asymmetric key.
	Key?: _ @go(,interface{})

	// Key identifier, parsed from `kid` header.
	KeyID?: string

	// Key use, parsed from `use` header.
	Use?: string
}
