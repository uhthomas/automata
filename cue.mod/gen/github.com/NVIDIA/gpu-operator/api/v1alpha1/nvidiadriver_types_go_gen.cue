// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/NVIDIA/gpu-operator/api/v1alpha1

package v1alpha1

import (
	corev1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#NVIDIADriverCRDName: "NVIDIADriver"

// NVIDIADriverSpec defines the desired state of NVIDIADriver
#NVIDIADriverSpec: {
	// +kubebuilder:validation:Enum=gpu;vgpu;vgpu-host-manager
	// +kubebuilder:default=gpu
	// +kubebuilder:validation:XValidation:rule="self == oldSelf",message="driverType is an immutable field. Please create a new NvidiaDriver resource instead when you want to change this setting."
	driverType: #DriverType @go(DriverType)

	// UsePrecompiled indicates if deployment of NVIDIA Driver using pre-compiled modules is enabled
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Enable NVIDIA Driver deployment using pre-compiled modules"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:booleanSwitch"
	// +kubebuilder:validation:XValidation:rule="self == oldSelf",message="usePrecompiled is an immutable field. Please create a new NvidiaDriver resource instead when you want to change this setting."
	usePrecompiled?: null | bool @go(UsePrecompiled,*bool)

	// UseOpenKernelModules indicates if the open GPU kernel modules should be used
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Enable use of open GPU kernel modules"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:booleanSwitch"
	useOpenKernelModules?: null | bool @go(UseOpenKernelModules,*bool)

	// NVIDIA Driver container startup probe settings
	startupProbe?: null | #ContainerProbeSpec @go(StartupProbe,*ContainerProbeSpec)

	// NVIDIA Driver container liveness probe settings
	livenessProbe?: null | #ContainerProbeSpec @go(LivenessProbe,*ContainerProbeSpec)

	// NVIDIA Driver container readiness probe settings
	readinessProbe?: null | #ContainerProbeSpec @go(ReadinessProbe,*ContainerProbeSpec)

	// GPUDirectRDMA defines the spec for NVIDIA Peer Memory driver
	rdma?: null | #GPUDirectRDMASpec @go(GPUDirectRDMA,*GPUDirectRDMASpec)

	// GPUDirectStorage defines the spec for GDS driver
	gds?: null | #GPUDirectStorageSpec @go(GPUDirectStorage,*GPUDirectStorageSpec)

	// NVIDIA Driver repository
	// +kubebuilder:validation:Optional
	repository?: string @go(Repository)

	// NVIDIA Driver container image name
	// +kubebuilder:default=nvcr.io/nvidia/driver
	image: string @go(Image)

	// NVIDIA Driver version (or just branch for precompiled drivers)
	// +kubebuilder:validation:Optional
	version?: string @go(Version)

	// Image pull policy
	// +kubebuilder:validation:Optional
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Image Pull Policy"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:imagePullPolicy"
	imagePullPolicy?: string @go(ImagePullPolicy)

	// Image pull secrets
	// +kubebuilder:validation:Optional
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Image pull secrets"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:io.kubernetes:Secret"
	imagePullSecrets?: [...string] @go(ImagePullSecrets,[]string)

	// Manager represents configuration for NVIDIA Driver Manager initContainer
	manager?: #DriverManagerSpec @go(Manager)

	// Optional: Define resources requests and limits for each pod
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Resource Requirements"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:advanced,urn:alm:descriptor:com.tectonic.ui:resourceRequirements"
	resources?: null | #ResourceRequirements @go(Resources,*ResourceRequirements)

	// Optional: List of arguments
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Arguments"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:advanced,urn:alm:descriptor:com.tectonic.ui:text"
	args?: [...string] @go(Args,[]string)

	// Optional: List of environment variables
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Environment Variables"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:advanced,urn:alm:descriptor:com.tectonic.ui:text"
	env?: [...#EnvVar] @go(Env,[]EnvVar)

	// Optional: Custom repo configuration for NVIDIA Driver container
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Custom Repo Configuration For NVIDIA Driver Container"
	repoConfig?: null | #DriverRepoConfigSpec @go(RepoConfig,*DriverRepoConfigSpec)

	// Optional: Custom certificates configuration for NVIDIA Driver container
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Custom Certificates Configuration For NVIDIA Driver Container"
	certConfig?: null | #DriverCertConfigSpec @go(CertConfig,*DriverCertConfigSpec)

	// Optional: Licensing configuration for NVIDIA vGPU licensing
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Licensing Configuration For NVIDIA vGPU Driver Container"
	licensingConfig?: null | #DriverLicensingConfigSpec @go(LicensingConfig,*DriverLicensingConfigSpec)

	// Optional: Virtual Topology Daemon configuration for NVIDIA vGPU drivers
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Custom Virtual Topology Daemon Configuration For vGPU Driver Container"
	virtualTopologyConfig?: null | #VirtualTopologyConfigSpec @go(VirtualTopologyConfig,*VirtualTopologyConfigSpec)

	// Optional: Kernel module configuration parameters for the NVIDIA Driver
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Kernel module configuration parameters for the NVIDIA driver"
	kernelModuleConfig?: null | #KernelModuleConfigSpec @go(KernelModuleConfig,*KernelModuleConfigSpec)

	// +kubebuilder:validation:Optional
	// NodeSelector specifies a selector for installation of NVIDIA driver
	nodeSelector?: {[string]: string} @go(NodeSelector,map[string]string)

	// +kubebuilder:validation:Optional
	// Affinity specifies node affinity rules for driver pods
	nodeAffinity?: null | corev1.#NodeAffinity @go(NodeAffinity,*corev1.NodeAffinity)

	// +kubebuilder:validation:Optional
	// Optional: Map of string keys and values that can be used to organize and categorize
	// (scope and select) objects. May match selectors of replication controllers
	// and services.
	labels?: {[string]: string} @go(Labels,map[string]string)

	// +kubebuilder:validation:Optional
	// Optional: Annotations is an unstructured key value map stored with a resource that may be
	// set by external tools to store and retrieve arbitrary metadata. They are not
	// queryable and should be preserved when modifying objects.
	annotations?: {[string]: string} @go(Annotations,map[string]string)

	// +kubebuilder:validation:Optional
	// Optional: Set tolerations
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Tolerations"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:advanced,urn:alm:descriptor:io.kubernetes:Tolerations"
	tolerations?: [...corev1.#Toleration] @go(Tolerations,[]corev1.Toleration)

	// +kubebuilder:validation:Optional
	// Optional: Set priorityClassName
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="PriorityClassName"
	priorityClassName?: string @go(PriorityClassName)
}

// ResourceRequirements describes the compute resource requirements.
#ResourceRequirements: {
	// Limits describes the maximum amount of compute resources allowed.
	// More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
	// +optional
	limits?: corev1.#ResourceList @go(Limits)

	// Requests describes the minimum amount of compute resources required.
	// If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
	// otherwise to an implementation-defined value. Requests cannot exceed Limits.
	// More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
	// +optional
	requests?: corev1.#ResourceList @go(Requests)
}

// DriverManagerSpec describes configuration for NVIDIA Driver Manager(initContainer)
#DriverManagerSpec: {
	// Repository represents Driver Managerrepository path
	repository?: string @go(Repository)

	// Image represents NVIDIA Driver Manager image name
	// +kubebuilder:validation:Pattern=[a-zA-Z0-9\-]+
	image?: string @go(Image)

	// Version represents NVIDIA Driver Manager image tag(version)
	version?: string @go(Version)

	// Image pull policy
	// +kubebuilder:validation:Optional
	imagePullPolicy?: string @go(ImagePullPolicy)

	// Image pull secrets
	// +kubebuilder:validation:Optional
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Image pull secrets"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:io.kubernetes:Secret"
	imagePullSecrets?: [...string] @go(ImagePullSecrets,[]string)

	// Optional: List of environment variables
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Environment Variables"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:advanced,urn:alm:descriptor:com.tectonic.ui:text"
	env?: [...#EnvVar] @go(Env,[]EnvVar)
}

// EnvVar represents an environment variable present in a Container.
#EnvVar: {
	// Name of the environment variable.
	name: string @go(Name)

	// Value of the environment variable.
	value?: string @go(Value)
}

