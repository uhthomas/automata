import (
	corev1 "k8s.io/api/core/v1"
	"github.com/uhthomas/automata/clusters/desire/root_dev"
)

corev1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			labels: {
				"app.kubernetes.io/managed-by": "automata"
			}
		}
	}]
}

items: root_dev.items
