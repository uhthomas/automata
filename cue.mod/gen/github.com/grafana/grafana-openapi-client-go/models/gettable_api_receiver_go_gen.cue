// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-openapi-client-go/models

package models

// GettableAPIReceiver gettable Api receiver
//
// swagger:model GettableApiReceiver
#GettableAPIReceiver: {
	// discord configs
	discord_configs: [...null | #DiscordConfig] @go(DiscordConfigs,[]*DiscordConfig)

	// email configs
	email_configs: [...null | #EmailConfig] @go(EmailConfigs,[]*EmailConfig)

	// grafana managed receiver configs
	grafana_managed_receiver_configs: [...null | #GettableGrafanaReceiver] @go(GrafanaManagedReceiverConfigs,[]*GettableGrafanaReceiver)

	// msteams configs
	msteams_configs: [...null | #MSTeamsConfig] @go(MsteamsConfigs,[]*MSTeamsConfig)

	// A unique identifier for this receiver.
	name?: string @go(Name)

	// opsgenie configs
	opsgenie_configs: [...null | #OpsGenieConfig] @go(OpsgenieConfigs,[]*OpsGenieConfig)

	// pagerduty configs
	pagerduty_configs: [...null | #PagerdutyConfig] @go(PagerdutyConfigs,[]*PagerdutyConfig)

	// pushover configs
	pushover_configs: [...null | #PushoverConfig] @go(PushoverConfigs,[]*PushoverConfig)

	// slack configs
	slack_configs: [...null | #SlackConfig] @go(SlackConfigs,[]*SlackConfig)

	// sns configs
	sns_configs: [...null | #SNSConfig] @go(SNSConfigs,[]*SNSConfig)

	// telegram configs
	telegram_configs: [...null | #TelegramConfig] @go(TelegramConfigs,[]*TelegramConfig)

	// victorops configs
	victorops_configs: [...null | #VictorOpsConfig] @go(VictoropsConfigs,[]*VictorOpsConfig)

	// webex configs
	webex_configs: [...null | #WebexConfig] @go(WebexConfigs,[]*WebexConfig)

	// webhook configs
	webhook_configs: [...null | #WebhookConfig] @go(WebhookConfigs,[]*WebhookConfig)

	// wechat configs
	wechat_configs: [...null | #WechatConfig] @go(WechatConfigs,[]*WechatConfig)
}
