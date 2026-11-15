# LiveSync

[Self-hosted LiveSync](https://github.com/vrtmrz/obsidian-livesync) uses the
CouchDB Deployment in the `livesync` namespace. The Deployment uses the default
single replica and `Recreate` updates, with a separate 1 GiB `rook-ceph-nvme` PVC.

## Connect Obsidian

After deployment through the cluster's normal Flux pipeline, install the
Self-hosted LiveSync community plugin in Obsidian and configure CouchDB with:

- URI: `https://livesync-magiclove.hipparcos.net`
- Username: `admin`
- Database: a lowercase name for your vault, such as `obsidian`

External Secrets creates the `couchdb` Secret once using a password generator.
Retrieve the password with:

```sh
kubectl --context=oidc@magiclove -n livesync get secret couchdb \
  -o go-template='{{ index .data "password" | base64decode }}{{ "\n" }}'
```

This dedicated instance uses one administrator account for setup and sync.
Each configured Obsidian device therefore has full CouchDB administrator access,
including the ability to create and delete databases. The plugin can create
the vault database during setup without a separate provisioning script.

The password remains stable across reconciles. Deleting the Secret generates a
new password; save it separately when backing up the database. Settings belong
in the ConfigMap, since runtime configuration changes are discarded when the
pod is replaced.

Enable end-to-end encryption in LiveSync with a separate passphrase, then use
the plugin's encrypted setup URI to configure your other devices. Allow sync to
finish before closing the app, and use only one sync solution for this vault.
