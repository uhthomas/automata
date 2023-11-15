package recyclarr

import (
	"encoding/yaml"
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

	#CustomFormats: {
		trash_ids: [...#TrashID]
		quality_profiles?: [...{
			name:   string
			score?: int
		}]
	}

	#QualityProfiles: {
		name:                    string
		reset_unmatched_scores?: bool
	}

	#QualityDefinition: {
		type:             string
		preferred_ratio?: number & >=0 & <=1
	}

	#Instance: {
		base_url:            string
		api_key?:            string
		quality_definition?: #QualityDefinition
		quality_profiles?: [...#QualityProfiles]
		delete_old_custom_formats?:       bool
		replace_existing_custom_formats?: bool
		custom_formats?: [...#CustomFormats]
	}

	sonarr: [string]: #Instance
	radarr: [string]: #Instance
}

#ConfigMapList: items: [{
	data: "config.yaml": yaml.Marshal(_#RecylarrConfig & {
		radarr: main: {
			base_url: "http://radarr"
			// An "env_var!" tag is added by an init container.
			//
			// https://recyclarr.dev/wiki/yaml/env-vars
			api_key: "RADARR_API_KEY"
			quality_definition: type: "movie"
			quality_profiles: [{
				name:                   "Remux + WEB 2160p"
				reset_unmatched_scores: true
			}, {
				name:                   "Remux + WEB 1080p"
				reset_unmatched_scores: true
			}, {
				name:                   "Remux-1080p - Anime"
				reset_unmatched_scores: true
			}]
			custom_formats: [{
				trash_ids: [
					// Audio - Uncomment the next section if you are using the Advanced Audio Formats
					"496f355514737f7d83bf7aa4d24f8169", // TrueHD Atmos
					"2f22d89048b01681dde8afe203bf2e95", // DTS X
					"417804f7f2c4308c1f4c5d380d4c4475", // ATMOS (undefined)
					"1af239278386be2919e1bcee0bde047e", // DD+ ATMOS
					"3cafb66171b47f226146a0770576870f", // TrueHD
					"dcf3ec6938fa32445f590a4da84256cd", // DTS-HD MA
					"a570d4a0e56a2874b64e5bfa55202a1b", // FLAC
					"e7c2fcae07cbada050a0af3357491d7b", // PCM
					"8e109e50e0a0b83a5098b056e13bf6db", // DTS-HD HRA
					"185f1dd7264c4562b9022d963ac37424", // DD+
					"f9f847ac70a0af62ea4a08280b859636", // DTS-ES
					"1c1a4c5e823891c75bc50380a6866f73", // DTS
					"240770601cc226190c367ef59aba7463", // AAC
					"c2998bd0d90ed5621d8df281e839436e", // DD
					// All HDR Formats
					"e23edd2482476e595fb990b12e7c609c", // DV HDR10
					"58d6a88f13e2db7f5059c41047876f00", // DV
					"55d53828b9d81cbe20b02efd00aa0efd", // DV HLG
					"a3e19f8f627608af0211acd02bf89735", // DV SDR
					"b974a6cd08c1066250f1f177d7aa1225", // HDR10+
					"dfb86d5941bc9075d6af23b09c2aeecd", // HDR10
					"e61e28db95d22bedcadf030b8f156d96", // HDR
					"2a4d9069cc1fe3242ff9bdaebed239bb", // HDR (undefined)
					"08d6d8834ad9ec87b1dc7ec8148e7a1f", // PQ
					"9364dd386c9b4a1100dde8264690add7", // HLG
					// DV (WEBDL) - The next line is uncommented by default, and ensures that releases with Dolby Vision will only be grabbed if they have HDR10 fallback. You can comment the line out if you do not need HDR10 fallback
					"923b6abef9b17f937fab56cfcf89e1f1", // DV (WEBDL)
					// HDR10Plus Boost - Uncomment the next line if any of your devices DO support HDR10+
					"b17886cb4158d9fea189859409975758", // HDR10Plus Boost
					// Movie Versions
					"0f12c086e289cf966fa5948eac571f44", // Hybrid
					"570bc9ebecd92723d2d21500f4be314c", // Remaster
					"eca37840c13c6ef2dd0262b141a5482f", // 4K Remaster
					"e0c07d59beb37348e975a930d5e50319", // Criterion Collection
					"9d27d9d2181838f76dee150882bdc58c", // Masters of Cinema
					"db9b4c4b53d312a3ca5f1378f6440fc9", // Vinegar Syndrome
					"957d0f44b592285f26449575e8b1167e", // Special Edition
					"eecf3a857724171f968a66cb5719e152", // IMAX
					"9f6cbff8cfe4ebbc1bde14c7b7bec0de", // IMAX Enhanced
					// HQ Release Groups
					"3a3ff47579026e76d6504ebea39390de", // Remux Tier 01
					"9f98181fe5a3fbeb0cc29340da2a468a", // Remux Tier 02
					"c20f169ef63c5f40c2def54abaf4438e", // WEB Tier 01
					"403816d65392c79236dcb6dd591aeda4", // WEB Tier 02
					"af94e0fe497124d1f9ce732069ec8c3b", // WEB Tier 03
					// Misc
					"e7718d7a3ce595f289bfee26adc178f5", // Repack/Proper
					"ae43b294509409a6a13919dedd4764c4", // Repack2
					// Unwanted
					"ed38b889b31be83fda192888e2286d83", // BR-DISK
					"90a6f9a284dff5103f6346090e6280c8", // LQ
					"b8cd450cbfa689c0259a01d9e29ba3d6", // 3D
					"9c38ebb7384dada637be8899efa68e6f", // SDR
					// Streaming Services
					"cc5e51a9e85a6296ceefe097a77f12f4", // BCORE
					"2a6039655313bf5dab1e43523b62c374", // MA
				]
				quality_profiles: [{
					name: "Remux + WEB 2160p"
				}]
			}, {
				trash_ids: [
					"b3b3a6ac74ecbd56bcdbefa4799fb9df", // AMZN
					"40e9380490e748672c2522eaaeb692f7", // ATVP
					"84272245b2988854bfb76a16e60baea5", // DSNP
					"509e5f41146e278f9eab1ddaceb34515", // HBO
					"5763d1b0ce84aff3b21038eea8e9b8ad", // HMAX
					"526d445d4c16214309f0fd2b3be18a89", // Hulu
					"170b1d363bd8516fbf3a3eb05d4faff6", // NF
					"c9fd353f8f5f1baf56dc601c4cb29920", // PCOK
					"e36a0ba1bc902b26ee40818a1d59b8bd", // PMTP
					"c2863d2a50c9acad1fb50e53ece60817", // STAN
				]
				quality_profiles: [{
					name:  "Remux + WEB 2160p"
					score: 0
				}]
			}, {
				trash_ids: [
					// Audio - Uncomment the next section if you are using the Advanced Audio Formats
					"496f355514737f7d83bf7aa4d24f8169", // TrueHD Atmos
					"2f22d89048b01681dde8afe203bf2e95", // DTS X
					"417804f7f2c4308c1f4c5d380d4c4475", // ATMOS (undefined)
					"1af239278386be2919e1bcee0bde047e", // DD+ ATMOS
					"3cafb66171b47f226146a0770576870f", // TrueHD
					"dcf3ec6938fa32445f590a4da84256cd", // DTS-HD MA
					"a570d4a0e56a2874b64e5bfa55202a1b", // FLAC
					"e7c2fcae07cbada050a0af3357491d7b", // PCM
					"8e109e50e0a0b83a5098b056e13bf6db", // DTS-HD HRA
					"185f1dd7264c4562b9022d963ac37424", // DD+
					"f9f847ac70a0af62ea4a08280b859636", // DTS-ES
					"1c1a4c5e823891c75bc50380a6866f73", // DTS
					"240770601cc226190c367ef59aba7463", // AAC
					"c2998bd0d90ed5621d8df281e839436e", // DD
					// Movie Versions
					"0f12c086e289cf966fa5948eac571f44", // Hybrid
					"570bc9ebecd92723d2d21500f4be314c", // Remaster
					"eca37840c13c6ef2dd0262b141a5482f", // 4K Remaster
					"e0c07d59beb37348e975a930d5e50319", // Criterion Collection
					"9d27d9d2181838f76dee150882bdc58c", // Masters of Cinema
					"db9b4c4b53d312a3ca5f1378f6440fc9", // Vinegar Syndrome
					"957d0f44b592285f26449575e8b1167e", // Special Edition
					"eecf3a857724171f968a66cb5719e152", // IMAX
					"9f6cbff8cfe4ebbc1bde14c7b7bec0de", // IMAX Enhanced
					// HQ Release Groups
					"3a3ff47579026e76d6504ebea39390de", // Remux Tier 01
					"9f98181fe5a3fbeb0cc29340da2a468a", // Remux Tier 02
					"c20f169ef63c5f40c2def54abaf4438e", // WEB Tier 01
					"403816d65392c79236dcb6dd591aeda4", // WEB Tier 02
					"af94e0fe497124d1f9ce732069ec8c3b", // WEB Tier 03
					// Misc
					"e7718d7a3ce595f289bfee26adc178f5", // Repack/Proper
					"ae43b294509409a6a13919dedd4764c4", // Repack2
					// Unwanted
					"ed38b889b31be83fda192888e2286d83", // BR-DISK
					"90a6f9a284dff5103f6346090e6280c8", // LQ
					"dc98083864ea246d05a42df0d05f81cc", // x265 (HD)
					"b8cd450cbfa689c0259a01d9e29ba3d6", // 3D
					// Streaming Services
					"cc5e51a9e85a6296ceefe097a77f12f4", // BCORE
					"2a6039655313bf5dab1e43523b62c374", // MA
				]
				quality_profiles: [{
					name: "Remux + WEB 1080p"
				}]
			}, {
				trash_ids: [
					// Streaming Services
					"b3b3a6ac74ecbd56bcdbefa4799fb9df", // AMZN
					"40e9380490e748672c2522eaaeb692f7", // ATVP
					"84272245b2988854bfb76a16e60baea5", // DSNP
					"509e5f41146e278f9eab1ddaceb34515", // HBO
					"5763d1b0ce84aff3b21038eea8e9b8ad", // HMAX
					"526d445d4c16214309f0fd2b3be18a89", // Hulu
					"170b1d363bd8516fbf3a3eb05d4faff6", // NF
					"c9fd353f8f5f1baf56dc601c4cb29920", // PCOK
					"e36a0ba1bc902b26ee40818a1d59b8bd", // PMTP
					"c2863d2a50c9acad1fb50e53ece60817", // STAN
				]
				quality_profiles: [{
					name:  "Remux + WEB 1080p"
					score: 0
				}]
			}, {
				trash_ids: [
					// Anime CF/Scoring
					"fb3ccc5d5cc8f77c9055d4cb4561dded", // Anime BD Tier 01 (Top SeaDex Muxers)
					"66926c8fa9312bc74ab71bf69aae4f4a", // Anime BD Tier 02 (SeaDex Muxers)
					"fa857662bad28d5ff21a6e611869a0ff", // Anime BD Tier 03 (SeaDex Muxers)
					"f262f1299d99b1a2263375e8fa2ddbb3", // Anime BD Tier 04 (SeaDex Muxers)
					"ca864ed93c7b431150cc6748dc34875d", // Anime BD Tier 05 (Remuxes)
					"9dce189b960fddf47891b7484ee886ca", // Anime BD Tier 06 (FanSubs)
					"1ef101b3a82646b40e0cab7fc92cd896", // Anime BD Tier 07 (P2P/Scene)
					"6115ccd6640b978234cc47f2c1f2cadc", // Anime BD Tier 08 (Mini Encodes)
					"8167cffba4febfb9a6988ef24f274e7e", // Anime Web Tier 01 (Muxers)
					"8526c54e36b4962d340fce52ef030e76", // Anime Web Tier 02 (Top FanSubs)
					"de41e72708d2c856fa261094c85e965d", // Anime Web Tier 03 (Official Subs)
					"9edaeee9ea3bcd585da9b7c0ac3fc54f", // Anime Web Tier 04 (Official Subs)
					"22d953bbe897857b517928f3652b8dd3", // Anime Web Tier 05 (FanSubs)
					"a786fbc0eae05afe3bb51aee3c83a9d4", // Anime Web Tier 06 (FanSubs)
					"b0fdc5897f68c9a68c70c25169f77447", // Anime LQ Groups
					"c259005cbaeb5ab44c06eddb4751e70c", // v0
					"5f400539421b8fcf71d51e6384434573", // v1
					"3df5e6dfef4b09bb6002f732bed5b774", // v2
					"db92c27ba606996b146b57fbe6d09186", // v3
					"d4e5e842fad129a3c097bdb2d20d31a0", // v4
					// Anime Streaming Services
					"60f6d50cbd3cfc3e9a8c00e3a30c3114", // VRV
				]
				quality_profiles: [{
					name: "Remux-1080p - Anime"
				}]
			}, {
				trash_ids: [
					"9172b2f683f6223e3a1846427b417a3d", // VOSTFR
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: -10000
				}]
			}, {
				trash_ids: [
					"3a3ff47579026e76d6504ebea39390de", // Remux Tier 01
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 1050
				}]
			}, {
				trash_ids: [
					"9f98181fe5a3fbeb0cc29340da2a468a", // Remux Tier 02
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 1000
				}]
			}, {
				trash_ids: [
					"4a3b087eea2ce012fcc1ce319259a3be", // Anime Dual Audio
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 0
				}]
			}, {
				trash_ids: [
					"064af5f084a0a24458cc8ecd3220f93f", // Uncensored
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 0
				}]
			}, {
				trash_ids: [
					"a5d148168c4506b55cf53984107c396e", // 10bit
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 0
				}]
			}, {
				trash_ids: [
					"06b6542a47037d1e33b15aa3677c2365", // Anime Raws
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: -10000
				}]
			}, {
				trash_ids: [
					"b23eae459cc960816f2d6ba84af45055", // Dubs Only
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: -10000
				}]
			}]
		}
		sonarr: main: {
			base_url: "http://sonarr"
			// An "env_var!" tag is added by an init container.
			//
			// https://recyclarr.dev/wiki/yaml/env-vars
			api_key: "SONARR_API_KEY"
			quality_definition: type: "series"
			quality_profiles: [{
				name:                   "WEB-2160p"
				reset_unmatched_scores: true
			}, {
				name:                   "WEB-1080p"
				reset_unmatched_scores: true
			}, {
				name:                   "Remux-1080p - Anime"
				reset_unmatched_scores: true
			}]
			custom_formats: [{
				trash_ids: [
					// HDR Formats
					"7878c33f1963fefb3d6c8657d46c2f0a", // DV HDR10
					"1f733af03141f068a540eec352589a89", // DV HLG
					"27954b0a80aab882522a88a4d9eae1cd", // DV SDR
					"6d0d8de7b57e35518ac0308b0ddf404e", // DV
					"bb019e1cd00f304f80971c965de064dc", // HDR (undefined)
					"3e2c4e748b64a1a1118e0ea3f4cf6875", // HDR
					"3497799d29a085e2ac2df9d468413c94", // HDR10
					"a3d82cbef5039f8d295478d28a887159", // HDR10+
					"17e889ce13117940092308f48b48b45b", // HLG
					"2a7e3be05d3861d6df7171ec74cad727", // PQ
					// DV (WEBDL) - The next line is uncommented by default, and ensures that releases with Dolby Vision will only be grabbed if they have HDR10 fallback. You can comment the line out if you do not need HDR10 fallback
					"9b27ab6498ec0f31a3353992e19434ca", // DV (WEBDL)
					// HDR10Plus Boost - Uncomment the next line if any of your devices DO support HDR10+
					// - 0dad0a507451acddd754fe6dc3a7f5e7  // HDR10Plus Boost
					// Unwanted UHD
					"85c61753df5da1fb2aab6f2a47426b09", // BR-DISK
					"9c11cd3f07101cdba90a2d81cf0e56b4", // LQ
					"2016d1676f5ee13a5b7257ff86ac9a93", // SDR
					// Misc
					"ec8fa7296b64e8cd390a1600981f3923", // Repack/Proper
					"eb3d5cc0a2be0db205fb823640db6a3c", // Repack v2
					"44e7c4de10ae50265753082e5dc76047", // Repack v3
					// Streaming Services
					"d660701077794679fd59e8bdf4ce3a29", // AMZN
					"f67c9ca88f463a48346062e8ad07713f", // ATVP
					"36b72f59f4ea20aad9316f475f2d9fbb", // DCU
					"89358767a60cc28783cdc3d0be9388a4", // DSNP
					"7a235133c87f7da4c8cccceca7e3c7a6", // HBO
					"a880d6abc21e7c16884f3ae393f84179", // HMAX
					"f6cce30f1733d5c8194222a7507909bb", // HULU
					"0ac24a2a68a9700bcb7eeca8e5cd644c", // iT
					"d34870697c9db575f17700212167be23", // NF
					"b2b980877494b560443631eb1f473867", // NLZ
					"1656adc6d7bb2c8cca6acfb6592db421", // PCOK
					"c67a75ae4a1715f2bb4d492755ba4195", // PMTP
					"3ac5d84fce98bab1b531393e9c82f467", // QIBI
					"c30d2958827d1867c73318a5a2957eb1", // RED
					"ae58039e1319178e6be73caab5c42166", // SHO
					"1efe8da11bfd74fbbcd4d8117ddb9213", // STAN
					"5d2317d99af813b6529c7ebf01c83533", // VDL
					"77a7b25585c18af08f60b1547bb9b4fb", // CC
					// HQ Source Groups
					"e6258996055b9fbab7e9cb2f75819294", // WEB Tier 01
					"58790d4e2fdcd9733aa7ae68ba2bb503", // WEB Tier 02
					"d84935abd3f8556dcd51d4f27e22d0a6", // WEB Tier 03
					"d0c516558625b04b363fa6c5c2c7cfd4", // WEB Scene
				]
				quality_profiles: [{
					name: "WEB-2160p"
				}]
			}, {
				trash_ids: [
					// Unwanted
					"85c61753df5da1fb2aab6f2a47426b09", // BR-DISK
					"9c11cd3f07101cdba90a2d81cf0e56b4", // LQ
					"47435ece6b99a0b477caf360e79ba0bb", // x265 (HD)
					// Misc
					"ec8fa7296b64e8cd390a1600981f3923", // Repack/Proper
					"eb3d5cc0a2be0db205fb823640db6a3c", // Repack v2
					"44e7c4de10ae50265753082e5dc76047", // Repack v3
					// Streaming Services
					"d660701077794679fd59e8bdf4ce3a29", // AMZN
					"f67c9ca88f463a48346062e8ad07713f", // ATVP
					"36b72f59f4ea20aad9316f475f2d9fbb", // DCU
					"89358767a60cc28783cdc3d0be9388a4", // DSNP
					"7a235133c87f7da4c8cccceca7e3c7a6", // HBO
					"a880d6abc21e7c16884f3ae393f84179", // HMAX
					"f6cce30f1733d5c8194222a7507909bb", // HULU
					"0ac24a2a68a9700bcb7eeca8e5cd644c", // iT
					"d34870697c9db575f17700212167be23", // NF
					"b2b980877494b560443631eb1f473867", // NLZ
					"1656adc6d7bb2c8cca6acfb6592db421", // PCOK
					"c67a75ae4a1715f2bb4d492755ba4195", // PMTP
					"3ac5d84fce98bab1b531393e9c82f467", // QIBI
					"c30d2958827d1867c73318a5a2957eb1", // RED
					"ae58039e1319178e6be73caab5c42166", // SHO
					"1efe8da11bfd74fbbcd4d8117ddb9213", // STAN
					"5d2317d99af813b6529c7ebf01c83533", // VDL
					"77a7b25585c18af08f60b1547bb9b4fb", // CC
					// HQ Source Groups
					"e6258996055b9fbab7e9cb2f75819294", // WEB Tier 01
					"58790d4e2fdcd9733aa7ae68ba2bb503", // WEB Tier 02
					"d84935abd3f8556dcd51d4f27e22d0a6", // WEB Tier 03
					"d0c516558625b04b363fa6c5c2c7cfd4", // WEB Scene
				]
				quality_profiles: [{
					name: "WEB-1080p"
				}]
			}, {
				trash_ids: [
					// Anime CF/Scoring
					"949c16fe0a8147f50ba82cc2df9411c9", // Anime BD Tier 01 (Top SeaDex Muxers)
					"ed7f1e315e000aef424a58517fa48727", // Anime BD Tier 02 (SeaDex Muxers)
					"096e406c92baa713da4a72d88030b815", // Anime BD Tier 03 (SeaDex Muxers)
					"30feba9da3030c5ed1e0f7d610bcadc4", // Anime BD Tier 04 (SeaDex Muxers)
					"545a76b14ddc349b8b185a6344e28b04", // Anime BD Tier 05 (Remuxes)
					"25d2afecab632b1582eaf03b63055f72", // Anime BD Tier 06 (FanSubs)
					"0329044e3d9137b08502a9f84a7e58db", // Anime BD Tier 07 (P2P/Scene)
					"c81bbfb47fed3d5a3ad027d077f889de", // Anime BD Tier 08 (Mini Encodes)
					"e0014372773c8f0e1bef8824f00c7dc4", // Anime Web Tier 01 (Muxers)
					"19180499de5ef2b84b6ec59aae444696", // Anime Web Tier 02 (Top FanSubs)
					"c27f2ae6a4e82373b0f1da094e2489ad", // Anime Web Tier 03 (Official Subs)
					"4fd5528a3a8024e6b49f9c67053ea5f3", // Anime Web Tier 04 (Official Subs)
					"29c2a13d091144f63307e4a8ce963a39", // Anime Web Tier 05 (FanSubs)
					"dc262f88d74c651b12e9d90b39f6c753", // Anime Web Tier 06 (FanSubs)
					"e3515e519f3b1360cbfc17651944354c", // Anime LQ Groups
					"d2d7b8a9d39413da5f44054080e028a3", // v0
					"273bd326df95955e1b6c26527d1df89b", // v1
					"228b8ee9aa0a609463efca874524a6b8", // v2
					"0e5833d3af2cc5fa96a0c29cd4477feb", // v3
					"4fc15eeb8f2f9a749f918217d4234ad8", // v4
					// Anime Streaming Services
					"d660701077794679fd59e8bdf4ce3a29", // AMZN
					"3e0b26604165f463f3e8e192261e7284", // CR
					"89358767a60cc28783cdc3d0be9388a4", // DSNP
					"1284d18e693de8efe0fe7d6b3e0b9170", // FUNi
					"d34870697c9db575f17700212167be23", // NF
					"44a8ee6403071dd7b8a3a8dd3fe8cb20", // VRV
				]
				quality_profiles: [{
					name: "Remux-1080p - Anime"
				}]
			}, {
				trash_ids: [
					// Anime Streaming Services
					"7dd31f3dee6d2ef8eeaa156e23c3857e", // B-Global
					"4c67ff059210182b59cdd41697b8cb08", // Bilibili
					"570b03b3145a25011bf073274a407259", // HIDIVE
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 0
				}]
			}, {
				trash_ids: [
					"15a05bc7c1a36e2b57fd628f8977e2fc", // AV1
					"07a32f77690263bb9fda1842db7e273f", // VOSTFR
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: -10000
				}]
			}, {
				trash_ids: [
					"e6258996055b9fbab7e9cb2f75819294", // WEB Tier 01
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 450
				}]
			}, {
				trash_ids: [
					"58790d4e2fdcd9733aa7ae68ba2bb503", // WEB Tier 02
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 400
				}]
			}, {
				trash_ids: [
					"d84935abd3f8556dcd51d4f27e22d0a6", // WEB Tier 03
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 350
				}]
			}, {
				trash_ids: [
					"418f50b10f1907201b6cfdf881f467b7", // Anime Dual Audio
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 0
				}]
			}, {
				trash_ids: [
					"026d5aadd1a6b4e550b134cb6c72b3ca", // Uncensored
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 0
				}]
			}, {
				trash_ids: [
					"b2550eb333d27b75833e25b8c2557b38", // 10bit
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: 0
				}]
			}, {
				trash_ids: [
					"b4a1b3d705159cdca36d71e57ca86871", // Anime Raws
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: -10000
				}]
			}, {
				trash_ids: [
					"9c14d194486c4014d422adc64092d794", // Dubs Only
				]
				quality_profiles: [{
					name:  "Remux-1080p - Anime"
					score: -10000
				}]
			}]
		}
	})
}]