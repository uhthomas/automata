# Ceph CSI Operator

[https://github.com/ceph/ceph-csi-operator](https://github.com/ceph/ceph-csi-operator)

## ⚠️ Driver-plugin RBAC lives elsewhere

This package contains only the **controller** resources (the
`ceph-csi-operator-controller-manager` Deployment, its CRDs, the management
ClusterRoles, and the leader-election Role).

The **driver-plugin RBAC** (cephfs/rbd/nfs ctrlplugin and nodeplugin
ServiceAccounts, Roles, RoleBindings, ClusterRoles, ClusterRoleBindings) is
in `k8s/magiclove/rook_ceph/ceph_csi/` — it lives there because the driver
pods run in the `rook-ceph` namespace, not the `ceph-csi-operator` namespace.

**Bump both packages together** on every ceph-csi-operator upgrade. See
`k8s/magiclove/rook_ceph/ceph_csi/README.md` for the regeneration command
and resource mapping.
