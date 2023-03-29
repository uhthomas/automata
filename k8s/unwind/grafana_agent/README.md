# Grafana Agent

The Grafana Agent collects logs and metrics for the whole cluster which are then
sent both to local instances of Loki and Mimir as well as Grafana Cloud.

## Grafana Cloud Secrets

```sh
❯ k -n vault exec vault-0 -- vault kv put secret/kubernetes/unwind/grafana-agent/grafana-cloud-logs username= password=
❯ k -n vault exec vault-0 -- vault kv put secret/kubernetes/unwind/grafana-agent/grafana-cloud-metrics username= password=
❯ k -n vault exec -it vault-0 -- vault write auth/kubernetes/role/grafana-agent-grafana-cloud-read bound_service_account_names=grafana-agent bound_service_account_namespaces=grafana-agent policies=kubernetes-kv-read ttl=24h
```
