// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// TLSConfig TLSConfig configures the options for TLS connections.
//
// swagger:model TLSConfig
#TLSConfig: {
	// Text of the CA cert to use for the targets.
	ca?: string @go(Ca)

	// The CA cert to use for the targets.
	ca_file?: string @go(CaFile)

	// Text of the client cert file for the targets.
	cert?: string @go(Cert)

	// The client cert file for the targets.
	cert_file?: string @go(CertFile)

	// Disable target certificate validation.
	insecure_skip_verify?: bool @go(InsecureSkipVerify)

	// key
	key?: #Secret @go(Key)

	// The client key file for the targets.
	key_file?: string @go(KeyFile)

	// max version
	max_version?: #TLSVersion @go(MaxVersion)

	// min version
	min_version?: #TLSVersion @go(MinVersion)

	// Used to verify the hostname for the targets.
	server_name?: string @go(ServerName)
}
