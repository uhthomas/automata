# Cilium

[https://docs.cilium.io/en/stable/](https://docs.cilium.io/en/stable/)

Pretty sure the resources were created with:

```sh
❯ KUBERNETES_API_SERVER_ADDRESS="magiclove.hipparcos.net" KUBERNETES_API_SERVER_PORT=6443 helm template \
    cilium \
    cilium/cilium \
    --version 1.18.1 \
    --namespace cilium \
    --set ipam.mode=kubernetes \
    --set=kubeProxyReplacement=true \
    --set=securityContext.capabilities.ciliumAgent="{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID}" \
    --set=securityContext.capabilities.cleanCiliumState="{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE}" \
    --set=cgroup.autoMount.enabled=false \
    --set=cgroup.hostRoot=/sys/fs/cgroup \
    --set=k8sServiceHost=localhost \
    --set=k8sServicePort=7445 \
    --set hubble.relay.enabled=true \
    --set hubble.ui.enabled=true \
    --set hubble.tls.auto.enabled=true \
    --set hubble.tls.auto.method=certmanager \
    --set hubble.tls.auto.certValidityDuration=1095 \
    --set hubble.tls.auto.certManagerIssuerRef.group="cert-manager.io" \
    --set hubble.tls.auto.certManagerIssuerRef.kind="ClusterIssuer" \
    --set hubble.tls.auto.certManagerIssuerRef.name="ca-issuer" \
    --set bgpControlPlane.enabled=true > cilium.yaml
```

Per
[https://www.talos.dev/v1.11/kubernetes-guides/network/deploying-cilium/](https://www.talos.dev/v1.11/kubernetes-guides/network/deploying-cilium/)

To update, render with the chart at the current version and then diff it against
the target version.

```sh
❯ helm template ... --version=1.16.1 --kube-version=1.34.0 > cilium-1.16.1.yaml
❯ helm template ... --version=1.18.1 --kube-version=1.34.0 > cilium-1.18.1.yaml
❯ cue import -l "strings.ToLower(kind)" --list -R cilium-1.16.1.yaml cilium-1.18.1.yaml
❯ diff -urN cilium-1.16.1.cue cilium-1.18.1.cue > out.diff
```

## BGP

```frr
router bgp 65000
  bgp router-id 172.16.0.1
  no bgp ebgp-requires-policy

  neighbor magiclove peer-group
  neighbor magiclove remote-as 65100

  neighbor 172.16.0.110 peer-group magiclove
  neighbor 172.16.0.120 peer-group magiclove
  neighbor 172.16.0.130 peer-group magiclove

  address-family ipv4 unicast
    neighbor magiclove next-hop-self
    neighbor magiclove soft-reconfiguration inbound
  exit-address-family
exit
```
