package kaniop

import admissionregistrationv1 "k8s.io/api/admissionregistration/v1"

#ValidatingAdmissionPolicyList: admissionregistrationv1.#ValidatingAdmissionPolicyList & {
	apiVersion: "admissionregistration.k8s.io/v1"
	kind:       "ValidatingAdmissionPolicyList"
	items: [...{
		apiVersion: "admissionregistration.k8s.io/v1"
		kind:       "ValidatingAdmissionPolicy"
	}]
}

#ValidatingAdmissionPolicyList: items: [{
	metadata: name: "kanidm-group-validation-policy"
	spec: {
		matchConstraints: resourceRules: [{
			apiGroups: ["kaniop.rs"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["kanidmgroups"]
		}]
		validations: [{
			expression: """
				!has(object.spec.members) || object.spec.members == null || object.spec.members.all(
				  m,
				  object.spec.members.filter(m2, m2.split('@')[0].lowerAscii() == m.split('@')[0].lowerAscii()).size() == 1
				)
				"""
			message: "Group members must be unique when normalized (case-insensitive and ignoring domain)."
		}, {
			expression: """
				!has(object.spec.mail) || object.spec.mail == null || object.spec.mail.all(
				  e,
				  object.spec.mail.filter(e2, e2.lowerAscii() == e.lowerAscii()).size() == 1
				)
				"""
			message: "Group mail addresses must be unique when normalized (case-insensitive)."
		}]
	}
}, {
	metadata: name: "kanidm-oauth2-client-validation-policy"
	spec: {
		matchConstraints: resourceRules: [{
			apiGroups: ["kaniop.rs"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["kanidmoauth2clients"]
		}]
		validations: [{
			expression: """
				!has(object.spec.redirectUrl) || object.spec.redirectUrl == null || object.spec.redirectUrl.all(
				  url,
				  object.spec.redirectUrl.filter(url2, url2.lowerAscii() == url.lowerAscii()).size() == 1
				)
				"""
			message: "Redirect URLs must be unique when normalized (case-insensitive)."
		}, {
			expression: "!has(object.spec.allowInsecureClientDisablePkce) || (has(object.spec.allowInsecureClientDisablePkce) && !object.spec.public)"
			message:    "Public clients cannot disable PKCE."
		}, {
			expression: "!has(object.spec.allowLocalhostRedirect) || (has(object.spec.allowLocalhostRedirect) && object.spec.public)"
			message:    "Just public clients can allow localhost redirect."
		}, {
			expression: """
				!has(object.spec.scopeMap) || object.spec.scopeMap.all(
				  sm,
				  object.spec.scopeMap.filter(sm2, sm2.group.split('@')[0].lowerAscii() == sm.group.split('@')[0].lowerAscii()).size() == 1
				)
				"""
			message: "Groups must be unique in Scope Maps."
		}, {
			expression: """
				!has(object.spec.scopeMap) || object.spec.scopeMap.all(
				  sm,
				  !sm.group.matches('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')
				)
				"""
			message: "Groups must be name or SPN in Scope Maps."
		}, {
			expression: """
				!has(object.spec.scopeMap) || object.spec.scopeMap.all(
				  sm,
				  sm.scopes.all(s, sm.scopes.filter(s2, s2.lowerAscii() == s.lowerAscii()).size() == 1)
				)
				"""
			message: "Scopes must be unique within each Scope Map entry (case-insensitive)."
		}, {
			expression: """
				!has(object.spec.supScopeMap) || object.spec.supScopeMap.all(
				  ssm,
				  (object.spec.supScopeMap.filter(ssm2, ssm2.group.split('@')[0].lowerAscii() == ssm.group.split('@')[0].lowerAscii()).size() == 1)
				)
				"""
			message: "Groups must be unique in Supplementary Scope Maps."
		}, {
			expression: """
				!has(object.spec.supScopeMap) || object.spec.supScopeMap.all(
				  ssm,
				  !ssm.group.matches('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')
				)
				"""
			message: "Groups must be name or SPN in Supplementary Scope Maps."
		}, {
			expression: """
				!has(object.spec.supScopeMap) || object.spec.supScopeMap.all(
				  ssm,
				  ssm.scopes.all(s, ssm.scopes.filter(s2, s2.lowerAscii() == s.lowerAscii()).size() == 1)
				)
				"""
			message: "Scopes must be unique within each Supplementary Scope Map entry (case-insensitive)."
		}, {
			expression: """
				!has(object.spec.claimMap) || object.spec.claimMap.all(
				  cm,
				  cm.valuesMap.all(v, cm.valuesMap.filter(v2, v2.group.split('@')[0].lowerAscii() == v.group.split('@')[0].lowerAscii()).size() == 1)
				)
				"""
			message: "Groups must be unique in Claim Maps."
		}, {
			expression: """
				!has(object.spec.claimMap) || object.spec.claimMap.all(
				  cm,
				  cm.valuesMap.all(v, !v.group.matches('[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}'))
				)
				"""
			message: "Groups must be name or SPN in Claim Maps."
		}, {
			expression: """
				!has(object.spec.claimMap) || object.spec.claimMap.all(
				  cm,
				  cm.valuesMap.all(v, v.values.all(val, v.values.filter(val2, val2.lowerAscii() == val.lowerAscii()).size() == 1))
				)
				"""
			message: "Values must be unique within each Claim Map entry (case-insensitive)."
		}, {
			expression: "!has(object.spec.secretRotation) || !object.spec.public"
			message:    "Public clients cannot have secret rotation (no secrets to rotate)."
		}]
	}
}, {
	metadata: name: "kanidm-person-validation-policy"
	spec: {
		matchConstraints: resourceRules: [{
			apiGroups: ["kaniop.rs"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["kanidmpersonsaccounts"]
		}]
		validations: [{
			expression: """
				!has(object.spec.mail) || object.spec.mail == null || object.spec.mail.all(
				  e,
				  object.spec.mail.filter(e2, e2.lowerAscii() == e.lowerAscii()).size() == 1
				)
				"""
			message: "Person mail addresses must be unique when normalized (case-insensitive)."
		}]
	}
}, {
	metadata: name: "kanidm-service-account-validation-policy"
	spec: {
		matchConstraints: resourceRules: [{
			apiGroups: ["kaniop.rs"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["kanidmserviceaccounts"]
		}]
		validations: [{
			expression: """
				!has(object.spec.apiTokens) || object.spec.apiTokens.all(
				  t,
				  !has(t.secretName) || t.secretName.matches(r'^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$')
				)
				"""
			message: "secretName must be a valid Kubernetes resource name."
		}, {
			expression: """
				!has(object.spec.apiTokens) || object.spec.apiTokens.all(
				  t,
				  !has(t.secretName) || object.spec.apiTokens.filter(t2, has(t2.secretName) && t2.secretName.lowerAscii() == t.secretName.lowerAscii()).size() == 1
				)
				"""
			message: "secretName must be unique across all API tokens (case-insensitive)."
		}, {
			expression: """
				!has(object.spec.apiTokens) || object.spec.apiTokens.all(
				  t,
				  object.spec.apiTokens.filter(t2, t2.label.lowerAscii() == t.label.lowerAscii()).size() == 1
				)
				"""
			message: "label must be unique across all API tokens (case-insensitive)."
		}]
	}
}, {
	metadata: name: "kanidm-validation-policy"
	spec: {
		matchConstraints: resourceRules: [{
			apiGroups: ["kaniop.rs"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["kanidms"]
		}]
		validations: [{
			expression: "object.metadata.name.matches('^[a-z0-9-]+$')"
			message:    "Invalid name. Only lowercase alphanumeric characters and '-' are allowed."
		}, {
			expression: """
				object.metadata.name.size() <= 48 && object.metadata.name.size() + object.spec.replicaGroups.map(rg, rg.name.size()).max() <= 62
				"""
			message: "Invalid name. Too long name, subresource names must no more than 63 characters."
		}, {
			expression: """
				(
				  has(object.spec.storage) && has(object.spec.storage.volumeClaimTemplate) &&
				  object.spec.storage.volumeClaimTemplate != null
				) || (
				  object.spec.replicaGroups.size() == 1 && object.spec.replicaGroups[0].replicas == 1 &&
				  (!has(object.spec.externalReplicationNodes) || object.spec.externalReplicationNodes.size() == 0)
				)
				"""
			message: "Replication not available for ephemeral storage."
		}, {
			expression: """
				object.spec.replicaGroups.all(
				  rg,
				  (object.spec.replicaGroups.filter(rg2, rg2.name == rg.name).size() == 1)
				)
				"""
			message: "Replica group names must be unique."
		}, {
			expression: """
				object.spec.replicaGroups.all(
				  rg,
				  !has(rg.primaryNode) || rg.primaryNode == false || rg.role == "write_replica" || rg.role == "write_replica_no_ui"
				)
				"""
			message: "Primary node only can be true if role is 'write_replica' or 'write_replica_no_ui'."
		}, {
			expression: """
				object.spec.replicaGroups.filter(
				  rg,
				  (has(rg.primaryNode) && rg.primaryNode == true)
				).size() +
				(!has(object.spec.externalReplicationNodes) ? 0 : object.spec.externalReplicationNodes.filter(
				  ern,(has(ern.automaticRefresh) && ern.automaticRefresh == true)
				).size())
				<= 1
				"""
			message: "Only one primary node replica group or automatic refresh external node is allowed."
		}, {
			expression: """
				!has(object.spec.externalReplicationNodes) || object.spec.externalReplicationNodes.all(
				  ern,
				  !has(ern.automaticRefresh) || ern.automaticRefresh == false || ern.type == "mutual-pull" || ern.type == "pull"
				)
				"""
			message: "Automatic refresh only can be true if type is 'mutual-pull' or 'pull'."
		}, {
			expression: """
				!has(object.spec.ingress) || !has(object.spec.ingress.extraTlsHosts) || object.spec.ingress.extraTlsHosts == null || object.spec.ingress.extraTlsHosts.all(
				  h,
				  object.spec.ingress.extraTlsHosts.filter(h2, h2.lowerAscii() == h.lowerAscii()).size() == 1
				)
				"""
			message: "Extra TLS hosts addresses must be unique when normalized (case-insensitive)."
		}]
	}
}]
