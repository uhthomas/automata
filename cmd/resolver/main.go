package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"os"
	"path/filepath"

	"gopkg.in/yaml.v3"
)

const strTag = "str"

func appendValue(n *yaml.Node, key, value string) {
	n.Content = append(n.Content, &yaml.Node{
		Kind:  yaml.ScalarNode,
		Value: key,
	}, &yaml.Node{
		Kind:  yaml.ScalarNode,
		Value: value,
	})
}

func appendMap(n *yaml.Node, key string) *yaml.Node {
	n.Content = append(n.Content, &yaml.Node{
		Kind:  yaml.ScalarNode,
		Value: key,
	}, &yaml.Node{Kind: yaml.MappingNode})
	return n.Content[len(n.Content)-1]
}

func createNode(n *yaml.Node, value string, keys ...string) {
	if n.Kind == yaml.DocumentNode {
		for _, nn := range n.Content {
			createNode(nn, value, keys...)
		}
		return
	}
	for i, nn := range n.Content {
		if nn.Value == keys[0] {
			createNode(n.Content[i+1], value, keys[1:]...)
			return
		}
	}
	if len(keys) == 1 {
		appendValue(n, keys[0], value)
		return
	}
	createNode(appendMap(n, keys[0]), value, keys[1:]...)
	return
}

func Main(ctx context.Context) error {
	p := flag.String("template", "", "Template file path")
	flag.Parse()

	f, err := os.Open(filepath.Clean(*p))
	if err != nil {
		return fmt.Errorf("open: %w", err)
	}
	defer f.Close()

	var n yaml.Node
	if err := yaml.NewDecoder(f).Decode(&n); err != nil {
		return fmt.Errorf("yaml decode: %w", err)
	}

	createNode(&n, "automata",
		"metadata",
		"labels",
		"app.kubernetes.io/managed-by",
	)

	var out map[string]interface{}
	if err := n.Decode(&out); err != nil {
		return fmt.Errorf("node decode: %w", err)
	}
	return yaml.NewEncoder(os.Stdout).Encode(out)
}

func main() {
	if err := Main(context.Background()); err != nil {
		log.Fatal(err)
	}
}
