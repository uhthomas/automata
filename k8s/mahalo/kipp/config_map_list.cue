package kipp

import "k8s.io/api/core/v1"

configMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

configMapList: items: [{
    metadata: name: "kipp-static"
	data: {
        "healthz": "" // liveness/readiness probes
        "index.html": """
            <!doctype html>
            <html>
            <head>
                <title>Goodbye</title>
                <style>
                    html {
                        font-family: monospace;
                    }
                </style>
            </head>
            <body>
                <pre>
                Kipp has had an exciting journey the past few years. The service has quickly
                grown from a small side project, to a service which serves millions of users and
                many tens of terabytes every month.

                This sort of exposure and traffic has provided a lot of growth for myself and
                the project. A lot of the source code was rewritten to introduce support for
                dedicated databases as opposed to filesystem based ones, creating interfaces for
                working with scalable storage backends like S3 and the introduction of
                server-side metrics to make sure the service was behaving correctly. In addition
                to modifications to the source code, the service was moved to a Kubernetes
                cluster which allowed for automatic scaling and rich collection of statistics.

                Kipp has seen an exallerated increase in the amount of traffic and content being
                served recently which is exciting, but has also introduced a large personal
                burden. Consider the following statistics:

                The past month:

                    53.32 million requests (up 484.76%)

                    89.81 TB of bandwidth (up 296.93%)

                    2.91 million visitors (up 90.03%)

                The past week:

                    23.34 million requests (up 25.59%)

                    47.38 TB of bandwidth (up 69.73%)

                    1.1 million visitors (up 15.28%)

                Kipp will cease operations effective immeditately. Serviving thousands of files
                and millions of users is not something I wish to continue doing.

                Thank you for making the project fun and successful.

                Thomas (thomas@6f.io) -- 21/10/2021
                </pre>
            </body>
            </html>
        """
    }
}]
