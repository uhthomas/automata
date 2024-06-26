// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// OAuth2 OAuth2 is the oauth2 client configuration.
//
// swagger:model OAuth2
#OAuth2: {
	// TLS config
	TLSConfig?: null | #TLSConfig @go(,*TLSConfig)

	// client id
	client_id?: string @go(ClientID)

	// client secret
	client_secret?: #Secret @go(ClientSecret)

	// client secret file
	client_secret_file?: string @go(ClientSecretFile)

	// endpoint params
	endpoint_params?: {[string]: string} @go(EndpointParams,map[string]string)

	// NoProxy contains addresses that should not use a proxy.
	no_proxy?: string @go(NoProxy)

	// proxy connect header
	proxy_connect_header?: #Header @go(ProxyConnectHeader)

	// ProxyFromEnvironment makes use of net/http ProxyFromEnvironment function
	// to determine proxies.
	proxy_from_environment?: bool @go(ProxyFromEnvironment)

	// proxy url
	proxy_url?: null | #URL @go(ProxyURL,*URL)

	// scopes
	scopes: [...string] @go(Scopes,[]string)

	// token url
	token_url?: string @go(TokenURL)
}
