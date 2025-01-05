# Minecraft

[https://docker-minecraft-server.readthedocs.io/](https://docker-minecraft-server.readthedocs.io/)

## CurseForge API Key

```sh
❯ k -n vault exec vault-0 -- vault kv put secret/kubernetes/unwind/minecraft/cf-api-key value=""
=================== Secret Path ===================
secret/data/kubernetes/unwind/minecraft/cf-api-key

======= Metadata =======
Key                Value
---                -----
created_time       2023-06-02T10:30:13.769524081Z
custom_metadata    <nil>
deletion_time      n/a
destroyed          false
version            1
❯ k -n vault exec -it vault-0 -- vault write auth/kubernetes/role/minecraft-read bound_service_account_names=default bound_service_account_namespaces=minecraft policies=kubernetes-kv-read ttl=24h
Success! Data written to: auth/kubernetes/role/minecraft-read
```
