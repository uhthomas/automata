// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// PagerdutyConfig PagerdutyConfig configures notifications via PagerDuty.
//
// swagger:model PagerdutyConfig
#PagerdutyConfig: {
	// class
	class?: string @go(Class)

	// client
	client?: string @go(Client)

	// client url
	client_url?: string @go(ClientURL)

	// component
	component?: string @go(Component)

	// description
	description?: string @go(Description)

	// details
	details?: {[string]: string} @go(Details,map[string]string)

	// group
	group?: string @go(Group)

	// http config
	http_config?: null | #HTTPClientConfig @go(HTTPConfig,*HTTPClientConfig)

	// images
	images: [...null | #PagerdutyImage] @go(Images,[]*PagerdutyImage)

	// links
	links: [...null | #PagerdutyLink] @go(Links,[]*PagerdutyLink)

	// routing key
	routing_key?: #Secret @go(RoutingKey)

	// routing key file
	routing_key_file?: string @go(RoutingKeyFile)

	// send resolved
	send_resolved?: bool @go(SendResolved)

	// service key
	service_key?: #Secret @go(ServiceKey)

	// service key file
	service_key_file?: string @go(ServiceKeyFile)

	// severity
	severity?: string @go(Severity)

	// source
	source?: string @go(Source)

	// url
	url?: null | #URL @go(URL,*URL)
}
