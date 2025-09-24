# External Secrets

[https://github.com/external-secrets/external-secrets](https://github.com/external-secrets/external-secrets)

```sh
❯ helm template external-secrets/external-secrets -n external-secrets --set installCRDs=false --set webhook.certManager.enabled=true > out.yaml
❯ cue import -l "strings.ToLower(kind)" --list out.yaml

```
