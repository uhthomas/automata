# Redis Operator

https://github.com/spotahome/redis-operator

Imported with:

```sh
❯ curl -LfsO https://raw.githubusercontent.com/spotahome/redis-operator/fe8090ac7291ee53ac30e534fa1cc03e5759fd10/example/operator/all-redis-operator-resources.yaml
❯ curl -LfsO https://raw.githubusercontent.com/spotahome/redis-operator/fe8090ac7291ee53ac30e534fa1cc03e5759fd10/manifests/databases.spotahome.com_redisfailovers.yaml
❯ cue import -l "strings.ToLower(kind)" --list all-redis-operator-resources.yaml databases.spotahome.com_redisfailovers.yaml
```
