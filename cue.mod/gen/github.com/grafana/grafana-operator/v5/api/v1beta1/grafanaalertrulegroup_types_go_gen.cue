// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-operator/v5/api/v1beta1

package v1beta1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	apiextensions "k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1"
	"github.com/grafana/grafana-openapi-client-go/models"
)

// GrafanaAlertRuleGroupSpec defines the desired state of GrafanaAlertRuleGroup
// +kubebuilder:validation:XValidation:rule="(has(self.folderUID) && !(has(self.folderRef))) || (has(self.folderRef) && !(has(self.folderUID)))", message="Only one of FolderUID or FolderRef can be set"
#GrafanaAlertRuleGroupSpec: {
	// +optional
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Format=duration
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$"
	// +kubebuilder:default="10m"
	resyncPeriod?: metav1.#Duration @go(ResyncPeriod)

	// selects Grafanas for import
	instanceSelector?: null | metav1.#LabelSelector @go(InstanceSelector,*metav1.LabelSelector)

	// UID of the folder containing this rule group
	// Overrides the FolderSelector
	folderUID?: string @go(FolderUID)

	// Match GrafanaFolders CRs to infer the uid
	folderRef?: string @go(FolderRef)
	rules: [...#AlertRule] @go(Rules,[]AlertRule)

	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Format=duration
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$"
	// +kubebuilder:validation:Required
	interval: metav1.#Duration @go(Interval)

	// +optional
	allowCrossNamespaceImport?: null | bool @go(AllowCrossNamespaceImport,*bool)
}

// AlertRule defines a specific rule to be evaluated. It is based on the upstream model with some k8s specific type mappings
#AlertRule: {
	annotations?: {[string]: string} @go(Annotations,map[string]string)
	condition: string @go(Condition)

	// +kubebuilder:validation:Required
	data: [...null | #AlertQuery] @go(Data,[]*AlertQuery)

	// +kubebuilder:validation:Enum=OK;Alerting;Error
	execErrState: string @go(ExecErrState)

	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Format=duration
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$"
	// +kubebuilder:validation:Required
	for?:      null | metav1.#Duration @go(For,*metav1.Duration)
	isPaused?: bool                    @go(IsPaused)
	labels?: {[string]: string} @go(Labels,map[string]string)

	// +kubebuilder:validation:Enum=Alerting;NoData;OK
	noDataState?: null | string @go(NoDataState,*string)

	// +kubebuilder:validation:MinLength=1
	// +kubebuilder:validation:MaxLength=190
	// +kubebuilder:example="Always firing"
	title: string @go(Title)

	// +kubebuilder:validation:Pattern="^[a-zA-Z0-9-_]+$"
	uid: string @go(UID)
}

#AlertQuery: {
	// Grafana data source unique identifier; it should be '__expr__' for a Server Side Expression operation.
	datasourceUid?: string @go(DatasourceUID)

	// JSON is the raw JSON query and includes the above properties as well as custom properties.
	model?: null | apiextensions.#JSON @go(Model,*apiextensions.JSON)

	// QueryType is an optional identifier for the type of query.
	// It can be used to distinguish different types of queries.
	queryType?: string @go(QueryType)

	// RefID is the unique identifier of the query, set by the frontend call.
	refId?: string @go(RefID)

	// relative time range
	relativeTimeRange?: null | models.#RelativeTimeRange @go(RelativeTimeRange,*models.RelativeTimeRange)
}

// GrafanaAlertRuleGroupStatus defines the observed state of GrafanaAlertRuleGroup
#GrafanaAlertRuleGroupStatus: {
	conditions: [...metav1.#Condition] @go(Conditions,[]metav1.Condition)
}

// GrafanaAlertRuleGroup is the Schema for the grafanaalertrulegroups API
#GrafanaAlertRuleGroup: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta           @go(ObjectMeta)
	spec?:     #GrafanaAlertRuleGroupSpec   @go(Spec)
	status?:   #GrafanaAlertRuleGroupStatus @go(Status)
}

// GrafanaAlertRuleGroupList contains a list of GrafanaAlertRuleGroup
#GrafanaAlertRuleGroupList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#GrafanaAlertRuleGroup] @go(Items,[]GrafanaAlertRuleGroup)
}