// ContainerProbeSpec defines the properties for configuring container probes
#ContainerProbeSpec: {
	// Number of seconds after the container has started before liveness probes are initiated.
	// More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
	// +kubebuilder:validation:Optional
	initialDelaySeconds?: int32 @go(InitialDelaySeconds)

	// Number of seconds after which the probe times out.
	// Defaults to 1 second. Minimum value is 1.
	// More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
	// +kubebuilder:validation:Optional
	// +kubebuilder:validation:Minimum=1
	timeoutSeconds?: int32 @go(TimeoutSeconds)

	// How often (in seconds) to perform the probe.
	// Default to 10 seconds. Minimum value is 1.
	// +kubebuilder:validation:Optional
	// +kubebuilder:validation:Minimum=1
	periodSeconds?: int32 @go(PeriodSeconds)

	// Minimum consecutive successes for the probe to be considered successful after having failed.
	// Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
	// +kubebuilder:validation:Optional
	// +kubebuilder:validation:Minimum=1
	successThreshold?: int32 @go(SuccessThreshold)

	// Minimum consecutive failures for the probe to be considered failed after having succeeded.
	// Defaults to 3. Minimum value is 1.
	// +kubebuilder:validation:Optional
	// +kubebuilder:validation:Minimum=1
	failureThreshold?: int32 @go(FailureThreshold)
}

