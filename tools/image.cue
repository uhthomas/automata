package tools

import "strings"

#Image: {
	name:    string
	tag:     string
	digest?: string & strings.HasPrefix("sha256:")

	if tag == "" && digest == "" {
		reference: name
	}
	if tag != "" && digest == "" {
		reference: "\(name):\(tag)"
	}
	if tag != "" && digest != "" {
		reference: "\(name):\(tag)@\(digest)"
	}
}
