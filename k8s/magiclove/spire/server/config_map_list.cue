package server

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
	data: "server.conf": """
		server {
		  bind_address = "0.0.0.0"
		  bind_port = "8081"
		  socket_path = "/tmp/spire-server/private/api.sock"
		  trust_domain = "spire-magiclove.hipparcos.net"
		  data_dir = "/run/spire/data"
		  log_level = "DEBUG"
		  #AWS requires the use of RSA.  EC cryptography is not supported
		  ca_key_type = "rsa-2048"

		  ca_subject = {
		    country = ["US"],
		    organization = ["SPIFFE"],
		    common_name = "",
		  }
		}

		plugins {
		  DataStore "sql" {
		    plugin_data {
		      database_type = "sqlite3"
		      connection_string = "/run/spire/data/datastore.sqlite3"
		    }
		  }

		  NodeAttestor "k8s_sat" {
		    plugin_data {
		      clusters = {
		        # NOTE: Change this to your cluster name
		        "magiclove" = {
		          use_token_review_api_validation = true
		          service_account_allow_list = ["spire:spire-agent"]
		        }
		      }
		    }
		  }

		  KeyManager "disk" {
		    plugin_data {
		      keys_path = "/run/spire/data/keys.json"
		    }
		  }

		  Notifier "k8sbundle" {
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
