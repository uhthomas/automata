# Grafana

[https://grafana.com/grafana/](https://grafana.com/grafana/)

[https://github.com/grafana/grafana](https://github.com/grafana/grafana)

External Secrets generates the admin password using `Password/grafana` and
stores it alongside the username in `Secret/grafana`. Grafana and the Grafana
operator both reference this Secret.

The ExternalSecret uses `OnChange` so replacing the old 1Password source triggers
reconciliation. Its immutable target preserves the existing working credentials
and prevents later reconciliation from replacing them. Grafana only uses the
configured admin password when initializing its database, so retain the Secret
with the database when restoring either.
