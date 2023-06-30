//go:build tools
// +build tools

package tools

import (
	_ "cuelang.org/go/cmd/cue"
	_ "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"
	_ "github.com/prometheus/prometheus/model/rulefmt"
	_ "github.com/rook/rook/pkg/apis/ceph.rook.io/v1"
	_ "k8s.io/api"
	_ "k8s.io/apiextensions-apiserver"
	_ "k8s.io/client-go/tools/clientcmd/api/v1"
	_ "k8s.io/kube-aggregator"
	_ "k8s.io/kubernetes/cmd/kubectl"
	_ "kubevirt.io/api"
)
