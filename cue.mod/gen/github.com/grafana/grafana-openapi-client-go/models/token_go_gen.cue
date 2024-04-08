// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// Token token
//
// swagger:model Token
#Token: {
	// account
	account?: string @go(Account)

	// anonymous ratio
	anonymousRatio?: int64 @go(AnonymousRatio)

	// company
	company?: string @go(Company)

	// details url
	details_url?: string @go(DetailsURL)

	// exp
	exp?: int64 @go(Exp)

	// iat
	iat?: int64 @go(Iat)

	// included users
	included_users?: int64 @go(IncludedUsers)

	// iss
	iss?: string @go(Iss)

	// jti
	jti?: string @go(Jti)

	// lexp
	lexp?: int64 @go(Lexp)

	// lic exp warn days
	lic_exp_warn_days?: int64 @go(LicExpWarnDays)

	// lid
	lid?: string @go(Lid)

	// limit by
	limit_by?: string @go(LimitBy)

	// max concurrent user sessions
	max_concurrent_user_sessions?: int64 @go(MaxConcurrentUserSessions)

	// nbf
	nbf?: int64 @go(Nbf)

	// prod
	prod: [...string] @go(Prod,[]string)

	// slug
	slug?: string @go(Slug)

	// status
	status?: #TokenStatus @go(Status)

	// sub
	sub?: string @go(Sub)

	// tok exp warn days
	tok_exp_warn_days?: int64 @go(TokExpWarnDays)

	// trial
	trial?: bool @go(Trial)

	// trial exp
	trial_exp?: int64 @go(TrialExp)

	// update days
	update_days?: int64 @go(UpdateDays)

	// usage billing
	usage_billing?: bool @go(UsageBilling)
}