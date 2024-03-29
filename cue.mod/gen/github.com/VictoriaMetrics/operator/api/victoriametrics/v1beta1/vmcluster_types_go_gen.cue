// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/VictoriaMetrics/operator/api/victoriametrics/v1beta1

package v1beta1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/api/core/v1"
	appsv1 "k8s.io/api/apps/v1"
)

#ClusterStatusExpanding:   "expanding"
#ClusterStatusOperational: "operational"
#ClusterStatusFailed:      "failed"

// VMClusterSpec defines the desired state of VMCluster
// +k8s:openapi-gen=true
#VMClusterSpec: _

// VMCluster is fast, cost-effective and scalable time-series database.
// Cluster version with
// +operator-sdk:gen-csv:customresourcedefinitions.displayName="VMCluster App"
// +operator-sdk:gen-csv:customresourcedefinitions.resources="Deployment,apps"
// +operator-sdk:gen-csv:customresourcedefinitions.resources="Statefulset,apps"
// +operator-sdk:gen-csv:customresourcedefinitions.resources="Service,v1"
// +genclient
// +k8s:openapi-gen=true
// +kubebuilder:subresource:status
// +kubebuilder:resource:path=vmclusters,scope=Namespaced
// +kubebuilder:printcolumn:name="Insert Count",type="string",JSONPath=".spec.vminsert.replicaCount",description="replicas of VMInsert"
// +kubebuilder:printcolumn:name="Storage Count",type="string",JSONPath=".spec.vmstorage.replicaCount",description="replicas of VMStorage"
// +kubebuilder:printcolumn:name="Select Count",type="string",JSONPath=".spec.vmselect.replicaCount",description="replicas of VMSelect"
// +kubebuilder:printcolumn:name="Age",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:printcolumn:name="Status",type="string",JSONPath=".status.clusterStatus",description="Current status of cluster"
// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object
#VMCluster: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #VMClusterSpec     @go(Spec)
	status?:   #VMClusterStatus   @go(Status)
}

// VMClusterStatus defines the observed state of VMCluster
#VMClusterStatus: {
	// Deprecated.
	updateFailCount: int @go(UpdateFailCount)

	// Deprecated.
	lastSync?:     string @go(LastSync)
	clusterStatus: string @go(ClusterStatus)
	reason?:       string @go(Reason)
}

// VMClusterList contains a list of VMCluster
// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object
#VMClusterList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#VMCluster] @go(Items,[]VMCluster)
}

