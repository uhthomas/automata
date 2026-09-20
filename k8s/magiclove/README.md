# magiclove

Please follow the documentation for `onepassword-connect` as it is a
prerequisite.

## Deploy

```sh
./hack/k8s-deploy.sh main
```

The command renders and validates the complete graph, publishes it as an OCI
artifact, and asks Flux to reconcile that artifact. Restore production without
publishing a new artifact with `./hack/k8s-reconcile.sh main`.

Do not invoke `kubectl apply` directly or pipe a partial CUE export to the
cluster.

## Talos Upgrades

The current manifest ID is
`9b5b525cd82cc70e6923eec6764eaea4892f3448aaa1fa852d0c1c62cf69b926`.

```sh
❯ talosctl upgrade -p -i factory.talos.dev/installer-secureboot/9b5b525cd82cc70e6923eec6764eaea4892f3448aaa1fa852d0c1c62cf69b926:v1.11.0 --debug
``

```yaml
customization:
    extraKernelArgs:
        - iommu=pt
        - initcall_blacklist=acpi_cpufreq_init
        - amd_pstate=active
        - amd_iommu=on
        - pci=realloc=off
        - pcie_aspm.policy=performance
    systemExtensions:
        officialExtensions:
            - siderolabs/amd-ucode
            - siderolabs/nonfree-kmod-nvidia-production
            - siderolabs/nvidia-container-toolkit-production
```
