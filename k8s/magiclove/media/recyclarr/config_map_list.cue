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

_#RecyclarrConfig: {
	#NonEmptyString: strings.MinRunes(1)
	#TrashID:        =~"^[0-9a-f]{32}$"

	#ProfileReference: {
		trash_id?: #TrashID
		name?:     #NonEmptyString
	}

	#CustomFormat: {
		trash_ids: [...#TrashID] & list.UniqueItems()
		score?: int
		assign_scores_to?: [...#ProfileReference & {
			score?: int
		}]
	}

	#CustomFormatGroup: {
		trash_id: #TrashID
		assign_scores_to?: [...#ProfileReference]
		select_all?: bool | *false
		select?: [...#TrashID] & list.UniqueItems()
		exclude?: [...#TrashID] & list.UniqueItems()
	}

	#QualityProfile: {
		trash_id?: #TrashID
		name?:     #NonEmptyString
		reset_unmatched_scores?: {
			enabled: bool
			except?: [...string]
			except_patterns?: [...string]
		}
		score_set?: string | *"default"
		upgrade?: {
			allowed:        bool
			until_quality?: string
			until_score?:   number
		}
		min_format_score?:         number
		min_upgrade_format_score?: number
		quality_sort?:             "bottom" | "top" | *"top"
		qualities?: [...{
			name:     string
			enabled?: bool | *true
			qualities?: [...string]
		}]
	}

	#QualityDefinition: {
		type:             string
		preferred_ratio?: >=0 & <=1 | *1
		qualities?: [...{
			name:       string
			min?:       number | "unlimited"
			max?:       number | "unlimited"
			preferred?: number | "unlimited"
		}]
	}

	#Include: {config: string} | {template: string}

	#Instance: {
		base_url?:           string
		api_key?:            #NonEmptyString
		quality_definition?: #QualityDefinition
		quality_profiles?: [...#QualityProfile]
		delete_old_custom_formats?: bool | *false
		custom_formats?: [...#CustomFormat]
		custom_format_groups?: {
			skip?: [...#TrashID] & list.UniqueItems()
			add?: [...#CustomFormatGroup]
		}
		include?: [...#Include]
		// Specialized for Radarr and Sonarr below.
		media_naming?: _
		media_management?: {
			propers_and_repacks?: string
		}
	}

	radarr: [=~"^[A-Za-z0-9_]+$"]: #Instance & {
		media_naming?: {
			folder?: string
			movie?: {
				rename?:   bool
				standard?: string
			}
		}
	}

	sonarr: [=~"^[A-Za-z0-9_]+$"]: #Instance & {
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
	data: "recyclarr.yml": yaml.Marshal(_#RecyclarrConfig & {
		radarr: radarr_main: {
			base_url: "http://radarr"

			// An !env_var tag is added by an init container.
			// https://recyclarr.dev/reference/configuration/value-substitution
			api_key: "RADARR_API_KEY"

			// Jellyfin understands TMDB IDs in this format. Renaming is enabled for
			// new imports; Recyclarr does not initiate a bulk rename of existing files.
			media_naming: {
				folder: "jellyfin-tmdb"
				movie: {
					rename:   true
					standard: "jellyfin-tmdb"
				}
			}

			// TRaSH scores repacks and propers explicitly with custom formats.
			media_management: propers_and_repacks: "do_not_prefer"

			// Radarr has one global quality definition. Keep the movie definition
			// because this instance serves both standard and anime profiles.
			quality_definition: type: "movie"

			// UHD Bluray + WEB is the everyday 4K choice; Remux is reserved for
			// showcase films, while HD covers titles without a worthwhile 4K release.
			// Existing names are pinned so the first v8 sync adopts old profiles.
			quality_profiles: [{
				trash_id: "64fb5f9858489bdac2af690e27c8f42f" // UHD Bluray + WEB
				reset_unmatched_scores: enabled: true
			}, {
				trash_id: "fd161a61e3ab826d3a22d53f935696dd" // Remux + WEB 2160p
				name:     "Remux + WEB 2160p"
				reset_unmatched_scores: enabled: true
			}, {
				trash_id: "d1d67249d3890e49bc12e275d989a7e9" // HD Bluray + WEB
				reset_unmatched_scores: enabled: true
			}, {
				trash_id: "722b624f9af1e492284c4bc842153a38" // [Anime] Remux-1080p
				name:     "Remux-1080p - Anime"
				reset_unmatched_scores: enabled: true
			}]

			// Start with the official UHD quick-setup choices. Prefer Dolby Vision
			// when it includes an HDR fallback, and reject DV-only releases so other
			// clients are not left with a purple/green image. Keep Web 4K available
			// when HDR is unavailable, but reject SDR disc encodes and remuxes.
			custom_format_groups: add: [{
				trash_id: "f8bf8eab4617f12dfdbd16303d8da245" // [Optional] Golden Rule HD
				select: [
					"dc98083864ea246d05a42df0d05f81cc", // x265 (HD)
				]
			}, {
				trash_id: "ff204bbcecdd487d1cefcefdbf0c278d" // [Optional] Golden Rule UHD
				select: [
					"839bea857ed2c0a8e084f3cbdbd65ecb", // x265 (no HDR/DV)
				]
			}, {
				trash_id: "a3ac6af01d78e4f21fcb75f601ac96df" // [Unwanted] Unwanted Formats
				select: [
					"b8cd450cbfa689c0259a01d9e29ba3d6", // 3D
					"cae4ca30163749b891686f95532519bd", // AV1
					"b6832f586342ef70d9c128d40c07b872", // Bad Dual Groups
					"cc444569854e9de0b084ab2b8b1532b2", // Black and White Editions
					"ed38b889b31be83fda192888e2286d83", // BR-DISK
					"0a3f082873eb454bde444150b70253cc", // Extras
					"e6886871085226c3da1830830146846c", // Generated Dynamic HDR
					"90a6f9a284dff5103f6346090e6280c8", // LQ
					"e204b80c87be9497a8a6eaff48f72905", // LQ (Release Title)
					"712d74cd88bceb883ee32f773656b1f5", // Sing-Along Versions
					"bfd8eb01832d646a0a89c4deb46f8564", // Upscaled
				]
			}, {
				// Reject DV-only releases when no HDR fallback is present.
				trash_id: "7fc2751eef7e6bdc70b74136e5e35c76" // [HDR Formats] DV (w/o HDR fallback)
			}, {
				trash_id: "1616617ab3a14397a2b2321bcbda44d1" // [HDR Formats] DV Boost
			}, {
				trash_id: "f4f1474b963b24cf983455743aa9906c" // [Optional] Movie Versions
				select: [
					"0f12c086e289cf966fa5948eac571f44", // Hybrid
					"eecf3a857724171f968a66cb5719e152", // IMAX
					"9f6cbff8cfe4ebbc1bde14c7b7bec0de", // IMAX Enhanced
				]
			}, {
				trash_id: "47f0d69750de9e16855915fa73bb7b08" // [HDR Formats] SDR
				select: [
					"25c12f78430a3a23413652cbd1d48d77", // SDR (no WEBDL)
				]
			}]
		}

		sonarr: sonarr_main: {
			base_url: "http://sonarr"

			// An !env_var tag is added by an init container.
			// https://recyclarr.dev/reference/configuration/value-substitution
			api_key: "SONARR_API_KEY"

			// Jellyfin uses the TVDB ID to disambiguate series. Episode names keep
			// the codec, HDR, audio, custom-format, and release-group information.
			media_naming: {
				series: "jellyfin-tvdb"
				season: "default"
				episodes: {
					rename:   true
					standard: "default"
					daily:    "default"
					anime:    "default"
				}
			}

			media_management: propers_and_repacks: "do_not_prefer"

			// Sonarr has one global quality definition. Keep the series definition
			// because this instance serves both standard and anime profiles.
			quality_definition: type: "series"

			// Use 1080p for everyday/long-running TV and 2160p for visually rich
			// shows. Existing names are pinned so the first v8 sync adopts them.
			quality_profiles: [{
				trash_id: "72dae194fc92bf828f32cde7744e51a1" // WEB-1080p
				reset_unmatched_scores: enabled: true
			}, {
				trash_id: "d1498e7d189fbe6c7110ceaabb7473e6" // WEB-2160p
				name:     "WEB-2160p"
				reset_unmatched_scores: enabled: true
			}, {
				trash_id: "20e0fc959f1f1704bed501f23bdae76f" // [Anime] Remux-1080p
				name:     "Remux-1080p - Anime"
				reset_unmatched_scores: enabled: true
			}]

			// Apply the official HD and UHD quick-setup choices to their compatible
			// profiles. The OLED policy mirrors Radarr: safe DV is preferred, DV-only
			// is rejected, and SDR Web remains a fallback when HDR is unavailable.
			custom_format_groups: add: [{
				trash_id: "158188097a58d7687dee647e04af0da3" // [Optional] Golden Rule HD
				select: [
					"47435ece6b99a0b477caf360e79ba0bb", // x265 (HD)
				]
			}, {
				trash_id: "e3f37512790f00d0e89e54fe5e790d1c" // [Optional] Golden Rule UHD
				select: [
					"9b64dff695c2115facf1b6ea59c9bd07", // x265 (no HDR/DV)
				]
			}, {
				trash_id: "85fae4a2294965b75710ef2989c850eb" // [Streaming Services] HD/UHD boost
			}, {
				trash_id: "59c3af66780d08332fdc64e68297098f" // [Unwanted] Unwanted Formats
				select: [
					"15a05bc7c1a36e2b57fd628f8977e2fc", // AV1
					"32b367365729d530ca1c124a0b180c64", // Bad Dual Groups
					"85c61753df5da1fb2aab6f2a47426b09", // BR-DISK
					"6f808933a71bd9666531610cb8c059cc", // BR-DISK (BTN)
					"fbcb31d8dabd2a319072b84fc0b7249c", // Extras
					"9c11cd3f07101cdba90a2d81cf0e56b4", // LQ
					"e2315f990da2e2cbfc9fa5b7a6fcfe48", // LQ (Release Title)
					"23297a736ca77c0fc8e70f8edd7ee56c", // Upscaled
				]
			}, {
				// Reject DV-only releases when no HDR fallback is present.
				trash_id: "d776a1ea912a117d66d83b880ff2055d" // [HDR Formats] DV (w/o HDR fallback)
			}, {
				trash_id: "e0b2774083df4265f25c9e5bc6c80940" // [HDR Formats] DV Boost
			}, {
				trash_id: "e1053c0ef622df3749fa43c22865663a" // [HDR Formats] SDR
				select: [
					"83304f261cf516bb208c18c54c0adf97", // SDR (no WEBDL)
				]
			}]
		}
	})
}]
