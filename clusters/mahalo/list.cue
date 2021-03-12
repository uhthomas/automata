import (
	"github.com/uhthomas/automata/clusters/mahalo/cert_manager"
	"github.com/uhthomas/automata/clusters/mahalo/ingress_nginx"
	"k8s.io/api/core/v1"
)

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: labels: "app.kubernetes.io/managed-by": "automata"
	}]
}

items: cert_manager.items +
	ingress_nginx.items
