// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/VictoriaMetrics/operator/api/victoriametrics/v1beta1

package v1beta1

import (
	"k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// VMProbeSpec contains specification parameters for a Probe.
// +k8s:openapi-gen=true
#VMProbeSpec: {
	// The job name assigned to scraped metrics by default.
	jobName?: string @go(JobName)

	// Specification for the prober to use for probing targets.
	// The prober.URL parameter is required. Targets cannot be probed if left empty.
	vmProberSpec: #VMProberSpec @go(VMProberSpec)

	// The module to use for probing specifying how to probe the target.
	// Example module configuring in the blackbox exporter:
	// https://github.com/prometheus/blackbox_exporter/blob/master/example.yml
	module?: string @go(Module)

	// Targets defines a set of static and/or dynamically discovered targets to be probed using the prober.
	targets?: #VMProbeTargets @go(Targets)

	// Interval at which targets are probed using the configured prober.
	// If not specified Prometheus' global scrape interval is used.
	interval?: string @go(Interval)

	// ScrapeInterval is the same as Interval and has priority over it.
	// one of scrape_interval or interval can be used
	// +optional
	scrape_interval?: string @go(ScrapeInterval)

	// Timeout for scraping metrics from the Prometheus exporter.
	scrapeTimeout?: string @go(ScrapeTimeout)

	// Optional HTTP URL parameters
	// +optional
	params?: {[string]: [...string]} @go(Params,map[string][]string)

	// FollowRedirects controls redirects for scraping.
	// +optional
	follow_redirects?: null | bool @go(FollowRedirects,*bool)

	// SampleLimit defines per-scrape limit on number of scraped samples that will be accepted.
	// +optional
	sampleLimit?: uint64 @go(SampleLimit)

	// File to read bearer token for scraping targets.
	// +optional
	bearerTokenFile?: string @go(BearerTokenFile)

	// Secret to mount to read bearer token for scraping targets. The secret
	// needs to be in the same namespace as the service scrape and accessible by
	// the victoria-metrics operator.
	// +optional
	// +nullable
	bearerTokenSecret?: null | v1.#SecretKeySelector @go(BearerTokenSecret,*v1.SecretKeySelector)

	// BasicAuth allow an endpoint to authenticate over basic authentication
	// More info: https://prometheus.io/docs/operating/configuration/#endpoints
	// +optional
	basicAuth?: null | #BasicAuth @go(BasicAuth,*BasicAuth)

	// OAuth2 defines auth configuration
	// +optional
	oauth2?: null | #OAuth2 @go(OAuth2,*OAuth2)

	// Authorization with http header Authorization
	// +optional
	authorization?: null | #Authorization @go(Authorization,*Authorization)

	// TLSConfig configuration to use when scraping the endpoint
	// +optional
	tlsConfig?: null | #TLSConfig @go(TLSConfig,*TLSConfig)

	// VMScrapeParams defines VictoriaMetrics specific scrape parametrs
	// +optional
	vm_scrape_params?: null | #VMScrapeParams @go(VMScrapeParams,*VMScrapeParams)
}

// VMProbeTargets defines a set of static and dynamically discovered targets for the prober.
// +k8s:openapi-gen=true
#VMProbeTargets: {
	// StaticConfig defines static targets which are considers for probing.
	// More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#static_config.
	staticConfig?: null | #VMProbeTargetStaticConfig @go(StaticConfig,*VMProbeTargetStaticConfig)

	// Ingress defines the set of dynamically discovered ingress objects which hosts are considered for probing.
	ingress?: null | #ProbeTargetIngress @go(Ingress,*ProbeTargetIngress)
}

// VMProbeTargetStaticConfig defines the set of static targets considered for probing.
// +k8s:openapi-gen=true
#VMProbeTargetStaticConfig: {
	// Targets is a list of URLs to probe using the configured prober.
	targets: [...string] @go(Targets,[]string)

	// Labels assigned to all metrics scraped from the targets.
	labels?: {[string]: string} @go(Labels,map[string]string)

	// More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
	relabelingConfigs?: [...null | #RelabelConfig] @go(RelabelConfigs,[]*RelabelConfig)
}

// ProbeTargetIngress defines the set of Ingress objects considered for probing.
// +k8s:openapi-gen=true
#ProbeTargetIngress: {
	// Select Ingress objects by labels.
	selector?: metav1.#LabelSelector @go(Selector)

	// Select Ingress objects by namespace.
	namespaceSelector?: #NamespaceSelector @go(NamespaceSelector)

	// RelabelConfigs to apply to samples before ingestion.
	// More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
	relabelingConfigs?: [...null | #RelabelConfig] @go(RelabelConfigs,[]*RelabelConfig)
}

// VMProberSpec contains specification parameters for the Prober used for probing.
// +k8s:openapi-gen=true
#VMProberSpec: {
	// Mandatory URL of the prober.
	url: string @go(URL)

	// HTTP scheme to use for scraping.
	// Defaults to `http`.
	// +optional
	// +kubebuilder:validation:Enum=http;https
	scheme?: string @go(Scheme)

	// Path to collect metrics from.
	// Defaults to `/probe`.
	path?: string @go(Path)
}

// VMProbeStatus defines the observed state of VMProbe
#VMProbeStatus: {
}

// VMProbe defines a probe for targets, that will be executed with prober,
// like blackbox exporter.
// It helps to monitor reachability of target with various checks.
// +kubebuilder:object:root=true
// +kubebuilder:subresource:status
#VMProbe: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #VMProbeSpec       @go(Spec)
	status?:   #VMProbeStatus     @go(Status)
}

// VMProbeList contains a list of VMProbe
// +kubebuilder:object:root=true
#VMProbeList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#VMProbe] @go(Items,[]VMProbe)
}