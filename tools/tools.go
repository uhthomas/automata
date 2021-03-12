// +build tools

package tools

import (
	_ "k8s.io/api"
	_ "k8s.io/apiextensions-apiserver"
	_ "k8s.io/client-go/tools/clientcmd/api/v1"
	_ "k8s.io/kube-aggregator"
)
