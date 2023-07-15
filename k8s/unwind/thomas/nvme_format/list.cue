package nvme_format

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name: "nvme-format"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
}

#List: items: list.Concat(_items)

_items: [#JobList.items]
