#!/bin/sh

cue export ~/code/github.com/uhthomas/automata/k8s/$1/list.cue | KUBECTL_APPLYSET=true kubectl --context oidc@$1 apply -f - --server-side --force-conflicts --applyset=applyset/automata --prune
