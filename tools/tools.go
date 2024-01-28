//go:build tools
// +build tools

package tools

import (
	_ "cuelang.org/go/cmd/cue"
	_ "github.com/1Password/onepassword-operator/api/v1"
	_ "github.com/NVIDIA/gpu-operator"
	_ "github.com/VictoriaMetrics/operator/api/victoriametrics/v1beta1"
	_ "github.com/backube/volsync/api/v1alpha1"
	_ "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"
	_ "github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2"
	_ "github.com/crunchydata/postgres-operator/pkg/apis/postgres-operator.crunchydata.com/v1beta1"
	_ "github.com/external-secrets/external-secrets/apis/externalsecrets/v1beta1"
	_ "github.com/prometheus/prometheus/model/rulefmt"
	_ "github.com/rook/rook/pkg/apis/ceph.rook.io/v1"
	_ "k8s.io/api"
	_ "k8s.io/apiextensions-apiserver"
	_ "k8s.io/client-go/tools/clientcmd/api/v1"
	_ "k8s.io/kube-aggregator"
	_ "k8s.io/kubernetes/cmd/kubectl"
)
