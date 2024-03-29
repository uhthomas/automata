// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/external-secrets/external-secrets/apis/externalsecrets/v1beta1

package v1beta1

import esmeta "github.com/external-secrets/external-secrets/apis/meta/v1"

#OraclePrincipalType: string // #enumOraclePrincipalType

#enumOraclePrincipalType:
	#UserPrincipal |
	#InstancePrincipal |
	#WorkloadPrincipal

// UserPrincipal represents a user principal.
#UserPrincipal: #OraclePrincipalType & "UserPrincipal"

// InstancePrincipal represents a instance principal.
#InstancePrincipal: #OraclePrincipalType & "InstancePrincipal"

// WorkloadPrincipal represents a workload principal.
#WorkloadPrincipal: #OraclePrincipalType & "Workload"

// Configures an store to sync secrets using a Oracle Vault
// backend.
#OracleProvider: {
	// Region is the region where vault is located.
	region: string @go(Region)

	// Vault is the vault's OCID of the specific vault where secret is located.
	vault: string @go(Vault)

	// The type of principal to use for authentication. If left blank, the Auth struct will
	// determine the principal type. This optional field must be specified if using
	// workload identity.
	// +optional
	principalType?: #OraclePrincipalType @go(PrincipalType)

	// Auth configures how secret-manager authenticates with the Oracle Vault.
	// If empty, use the instance principal, otherwise the user credentials specified in Auth.
	// +optional
	auth?: null | #OracleAuth @go(Auth,*OracleAuth)
}

#OracleAuth: {
	// Tenancy is the tenancy OCID where user is located.
	tenancy: string @go(Tenancy)

	// User is an access OCID specific to the account.
	user: string @go(User)

	// SecretRef to pass through sensitive information.
	secretRef: #OracleSecretRef @go(SecretRef)
}

#OracleSecretRef: {
	// PrivateKey is the user's API Signing Key in PEM format, used for authentication.
	privatekey: esmeta.#SecretKeySelector @go(PrivateKey)

	// Fingerprint is the fingerprint of the API private key.
	fingerprint: esmeta.#SecretKeySelector @go(Fingerprint)
}
