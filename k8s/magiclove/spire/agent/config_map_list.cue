package agent

import "k8s.io/api/core/v1"

#ConfigMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

#ConfigMapList: items: [{
	metadata: name: "spire-agent"
	data: "agent.conf": """
		agent {
		  data_dir = "/run/spire"
		  log_level = "DEBUG"
		  server_address = "spire-server"
		  server_port = "8081"
		  socket_path = "/run/spire/sockets/agent.sock"
		  trust_bundle_path = "/run/spire/bundle/bundle.crt"
		  trust_domain = "spire-magiclove.hipparcos.net"
		}

		plugins {
		  NodeAttestor "k8s_sat" {
		    plugin_data {
		      cluster = "magiclove"
		    }
		  }

		  KeyManager "memory" {
		    plugin_data {
		    }
		  }

		  WorkloadAttestor "k8s" {
		    plugin_data {
		      # Defaults to the secure kubelet port by default.
		      # Minikube does not have a cert in the cluster CA bundle that
		      # can authenticate the kubelet cert, so skip validation.
		      skip_kubelet_verification = true
		      node_name_env = "MY_NODE_NAME"
		    }
		  }

		  WorkloadAttestor "unix" {
		      plugin_data {
		      }
		  }
		}

		health_checks {
		  listener_enabled = true
		  bind_address = "0.0.0.0"
		  bind_port = "8080"
		  live_path = "/live"
		  ready_path = "/ready"
		}

		"""
}]
