# Intel GPU device plugin for Kubernetes

https://intel.github.io/intel-device-plugins-for-kubernetes/cmd/gpu_plugin/README.html

https://github.com/intel/intel-device-plugins-for-kubernetes

Imported with:

```sh
❯ k kustomize "https://github.com/intel/intel-device-plugins-for-kubernetes/deployments/nfd/overlays/node-feature-rules/?ref=v0.26.0" > nfd.yaml
❯ k kustomize "https://github.com/intel/intel-device-plugins-for-kubernetes/deployments/gpu_plugin/overlays/fractional_resources/?ref=v0.26.0" > gpu.yaml
❯ cue import -R -l "strings.ToLower(kind)" --list nfd.yaml gpu.yaml
```

[Logging, monitoring and shared-dev](https://intel.github.io/intel-device-plugins-for-kubernetes/cmd/gpu_plugin/README.html#modes-and-configuration-options)
has also been enabled.
