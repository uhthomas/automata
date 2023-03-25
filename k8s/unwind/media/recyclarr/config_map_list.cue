package recyclarr

import (
	// "encoding/yaml"
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
			name:  string
			score: int
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

	sonarr: [string]: {
		base_url:            string
		api_key:             string
		quality_definition?: #QualityDefinition
		quality_profiles?: [...#QualityProfiles]
		delete_old_custom_formats?:       bool
		replace_existing_custom_formats?: bool
		custom_formats?: [...#CustomFormats]
	}
	radarr: [string]: {
		base_url:            string
		api_key:             string
		quality_definition?: #QualityDefinition
		quality_profiles?: [...#QualityProfiles]
		delete_old_custom_formats?:       bool
		replace_existing_custom_formats?: bool
		custom_formats?: [...#CustomFormats]
	}
}

#ConfigMapList: items: [{
	// data: "config.yaml": yaml.Marshal(_#RecylarrConfig & {
	//  radarr: main: {
	//   base_url: "!secret radarr_url"
	//   api_key:  "!secret radarr_apikey"
	//   quality_definition: {
	//    type:            "movie"
	//    preferred_ratio: 0.5
	//   }
	//   custom_formats: [{
	//    trash_ids: [
	//     "ed38b889b31be83fda192888e2286d83", // BR-DISK
	//     "90cedc1fea7ea5d11298bebd3d1d3223", // EVO (no WEBDL)
	//     "90a6f9a284dff5103f6346090e6280c8", // LQ
	//     "dc98083864ea246d05a42df0d05f81cc", // x265 (720/1080p)
	//     "b8cd450cbfa689c0259a01d9e29ba3d6", // 3D
	//     "ae9b7c9ebde1f3bd336a8cbd1ec4c5e5", // No-RlsGroup
	//     "7357cf5161efbf8c4d5d0c30b4815ee2", // Obfuscated
	//     "5c44f52a8714fdd79bb4d98e2673be1f", // Retags
	//     "b6832f586342ef70d9c128d40c07b872", // Bad Dual Groups
	//     "923b6abef9b17f937fab56cfcf89e1f1", // DV (WEBDL)
	//    ]
	//    quality_profiles: [{
	//     name:  "HD-1080p"
	//     score: 0
	//    }, {
	//     name:  "HD-720p"
	//     score: -1000
	//    }]
	//   }, {
	//    trash_ids: [
	//     "496f355514737f7d83bf7aa4d24f8169", // TrueHD ATMOS
	//     "2f22d89048b01681dde8afe203bf2e95", // DTS X
	//    ]
	//    quality_profiles: [{name: "SD"}]
	//   }]
	//  }
	//  sonarr: main: {
	//   base_url: "!secret sonarr_url"
	//   api_key:  "!secret sonarr_apikey"
	//   quality_definition: type: "series"
	//   custom_formats: [{
	//    trash_ids: [
	//     "EBC725268D687D588A20CBC5F97E538B",
	//     "1B018E0C53EC825085DD911102E2CA36",
	//     "71899E6C303A07AF0E4746EFF9873532",
	//    ]
	//   }]
	//  }
	// })
}]
