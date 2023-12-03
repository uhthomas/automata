package recyclarr

import (
	"encoding/yaml"
	"list"
	"strings"

	"k8s.io/api/core/v1"
)

#ConfigMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

_#RecylarrConfig: {
	#TrashID: string & {
		strings.MinRunes(32)
		=~"^[0-9a-fA-F]+$"
	}

	#CustomFormat: {
		trash_ids: [...#TrashID] & list.UniqueItems()
		quality_profiles?: [...{
			name:   string
			score?: int
		}]
	}

	#QualityProfile: {
		name: string
		reset_unmatched_scores?: {
			enabled: bool
			except?: [...string]
		}
		score_set?: string | *"default"
		upgrade?: {
			allowed:        bool
			until_quality?: string
			until_score?:   number
		}
		min_format_score?: number
		quality_sort?:     "bottom" | "top" | *"top"
		qualities?: [...{
			name:     string
			enabled?: bool | *true
			qualities?: [...string]
		}]
	}

	#QualityDefinition: {
		type:             string
		preferred_ratio?: >=0 & <=1 | *1
	}

	#Include: {config: string} | {template: string}

	#ReleaseProfile: {
		trash_ids:               [...#TrashID] & list.UniqueItems()
		strict_negative_scores?: bool | *false
		tags?: [...string]
		filter?: {
			include: [...#TrashID] & list.UniqueItems()
		} | {
			exclude: [...#TrashID] & list.UniqueItems()
		}
	}

	#Instance: {
		base_url?:           string
		api_key?:            strings.MinRunes(1)
		quality_definition?: #QualityDefinition
		quality_profiles?: [...#QualityProfile]
		delete_old_custom_formats?:       bool | *false
		replace_existing_custom_formats?: bool | *false
		custom_formats?: [...#CustomFormat]
		include?: [...#Include]
	}

	radarr: [=~"^.*$" & !~"^()$"]: #Instance & {
		media_naming?: {
			folder?: string
			movie?: {
				rename?:   bool
				standard?: string
			}
		}
	}

	sonarr: [=~"^.*$" & !~"^()$"]: #Instance & {
		release_profiles?: [...#ReleaseProfile]
		media_naming?: {
			season?: string
			series?: string
			episodes?: {
				rename?:   bool
				standard?: string
				daily?:    string
				anime?:    string
			}
		}
	}
}

#ConfigMapList: items: [{
	// Mostly copied from https://recyclarr.dev/wiki/guide-configs/
	data: "config.yaml": yaml.Marshal(_#RecylarrConfig & {
		radarr: "radarr-main": {
			base_url: "http://radarr"

			// An "env_var!" tag is added by an init container.
			//
			// https://recyclarr.dev/wiki/yaml/env-vars
			api_key: "RADARR_API_KEY"

			// Comment out any of the following includes to disable them
			include: [{
				template: "radarr-quality-definition-movie"
			}, {
				template: "radarr-quality-profile-remux-web-2160p"
			}, {
				template: "radarr-custom-formats-remux-web-2160p"
			}, {
				template: "radarr-quality-profile-anime"
			}, {
				template: "radarr-custom-formats-anime"
			}]

			// Custom Formats: https://recyclarr.dev/wiki/yaml/config-reference/custom-formats/
			custom_formats: [{
				// Audio
				// Uncomment the next section to enable Advanced Audio Formats
				// "496f355514737f7d83bf7aa4d24f8169", // TrueHD Atmos
				// "2f22d89048b01681dde8afe203bf2e95", // DTS X
				// "417804f7f2c4308c1f4c5d380d4c4475", // ATMOS (undefined)
				// "1af239278386be2919e1bcee0bde047e", // DD+ ATMOS
				// "3cafb66171b47f226146a0770576870f", // TrueHD
				// "dcf3ec6938fa32445f590a4da84256cd", // DTS-HD MA
				// "a570d4a0e56a2874b64e5bfa55202a1b", // FLAC
				// "e7c2fcae07cbada050a0af3357491d7b", // PCM
				// "8e109e50e0a0b83a5098b056e13bf6db", // DTS-HD HRA
				// "185f1dd7264c4562b9022d963ac37424", // DD+
				// "f9f847ac70a0af62ea4a08280b859636", // DTS-ES
				// "1c1a4c5e823891c75bc50380a6866f73", // DTS
				// "240770601cc226190c367ef59aba7463", // AAC
				// "c2998bd0d90ed5621d8df281e839436e", // DD
				quality_profiles: [{name: "Remux + WEB 2160p"}]
			}, {
				// Movie Versions
				trash_ids: ["9f6cbff8cfe4ebbc1bde14c7b7bec0de"] // IMAX Enhanced
				quality_profiles: [{name: "Remux + WEB 2160p"}]
			}, {
				// score: 0 # Uncomment this line to disable prioritised IMAX Enhanced releases
				// Optional
				trash_ids: [
					// Comment out the next line if you and all of your users' setups are fully DV compatible
					"923b6abef9b17f937fab56cfcf89e1f1", // DV (WEBDL)

					// HDR10Plus Boost - Uncomment the next line if any of your devices DO support HDR10+
					// "b17886cb4158d9fea189859409975758", // HDR10Plus Boost
				]
				quality_profiles: [{name: "Remux + WEB 2160p"}]
			}, {
				trash_ids: ["9c38ebb7384dada637be8899efa68e6f"] // SDR
				quality_profiles: [{name: "Remux + WEB 2160p"}]
			}, {
				trash_ids: ["064af5f084a0a24458cc8ecd3220f93f"] // Uncensored
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 0
				}]
			}, {
				trash_ids: ["a5d148168c4506b55cf53984107c396e"] // 10bit
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 0
				}]
			}, {

				trash_ids: ["4a3b087eea2ce012fcc1ce319259a3be"] // Anime Dual Audio
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 0
				}]
			}]
		}
		sonarr: "sonarr-main": {
			base_url: "http://sonarr"

			// An "env_var!" tag is added by an init container.
			//
			// https://recyclarr.dev/wiki/yaml/env-vars
			api_key: "SONARR_API_KEY"

			// Comment out any of the following includes to disable them
			include: [{
				template: "sonarr-quality-definition-series"
			}, {
				template: "sonarr-v4-quality-profile-web-2160p"
			}, {
				template: "sonarr-v4-custom-formats-web-2160p"
			}, {
				template: "sonarr-v4-quality-profile-anime"
			}, {
				template: "sonarr-v4-custom-formats-anime"
			}]

			// Custom Formats: https://recyclarr.dev/wiki/yaml/config-reference/custom-formats/
			custom_formats: [{
				// HDR Formats
				trash_ids: [
					// Comment out the next line if you and all of your users' setups are fully DV compatible
					"9b27ab6498ec0f31a3353992e19434ca", // DV (WEBDL)

					// HDR10Plus Boost - Uncomment the next line if any of your devices DO support HDR10+
					// "0dad0a507451acddd754fe6dc3a7f5e7", // HDR10Plus Boost
				]
				quality_profiles: [{name: "WEB-2160p"}]
			}, {
				// Optional
				trash_ids: ["2016d1676f5ee13a5b7257ff86ac9a93"] // SDR
				quality_profiles: [{name: "WEB-2160p"}]
			}, {
				trash_ids: ["026d5aadd1a6b4e550b134cb6c72b3ca"] // Uncensored
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 0
				}]
			}, {

				trash_ids: ["b2550eb333d27b75833e25b8c2557b38"] // 10bit
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 0
				}]
			}, {

				trash_ids: ["418f50b10f1907201b6cfdf881f467b7"] // Anime Dual Audio
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 0
				}]
			}]
		}
	})
}]
