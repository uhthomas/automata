#!/bin/sh

kubectx admin@$1

cue export ~/code/github.com/uhthomas/automata/k8s/$1/list.cue | KUBECTL_APPLYSET=true kubectl apply -f - --server-side --force-conflicts --applyset=applyset/automata --prune
