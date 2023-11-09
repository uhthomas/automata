# Prowlarr

https://github.com/Prowlarr/Prowlarr

## Tailscale

[Tailscale](https://tailscale.com/) is run as an exit node with a socks5 server
for Prowlarr to use instead of the local network.

The auth key is stored in Vault.

```sh
❯ k -n vault exec vault-0 -- vault kv put secret/kubernetes/unwind/media/prowlarr-tailscale-authkey authkey=<some_key>
❯ k -n vault exec -it vault-0 -- vault write auth/kubernetes/role/media-prowlarr-tailscale-read bound_service_account_names=prowlarr bound_service_account_namespaces=media policies=kubernetes-kv-read ttl=24h
```
