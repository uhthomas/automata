import "k8s.io/api/core/v1"

v1.#Secret & {
    apiVersion: "v1"
    kind: "Secret"
    metadata: {
        name: "example"
        namespace: "example"
    }
    data: example: 'example'
}
