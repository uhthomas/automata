// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/pkg/cidr

package cidr

import "net"

// CIDR is a network CIDR representation based on net.IPNet
#CIDR: {
	IPNet?: null | net.#IPNet @go(,*net.IPNet)
}
