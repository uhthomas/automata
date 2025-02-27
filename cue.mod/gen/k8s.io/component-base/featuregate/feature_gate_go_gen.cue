// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/component-base/featuregate

package featuregate

#Feature: string // #enumFeature

#enumFeature:
	_#allAlphaGate |
	_#allBetaGate

_#flagName: "feature-gates"

// allAlphaGate is a global toggle for alpha features. Per-feature key
// values override the default set by allAlphaGate. Examples:
//   AllAlpha=false,NewFeature=true  will result in newFeature=true
//   AllAlpha=true,NewFeature=false  will result in newFeature=false
_#allAlphaGate: #Feature & "AllAlpha"

// allBetaGate is a global toggle for beta features. Per-feature key
// values override the default set by allBetaGate. Examples:
//   AllBeta=false,NewFeature=true  will result in NewFeature=true
//   AllBeta=true,NewFeature=false  will result in NewFeature=false
_#allBetaGate: #Feature & "AllBeta"

#FeatureSpec: {
	// Default is the default enablement state for the feature
	Default: bool

	// LockToDefault indicates that the feature is locked to its default and cannot be changed
	LockToDefault: bool

	// PreRelease indicates the maturity level of the feature
	PreRelease: _#prerelease
}

_#prerelease: string

// Values for PreRelease.
#Alpha: _#prerelease & "ALPHA"
#Beta:  _#prerelease & "BETA"
#GA:    _#prerelease & ""

// Deprecated
#Deprecated: _#prerelease & "DEPRECATED"

// FeatureGate indicates whether a given feature is enabled or not
#FeatureGate: _

// MutableFeatureGate parses and stores flag gates for known features from
// a string like feature1=true,feature2=false,...
#MutableFeatureGate: _
