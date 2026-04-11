# ceph-csi (driver-plugin RBAC)

This directory is **part of the ceph-csi-operator install**, not rook itself,
even though it lives under `rook_ceph/`. It contains the per-driver
ServiceAccounts, Roles, RoleBindings, ClusterRoles, and ClusterRoleBindings
that the CSI driver pods (cephfs/rbd/nfs ctrlplugin + nodeplugin) run as.

It lives here rather than in `k8s/magiclove/ceph_csi_operator/` because the
driver pods run in the `rook-ceph` namespace (alongside the Ceph cluster),
while the ceph-csi-operator controller runs in its own `ceph-csi-operator`
namespace. The namespaced RBAC has to be in the namespace where it's used.

## Source of truth

These manifests are rendered by the `ceph-csi-operator` helm chart. To regenerate:

```sh
❯ helm template ceph-csi-operator \
    oci://quay.io/ceph-csi/ceph-csi-operator \
    --version <X.Y.Z> \
    -n ceph-csi-operator > csio.yaml
```

Or from the release tarball:

```sh
❯ curl -sLO https://github.com/ceph/ceph-csi-operator/releases/download/v<X.Y.Z>/ceph-csi-operator-<X.Y.Z>.tgz
❯ helm template ceph-csi-operator ceph-csi-operator-<X.Y.Z>.tgz -n ceph-csi-operator > csio.yaml
```

The **release name must be `ceph-csi-operator`** — anything else causes the
generated resource names to be prefixed differently from what's already in
this tree.

## What lives where

When upgrading ceph-csi-operator, the helm output splits across two packages:

| Kind(s) | Name pattern | Package |
|---|---|---|
| ClusterRole, ClusterRoleBinding | `ceph-csi-operator-{cephfs,rbd,nfs,nvmeof}-{ctrl,node}plugin-cr`/`-crb` | `rook_ceph/ceph_csi/` (here) |
| Role, RoleBinding | same driver-plugin names, `-r`/`-rb` suffix | `rook_ceph/ceph_csi/` (here) |
| ServiceAccount | `ceph-csi-operator-{cephfs,rbd,nfs}-{ctrl,node}plugin-sa` | `rook_ceph/ceph_csi/` (here) |
| ClusterRole (management) | `ceph-csi-operator-{manager-role,metrics-*,operatorconfig-*,*-viewer-role,*-editor-role,cephconnection*,clientprofile*}` | `ceph_csi_operator/` |
| Role (leader election) | `ceph-csi-operator-leader-election-role` | `ceph_csi_operator/` |
| Deployment (controller) | `ceph-csi-operator-controller-manager` | `ceph_csi_operator/` |
| CustomResourceDefinition | everything in `csi.ceph.io` group | `ceph_csi_operator/` |

**Both packages must be bumped together** when upgrading ceph-csi-operator.
It's easy to miss: a `grep` for "ceph-csi-operator" in the separate package
won't find these files. See `grep -rln 'ceph-csi-operator' k8s/magiclove/`
before every upgrade.

## What's intentionally omitted

- **NVMe-oF driver RBAC** (`ceph-csi-operator-nvmeof-*`) — we don't use
  NVMe-oF. If you enable it, add the corresponding ClusterRole,
  ClusterRoleBinding, Role, RoleBinding, and ServiceAccount entries.
- **NFS nodeplugin Role** — the helm output only has a ClusterRole for
  `nfs-nodeplugin`, no namespaced Role; we mirror that.
