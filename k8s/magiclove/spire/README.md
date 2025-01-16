# Spire

[https://spiffe.io/docs/latest/try/getting-started-k8s/](https://spiffe.io/docs/latest/try/getting-started-k8s/)

The CSI driver would be nice.

[https://github.com/spiffe/spiffe-csi](https://github.com/spiffe/spiffe-csi)

```sh
❯ k exec -it sts/spire-server -- \
    /opt/spire/bin/spire-server entry create \
    -spiffeID spiffe://spire-magiclove.hipparcos.net/ns/spire/sa/spire-agent \
    -selector k8s_sat:cluster:magiclove \
    -selector k8s_sat:agent_ns:spire \
    -selector k8s_sat:agent_sa:spire-agent \
    -node
Entry ID         : b313a13a-bf78-4c92-9dd7-e1eee47658f0
SPIFFE ID        : spiffe://spire-magiclove.hipparcos.net/ns/spire/sa/spire-agent
Parent ID        : spiffe://spire-magiclove.hipparcos.net/spire/server
Revision         : 0
X509-SVID TTL    : default
JWT-SVID TTL     : default
Selector         : k8s_sat:agent_ns:spire
Selector         : k8s_sat:agent_sa:spire-agent
Selector         : k8s_sat:cluster:magiclove
```

```sh
❯ k exec -it sts/spire-server -- \
    /opt/spire/bin/spire-server entry create \
    -spiffeID spiffe://spire-magiclove.hipparcos.net/ns/default/sa/default \
    -parentID spiffe://spire-magiclove.hipparcos.net/ns/spire/sa/spire-agent \
    -selector k8s:ns:spire \
    -selector k8s:sa:default
Entry ID         : 95074358-a44a-4a66-9404-77a8fae994e2
SPIFFE ID        : spiffe://spire-magiclove.hipparcos.net/ns/default/sa/default
Parent ID        : spiffe://spire-magiclove.hipparcos.net/ns/spire/sa/spire-agent
Revision         : 0
X509-SVID TTL    : default
JWT-SVID TTL     : default
Selector         : k8s:ns:spire
Selector         : k8s:sa:default
```

```sh
❯ k exec -it deploy/spire-client -- /opt/spire/bin/spire-agent api fetch -socketPath /run/spire/sockets/agent.sock
Received 1 svid after 87.184133ms

SPIFFE ID:              spiffe://spire-magiclove.hipparcos.net/ns/default/sa/default
SVID Valid After:       2025-01-16 01:31:24 +0000 UTC
SVID Valid Until:       2025-01-16 02:31:34 +0000 UTC
CA #1 Valid After:      2025-01-16 00:02:26 +0000 UTC
CA #1 Valid Until:      2025-01-17 00:02:36 +0000 UTC
```
