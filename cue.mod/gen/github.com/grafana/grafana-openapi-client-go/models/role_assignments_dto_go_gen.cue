// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// RoleAssignmentsDTO role assignments DTO
//
// swagger:model RoleAssignmentsDTO
#RoleAssignmentsDTO: {
	// role uid
	role_uid?: string @go(RoleUID)

	// service accounts
	service_accounts: [...int64] @go(ServiceAccounts,[]int64)

	// teams
	teams: [...int64] @go(Teams,[]int64)

	// users
	users: [...int64] @go(Users,[]int64)
}
