// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/component-base/logs/api/v1

package v1

import "k8s.io/apimachinery/pkg/api/resource"

// DefaultLogFormat is the traditional klog output format.
#DefaultLogFormat: "text"

// JSONLogFormat emits each log message as a JSON struct.
#JSONLogFormat: "json"

// LoggingConfiguration contains logging options.
#LoggingConfiguration: {
	// Format Flag specifies the structure of log messages.
	// default value of format is `text`
	format?: string @go(Format)

	// Maximum time between log flushes.
	// If a string, parsed as a duration (i.e. "1s")
	// If an int, the maximum number of nanoseconds (i.e. 1s = 1000000000).
	// Ignored if the selected logging backend writes log messages without buffering.
	flushFrequency: #TimeOrMetaDuration @go(FlushFrequency)

	// Verbosity is the threshold that determines which log messages are
	// logged. Default is zero which logs only the most important
	// messages. Higher values enable additional messages. Error messages
	// are always logged.
	verbosity: #VerbosityLevel @go(Verbosity)

	// VModule overrides the verbosity threshold for individual files.
	// Only supported for "text" log format.
	vmodule?: #VModuleConfiguration @go(VModule)

	// [Alpha] Options holds additional parameters that are specific
	// to the different logging formats. Only the options for the selected
	// format get used, but all of them get validated.
	// Only available when the LoggingAlphaOptions feature gate is enabled.
	options?: #FormatOptions @go(Options)
}

// TimeOrMetaDuration is present only for backwards compatibility for the
// flushFrequency field, and new fields should use metav1.Duration.
#TimeOrMetaDuration: _

// FormatOptions contains options for the different logging formats.
#FormatOptions: {
	// [Alpha] JSON contains options for logging format "json".
	// Only available when the LoggingAlphaOptions feature gate is enabled.
	json?: #JSONOptions @go(JSON)
}

// JSONOptions contains options for logging format "json".
#JSONOptions: {
	// [Alpha] SplitStream redirects error messages to stderr while
	// info messages go to stdout, with buffering. The default is to write
	// both to stdout, without buffering. Only available when
	// the LoggingAlphaOptions feature gate is enabled.
	splitStream?: bool @go(SplitStream)

	// [Alpha] InfoBufferSize sets the size of the info stream when
	// using split streams. The default is zero, which disables buffering.
	// Only available when the LoggingAlphaOptions feature gate is enabled.
	infoBufferSize?: resource.#QuantityValue @go(InfoBufferSize)
}

// VModuleConfiguration is a collection of individual file names or patterns
// and the corresponding verbosity threshold.
#VModuleConfiguration: [...#VModuleItem]

// VModuleItem defines verbosity for one or more files which match a certain
// glob pattern.
#VModuleItem: {
	// FilePattern is a base file name (i.e. minus the ".go" suffix and
	// directory) or a "glob" pattern for such a name. It must not contain
	// comma and equal signs because those are separators for the
	// corresponding klog command line argument.
	filePattern: string @go(FilePattern)

	// Verbosity is the threshold for log messages emitted inside files
	// that match the pattern.
	verbosity: #VerbosityLevel @go(Verbosity)
}

// VerbosityLevel represents a klog or logr verbosity threshold.
#VerbosityLevel: uint32