// GPUDirectStorageSpec defines the properties for NVIDIA GPUDirect Storage Driver deployment(Experimental)
#GPUDirectStorageSpec: {
	// Enabled indicates if GPUDirect Storage is enabled through GPU operator
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Enable GPUDirect Storage through GPU operator"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:booleanSwitch"
	enabled?: null | bool @go(Enabled,*bool)

	// NVIDIA GPUDirect Storage Driver image repository
	// +kubebuilder:validation:Optional
	repository?: string @go(Repository)

	// NVIDIA GPUDirect Storage Driver image name
	// +kubebuilder:validation:Pattern=[a-zA-Z0-9\-]+
	image?: string @go(Image)

	// NVIDIA GPUDirect Storage Driver image tag
	// +kubebuilder:validation:Optional
	version?: string @go(Version)

	// Image pull policy
	// +kubebuilder:validation:Optional
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Image Pull Policy"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:imagePullPolicy"
	imagePullPolicy?: string @go(ImagePullPolicy)

	// Image pull secrets
	// +kubebuilder:validation:Optional
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Image pull secrets"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:io.kubernetes:Secret"
	imagePullSecrets?: [...string] @go(ImagePullSecrets,[]string)

	// Optional: List of arguments
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Arguments"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:advanced,urn:alm:descriptor:com.tectonic.ui:text"
	args?: [...string] @go(Args,[]string)

	// Optional: List of environment variables
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Environment Variables"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:advanced,urn:alm:descriptor:com.tectonic.ui:text"
	env?: [...#EnvVar] @go(Env,[]EnvVar)
}

// GPUDirectRDMASpec defines the properties for nvidia-peermem deployment
#GPUDirectRDMASpec: {
	// Enabled indicates if GPUDirect RDMA is enabled through GPU operator
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Enable GPUDirect RDMA through GPU operator"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:booleanSwitch"
	enabled?: null | bool @go(Enabled,*bool)

	// UseHostMOFED indicates to use MOFED drivers directly installed on the host to enable GPUDirect RDMA
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Use MOFED drivers directly installed on the host to enable GPUDirect RDMA"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:booleanSwitch"
	useHostMofed?: null | bool @go(UseHostMOFED,*bool)
}

