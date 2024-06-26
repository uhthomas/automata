// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-operator/v5/api/v1beta1

package v1beta1

import (
	"k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DashboardSourceType: string // #enumDashboardSourceType

#enumDashboardSourceType:
	#DashboardSourceTypeRawJson |
	#DashboardSourceTypeGzipJson |
	#DashboardSourceJsonnetProject |
	#DashboardSourceTypeUrl |
	#DashboardSourceTypeJsonnet |
	#DashboardSourceTypeGrafanaCom |
	#DashboardSourceConfigMap

#DashboardSourceTypeRawJson:    #DashboardSourceType & "json"
#DashboardSourceTypeGzipJson:   #DashboardSourceType & "gzipJson"
#DashboardSourceJsonnetProject: #DashboardSourceType & "jsonnetProjectWithRuntimeRaw"
#DashboardSourceTypeUrl:        #DashboardSourceType & "url"
#DashboardSourceTypeJsonnet:    #DashboardSourceType & "jsonnet"
#DashboardSourceTypeGrafanaCom: #DashboardSourceType & "grafana"
#DashboardSourceConfigMap:      #DashboardSourceType & "configmap"
#DefaultResyncPeriod:           "5m"

#GrafanaDashboardDatasource: {
	inputName:      string @go(InputName)
	datasourceName: string @go(DatasourceName)
}

// GrafanaDashboardSpec defines the desired state of GrafanaDashboard
#GrafanaDashboardSpec: {
	// dashboard json
	// +optional
	json?: string @go(Json)

	// GzipJson the dashboard's JSON compressed with Gzip. Base64-encoded when in YAML.
	// +optional
	gzipJson?: bytes @go(GzipJson,[]byte)

	// dashboard url
	// +optional
	url?: string @go(Url)

	// Jsonnet
	// +optional
	jsonnet?: string @go(Jsonnet)

	// Jsonnet project build
	jsonnetLib?: null | #JsonnetProjectBuild @go(JsonnetProjectBuild,*JsonnetProjectBuild)

	// grafana.com/dashboards
	// +optional
	grafanaCom?: null | #GrafanaComDashboardReference @go(GrafanaCom,*GrafanaComDashboardReference)

	// dashboard from configmap
	// +optional
	configMapRef?: null | v1.#ConfigMapKeySelector @go(ConfigMapRef,*v1.ConfigMapKeySelector)

	// selects Grafanas for import
	instanceSelector?: null | metav1.#LabelSelector @go(InstanceSelector,*metav1.LabelSelector)

	// folder assignment for dashboard
	// +optional
	folder?: string @go(FolderTitle)

	// plugins
	// +optional
	plugins?: #PluginList @go(Plugins)

	// Cache duration for dashboards fetched from URLs
	// +optional
	contentCacheDuration?: metav1.#Duration @go(ContentCacheDuration)

	// how often the dashboard is refreshed, defaults to 5m if not set
	// +optional
	resyncPeriod?: string @go(ResyncPeriod)

	// maps required data sources to existing ones
	// +optional
	datasources?: [...#GrafanaDashboardDatasource] @go(Datasources,[]GrafanaDashboardDatasource)

	// allow to import this resources from an operator in a different namespace
	// +optional
	allowCrossNamespaceImport?: null | bool @go(AllowCrossNamespaceImport,*bool)

	// environments variables as a map
	// +optional
	envs?: [...#GrafanaDashboardEnv] @go(Envs,[]GrafanaDashboardEnv)

	// environments variables from secrets or config maps
	// +optional
	envFrom?: [...#GrafanaDashboardEnvFromSource] @go(EnvsFrom,[]GrafanaDashboardEnvFromSource)
}

#GrafanaDashboardEnv: {
	name: string @go(Name)

	// Inline evn value
	// +optional
	value?: string @go(Value)

	// Reference on value source, might be the reference on a secret or config map
	// +optional
	valueFrom?: #GrafanaDashboardEnvFromSource @go(ValueFrom)
}

#GrafanaDashboardEnvFromSource: {
	// Selects a key of a ConfigMap.
	// +optional
	configMapKeyRef?: null | v1.#ConfigMapKeySelector @go(ConfigMapKeyRef,*v1.ConfigMapKeySelector)

	// Selects a key of a Secret.
	// +optional
	secretKeyRef?: null | v1.#SecretKeySelector @go(SecretKeyRef,*v1.SecretKeySelector)
}

#JsonnetProjectBuild: {
	jPath?: [...string] @go(JPath,[]string)
	fileName:           string @go(FileName)
	gzipJsonnetProject: bytes  @go(GzipJsonnetProject,[]byte)
}

// GrafanaComDashbooardReference is a reference to a dashboard on grafana.com/dashboards
#GrafanaComDashboardReference: {
	id:        int        @go(Id)
	revision?: null | int @go(Revision,*int)
}

// GrafanaDashboardStatus defines the observed state of GrafanaDashboard
#GrafanaDashboardStatus: {
	contentCache?:     bytes        @go(ContentCache,[]byte)
	contentTimestamp?: metav1.#Time @go(ContentTimestamp)
	contentUrl?:       string       @go(ContentUrl)
	hash?:             string       @go(Hash)

	// The dashboard instanceSelector can't find matching grafana instances
	NoMatchingInstances?: bool

	// Last time the dashboard was resynced
	lastResync?: metav1.#Time @go(LastResync)
	uid?:        string       @go(UID)
}

// GrafanaDashboard is the Schema for the grafanadashboards API
// +kubebuilder:printcolumn:name="No matching instances",type="boolean",JSONPath=".status.NoMatchingInstances",description=""
// +kubebuilder:printcolumn:name="Last resync",type="date",format="date-time",JSONPath=".status.lastResync",description=""
// +kubebuilder:printcolumn:name="Age",type="date",JSONPath=".metadata.creationTimestamp",description=""
#GrafanaDashboard: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta      @go(ObjectMeta)
	spec?:     #GrafanaDashboardSpec   @go(Spec)
	status?:   #GrafanaDashboardStatus @go(Status)
}

// GrafanaDashboardList contains a list of GrafanaDashboard
#GrafanaDashboardList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#GrafanaDashboard] @go(Items,[]GrafanaDashboard)
}
