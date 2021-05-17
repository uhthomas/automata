# Pillowtalk

Pillowtalk is a 5 node Kubernetes cluster with a total capacity of:
- 120 CPU
- 176GB memory
- 30TB raw storage

## Metals

Ordered by their physical location in the rack.

| Name       | CPU                             | Memory | Storage         | IP Addresses |
| ---------- | ------------------------------- | ------ | --------------- | ------------ |
| 5dc508ed7c | E5-2609 v2 @ 2.50GHz (4C4T)     | 16GB   | None            | 10.0.0.2     |
| d9294fd26f | 2x E5-2630 v2 @ 2.60GHz (6C12T) | 32GB   | None            | 10.0.0.3     |
| 44fe941f5c | 2x E5-2650 v2 @ 2.60GHz (8C16T) | 48GB   | 10TB (6TB, 4TB) | 10.0.0.4     |
| c28593b8bf | 2x E5-2650 v2 @ 2.60GHz (8C16T) | 48GB   | 10TB (6TB, 4TB) | 10.0.0.5     |