// KernelModuleConfigSpec defines custom configuration parameters for the NVIDIA Driver
#KernelModuleConfigSpec: {
	// +kubebuilder:validation:Optional
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="ConfigMap Name"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:text"
	name?: string @go(Name)
}

// VirtualTopologyConfigSpec defines virtual topology daemon configuration with NVIDIA vGPU
#VirtualTopologyConfigSpec: {
	// Optional: Config name representing virtual topology daemon configuration file nvidia-topologyd.conf
	// +kubebuilder:validation:Optional
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="ConfigMap Name"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:text"
	name?: string @go(Name)
}

// DriverCertConfigSpec defines custom certificates configuration for NVIDIA Driver container
#DriverCertConfigSpec: {
	// +kubebuilder:validation:Optional
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="ConfigMap Name"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:text"
	name?: string @go(Name)
}

// DriverRepoConfigSpec defines custom repo configuration for NVIDIA Driver container
#DriverRepoConfigSpec: {
	// +kubebuilder:validation:Optional
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="ConfigMap Name"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:text"
	name?: string @go(Name)
}

// DriverLicensingConfigSpec defines licensing server configuration for NVIDIA Driver container
#DriverLicensingConfigSpec: {
	// +kubebuilder:validation:Optional
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="ConfigMap Name"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:text"
	name?: string @go(Name)

	// NLSEnabled indicates if NVIDIA Licensing System is used for licensing.
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors=true
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.displayName="Enable NVIDIA Licensing System licensing"
	// +operator-sdk:gen-csv:customresourcedefinitions.specDescriptors.x-descriptors="urn:alm:descriptor:com.tectonic.ui:booleanSwitch"
	nlsEnabled?: null | bool @go(NLSEnabled,*bool)
}

// DriverType defines NVIDIA driver type
#DriverType: string // #enumDriverType

#enumDriverType:
	#GPU |
	#VGPU |
	#VGPUHostManager

// GPU driver type
#GPU: #DriverType & "gpu"

// VGPU guest driver type
#VGPU: #DriverType & "vgpu"

// VGPUHostManager specifies vgpu host manager type
#VGPUHostManager: #DriverType & "vgpu-host-manager"

// State indicates state of the NVIDIA driver managed by this instance
#State: string // #enumState

#enumState:
	#Ready |
	#NotReady |
	#Disabled

// Ready indicates that the NVIDIA driver managed by this instance is ready
#Ready: #State & "ready"

// NotReady indicates that the NVIDIA driver managed by this instance is not ready
#NotReady: #State & "notReady"

// Disabled indicates if the state is disabled in ClusterPolicy
#Disabled: #State & "disabled"

// NVIDIADriverStatus defines the observed state of NVIDIADriver
#NVIDIADriverStatus: {
	// INSERT ADDITIONAL STATUS FIELD - define observed state of cluster
	// Important: Run "make" to regenerate code after modifying this file
	// +kubebuilder:validation:Enum=ignored;ready;notReady
	// State indicates status of NVIDIADriver instance
	state: #State @go(State)

	// Namespace indicates a namespace in which the operator and driver are installed
	namespace?: string @go(Namespace)

	// Conditions is a list of conditions representing the NVIDIADriver's current state.
	conditions?: [...metav1.#Condition] @go(Conditions,[]metav1.Condition)
}

// NVIDIADriver is the Schema for the nvidiadrivers API
#NVIDIADriver: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta  @go(ObjectMeta)
	spec?:     #NVIDIADriverSpec   @go(Spec)
	status?:   #NVIDIADriverStatus @go(Status)
}

// NVIDIADriverList contains a list of NVIDIADriver
#NVIDIADriverList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#NVIDIADriver] @go(Items,[]NVIDIADriver)
}