#VMSelect: {
	// Name is deprecated and will be removed at 0.22.0 release
	// +deprecated
	name?: string @go(Name)

	// PodMetadata configures Labels and Annotations which are propagated to the VMSelect pods.
	podMetadata?: null | #EmbeddedObjectMetadata @go(PodMetadata,*EmbeddedObjectMetadata)

	// Image - docker image settings for VMSelect
	// +optional
	image?: #Image @go(Image)

	// Secrets is a list of Secrets in the same namespace as the VMSelect
	// object, which shall be mounted into the VMSelect Pods.
	// The Secrets are mounted into /etc/vm/secrets/<secret-name>.
	// +optional
	secrets?: [...string] @go(Secrets,[]string)

	// ConfigMaps is a list of ConfigMaps in the same namespace as the VMSelect
	// object, which shall be mounted into the VMSelect Pods.
	// The ConfigMaps are mounted into /etc/vm/configs/<configmap-name>.
	// +optional
	configMaps?: [...string] @go(ConfigMaps,[]string)

	// LogFormat for VMSelect to be configured with.
	// default or json
	// +optional
	// +kubebuilder:validation:Enum=default;json
	logFormat?: string @go(LogFormat)

	// LogLevel for VMSelect to be configured with.
	// +optional
	// +kubebuilder:validation:Enum=INFO;WARN;ERROR;FATAL;PANIC
	logLevel?: string @go(LogLevel)

	// ReplicaCount is the expected size of the VMSelect cluster. The controller will
	// eventually make the size of the running cluster equal to the expected
	// size.
	// +operator-sdk:csv:customresourcedefinitions:type=spec,displayName="Number of pods",xDescriptors="urn:alm:descriptor:com.tectonic.ui:podCount,urn:alm:descriptor:io.kubernetes:custom"
	replicaCount?: null | int32 @go(ReplicaCount,*int32)

	// Volumes allows configuration of additional volumes on the output Deployment definition.
	// Volumes specified will be appended to other volumes that are generated as a result of
	// StorageSpec objects.
	// +optional
	volumes?: [...v1.#Volume] @go(Volumes,[]v1.Volume)

	// VolumeMounts allows configuration of additional VolumeMounts on the output Deployment definition.
	// VolumeMounts specified will be appended to other VolumeMounts in the VMSelect container,
	// that are generated as a result of StorageSpec objects.
	// +optional
	volumeMounts?: [...v1.#VolumeMount] @go(VolumeMounts,[]v1.VolumeMount)

	// Resources container resource request and limits, https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
	// +operator-sdk:csv:customresourcedefinitions:type=spec,displayName="Resources",xDescriptors="urn:alm:descriptor:com.tectonic.ui:resourceRequirements"
	// +optional
	resources?: v1.#ResourceRequirements @go(Resources)

	// Affinity If specified, the pod's scheduling constraints.
	// +optional
	affinity?: null | v1.#Affinity @go(Affinity,*v1.Affinity)

	// Tolerations If specified, the pod's tolerations.
	// +optional
	tolerations?: [...v1.#Toleration] @go(Tolerations,[]v1.Toleration)

	// SecurityContext holds pod-level security attributes and common container settings.
	// This defaults to the default PodSecurityContext.
	// +optional
	securityContext?: null | v1.#PodSecurityContext @go(SecurityContext,*v1.PodSecurityContext)

	// Containers property allows to inject additions sidecars or to patch existing containers.
	// It can be useful for proxies, backup, etc.
	// +optional
	containers?: [...v1.#Container] @go(Containers,[]v1.Container)

	// InitContainers allows adding initContainers to the pod definition. Those can be used to e.g.
	// fetch secrets for injection into the VMSelect configuration from external sources. Any
	// errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
	// Using initContainers for any use case other then secret fetching is entirely outside the scope
	// of what the maintainers will support and by doing so, you accept that this behaviour may break
	// at any time without notice.
	// +optional
	initContainers?: [...v1.#Container] @go(InitContainers,[]v1.Container)

	// Priority class assigned to the Pods
	// +optional
	priorityClassName?: string @go(PriorityClassName)

	// HostNetwork controls whether the pod may use the node network namespace
	// +optional
	hostNetwork?: bool @go(HostNetwork)

	// DNSPolicy sets DNS policy for the pod
	// +optional
	dnsPolicy?: v1.#DNSPolicy @go(DNSPolicy)

	// Specifies the DNS parameters of a pod.
	// Parameters specified here will be merged to the generated DNS
	// configuration based on DNSPolicy.
	// +optional
	dnsConfig?: null | v1.#PodDNSConfig @go(DNSConfig,*v1.PodDNSConfig)

	// TopologySpreadConstraints embedded kubernetes pod configuration option,
	// controls how pods are spread across your cluster among failure-domains
	// such as regions, zones, nodes, and other user-defined topology domains
	// https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/
	// +optional
	topologySpreadConstraints?: [...v1.#TopologySpreadConstraint] @go(TopologySpreadConstraints,[]v1.TopologySpreadConstraint)

	// CacheMountPath allows to add cache persistent for VMSelect,
	// will use "/cache" as default if not specified.
	// +optional
	cacheMountPath?: string @go(CacheMountPath)

	// Storage - add persistent volume for cacheMounthPath
	// its useful for persistent cache
	// use storage instead of persistentVolume.
	// +deprecated
	// +optional
	persistentVolume?: null | #StorageSpec @go(Storage,*StorageSpec)

	// StorageSpec - add persistent volume claim for cacheMountPath
	// its needed for persistent cache
	// +optional
	storage?: null | #StorageSpec @go(StorageSpec,*StorageSpec)

	// ExtraEnvs that will be added to VMSelect pod
	// +optional
	extraEnvs?: [...v1.#EnvVar] @go(ExtraEnvs,[]v1.EnvVar)

	// +optional
	extraArgs?: {[string]: string} @go(ExtraArgs,map[string]string)

	// Port listen port
	// +optional
	port?: string @go(Port)

	// ClusterNativePort for multi-level cluster setup.
	// More details: https://docs.victoriametrics.com/Cluster-VictoriaMetrics.html#multi-level-cluster-setup
	// +optional
	clusterNativeListenPort?: string @go(ClusterNativePort)

	// SchedulerName - defines kubernetes scheduler name
	// +optional
	schedulerName?: string @go(SchedulerName)

	// RuntimeClassName - defines runtime class for kubernetes pod.
	// https://kubernetes.io/docs/concepts/containers/runtime-class/
	// +optional
	runtimeClassName?: null | string @go(RuntimeClassName,*string)

	// ServiceSpec that will be added to vmselect service spec
	// +optional
	serviceSpec?: null | #ServiceSpec @go(ServiceSpec,*ServiceSpec)

	// ServiceScrapeSpec that will be added to vmselect VMServiceScrape spec
	// +optional
	serviceScrapeSpec?: null | #VMServiceScrapeSpec @go(ServiceScrapeSpec,*VMServiceScrapeSpec)

	// PodDisruptionBudget created by operator
	// +optional
	podDisruptionBudget?: null | #EmbeddedPodDisruptionBudgetSpec @go(PodDisruptionBudget,*EmbeddedPodDisruptionBudgetSpec)

	#EmbeddedProbes

	// Configures horizontal pod autoscaling.
	// Note, enabling this option disables vmselect to vmselect communication. In most cases it's not an issue.
	// +optional
	hpa?: null | #EmbeddedHPA @go(HPA,*EmbeddedHPA)

	// NodeSelector Define which Nodes the Pods are scheduled on.
	// +optional
	nodeSelector?: {[string]: string} @go(NodeSelector,map[string]string)

	// RollingUpdateStrategy defines strategy for application updates
	// Default is OnDelete, in this case operator handles update process
	// Can be changed for RollingUpdate
	// +optional
	rollingUpdateStrategy?: appsv1.#StatefulSetUpdateStrategyType @go(RollingUpdateStrategy)

	// TerminationGracePeriodSeconds period for container graceful termination
	// +optional
	terminationGracePeriodSeconds?: null | int64 @go(TerminationGracePeriodSeconds,*int64)

	// ReadinessGates defines pod readiness gates
	readinessGates?: [...v1.#PodReadinessGate] @go(ReadinessGates,[]v1.PodReadinessGate)

	// ClaimTemplates allows adding additional VolumeClaimTemplates for StatefulSet
	claimTemplates?: [...v1.#PersistentVolumeClaim] @go(ClaimTemplates,[]v1.PersistentVolumeClaim)
}

#InsertPorts: {
	// GraphitePort listen port
	// +optional
	graphitePort?: string @go(GraphitePort)

	// InfluxPort listen port
	// +optional
	influxPort?: string @go(InfluxPort)

	// OpenTSDBHTTPPort for http connections.
	// +optional
	openTSDBHTTPPort?: string @go(OpenTSDBHTTPPort)

	// OpenTSDBPort for tcp and udp listen
	// +optional
	openTSDBPort?: string @go(OpenTSDBPort)
}

#VMInsert: {
	// Name is deprecated and will be removed at 0.22.0 release
	// +deprecated
	// +optional
	name?: string @go(Name)

	// PodMetadata configures Labels and Annotations which are propagated to the VMSelect pods.
	podMetadata?: null | #EmbeddedObjectMetadata @go(PodMetadata,*EmbeddedObjectMetadata)

	// Image - docker image settings for VMInsert
	// +optional
	image?: #Image @go(Image)

	// Secrets is a list of Secrets in the same namespace as the VMSelect
	// object, which shall be mounted into the VMSelect Pods.
	// The Secrets are mounted into /etc/vm/secrets/<secret-name>.
	// +optional
	secrets?: [...string] @go(Secrets,[]string)

	// ConfigMaps is a list of ConfigMaps in the same namespace as the VMSelect
	// object, which shall be mounted into the VMSelect Pods.
	// The ConfigMaps are mounted into /etc/vm/configs/<configmap-name>.
	// +optional
	configMaps?: [...string] @go(ConfigMaps,[]string)

	// LogFormat for VMSelect to be configured with.
	// default or json
	// +optional
	// +kubebuilder:validation:Enum=default;json
	logFormat?: string @go(LogFormat)

	// LogLevel for VMSelect to be configured with.
	// +optional
	// +kubebuilder:validation:Enum=INFO;WARN;ERROR;FATAL;PANIC
	logLevel?: string @go(LogLevel)

	// ReplicaCount is the expected size of the VMInsert cluster. The controller will
	// eventually make the size of the running cluster equal to the expected
	// size.
	// +operator-sdk:csv:customresourcedefinitions:type=spec,displayName="Number of pods",xDescriptors="urn:alm:descriptor:com.tectonic.ui:podCount,urn:alm:descriptor:io.kubernetes:custom"
	replicaCount?: null | int32 @go(ReplicaCount,*int32)

	// Volumes allows configuration of additional volumes on the output Deployment definition.
	// Volumes specified will be appended to other volumes that are generated as a result of
	// StorageSpec objects.
	// +optional
	volumes?: [...v1.#Volume] @go(Volumes,[]v1.Volume)

	// VolumeMounts allows configuration of additional VolumeMounts on the output Deployment definition.
	// VolumeMounts specified will be appended to other VolumeMounts in the VMSelect container,
	// that are generated as a result of StorageSpec objects.
	// +optional
	volumeMounts?: [...v1.#VolumeMount] @go(VolumeMounts,[]v1.VolumeMount)

	// Resources container resource request and limits, https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
	// +operator-sdk:csv:customresourcedefinitions:type=spec,displayName="Resources",xDescriptors="urn:alm:descriptor:com.tectonic.ui:resourceRequirements"
	// +optional
	resources?: v1.#ResourceRequirements @go(Resources)

	// Affinity If specified, the pod's scheduling constraints.
	// +optional
	affinity?: null | v1.#Affinity @go(Affinity,*v1.Affinity)

	// Tolerations If specified, the pod's tolerations.
	// +optional
	tolerations?: [...v1.#Toleration] @go(Tolerations,[]v1.Toleration)

	// SecurityContext holds pod-level security attributes and common container settings.
	// This defaults to the default PodSecurityContext.
	// +optional
	securityContext?: null | v1.#PodSecurityContext @go(SecurityContext,*v1.PodSecurityContext)

	// Containers property allows to inject additions sidecars or to patch existing containers.
	// It can be useful for proxies, backup, etc.
	// +optional
	containers?: [...v1.#Container] @go(Containers,[]v1.Container)

	// InitContainers allows adding initContainers to the pod definition. Those can be used to e.g.
	// fetch secrets for injection into the VMSelect configuration from external sources. Any
	// errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
	// Using initContainers for any use case other then secret fetching is entirely outside the scope
	// of what the maintainers will support and by doing so, you accept that this behaviour may break
	// at any time without notice.
	// +optional
	initContainers?: [...v1.#Container] @go(InitContainers,[]v1.Container)

	// Priority class assigned to the Pods
	// +optional
	priorityClassName?: string @go(PriorityClassName)

	// HostNetwork controls whether the pod may use the node network namespace
	// +optional
	hostNetwork?: bool @go(HostNetwork)

	// DNSPolicy sets DNS policy for the pod
	// +optional
	dnsPolicy?: v1.#DNSPolicy @go(DNSPolicy)

	// Specifies the DNS parameters of a pod.
	// Parameters specified here will be merged to the generated DNS
	// configuration based on DNSPolicy.
	// +optional
	dnsConfig?: null | v1.#PodDNSConfig @go(DNSConfig,*v1.PodDNSConfig)

	// TopologySpreadConstraints embedded kubernetes pod configuration option,
	// controls how pods are spread across your cluster among failure-domains
	// such as regions, zones, nodes, and other user-defined topology domains
	// https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/
	// +optional
	topologySpreadConstraints?: [...v1.#TopologySpreadConstraint] @go(TopologySpreadConstraints,[]v1.TopologySpreadConstraint)

	// +optional
	extraArgs?: {[string]: string} @go(ExtraArgs,map[string]string)

	// InsertPorts - additional listen ports for data ingestion.
	insertPorts?: null | #InsertPorts @go(InsertPorts,*InsertPorts)

	// Port listen port
	// +optional
	port?: string @go(Port)

	// ClusterNativePort for multi-level cluster setup.
	// More details: https://docs.victoriametrics.com/Cluster-VictoriaMetrics.html#multi-level-cluster-setup
	// +optional
	clusterNativeListenPort?: string @go(ClusterNativePort)

	// SchedulerName - defines kubernetes scheduler name
	// +optional
	schedulerName?: string @go(SchedulerName)

	// RuntimeClassName - defines runtime class for kubernetes pod.
	// https://kubernetes.io/docs/concepts/containers/runtime-class/
	// +optional
	runtimeClassName?: null | string @go(RuntimeClassName,*string)

	// ExtraEnvs that will be added to VMSelect pod
	// +optional
	extraEnvs?: [...v1.#EnvVar] @go(ExtraEnvs,[]v1.EnvVar)

	// ServiceSpec that will be added to vminsert service spec
	// +optional
	serviceSpec?: null | #ServiceSpec @go(ServiceSpec,*ServiceSpec)

	// ServiceScrapeSpec that will be added to vminsert VMServiceScrape spec
	// +optional
	serviceScrapeSpec?: null | #VMServiceScrapeSpec @go(ServiceScrapeSpec,*VMServiceScrapeSpec)

	// UpdateStrategy - overrides default update strategy.
	// +kubebuilder:validation:Enum=Recreate;RollingUpdate
	// +optional
	updateStrategy?: null | appsv1.#DeploymentStrategyType @go(UpdateStrategy,*appsv1.DeploymentStrategyType)

	// RollingUpdate - overrides deployment update params.
	// +optional
	rollingUpdate?: null | appsv1.#RollingUpdateDeployment @go(RollingUpdate,*appsv1.RollingUpdateDeployment)

	// PodDisruptionBudget created by operator
	// +optional
	podDisruptionBudget?: null | #EmbeddedPodDisruptionBudgetSpec @go(PodDisruptionBudget,*EmbeddedPodDisruptionBudgetSpec)

	#EmbeddedProbes

	// HPA defines kubernetes PodAutoScaling configuration version 2.
	hpa?: null | #EmbeddedHPA @go(HPA,*EmbeddedHPA)

	// NodeSelector Define which Nodes the Pods are scheduled on.
	// +optional
	nodeSelector?: {[string]: string} @go(NodeSelector,map[string]string)

	// TerminationGracePeriodSeconds period for container graceful termination
	// +optional
	terminationGracePeriodSeconds?: null | int64 @go(TerminationGracePeriodSeconds,*int64)

	// ReadinessGates defines pod readiness gates
	readinessGates?: [...v1.#PodReadinessGate] @go(ReadinessGates,[]v1.PodReadinessGate)
}

#VMStorage: {
	// Name is deprecated and will be removed at 0.22.0 release
	// +deprecated
	// +optional
	name?: string @go(Name)

	// PodMetadata configures Labels and Annotations which are propagated to the VMSelect pods.
	podMetadata?: null | #EmbeddedObjectMetadata @go(PodMetadata,*EmbeddedObjectMetadata)

	// Image - docker image settings for VMStorage
	// +optional
	image?: #Image @go(Image)

	// Secrets is a list of Secrets in the same namespace as the VMSelect
	// object, which shall be mounted into the VMSelect Pods.
	// The Secrets are mounted into /etc/vm/secrets/<secret-name>.
	// +optional
	secrets?: [...string] @go(Secrets,[]string)

	// ConfigMaps is a list of ConfigMaps in the same namespace as the VMSelect
	// object, which shall be mounted into the VMSelect Pods.
	// The ConfigMaps are mounted into /etc/vm/configs/<configmap-name>.
	// +optional
	configMaps?: [...string] @go(ConfigMaps,[]string)

	// LogFormat for VMSelect to be configured with.
	// default or json
	// +optional
	// +kubebuilder:validation:Enum=default;json
	logFormat?: string @go(LogFormat)

	// LogLevel for VMSelect to be configured with.
	// +optional
	// +kubebuilder:validation:Enum=INFO;WARN;ERROR;FATAL;PANIC
	logLevel?: string @go(LogLevel)

	// ReplicaCount is the expected size of the VMStorage cluster. The controller will
	// eventually make the size of the running cluster equal to the expected
	// size.
	// +operator-sdk:csv:customresourcedefinitions:type=spec,displayName="Number of pods",xDescriptors="urn:alm:descriptor:com.tectonic.ui:podCount,urn:alm:descriptor:io.kubernetes:custom"
	replicaCount?: null | int32 @go(ReplicaCount,*int32)

	// Volumes allows configuration of additional volumes on the output Deployment definition.
	// Volumes specified will be appended to other volumes that are generated as a result of
	// StorageSpec objects.
	// +optional
	volumes?: [...v1.#Volume] @go(Volumes,[]v1.Volume)

	// VolumeMounts allows configuration of additional VolumeMounts on the output Deployment definition.
	// VolumeMounts specified will be appended to other VolumeMounts in the VMSelect container,
	// that are generated as a result of StorageSpec objects.
	// +optional
	volumeMounts?: [...v1.#VolumeMount] @go(VolumeMounts,[]v1.VolumeMount)

	// Resources container resource request and limits, https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
	// +operator-sdk:csv:customresourcedefinitions:type=spec,displayName="Resources",xDescriptors="urn:alm:descriptor:com.tectonic.ui:resourceRequirements"
	// +optional
	resources?: v1.#ResourceRequirements @go(Resources)

	// Affinity If specified, the pod's scheduling constraints.
	// +optional
	affinity?: null | v1.#Affinity @go(Affinity,*v1.Affinity)

	// Tolerations If specified, the pod's tolerations.
	// +optional
	tolerations?: [...v1.#Toleration] @go(Tolerations,[]v1.Toleration)

	// SecurityContext holds pod-level security attributes and common container settings.
	// This defaults to the default PodSecurityContext.
	// +optional
	securityContext?: null | v1.#PodSecurityContext @go(SecurityContext,*v1.PodSecurityContext)

	// Containers property allows to inject additions sidecars or to patch existing containers.
	// It can be useful for proxies, backup, etc.
	// +optional
	containers?: [...v1.#Container] @go(Containers,[]v1.Container)

	// InitContainers allows adding initContainers to the pod definition. Those can be used to e.g.
	// fetch secrets for injection into the VMSelect configuration from external sources. Any
	// errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
	// Using initContainers for any use case other then secret fetching is entirely outside the scope
	// of what the maintainers will support and by doing so, you accept that this behaviour may break
	// at any time without notice.
	// +optional
	initContainers?: [...v1.#Container] @go(InitContainers,[]v1.Container)

	// Priority class assigned to the Pods
	// +optional
	priorityClassName?: string @go(PriorityClassName)

	// HostNetwork controls whether the pod may use the node network namespace
	// +optional
	hostNetwork?: bool @go(HostNetwork)

	// DNSPolicy sets DNS policy for the pod
	// +optional
	dnsPolicy?: v1.#DNSPolicy @go(DNSPolicy)

	// Specifies the DNS parameters of a pod.
	// Parameters specified here will be merged to the generated DNS
	// configuration based on DNSPolicy.
	// +optional
	dnsConfig?: null | v1.#PodDNSConfig @go(DNSConfig,*v1.PodDNSConfig)

	// TopologySpreadConstraints embedded kubernetes pod configuration option,
	// controls how pods are spread across your cluster among failure-domains
	// such as regions, zones, nodes, and other user-defined topology domains
	// https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/
	// +optional
	topologySpreadConstraints?: [...v1.#TopologySpreadConstraint] @go(TopologySpreadConstraints,[]v1.TopologySpreadConstraint)

	// StorageDataPath - path to storage data
	// +optional
	storageDataPath?: string @go(StorageDataPath)

	// Storage - add persistent volume for StorageDataPath
	// its useful for persistent cache
	// +optional
	storage?: null | #StorageSpec @go(Storage,*StorageSpec)

	// TerminationGracePeriodSeconds period for container graceful termination
	// +optional
	terminationGracePeriodSeconds?: int64 @go(TerminationGracePeriodSeconds)

	// SchedulerName - defines kubernetes scheduler name
	// +optional
	schedulerName?: string @go(SchedulerName)

	// RuntimeClassName - defines runtime class for kubernetes pod.
	// https://kubernetes.io/docs/concepts/containers/runtime-class/
	// +optional
	runtimeClassName?: null | string @go(RuntimeClassName,*string)

	// Port for health check connetions
	port?: string @go(Port)

	// VMInsertPort for VMInsert connections
	// +optional
	vmInsertPort?: string @go(VMInsertPort)

	// VMSelectPort for VMSelect connections
	// +optional
	vmSelectPort?: string @go(VMSelectPort)

	// VMBackup configuration for backup
	// +optional
	vmBackup?: null | #VMBackup @go(VMBackup,*VMBackup)

	// +optional
	extraArgs?: {[string]: string} @go(ExtraArgs,map[string]string)

	// ExtraEnvs that will be added to VMSelect pod
	// +optional
	extraEnvs?: [...v1.#EnvVar] @go(ExtraEnvs,[]v1.EnvVar)

	// ServiceSpec that will be create additional service for vmstorage
	// +optional
	serviceSpec?: null | #ServiceSpec @go(ServiceSpec,*ServiceSpec)

	// ServiceScrapeSpec that will be added to vmstorage VMServiceScrape spec
	// +optional
	serviceScrapeSpec?: null | #VMServiceScrapeSpec @go(ServiceScrapeSpec,*VMServiceScrapeSpec)

	// PodDisruptionBudget created by operator
	// +optional
	podDisruptionBudget?: null | #EmbeddedPodDisruptionBudgetSpec @go(PodDisruptionBudget,*EmbeddedPodDisruptionBudgetSpec)

	#EmbeddedProbes

	// MaintenanceInsertNodeIDs - excludes given node ids from insert requests routing, must contain pod suffixes - for pod-0, id will be 0 and etc.
	// lets say, you have pod-0, pod-1, pod-2, pod-3. to exclude pod-0 and pod-3 from insert routing, define nodeIDs: [0,3].
	// Useful at storage expanding, when you want to rebalance some data at cluster.
	// +optional
	maintenanceInsertNodeIDs?: [...int32] @go(MaintenanceInsertNodeIDs,[]int32)

	// MaintenanceInsertNodeIDs - excludes given node ids from select requests routing, must contain pod suffixes - for pod-0, id will be 0 and etc.
	maintenanceSelectNodeIDs?: [...int32] @go(MaintenanceSelectNodeIDs,[]int32)

	// NodeSelector Define which Nodes the Pods are scheduled on.
	// +optional
	nodeSelector?: {[string]: string} @go(NodeSelector,map[string]string)

	// RollingUpdateStrategy defines strategy for application updates
	// Default is OnDelete, in this case operator handles update process
	// Can be changed for RollingUpdate
	// +optional
	rollingUpdateStrategy?: appsv1.#StatefulSetUpdateStrategyType @go(RollingUpdateStrategy)

	// ReadinessGates defines pod readiness gates
	readinessGates?: [...v1.#PodReadinessGate] @go(ReadinessGates,[]v1.PodReadinessGate)

	// ClaimTemplates allows adding additional VolumeClaimTemplates for StatefulSet
	claimTemplates?: [...v1.#PersistentVolumeClaim] @go(ClaimTemplates,[]v1.PersistentVolumeClaim)
}

#VMBackup: {
	// AcceptEULA accepts enterprise feature usage, must be set to true.
	// otherwise backupmanager cannot be added to single/cluster version.
	// https://victoriametrics.com/legal/esa/
	// +optional
	acceptEULA: bool @go(AcceptEULA)

	// SnapshotCreateURL overwrites url for snapshot create
	// +optional
	snapshotCreateURL?: string @go(SnapshotCreateURL)

	// SnapShotDeleteURL overwrites url for snapshot delete
	// +optional
	snapshotDeleteURL?: string @go(SnapShotDeleteURL)

	// Defines number of concurrent workers. Higher concurrency may reduce backup duration (default 10)
	// +optional
	concurrency?: null | int32 @go(Concurrency,*int32)

	// Defines destination for backup
	destination?: string @go(Destination)

	// DestinationDisableSuffixAdd - disables suffix adding for cluster version backups
	// each vmstorage backup must have unique backup folder
	// so operator adds POD_NAME as suffix for backup destination folder.
	// +optional
	destinationDisableSuffixAdd?: bool @go(DestinationDisableSuffixAdd)

	// Custom S3 endpoint for use with S3-compatible storages (e.g. MinIO). S3 is used if not set
	// +optional
	customS3Endpoint?: null | string @go(CustomS3Endpoint,*string)

	// CredentialsSecret is secret in the same namespace for access to remote storage
	// The secret is mounted into /etc/vm/creds.
	// +optional
	credentialsSecret?: null | v1.#SecretKeySelector @go(CredentialsSecret,*v1.SecretKeySelector)

	// Defines if hourly backups disabled (default false)
	// +optional
	disableHourly?: null | bool @go(DisableHourly,*bool)

	// Defines if daily backups disabled (default false)
	// +optional
	disableDaily?: null | bool @go(DisableDaily,*bool)

	// Defines if weekly backups disabled (default false)
	// +optional
	disableWeekly?: null | bool @go(DisableWeekly,*bool)

	// Defines if monthly backups disabled (default false)
	// +optional
	disableMonthly?: null | bool @go(DisableMonthly,*bool)

	// Image - docker image settings for VMBackuper
	// +optional
	image?: #Image @go(Image)

	// Port for health check connections
	port?: string @go(Port)

	// LogFormat for VMSelect to be configured with.
	// default or json
	// +optional
	// +kubebuilder:validation:Enum=default;json
	logFormat?: null | string @go(LogFormat,*string)

	// LogLevel for VMSelect to be configured with.
	// +optional
	// +kubebuilder:validation:Enum=INFO;WARN;ERROR;FATAL;PANIC
	logLevel?: null | string @go(LogLevel,*string)

	// Resources container resource request and limits, https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
	// if not defined default resources from operator config will be used
	// +optional
	resources?: v1.#ResourceRequirements @go(Resources)

	// extra args like maxBytesPerSecond default 0
	// +optional
	extraArgs?: {[string]: string} @go(ExtraArgs,map[string]string)

	// +optional
	extraEnvs?: [...v1.#EnvVar] @go(ExtraEnvs,[]v1.EnvVar)

	// VolumeMounts allows configuration of additional VolumeMounts on the output Deployment definition.
	// VolumeMounts specified will be appended to other VolumeMounts in the vmbackupmanager container,
	// that are generated as a result of StorageSpec objects.
	// +optional
	volumeMounts?: [...v1.#VolumeMount] @go(VolumeMounts,[]v1.VolumeMount)

	// Restore Allows to enable restore options for pod
	// Read more: https://docs.victoriametrics.com/vmbackupmanager.html#restore-commands
	// +optional
	restore?: null | #VMRestore @go(Restore,*VMRestore)
}

#VMRestore: {
	// OnStart defines configuration for restore on pod start
	// +optional
	onStart?: null | #VMRestoreOnStartConfig @go(OnStart,*VMRestoreOnStartConfig)
}

#VMRestoreOnStartConfig: {
	// Enabled defines if restore on start enabled
	// +optional
	enabled?: bool @go(Enabled)
}

// Image defines docker image settings
#Image: {
	// Repository contains name of docker image + it's repository if needed
	repository?: string @go(Repository)

	// Tag contains desired docker image version
	tag?: string @go(Tag)

	// PullPolicy describes how to pull docker image
	pullPolicy?: v1.#PullPolicy @go(PullPolicy)
}
