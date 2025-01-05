# NVIDIA Device Plugin

[https://github.com/NVIDIA/k8s-device-plugin](https://github.com/NVIDIA/k8s-device-plugin)

[https://www.talos.dev/v1.6/talos-guides/configuration/nvidia-gpu-proprietary/](https://www.talos.dev/v1.6/talos-guides/configuration/nvidia-gpu-proprietary/)

###### patch.yaml

```sh
talosctl patch mc --patch @patch.yaml
```

```yaml
machine:
  kernel:
    modules:
      - name: nvidia
      - name: nvidia_uvm
      - name: nvidia_drm
      - name: nvidia_modeset
  sysctls:
    net.core.bpf_jit_harden: 1
```

Restart, install the device plugin and then:

```yaml
- op: add
  path: /machine/files
  value:
    - content: |
        [plugins]
          [plugins."io.containerd.cri.v1.runtime"]
            [plugins."io.containerd.cri.v1.runtime".containerd]
              default_runtime_name = "nvidia"
      path: /etc/cri/conf.d/20-customization.part
      op: create
```
