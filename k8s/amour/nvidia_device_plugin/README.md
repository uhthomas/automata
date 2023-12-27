# NVIDIA Device Plugin

[https://github.com/NVIDIA/k8s-device-plugin](https://github.com/NVIDIA/k8s-device-plugin)

[https://www.talos.dev/v1.6/talos-guides/configuration/nvidia-gpu-proprietary/](https://www.talos.dev/v1.6/talos-guides/configuration/nvidia-gpu-proprietary/)

###### patch.yaml

```yaml
- op: add
  path: /machine/files
  value:
    - content: |
        version = 2
        [plugins]
        [plugins."io.containerd.grpc.v1.cri"]
        [plugins."io.containerd.grpc.v1.cri".containerd]
        default_runtime_name = "nvidia"

        [plugins."io.containerd.grpc.v1.cri".containerd.runtimes]
                [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia]
                privileged_without_host_devices = false
                runtime_engine = ""
                runtime_root = ""
                runtime_type = "io.containerd.runc.v2"
                [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia.options]
                BinaryName = "/usr/bin/nvidia-container-runtime"
      op: create
```
