import (
	corev1 "k8s.io/api/core/v1"
	"github.com/uhthomas/automata/clusters/desire"
	"github.com/uhthomas/automata/clusters/desire/root_dev"
	"github.com/uhthomas/automata/clusters/desire/thanos"
)

corev1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: labels: {
			"app.kubernetes.io/managed-by": "automata"
		}
	}]
}

items: [desire.cluster_issuer] +
	root_dev.items +
	thanos.items
