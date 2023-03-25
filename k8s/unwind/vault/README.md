# Vault

Vault needs a bit of manual intervention before it can actually work.

See the documentation for [installing vault to Kubernetes with integrated storage](https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-minikube-raft).

Essentially:

```sh
❯ k -n vault exec vault-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > cluster-keys.json
❯ VAULT_UNSEAL_KEY=$(jq -r ".unseal_keys_b64[]" cluster-keys.json)
❯ k -n vault exec vault-0 -- vault operator unseal $VAULT_UNSEAL_KEY
❯ k -n vault exec vault-1 -- vault operator raft join http://vault-0.vault-internal:8200
❯ k -n vault exec vault-2 -- vault operator raft join http://vault-0.vault-internal:8200
❯ k -n vault exec vault-1 -- vault operator unseal $VAULT_UNSEAL_KEY
❯ k -n vault exec vault-2 -- vault operator unseal $VAULT_UNSEAL_KEY
```

Then, Vault needs to be unsealed when the pod restarts. It would be nice to find
a solution for auto-unsealing on bare-metal.

```sh
❯ VAULT_UNSEAL_KEY=$(jq -r ".unseal_keys_b64[]" cluster-keys.json)
❯ for i in {0..2}; do; k -n vault exec vault-$i -- vault operator unseal $VAULT_UNSEAL_KEY; done
```
