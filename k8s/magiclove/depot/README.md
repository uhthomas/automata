# Depot

Personal SMB storage in the `depot` namespace: 1 TiB of ext4 on erasure-coded
RBD (`rook-ceph-nvme-ec`). The volume supports expansion and is retained when
its PVC is deleted.

## Mount on Linux

After deployment, install `cifs-utils` and save the generated `smbuser`
credentials. Deleting the `depot` Secret generates a new password.

```sh
sudo install -d -m 0755 /etc/samba
sudo install -m 0600 /dev/null /etc/samba/depot2.credentials
kubectl --context=oidc@magiclove -n depot get secret depot \
  -o go-template='{{ printf "username=%s\npassword=%s\n" (index .data "username" | base64decode) (index .data "password" | base64decode) }}' \
  | sudo tee /etc/samba/depot2.credentials >/dev/null

sudo mkdir -p /depot2
sudo mount -t cifs //depot-magiclove.hipparcos.net/depot /depot2 \
  -o "credentials=/etc/samba/depot2.credentials,vers=3.1.1,multichannel,max_channels=4,uid=$(id -u),gid=$(id -g)"
```

The client needs LAN access to the service. Check `/proc/fs/cifs/DebugData`
to confirm whether additional SMB channels were established.
