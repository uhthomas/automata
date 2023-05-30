load("@bazel_gazelle//:deps.bzl", "go_repository")

def go_dependencies():
    go_repository(
        name = "cc_mvdan_gofumpt",
        build_file_proto_mode = "disable_global",
        importpath = "mvdan.cc/gofumpt",
        sum = "h1:avhhrOmv0IuvQVK7fvwV91oFSGAk5/6Po8GXTzICeu8=",
        version = "v0.3.1",
    )

    go_repository(
        name = "co_honnef_go_tools",
        build_file_proto_mode = "disable_global",
        importpath = "honnef.co/go/tools",
        sum = "h1:UoveltGrhghAA7ePc+e+QYDHXrBps2PqFZiHkGR/xK8=",
        version = "v0.0.1-2020.1.4",
    )
    go_repository(
        name = "com_github_abdullin_seq",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/abdullin/seq",
        sum = "h1:DBNMBMuMiWYu0b+8KMJuWmfCkcxl09JwdlqwDZZ6U14=",
        version = "v0.0.0-20160510034733-d5467c17e7af",
    )
    go_repository(
        name = "com_github_aerospike_aerospike_client_go_v5",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aerospike/aerospike-client-go/v5",
        sum = "h1:tRxcUq0HY8fFPQEzF3EgrknF+w1xFO0YDfUb9Nm8yRI=",
        version = "v5.6.0",
    )

    go_repository(
        name = "com_github_alecthomas_kingpin_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/alecthomas/kingpin/v2",
        sum = "h1:H0aULhgmSzN8xQ3nX1uxtdlTHYoPLu5AhHxWrKI6ocU=",
        version = "v2.3.2",
    )

    go_repository(
        name = "com_github_alecthomas_template",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/alecthomas/template",
        sum = "h1:JYp7IbQjafoB+tBA3gMyHYHrpOtNuDiK/uB5uXxq5wM=",
        version = "v0.0.0-20190718012654-fb15b899a751",
    )
    go_repository(
        name = "com_github_alecthomas_units",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/alecthomas/units",
        sum = "h1:s6gZFSlWYmbqAuRjVTiNNhvNRfY2Wxp9nhfyel4rklc=",
        version = "v0.0.0-20211218093645-b94a6e3cc137",
    )
    go_repository(
        name = "com_github_aliyun_alibaba_cloud_sdk_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aliyun/alibaba-cloud-sdk-go",
        sum = "h1:zAH0YjWzonbKHvNkfbxqTmX51uHbkQYu+jJah2IAiCA=",
        version = "v1.62.146",
    )
    go_repository(
        name = "com_github_aliyun_aliyun_oss_go_sdk",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aliyun/aliyun-oss-go-sdk",
        sum = "h1:nWDRPCyCltiTsANwC/n3QZH7Vww33Npq9MKqlwRzI/c=",
        version = "v0.0.0-20190307165228-86c17b95fcd5",
    )
    go_repository(
        name = "com_github_andybalholm_brotli",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/andybalholm/brotli",
        sum = "h1:V7DdXeJtZscaqfNuAdSRuRFzuiKlHSC/Zh3zl9qY3JY=",
        version = "v1.0.4",
    )

    go_repository(
        name = "com_github_antihax_optional",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/antihax/optional",
        sum = "h1:xK2lYat7ZLaVVcIuj82J8kIro4V6kDe0AUDFboUCwcg=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_antlr_antlr4_runtime_go_antlr",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/antlr/antlr4/runtime/Go/antlr",
        sum = "h1:yL7+Jz0jTC6yykIK/Wh74gnTJnrGr5AyrNMXuA0gves=",
        version = "v1.4.10",
    )
    go_repository(
        name = "com_github_antlr_antlr4_runtime_go_antlr_v4",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/antlr/antlr4/runtime/Go/antlr/v4",
        sum = "h1:7RFfzj4SSt6nnvCPbCqijJi1nWCd+TqAT3bYCStRC18=",
        version = "v4.0.0-20230305170008-8188dc5388df",
    )
    go_repository(
        name = "com_github_apache_arrow_go_arrow",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/apache/arrow/go/arrow",
        sum = "h1:ZsPrlYPY/v1PR7pGrmYD/rq5BFiSPalH8i9eEkSfnnI=",
        version = "v0.0.0-20210818145353-234c94e4ce64",
    )
    go_repository(
        name = "com_github_apache_thrift",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/apache/thrift",
        sum = "h1:pODnxUFNcjP9UTLZGTdeh+j16A8lJbRvD3rOtrk/7bs=",
        version = "v0.12.0",
    )
    go_repository(
        name = "com_github_apple_foundationdb_bindings_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/apple/foundationdb/bindings/go",
        sum = "h1:VoHKYIXEQU5LWoambPBOvYxyLqZYHuj+rj5DVnMUc3k=",
        version = "v0.0.0-20190411004307-cd5c9d91fad2",
    )

    go_repository(
        name = "com_github_armon_circbuf",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/armon/circbuf",
        sum = "h1:QEF07wC0T1rKkctt1RINW/+RMTVmiwxETico2l3gxJA=",
        version = "v0.0.0-20150827004946-bbbad097214e",
    )

    go_repository(
        name = "com_github_armon_go_metrics",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/armon/go-metrics",
        sum = "h1:hR91U9KYmb6bLBYLQjyM+3j+rcd/UhE+G78SFnF8gJA=",
        version = "v0.4.1",
    )
    go_repository(
        name = "com_github_armon_go_proxyproto",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/armon/go-proxyproto",
        sum = "h1:h0gP0hBU6DsA5IQduhLWGOEfIUKzJS5hhXQBSgHuF/g=",
        version = "v0.0.0-20190211145416-68259f75880e",
    )
    go_repository(
        name = "com_github_armon_go_radix",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/armon/go-radix",
        sum = "h1:F4z6KzEeeQIMeLFa97iZU6vupzoecKdU5TX24SNppXI=",
        version = "v1.0.0",
    )

    go_repository(
        name = "com_github_armon_go_socks5",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/armon/go-socks5",
        sum = "h1:0CwZNZbxp69SHPdPJAN/hZIm0C4OItdklCFmMRWYpio=",
        version = "v0.0.0-20160902184237-e75332964ef5",
    )

    go_repository(
        name = "com_github_asaskevich_govalidator",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/asaskevich/govalidator",
        sum = "h1:DklsrG3dyBCFEj5IhUbnKptjxatkF07cF2ak3yi77so=",
        version = "v0.0.0-20230301143203-a9d515a09cc2",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aws/aws-sdk-go",
        sum = "h1:Asrp6EMqqRxZvjK0NjzkWcrOk15RnWtupuUrUuZMabk=",
        version = "v1.44.267",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aws/aws-sdk-go-v2",
        sum = "h1:HcN6yDnHV9S7D69E7To0aUppJhiJNEzQSNcUxc7r3qo=",
        version = "v1.8.0",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_config",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aws/aws-sdk-go-v2/config",
        sum = "h1:rtoCnNObhVm7me+v9sA2aY+NtHNZjjWWC3ifXVci+wE=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_credentials",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aws/aws-sdk-go-v2/credentials",
        sum = "h1:Uud/fZzm0lqqhE8kvXYJFAJ3PGnagKoUcvHq1hXfBZw=",
        version = "v1.3.2",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_feature_ec2_imds",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aws/aws-sdk-go-v2/feature/ec2/imds",
        sum = "h1:SGqDJun6tydgsSIFxv9+EYBJVqVUwg2QMJp6PbNq8C8=",
        version = "v1.4.0",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_feature_s3_manager",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aws/aws-sdk-go-v2/feature/s3/manager",
        sum = "h1:Iqp2aHeRF3kaaNuDS82bHBzER285NM6lLPAgsxHCR2A=",
        version = "v1.4.0",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_internal_ini",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aws/aws-sdk-go-v2/internal/ini",
        sum = "h1:xu45foJnwMwBqSkIMKyJP9kbyHi5hdhZ/WiJ7D2sHZ0=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_internal_accept_encoding",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding",
        sum = "h1:YcGVEqLQGHDa81776C3daai6ZkkRGf/8RAQ07hV0QcU=",
        version = "v1.2.2",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_internal_presigned_url",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aws/aws-sdk-go-v2/service/internal/presigned-url",
        sum = "h1:Xv1rGYgsRRn0xw9JFNnfpBMZam54PrWpC4rJOJ9koA8=",
        version = "v1.2.2",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_internal_s3shared",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aws/aws-sdk-go-v2/service/internal/s3shared",
        sum = "h1:ewIpdVz12MDinJJB/nu1uUiFIWFnvtd3iV7cEW7lR+M=",
        version = "v1.5.2",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_s3",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aws/aws-sdk-go-v2/service/s3",
        sum = "h1:cxZbzTYXgiQrZ6u2/RJZAkkgZssqYOdydvJPBgIHlsM=",
        version = "v1.12.0",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_sso",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aws/aws-sdk-go-v2/service/sso",
        sum = "h1:b+U3WrF9ON3f32FH19geqmiod4uKcMv/q+wosQjjyyM=",
        version = "v1.3.2",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_sts",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aws/aws-sdk-go-v2/service/sts",
        sum = "h1:1Pls85C5CFjhE3aH+h85/hyAk89kQNlAWlEQtIkaFyc=",
        version = "v1.6.1",
    )
    go_repository(
        name = "com_github_aws_smithy_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/aws/smithy-go",
        sum = "h1:+cLHMRrDZvQ4wk+KuQ9yH6eEg6KZEJ9RI2IkDqnygCg=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_github_axiomhq_hyperloglog",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/axiomhq/hyperloglog",
        sum = "h1:eqjiAL3qooftPm8b9C1GsSSRcmlw7iOva8vdBTmV2PY=",
        version = "v0.0.0-20220105174342-98591331716a",
    )
    go_repository(
        name = "com_github_azure_azure_pipeline_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/azure-pipeline-go",
        sum = "h1:7U9HBg1JFK3jHl5qmo4CTZKFTVgMwdFHMVtCdfBE21U=",
        version = "v0.2.3",
    )

    go_repository(
        name = "com_github_azure_azure_sdk_for_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/azure-sdk-for-go",
        sum = "h1:Uu/Ww6ernvPTrpq31kITVTIm/I5jlJ1wjtEH/bmSB2k=",
        version = "v67.2.0+incompatible",
    )
    go_repository(
        name = "com_github_azure_azure_sdk_for_go_sdk_azcore",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/azure-sdk-for-go/sdk/azcore",
        sum = "h1:gVXuXcWd1i4C2Ruxe321aU+IKGaStvGB/S90PUPB/W8=",
        version = "v1.3.1",
    )
    go_repository(
        name = "com_github_azure_azure_sdk_for_go_sdk_azidentity",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/azure-sdk-for-go/sdk/azidentity",
        sum = "h1:T8quHYlUGyb/oqtSTwqlCr1ilJHrDv+ZtpSfo+hm1BU=",
        version = "v1.2.1",
    )
    go_repository(
        name = "com_github_azure_azure_sdk_for_go_sdk_internal",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/azure-sdk-for-go/sdk/internal",
        sum = "h1:+5VZ72z0Qan5Bog5C+ZkgSqUbeVUd9wgtHOrIKuc5b8=",
        version = "v1.1.2",
    )
    go_repository(
        name = "com_github_azure_azure_sdk_for_go_sdk_resourcemanager_compute_armcompute_v4",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/compute/armcompute/v4",
        sum = "h1:Vjq3Uy3JAU1DTxbA+uX6BegIhgO2pyFltbfbmDa9KdI=",
        version = "v4.1.0",
    )
    go_repository(
        name = "com_github_azure_azure_sdk_for_go_sdk_resourcemanager_msi_armmsi",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/msi/armmsi",
        sum = "h1:ZOt3s8LxEoRGgdD/k7Co4wGAWKmO4+jdPRCRBa8Rzc0=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_azure_azure_sdk_for_go_sdk_resourcemanager_resources_armresources",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/resources/armresources",
        sum = "h1:ECsQtyERDVz3NP3kvDOTLvbQhqWp/x9EsGKtb4ogUr8=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_azure_azure_storage_blob_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/azure-storage-blob-go",
        sum = "h1:1BCg74AmVdYwO3dlKwtFU1V0wU2PZdREkXvAmZJRUlM=",
        version = "v0.14.0",
    )

    go_repository(
        name = "com_github_azure_go_ansiterm",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/go-ansiterm",
        sum = "h1:L/gRVlceqvL25UVaW/CKtUDjefjrs0SPonmDGUVOYP0=",
        version = "v0.0.0-20230124172434-306776ec8161",
    )
    go_repository(
        name = "com_github_azure_go_autorest",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/go-autorest",
        sum = "h1:V5VMDjClD3GiElqLWO7mz2MxNAK/vTfRHdAubSIPRgs=",
        version = "v14.2.0+incompatible",
    )
    go_repository(
        name = "com_github_azure_go_autorest_autorest",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/go-autorest/autorest",
        sum = "h1:ndAExarwr5Y+GaHE6VCaY1kyS/HwwGGyuimVhWsHOEM=",
        version = "v0.11.28",
    )
    go_repository(
        name = "com_github_azure_go_autorest_autorest_adal",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/go-autorest/autorest/adal",
        sum = "h1:Yepx8CvFxwNKpH6ja7RZ+sKX+DWYNldbLiALMC3BTz8=",
        version = "v0.9.23",
    )
    go_repository(
        name = "com_github_azure_go_autorest_autorest_azure_auth",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/go-autorest/autorest/azure/auth",
        sum = "h1:wkAZRgT/pn8HhFyzfe9UnqOjJYqlembgCTi72Bm/xKk=",
        version = "v0.5.12",
    )
    go_repository(
        name = "com_github_azure_go_autorest_autorest_azure_cli",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/go-autorest/autorest/azure/cli",
        sum = "h1:0W/yGmFdTIT77fvdlGZ0LMISoLHFJ7Tx4U0yeB+uFs4=",
        version = "v0.4.5",
    )

    go_repository(
        name = "com_github_azure_go_autorest_autorest_date",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/go-autorest/autorest/date",
        sum = "h1:7gUk1U5M/CQbp9WoqinNzJar+8KY+LPI6wiWrP/myHw=",
        version = "v0.3.0",
    )
    go_repository(
        name = "com_github_azure_go_autorest_autorest_mocks",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/go-autorest/autorest/mocks",
        sum = "h1:PGN4EDXnuQbojHbU0UWoNvmu9AGVwYHG9/fkDYhtAfw=",
        version = "v0.4.2",
    )
    go_repository(
        name = "com_github_azure_go_autorest_autorest_to",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/go-autorest/autorest/to",
        sum = "h1:oXVqrxakqqV1UZdSazDOPOLvOIz+XA683u8EctwboHk=",
        version = "v0.4.0",
    )
    go_repository(
        name = "com_github_azure_go_autorest_autorest_validation",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/go-autorest/autorest/validation",
        sum = "h1:AgyqjAd94fwNAoTjl/WQXg4VvFeRFpO+UhNyRXqF1ac=",
        version = "v0.3.1",
    )

    go_repository(
        name = "com_github_azure_go_autorest_logger",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/go-autorest/logger",
        sum = "h1:IG7i4p/mDa2Ce4TRyAO8IHnVhAVF3RFU+ZtXWSmf4Tg=",
        version = "v0.2.1",
    )
    go_repository(
        name = "com_github_azure_go_autorest_tracing",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/go-autorest/tracing",
        sum = "h1:TYi4+3m5t6K48TGI9AUdb+IzbnSxvnvUMfuitfgcfuo=",
        version = "v0.6.0",
    )
    go_repository(
        name = "com_github_azure_go_ntlmssp",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Azure/go-ntlmssp",
        sum = "h1:/IBSNwUN8+eKzUzbJPqhK839ygXJ82sde8x3ogr6R28=",
        version = "v0.0.0-20200615164410-66371956d46c",
    )
    go_repository(
        name = "com_github_azuread_microsoft_authentication_library_for_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/AzureAD/microsoft-authentication-library-for-go",
        sum = "h1:oPdPEZFSbl7oSPEAIPMPBMUmiL+mqgzBJwM/9qYcwNg=",
        version = "v0.8.1",
    )
    go_repository(
        name = "com_github_baiyubin_aliyun_sts_go_sdk",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/baiyubin/aliyun-sts-go-sdk",
        sum = "h1:ZNv7On9kyUzm7fvRZumSyy/IUiSC7AzL0I1jKKtwooA=",
        version = "v0.0.0-20180326062324-cfa1a18b161f",
    )

    go_repository(
        name = "com_github_benbjohnson_clock",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/benbjohnson/clock",
        sum = "h1:Q92kusRqC1XV2MjkWETPvjJVqKetz1OzxZB7mHJLju8=",
        version = "v1.1.0",
    )

    go_repository(
        name = "com_github_beorn7_perks",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/beorn7/perks",
        sum = "h1:VlbKKnNfV8bJzeqoa4cOKqO6bYr3WgKZxO8Z16+hsOM=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_bgentry_speakeasy",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/bgentry/speakeasy",
        sum = "h1:ByYyxL9InA1OWqxJqqp2A5pYHUrCiAL6K3J+LKSsQkY=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_bitly_go_hostpool",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/bitly/go-hostpool",
        sum = "h1:mXoPYz/Ul5HYEDvkta6I8/rnYM5gSdSV2tJ6XbZuEtY=",
        version = "v0.0.0-20171023180738-a3a6125de932",
    )
    go_repository(
        name = "com_github_bketelsen_crypt",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/bketelsen/crypt",
        sum = "h1:+0HFd5KSZ/mm3JmhmrDukiId5iR6w4+BdFtfSy4yWIc=",
        version = "v0.0.3-0.20200106085610-5cbc8cc4026c",
    )

    go_repository(
        name = "com_github_blang_semver_v4",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/blang/semver/v4",
        sum = "h1:1PFHFE6yCCTv8C1TeyNNarDzntLi7wMI5i/pzqYIsAM=",
        version = "v4.0.0",
    )
    go_repository(
        name = "com_github_bmizerany_assert",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/bmizerany/assert",
        sum = "h1:DDGfHa7BWjL4YnC6+E63dPcxHo2sUxDIu8g3QgEJdRY=",
        version = "v0.0.0-20160611221934-b7ed37b82869",
    )
    go_repository(
        name = "com_github_boltdb_bolt",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/boltdb/bolt",
        sum = "h1:JQmyP4ZBrce+ZQu0dY660FMfatumYDLun9hBCUVIkF4=",
        version = "v1.3.1",
    )
    go_repository(
        name = "com_github_boombuler_barcode",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/boombuler/barcode",
        sum = "h1:biVzkmvwrH8WK8raXaxBx6fRVTlJILwEwQGL1I/ByEI=",
        version = "v1.0.1-0.20190219062509-6c824513bacc",
    )
    go_repository(
        name = "com_github_briankassouf_jose",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/briankassouf/jose",
        sum = "h1:ZMEzE7R0WNqgbHplzSBaYJhJi5AZWTCK9baU0ebzG6g=",
        version = "v0.9.2-0.20180619214549-d2569464773f",
    )

    go_repository(
        name = "com_github_buger_jsonparser",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/buger/jsonparser",
        sum = "h1:2PnMjfWD7wBILjqQbt530v576A/cAbQvEW9gGIpYMUs=",
        version = "v1.1.1",
    )

    go_repository(
        name = "com_github_burntsushi_toml",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/BurntSushi/toml",
        sum = "h1:Rt8g24XnyGTyglgET/PRUNlrUeu9F5L+7FilkXfZgs0=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_burntsushi_xgb",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/BurntSushi/xgb",
        sum = "h1:1BDTz0u9nC3//pOCMdNH+CiXJVYJh5UQNCOBG7jbELc=",
        version = "v0.0.0-20160522181843-27f122750802",
    )
    go_repository(
        name = "com_github_cenkalti_backoff",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cenkalti/backoff",
        sum = "h1:tNowT99t7UNflLxfYYSlKYsBpXdEet03Pg2g16Swow4=",
        version = "v2.2.1+incompatible",
    )
    go_repository(
        name = "com_github_cenkalti_backoff_v3",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cenkalti/backoff/v3",
        sum = "h1:cfUAAO3yvKMYKPrvhDuHSwQnhZNk/RMHKdZqKTxfm6M=",
        version = "v3.2.2",
    )

    go_repository(
        name = "com_github_cenkalti_backoff_v4",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cenkalti/backoff/v4",
        sum = "h1:y4OZtCnogmCPw98Zjyt5a6+QwPLGkiQsYW5oUqylYbM=",
        version = "v4.2.1",
    )

    go_repository(
        name = "com_github_census_instrumentation_opencensus_proto",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/census-instrumentation/opencensus-proto",
        sum = "h1:iKLQ0xPNFxR/2hzXZMrBo8f1j86j5WHzznCCQxV/b8g=",
        version = "v0.4.1",
    )
    go_repository(
        name = "com_github_centrify_cloud_golang_sdk",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/centrify/cloud-golang-sdk",
        sum = "h1:jQ93fKqb/wRmK/KiHpa7Tk9rmHeKXhp4j+5Sg/tENiY=",
        version = "v0.0.0-20210923165758-a8c48d049166",
    )
    go_repository(
        name = "com_github_certifi_gocertifi",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/certifi/gocertifi",
        sum = "h1:uH66TXeswKn5PW5zdZ39xEwfS9an067BirqA+P4QaLI=",
        version = "v0.0.0-20200922220541-2c3bb06c6054",
    )

    go_repository(
        name = "com_github_cespare_xxhash",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cespare/xxhash",
        sum = "h1:a6HrQnmkObjyL+Gs60czilIUGqrzKutQD6XZog3p+ko=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_cespare_xxhash_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cespare/xxhash/v2",
        sum = "h1:DC2CZ1Ep5Y4k3ZQ899DldepgrayRUGE6BBZ/cd9Cj44=",
        version = "v2.2.0",
    )
    go_repository(
        name = "com_github_chai2010_gettext_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/chai2010/gettext-go",
        sum = "h1:1Lwwip6Q2QGsAdl/ZKPCwTe9fe0CjlUbqj5bFNSjIRk=",
        version = "v1.0.2",
    )
    go_repository(
        name = "com_github_checkpoint_restore_go_criu_v5",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/checkpoint-restore/go-criu/v5",
        sum = "h1:wpFFOoomK3389ue2lAb0Boag6XPht5QYpipxmSNL4d8=",
        version = "v5.3.0",
    )
    go_repository(
        name = "com_github_chrismalek_oktasdk_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/chrismalek/oktasdk-go",
        sum = "h1:CWU8piLyqoi9qXEUwzOh5KFKGgmSU5ZhktJyYcq6ryQ=",
        version = "v0.0.0-20181212195951-3430665dfaa0",
    )

    go_repository(
        name = "com_github_chzyer_logex",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/chzyer/logex",
        sum = "h1:Swpa1K6QvQznwJRcfTfQJmTE72DqScAa40E+fbHEXEE=",
        version = "v1.1.10",
    )
    go_repository(
        name = "com_github_chzyer_readline",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/chzyer/readline",
        sum = "h1:fY5BOSpyZCqRo5OhCuC+XN+r/bBCmeuuJtjz+bCNIf8=",
        version = "v0.0.0-20180603132655-2972be24d48e",
    )
    go_repository(
        name = "com_github_chzyer_test",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/chzyer/test",
        sum = "h1:q763qf9huN11kDQavWsoZXJNW3xEE4JJyHa5Q25/sd8=",
        version = "v0.0.0-20180213035817-a1ea475d72b1",
    )
    go_repository(
        name = "com_github_cilium_ebpf",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cilium/ebpf",
        sum = "h1:1k/q3ATgxSXRdrmPfH8d7YK0GfqVsEKZAX9dQZvs56k=",
        version = "v0.7.0",
    )
    go_repository(
        name = "com_github_circonus_labs_circonus_gometrics",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/circonus-labs/circonus-gometrics",
        sum = "h1:C29Ae4G5GtYyYMm1aztcyj/J5ckgJm2zwdDajFbx1NY=",
        version = "v2.3.1+incompatible",
    )
    go_repository(
        name = "com_github_circonus_labs_circonusllhist",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/circonus-labs/circonusllhist",
        sum = "h1:TJH+oke8D16535+jHExHj4nQvzlZrj7ug5D7I/orNUA=",
        version = "v0.1.3",
    )

    go_repository(
        name = "com_github_client9_misspell",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/client9/misspell",
        sum = "h1:ta993UF76GwbvJcIo3Y68y/M3WxlpEHPWIGDkJYwzJI=",
        version = "v0.3.4",
    )
    go_repository(
        name = "com_github_cloudflare_circl",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cloudflare/circl",
        sum = "h1:bZgT/A+cikZnKIwn7xL2OBj012Bmvho/o6RpRvv3GKY=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_cloudfoundry_community_go_cfclient",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cloudfoundry-community/go-cfclient",
        sum = "h1:k8q2Nsz7kNaUlysVCnWIFLMUSqiKXaGLdIf9P0GsX2Y=",
        version = "v0.0.0-20210823134051-721f0e559306",
    )

    go_repository(
        name = "com_github_cncf_udpa_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cncf/udpa/go",
        sum = "h1:QQ3GSy+MqSHxm/d8nCtnAiZdYFd45cYZPs8vOOIYKfk=",
        version = "v0.0.0-20220112060539-c52dc94e7fbe",
    )
    go_repository(
        name = "com_github_cncf_xds_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cncf/xds/go",
        sum = "h1:58f1tJ1ra+zFINPlwLWvQsR9CzAKt2e+EWV2yX9oXQ4=",
        version = "v0.0.0-20230310173818-32f1caf87195",
    )
    go_repository(
        name = "com_github_cockroachdb_apd",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cockroachdb/apd",
        sum = "h1:3LFP3629v+1aKXU5Q37mxmRxX/pIu1nijXydLShEq5I=",
        version = "v1.1.0",
    )

    go_repository(
        name = "com_github_cockroachdb_apd_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cockroachdb/apd/v2",
        sum = "h1:weh8u7Cneje73dDh+2tEVLUvyBc89iwepWCD8b8034E=",
        version = "v2.0.2",
    )
    go_repository(
        name = "com_github_cockroachdb_cockroach_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cockroachdb/cockroach-go",
        sum = "h1:2zRrJWIt/f9c9HhNHAgrRgq0San5gRRUJTBXLkchal0=",
        version = "v0.0.0-20181001143604-e0a95dfd547c",
    )
    go_repository(
        name = "com_github_cockroachdb_datadriven",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cockroachdb/datadriven",
        sum = "h1:xD/lrqdvwsc+O2bjSSi3YqY73Ke3LAiSCx49aCesA0E=",
        version = "v0.0.0-20200714090401-bf6692d28da5",
    )
    go_repository(
        name = "com_github_cockroachdb_errors",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cockroachdb/errors",
        sum = "h1:Lap807SXTH5tri2TivECb/4abUkMZC9zRoLarvcKDqs=",
        version = "v1.2.4",
    )
    go_repository(
        name = "com_github_cockroachdb_logtags",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cockroachdb/logtags",
        sum = "h1:o/kfcElHqOiXqcou5a3rIlMc7oJbMQkeLk0VQJ7zgqY=",
        version = "v0.0.0-20190617123548-eb05cc24525f",
    )
    go_repository(
        name = "com_github_codegangsta_inject",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/codegangsta/inject",
        sum = "h1:sDMmm+q/3+BukdIpxwO365v/Rbspp2Nt5XntgQRXq8Q=",
        version = "v0.0.0-20150114235600-33e0aa1cb7c0",
    )

    go_repository(
        name = "com_github_container_storage_interface_spec",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/container-storage-interface/spec",
        sum = "h1:gW8eyFQUZWWrMWa8p1seJ28gwDoN5CVJ4uAbQ+Hdycw=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_github_containerd_cgroups",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/containerd/cgroups",
        sum = "h1:ADZftAkglvCiD44c77s5YmMqaP2pzVCFZvBmAlBdAP4=",
        version = "v1.0.3",
    )
    go_repository(
        name = "com_github_containerd_console",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/containerd/console",
        sum = "h1:lIr7SlA5PxZyMV30bDW0MGbiOPXwc63yRuCP0ARubLw=",
        version = "v1.0.3",
    )
    go_repository(
        name = "com_github_containerd_containerd",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/containerd/containerd",
        sum = "h1:NLDEI//zhMZpR3DS/AP0qiN+dzYKNAwJaNXCnCmYcgY=",
        version = "v1.5.17",
    )
    go_repository(
        name = "com_github_containerd_continuity",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/containerd/continuity",
        sum = "h1:nisirsYROK15TAMVukJOUyGJjz4BNQJBVsNvAXZJ/eg=",
        version = "v0.3.0",
    )

    go_repository(
        name = "com_github_containerd_ttrpc",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/containerd/ttrpc",
        sum = "h1:GbtyLRxb0gOLR0TYQWt3O6B0NvT8tMdorEHqIQo/lWI=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_coredns_caddy",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/coredns/caddy",
        sum = "h1:ezvsPrT/tA/7pYDBZxu0cT0VmWk75AfIaf6GSYCNMf0=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_coredns_corefile_migration",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/coredns/corefile-migration",
        sum = "h1:MdOkT6F3ehju/n9tgxlGct8XAajOX2vN+wG7To4BWSI=",
        version = "v1.0.20",
    )
    go_repository(
        name = "com_github_coreos_bbolt",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/coreos/bbolt",
        sum = "h1:wZwiHHUieZCquLkDL0B8UhzreNWsPHooDAG3q34zk0s=",
        version = "v1.3.2",
    )
    go_repository(
        name = "com_github_coreos_etcd",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/coreos/etcd",
        sum = "h1:8F3hqu9fGYLBifCmRCJsicFqDx/D68Rt3q1JMazcgBQ=",
        version = "v3.3.13+incompatible",
    )

    go_repository(
        name = "com_github_coreos_go_oidc",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/coreos/go-oidc",
        sum = "h1:mh48q/BqXqgjVHpy2ZY7WnWAbenxRjsz9N1i1YxjHAk=",
        version = "v2.2.1+incompatible",
    )
    go_repository(
        name = "com_github_coreos_go_oidc_v3",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/coreos/go-oidc/v3",
        sum = "h1:6avEvcdvTa1qYsOZ6I5PRkSYHzpTNWgKYmaJfaYbrRw=",
        version = "v3.1.0",
    )

    go_repository(
        name = "com_github_coreos_go_semver",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/coreos/go-semver",
        sum = "h1:yi21YpKnrx1gt5R+la8n5WgS0kCrsPp33dmEyHReZr4=",
        version = "v0.3.1",
    )
    go_repository(
        name = "com_github_coreos_go_systemd",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/coreos/go-systemd",
        sum = "h1:iW4rZ826su+pqaw19uhpSCzhj44qo35pNgKFGqzDKkU=",
        version = "v0.0.0-20191104093116-d3cd4ed1dbcf",
    )

    go_repository(
        name = "com_github_coreos_go_systemd_v22",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/coreos/go-systemd/v22",
        sum = "h1:RrqgGjYQKalulkV8NGVIfkXQf6YYmOyiJKk8iXXhfZs=",
        version = "v22.5.0",
    )
    go_repository(
        name = "com_github_coreos_pkg",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/coreos/pkg",
        sum = "h1:GOPo6vn/vTN+3IwZBvXX0y5doJfSC7My0cdzelyOCsQ=",
        version = "v0.0.0-20220810130054-c7d1c02cb6cf",
    )
    go_repository(
        name = "com_github_couchbase_gocb_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/couchbase/gocb/v2",
        sum = "h1:OItaIrFqXR1ba9J77E2YOU+CSF9G9FHYivV26Xgoi98=",
        version = "v2.3.3",
    )
    go_repository(
        name = "com_github_couchbase_gocbcore_v10",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/couchbase/gocbcore/v10",
        sum = "h1:RJ+dSXxMUbrpfgYEEUhMYwPH1S5KvcQYve3D2aKHP28=",
        version = "v10.0.4",
    )

    go_repository(
        name = "com_github_cpuguy83_go_md2man_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cpuguy83/go-md2man/v2",
        sum = "h1:p1EgwI/C7NhT0JmVkwCD2ZBK8j4aeHQX2pMHHBfMQ6w=",
        version = "v2.0.2",
    )
    go_repository(
        name = "com_github_creack_pty",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/creack/pty",
        sum = "h1:n56/Zwd5o6whRC5PMGretI4IdRLlmBXYNjScPaBgsbY=",
        version = "v1.1.18",
    )
    go_repository(
        name = "com_github_cyphar_filepath_securejoin",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/cyphar/filepath-securejoin",
        sum = "h1:YX6ebbZCZP7VkM3scTTokDgBL2TY741X51MTk3ycuNI=",
        version = "v0.2.3",
    )
    go_repository(
        name = "com_github_datadog_datadog_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/DataDog/datadog-go",
        sum = "h1:qSG2N4FghB1He/r2mFrWKCaL7dXCilEuNEeAn20fdD4=",
        version = "v3.2.0+incompatible",
    )
    go_repository(
        name = "com_github_datadog_zstd",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/DataDog/zstd",
        sum = "h1:+IawcoXhCBylN7ccwdwf8LOH2jKq7NavGpEPanrlTzE=",
        version = "v1.4.4",
    )
    go_repository(
        name = "com_github_dave_dst",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/dave/dst",
        sum = "h1:lnxLAKI3tx7MgLNVDirFCsDTlTG9nKTk7GcptKcWSwY=",
        version = "v0.26.2",
    )
    go_repository(
        name = "com_github_dave_gopackages",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/dave/gopackages",
        sum = "h1:l99YKCdrK4Lvb/zTupt0GMPfNbncAGf8Cv/t1sYLOg0=",
        version = "v0.0.0-20170318123100-46e7023ec56e",
    )
    go_repository(
        name = "com_github_dave_jennifer",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/dave/jennifer",
        sum = "h1:S15ZkFMRoJ36mGAQgWL1tnr0NQJh9rZ8qatseX/VbBc=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_dave_kerr",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/dave/kerr",
        sum = "h1:xURkGi4RydhyaYR6PzcyHTueQudxY4LgxN1oYEPJHa0=",
        version = "v0.0.0-20170318121727-bc25dd6abe8e",
    )
    go_repository(
        name = "com_github_dave_rebecca",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/dave/rebecca",
        sum = "h1:jxVfdOxRirbXL28vXMvUvJ1in3djwkVKXCq339qhBL0=",
        version = "v0.9.1",
    )

    go_repository(
        name = "com_github_davecgh_go_spew",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/davecgh/go-spew",
        sum = "h1:U9qPSI2PIWSS1VwoXQT9A3Wy9MM3WgvqSxFWenqJduM=",
        version = "v1.1.2-0.20180830191138-d8f796af33cc",
    )
    go_repository(
        name = "com_github_daviddengcn_go_colortext",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/daviddengcn/go-colortext",
        sum = "h1:ANqDyC0ys6qCSvuEK7l3g5RaehL/Xck9EX8ATG8oKsE=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_denisenkom_go_mssqldb",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/denisenkom/go-mssqldb",
        sum = "h1:1OcPn5GBIobjWNd+8yjfHNIaFX14B1pWI3F9HZy5KXw=",
        version = "v0.12.2",
    )

    go_repository(
        name = "com_github_dennwc_varint",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/dennwc/varint",
        sum = "h1:kGNFFSSw8ToIy3obO/kKr8U9GZYUAxQEVuix4zfDWzE=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_denverdino_aliyungo",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/denverdino/aliyungo",
        sum = "h1:p6poVbjHDkKa+wtC8frBMwQtT3BmqGYBjzMwJ63tuR4=",
        version = "v0.0.0-20190125010748-a747050bb1ba",
    )
    go_repository(
        name = "com_github_dgrijalva_jwt_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/dgrijalva/jwt-go",
        sum = "h1:7qlOGliEKZXTDg6OTjfoBKDXWrumCAMpl/TFQ4/5kLM=",
        version = "v3.2.0+incompatible",
    )
    go_repository(
        name = "com_github_dgryski_go_metro",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/dgryski/go-metro",
        sum = "h1:8WFBn63wegobsYAX0YjD+8suexZDga5CctH4CCTx2+8=",
        version = "v0.0.0-20180109044635-280f6062b5bc",
    )
    go_repository(
        name = "com_github_dgryski_go_sip13",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/dgryski/go-sip13",
        sum = "h1:RMLoZVzv4GliuWafOuPuQDKSm1SJph7uCRnnS61JAn4=",
        version = "v0.0.0-20181026042036-e10d5fee7954",
    )

    go_repository(
        name = "com_github_digitalocean_godo",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/digitalocean/godo",
        sum = "h1:potyC1eD0N9n5/P4/WmJuKgg+OGYZOBWEW+/aKTX6QQ=",
        version = "v1.98.0",
    )
    go_repository(
        name = "com_github_dimchansky_utfbom",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/dimchansky/utfbom",
        sum = "h1:vV6w1AhK4VMnhBno/TPVCoK9U/LP0PkLCS9tbxHdi/U=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_dnaeon_go_vcr",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/dnaeon/go-vcr",
        sum = "h1:r8L/HqC0Hje5AXMu1ooW8oyQyOFv4GxqpL0nRP7SLLY=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_docker_cli",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/docker/cli",
        sum = "h1:f/GQLsVpo10VvToRay2IraVA1wHz9KktZyjev3SIVDU=",
        version = "v20.10.18+incompatible",
    )

    go_repository(
        name = "com_github_docker_distribution",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/docker/distribution",
        sum = "h1:T3de5rq0dB1j30rp0sA2rER+m322EBzniBPB6ZIzuh8=",
        version = "v2.8.2+incompatible",
    )
    go_repository(
        name = "com_github_docker_docker",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/docker/docker",
        sum = "h1:Kd3Bh9V/rO+XpTP/BLqM+gx8z7+Yb0AA2Ibj+nNo4ek=",
        version = "v23.0.4+incompatible",
    )
    go_repository(
        name = "com_github_docker_go_connections",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/docker/go-connections",
        sum = "h1:El9xVISelRB7BuFusrZozjnkIM5YnzCViNKohAFqRJQ=",
        version = "v0.4.0",
    )
    go_repository(
        name = "com_github_docker_go_units",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/docker/go-units",
        sum = "h1:69rxXcBk27SvSaaxTtLh/8llcHD8vYHT7WSdRZ/jvr4=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_github_docker_spdystream",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/docker/spdystream",
        sum = "h1:ZfSZ3P3BedhKGUhzj7BQlPSU4OvT6tfOKe3DVHzOA7s=",
        version = "v0.0.0-20181023171402-6480d4af844c",
    )

    go_repository(
        name = "com_github_docopt_docopt_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/docopt/docopt-go",
        sum = "h1:bWDMxwH3px2JBh6AyO7hdCn/PkvCZXii8TGj7sbtEbQ=",
        version = "v0.0.0-20180111231733-ee0de3bc6815",
    )
    go_repository(
        name = "com_github_dsnet_compress",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/dsnet/compress",
        sum = "h1:iFaUwBSo5Svw6L7HYpRu/0lE3e0BaElwnNO1qkNQxBY=",
        version = "v0.0.2-0.20210315054119-f66993602bf5",
    )
    go_repository(
        name = "com_github_dsnet_golib",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/dsnet/golib",
        sum = "h1:tFh1tRc4CA31yP6qDcu+Trax5wW5GuMxvkIba07qVLY=",
        version = "v0.0.0-20171103203638-1ea166775780",
    )
    go_repository(
        name = "com_github_duosecurity_duo_api_golang",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/duosecurity/duo_api_golang",
        sum = "h1:2MIhn2R6oXQbgW5yHfS+d6YqyMfXiu2L55rFZC4UD/M=",
        version = "v0.0.0-20190308151101-6c680f768e74",
    )

    go_repository(
        name = "com_github_dustin_go_humanize",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/dustin/go-humanize",
        sum = "h1:VSnTsYCnlFHaM2/igO1h6X3HA71jcobQuxemgkq4zYo=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_eapache_go_resiliency",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/eapache/go-resiliency",
        sum = "h1:1NtRmCAqadE2FN4ZcN6g90TP3uk8cg9rn9eNK2197aU=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_eapache_go_xerial_snappy",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/eapache/go-xerial-snappy",
        sum = "h1:YEetp8/yCZMuEPMUDHG0CW/brkkEp8mzqk2+ODEitlw=",
        version = "v0.0.0-20180814174437-776d5712da21",
    )
    go_repository(
        name = "com_github_eapache_queue",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/eapache/queue",
        sum = "h1:YOEu7KNc61ntiQlcEeUIoDTJ2o8mQznoNvUhiigpIqc=",
        version = "v1.1.0",
    )

    go_repository(
        name = "com_github_edsrzf_mmap_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/edsrzf/mmap-go",
        sum = "h1:6EUwBLQ/Mcr1EYLE4Tn1VdW1A4ckqCQWZBw8Hr0kjpQ=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_elazarl_go_bindata_assetfs",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/elazarl/go-bindata-assetfs",
        sum = "h1:G/bYguwHIzWq9ZoyUQqrjTmJbbYn3j3CKKpKinvZLFk=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_elazarl_goproxy",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/elazarl/goproxy",
        sum = "h1:pEtiCjIXx3RvGjlUJuCNxNOw0MNblyR9Wi+vJGBFh+8=",
        version = "v0.0.0-20191011121108-aa519ddbe484",
    )
    go_repository(
        name = "com_github_elazarl_goproxy_ext",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/elazarl/goproxy/ext",
        sum = "h1:dWB6v3RcOy03t/bUadywsbyrQwCqZeNIEX6M1OtSZOM=",
        version = "v0.0.0-20190711103511-473e67f1d7d2",
    )

    go_repository(
        name = "com_github_emicklei_go_restful_v3",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/emicklei/go-restful/v3",
        sum = "h1:hIovbnmBTLjHXkqEBUz3HGpXZdM7ZrE9fJIZIqlJLqE=",
        version = "v3.10.2",
    )

    go_repository(
        name = "com_github_emicklei_proto",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/emicklei/proto",
        sum = "h1:DiIeyTJ+gPSyJI+RIAqvuTeKb0tLUmaGXbYg6aFKsnE=",
        version = "v1.11.2",
    )
    go_repository(
        name = "com_github_envoyproxy_go_control_plane",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/envoyproxy/go-control-plane",
        sum = "h1:jtLewhRR2vMRNnq2ZZUoCjUlgut+Y0+sDDWPOfwOi1o=",
        version = "v0.11.0",
    )
    go_repository(
        name = "com_github_envoyproxy_protoc_gen_validate",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/envoyproxy/protoc-gen-validate",
        sum = "h1:c0g45+xCJhdgFGw7a5QAfdS4byAbud7miNWJ1WwEVf8=",
        version = "v0.10.1",
    )
    go_repository(
        name = "com_github_euank_go_kmsg_parser",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/euank/go-kmsg-parser",
        sum = "h1:cHD53+PLQuuQyLZeriD1V/esuG4MuU0Pjs5y6iknohY=",
        version = "v2.0.0+incompatible",
    )

    go_repository(
        name = "com_github_evanphx_json_patch",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/evanphx/json-patch",
        sum = "h1:jBYDEEiFBPxA0v50tFdvOzQQTCvpL6mnFh5mB2/l16U=",
        version = "v5.6.0+incompatible",
    )
    go_repository(
        name = "com_github_evanphx_json_patch_v5",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/evanphx/json-patch/v5",
        sum = "h1:b91NhWfaz02IuVxO9faSllyAtNXHMPkC5J8sJCLunww=",
        version = "v5.6.0",
    )

    go_repository(
        name = "com_github_exponent_io_jsonpath",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/exponent-io/jsonpath",
        sum = "h1:Wl78ApPPB2Wvf/TIe2xdyJxTlb6obmF18d8QdkxNDu4=",
        version = "v0.0.0-20210407135951-1de76d718b3f",
    )
    go_repository(
        name = "com_github_fatih_camelcase",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/fatih/camelcase",
        sum = "h1:hxNvNX/xYBp0ovncs8WyWZrOrpBNub/JfaMvbURyft8=",
        version = "v1.0.0",
    )

    go_repository(
        name = "com_github_fatih_color",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/fatih/color",
        sum = "h1:qfhVLaG5s+nCROl1zJsZRxFeYrHLqWroPOQ8BWiNb4w=",
        version = "v1.14.1",
    )
    go_repository(
        name = "com_github_fatih_structs",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/fatih/structs",
        sum = "h1:Q7juDM0QtcnhCpeyLGQKyg4TOIghuNXrkL32pHAUMxo=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_favadi_protoc_go_inject_tag",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/favadi/protoc-go-inject-tag",
        sum = "h1:JPrmsmc/uBShG85uY5xGZIa5WJ0IaNZn6LZhQR9tIQE=",
        version = "v1.3.0",
    )

    go_repository(
        name = "com_github_felixge_httpsnoop",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/felixge/httpsnoop",
        sum = "h1:s/nj+GCswXYzN5v2DpNMuMQYe+0DDwt5WVCU6CWBdXk=",
        version = "v1.0.3",
    )
    go_repository(
        name = "com_github_flowstack_go_jsonschema",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/flowstack/go-jsonschema",
        sum = "h1:dCrjGJRXIlbDsLAgTJZTjhwUJnnxVWl1OgNyYh5nyDc=",
        version = "v0.1.1",
    )
    go_repository(
        name = "com_github_form3tech_oss_jwt_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/form3tech-oss/jwt-go",
        sum = "h1:/l4kBbb4/vGSsdtB5nUe8L7B9mImVMaBPw9L/0TBHU8=",
        version = "v3.2.5+incompatible",
    )
    go_repository(
        name = "com_github_frankban_quicktest",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/frankban/quicktest",
        sum = "h1:yNZif1OkDfNoDfb9zZa9aXIpejNR4F23Wely0c+Qdqk=",
        version = "v1.13.0",
    )

    go_repository(
        name = "com_github_fsnotify_fsnotify",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/fsnotify/fsnotify",
        sum = "h1:n+5WquG0fcWoWp6xPWfHdbskMCQaFnG6PfBrh1Ky4HY=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_github_fullsailor_pkcs7",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/fullsailor/pkcs7",
        sum = "h1:RDBNVkRviHZtvDvId8XSGPu3rmpmSe+wKRcEWNgsfWU=",
        version = "v0.0.0-20190404230743-d7302db945fa",
    )

    go_repository(
        name = "com_github_fvbommel_sortorder",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/fvbommel/sortorder",
        sum = "h1:fUmoe+HLsBTctBDoaBwpQo5N+nrCp8g/BjKb/6ZQmYw=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_gabriel_vasile_mimetype",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/gabriel-vasile/mimetype",
        sum = "h1:qevA6c2MtE1RorlScnixeG0VA1H4xrXyhyX3oWBynNQ=",
        version = "v1.3.1",
    )
    go_repository(
        name = "com_github_gammazero_deque",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/gammazero/deque",
        sum = "h1:D2LrfOPgGHQprIxmsTpxtzhpmF66HoM6rXSmcqaX7h8=",
        version = "v0.0.0-20190130191400-2afb3858e9c7",
    )
    go_repository(
        name = "com_github_gammazero_workerpool",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/gammazero/workerpool",
        sum = "h1:VzbudKn/nvxYKOdzgkEBS6SSreRjAgoJ+ZeS4wPFkgc=",
        version = "v0.0.0-20190406235159-88d534f22b56",
    )
    go_repository(
        name = "com_github_getsentry_raven_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/getsentry/raven-go",
        sum = "h1:no+xWJRb5ZI7eE8TWgIq1jLulQiIoLG0IfYxv5JYMGs=",
        version = "v0.2.0",
    )

    go_repository(
        name = "com_github_ghodss_yaml",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/ghodss/yaml",
        sum = "h1:Mn26/9ZMNWSw9C9ERFA1PUxfmGpolnw2v0bKOREu5ew=",
        version = "v1.0.1-0.20190212211648-25d852aebe32",
    )
    go_repository(
        name = "com_github_go_asn1_ber_asn1_ber",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-asn1-ber/asn1-ber",
        sum = "h1:pDbRAunXzIUXfx4CB2QJFv5IuPiuoW+sWvr/Us009o8=",
        version = "v1.5.1",
    )

    go_repository(
        name = "com_github_go_errors_errors",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-errors/errors",
        sum = "h1:J6MZopCL4uSllY1OfXM374weqZFFItUbrImctkmUxIA=",
        version = "v1.4.2",
    )

    go_repository(
        name = "com_github_go_gl_glfw",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-gl/glfw",
        sum = "h1:QbL/5oDUmRBzO9/Z7Seo6zf912W/a6Sr4Eu0G/3Jho0=",
        version = "v0.0.0-20190409004039-e6da0acd62b1",
    )
    go_repository(
        name = "com_github_go_gl_glfw_v3_3_glfw",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-gl/glfw/v3.3/glfw",
        sum = "h1:WtGNWLvXpe6ZudgnXrq0barxBImvnnJoMEhXAzcbM0I=",
        version = "v0.0.0-20200222043503-6f7a984d4dc4",
    )
    go_repository(
        name = "com_github_go_kit_kit",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-kit/kit",
        sum = "h1:e4o3o3IsBfAKQh5Qbbiqyfu97Ku7jrO/JbohvztANh4=",
        version = "v0.12.0",
    )
    go_repository(
        name = "com_github_go_kit_log",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-kit/log",
        sum = "h1:MRVx0/zhvdseW+Gza6N9rVzU/IVzaeE1SFI4raAhmBU=",
        version = "v0.2.1",
    )
    go_repository(
        name = "com_github_go_ldap_ldap",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-ldap/ldap",
        sum = "h1:kD5HQcAzlQ7yrhfn+h+MSABeAy/jAJhvIJ/QDllP44g=",
        version = "v3.0.2+incompatible",
    )
    go_repository(
        name = "com_github_go_ldap_ldap_v3",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-ldap/ldap/v3",
        sum = "h1:fU/0xli6HY02ocbMuozHAYsaHLcnkLjvho2r5a34BUU=",
        version = "v3.4.1",
    )
    go_repository(
        name = "com_github_go_ldap_ldif",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-ldap/ldif",
        sum = "h1:sfz1YppV05y4sYaW7kXZtrocU/+vimnIWt4cxAYh7+o=",
        version = "v0.0.0-20200320164324-fd88d9b715b3",
    )

    go_repository(
        name = "com_github_go_logfmt_logfmt",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-logfmt/logfmt",
        sum = "h1:wGYYu3uicYdqXVgoYbvnkrPVXkuLM1p1ifugDMEdRi4=",
        version = "v0.6.0",
    )
    go_repository(
        name = "com_github_go_logr_logr",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-logr/logr",
        sum = "h1:g01GSCwiDw2xSZfjJ2/T9M+S6pFdcNtFYsp+Y43HYDQ=",
        version = "v1.2.4",
    )
    go_repository(
        name = "com_github_go_logr_stdr",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-logr/stdr",
        sum = "h1:hSWxHoqTgW2S2qGc0LTAI563KZ5YKYRhT3MFKZMbjag=",
        version = "v1.2.2",
    )
    go_repository(
        name = "com_github_go_logr_zapr",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-logr/zapr",
        sum = "h1:a9vnzlIBPQBBkeaR9IuMUfmVOrQlkoC4YfPoFkX3T7A=",
        version = "v1.2.3",
    )
    go_repository(
        name = "com_github_go_martini_martini",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-martini/martini",
        sum = "h1:xveKWz2iaueeTaUgdetzel+U7exyigDYBryyVfV/rZk=",
        version = "v0.0.0-20170121215854-22fa46961aab",
    )
    go_repository(
        name = "com_github_go_ole_go_ole",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-ole/go-ole",
        sum = "h1:/Fpf6oFPoeFik9ty7siob0G6Ke8QvQEuVcuChpwXzpY=",
        version = "v1.2.6",
    )

    go_repository(
        name = "com_github_go_openapi_analysis",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-openapi/analysis",
        sum = "h1:ZDFLvSNxpDaomuCueM0BlSXxpANBlFYiBvr+GXrvIHc=",
        version = "v0.21.4",
    )
    go_repository(
        name = "com_github_go_openapi_errors",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-openapi/errors",
        sum = "h1:rz6kiC84sqNQoqrtulzaL/VERgkoCyB6WdEkc2ujzUc=",
        version = "v0.20.3",
    )

    go_repository(
        name = "com_github_go_openapi_jsonpointer",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-openapi/jsonpointer",
        sum = "h1:eCs3fxoIi3Wh6vtgmLTOjdhSpiqphQ+DaPn38N2ZdrE=",
        version = "v0.19.6",
    )
    go_repository(
        name = "com_github_go_openapi_jsonreference",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-openapi/jsonreference",
        sum = "h1:3sVjiK66+uXK/6oQ8xgcRKcFgQ5KXa2KvnJRumpMGbE=",
        version = "v0.20.2",
    )
    go_repository(
        name = "com_github_go_openapi_loads",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-openapi/loads",
        sum = "h1:r2a/xFIYeZ4Qd2TnGpWDIQNcP80dIaZgf704za8enro=",
        version = "v0.21.2",
    )
    go_repository(
        name = "com_github_go_openapi_runtime",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-openapi/runtime",
        sum = "h1:TqagMVlRAOTwllE/7hNKx6rQ10O6T8ZzeJdMjSTKaD4=",
        version = "v0.19.24",
    )

    go_repository(
        name = "com_github_go_openapi_spec",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-openapi/spec",
        sum = "h1:ubHmXNY3FCIOinT8RNrrPfGc9t7I1qhPtdOGoG2AxRU=",
        version = "v0.20.8",
    )
    go_repository(
        name = "com_github_go_openapi_strfmt",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-openapi/strfmt",
        sum = "h1:rspiXgNWgeUzhjo1YU01do6qsahtJNByjLVbPLNHb8k=",
        version = "v0.21.7",
    )

    go_repository(
        name = "com_github_go_openapi_swag",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-openapi/swag",
        sum = "h1:yMBqmnQ0gyZvEb/+KzuWZOXgllrXT4SADYbvDaXHv/g=",
        version = "v0.22.3",
    )
    go_repository(
        name = "com_github_go_openapi_validate",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-openapi/validate",
        sum = "h1:G+c2ub6q47kfX1sOBLwIQwzBVt8qmOAARyo/9Fqs9NU=",
        version = "v0.22.1",
    )
    go_repository(
        name = "com_github_go_ozzo_ozzo_validation",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-ozzo/ozzo-validation",
        sum = "h1:msy24VGS42fKO9K1vLz82/GeYW1cILu7Nuuj1N3BBkE=",
        version = "v3.6.0+incompatible",
    )

    go_repository(
        name = "com_github_go_resty_resty_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-resty/resty/v2",
        sum = "h1:me+K9p3uhSmXtrBZ4k9jcEAfJmuC8IivWHwaLZwPrFY=",
        version = "v2.7.0",
    )
    go_repository(
        name = "com_github_go_sql_driver_mysql",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-sql-driver/mysql",
        sum = "h1:BCTh4TKNUYmOmMUcQ3IipzF5prigylS7XXjEkfCHuOE=",
        version = "v1.6.0",
    )

    go_repository(
        name = "com_github_go_stack_stack",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-stack/stack",
        sum = "h1:5SgMzNM5HxrEjV0ww2lTmX6E2Izsfxas4+YHWRs3Lsk=",
        version = "v1.8.0",
    )
    go_repository(
        name = "com_github_go_task_slim_sprig",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-task/slim-sprig",
        sum = "h1:p104kn46Q8WdvHunIJ9dAyjPVtrBPhSr3KT2yUst43I=",
        version = "v0.0.0-20210107165309-348f09dbbbc0",
    )
    go_repository(
        name = "com_github_go_test_deep",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-test/deep",
        sum = "h1:WOcxcdHcvdgThNXjw0t76K42FXTU7HpNQWHpA2HHNlg=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_go_yaml_yaml",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-yaml/yaml",
        sum = "h1:RYi2hDdss1u4YE7GwixGzWwVo47T8UQwnTLB6vQiq+o=",
        version = "v2.1.0+incompatible",
    )

    go_repository(
        name = "com_github_go_zookeeper_zk",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/go-zookeeper/zk",
        sum = "h1:7M2kwOsc//9VeeFiPtf+uSJlVpU66x9Ba5+8XK7/TDg=",
        version = "v1.0.3",
    )
    go_repository(
        name = "com_github_gocql_gocql",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/gocql/gocql",
        sum = "h1:UnbTERpP72VZ/viKE1Q1gPtmLvyTZTvuAstvSRydw/c=",
        version = "v1.0.0",
    )

    go_repository(
        name = "com_github_godbus_dbus_v5",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/godbus/dbus/v5",
        sum = "h1:mkgN1ofwASrYnJ5W6U/BxG15eXXXjirgZc7CLqkcaro=",
        version = "v5.0.6",
    )
    go_repository(
        name = "com_github_gofrs_uuid",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/gofrs/uuid",
        sum = "h1:CaSVZxm5B+7o45rtab4jC2G37WGYX1zQfuU2i6DSvnc=",
        version = "v4.3.0+incompatible",
    )

    go_repository(
        name = "com_github_gogo_protobuf",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/gogo/protobuf",
        sum = "h1:Ov1cvc58UF3b5XjBnZv7+opcTcQFZebYjWzi34vdm4Q=",
        version = "v1.3.2",
    )
    go_repository(
        name = "com_github_goji_httpauth",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/goji/httpauth",
        sum = "h1:lBXNCxVENCipq4D1Is42JVOP4eQjlB8TQ6H69Yx5J9Q=",
        version = "v0.0.0-20160601135302-2da839ab0f4d",
    )

    go_repository(
        name = "com_github_golang_glog",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/golang/glog",
        sum = "h1:jxpi2eWoU84wbX9iIEyAeeoac3FLuifZpY9tcNUD9kw=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_golang_groupcache",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/golang/groupcache",
        sum = "h1:oI5xCqsCo564l8iNU+DwB5epxmsaqB+rhGL0m5jtYqE=",
        version = "v0.0.0-20210331224755-41bb18bfe9da",
    )
    go_repository(
        name = "com_github_golang_jwt_jwt_v4",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/golang-jwt/jwt/v4",
        sum = "h1:7cYmW1XlMY7h7ii7UhUyChSgS5wUJEnm9uZVTGqOWzg=",
        version = "v4.5.0",
    )
    go_repository(
        name = "com_github_golang_lint",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/golang/lint",
        sum = "h1:2hRPrmiwPrp3fQX967rNJIhQPtiGXdlQWAxKbKw3VHA=",
        version = "v0.0.0-20180702182130-06c8688daad7",
    )

    go_repository(
        name = "com_github_golang_mock",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/golang/mock",
        sum = "h1:ErTB+efbowRARo13NNdxyJji2egdxLGQhRaY+DUumQc=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_github_golang_protobuf",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/golang/protobuf",
        sum = "h1:KhyjKVUg7Usr/dYsdSqoFveMYd5ko72D+zANwlG1mmg=",
        version = "v1.5.3",
    )
    go_repository(
        name = "com_github_golang_snappy",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/golang/snappy",
        sum = "h1:yAGX7huGHXlcLOEtBnF4w7FQwA26wojNCwOYAEhLjQM=",
        version = "v0.0.4",
    )
    go_repository(
        name = "com_github_golang_sql_civil",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/golang-sql/civil",
        sum = "h1:lXe2qZdvpiX5WZkZR4hgp4KJVfY3nMkvmwbVkpv1rVY=",
        version = "v0.0.0-20190719163853-cb61b32ac6fe",
    )
    go_repository(
        name = "com_github_golang_sql_sqlexp",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/golang-sql/sqlexp",
        sum = "h1:ZCD6MBpcuOVfGVqsEmY5/4FtYiKz6tSyUv9LPEDei6A=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_golangci_revgrep",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/golangci/revgrep",
        sum = "h1:DIPQnGy2Gv2FSA4B/hh8Q7xx3B7AIDk3DAMeHclH1vQ=",
        version = "v0.0.0-20220804021717-745bb2f7c2e6",
    )

    go_repository(
        name = "com_github_golangplus_bytes",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/golangplus/bytes",
        sum = "h1:YQKBijBVMsBxIiXT4IEhlKR2zHohjEqPole4umyDX+c=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_golangplus_fmt",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/golangplus/fmt",
        sum = "h1:FnUKtw86lXIPfBMc3FimNF3+ABcV+aH5F17OOitTN+E=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_golangplus_testing",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/golangplus/testing",
        sum = "h1:+ZeeiKZENNOMkTTELoSySazi+XaEhVO0mb+eanrSEUQ=",
        version = "v1.0.0",
    )

    go_repository(
        name = "com_github_google_btree",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/btree",
        sum = "h1:xf4v41cLI2Z6FxbKm+8Bu+m8ifhj15JuZ9sa0jZCMUU=",
        version = "v1.1.2",
    )
    go_repository(
        name = "com_github_google_cadvisor",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/cadvisor",
        sum = "h1:YyKnRy/3myRNGOvF1bNF9FFnpjY7Gky5yKi/ZlN+BSo=",
        version = "v0.47.1",
    )
    go_repository(
        name = "com_github_google_cel_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/cel-go",
        sum = "h1:jX8b/sSNoE1JBaxLAVDb+rTuEk9F7+Yd8UVKWjoz7SU=",
        version = "v0.15.2",
    )
    go_repository(
        name = "com_github_google_flatbuffers",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/flatbuffers",
        sum = "h1:dicJ2oXwypfwUGnB2/TYWYEKiuk9eYQlQO/AnOHl5mI=",
        version = "v2.0.0+incompatible",
    )

    go_repository(
        name = "com_github_google_gnostic",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/gnostic",
        sum = "h1:ZK/5VhkoX835RikCHpSUJV9a+S3e1zLh59YnyWeBW+0=",
        version = "v0.6.9",
    )

    go_repository(
        name = "com_github_google_go_cmp",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/go-cmp",
        sum = "h1:O2Tfq5qg4qc4AmwVlvv0oLiVAGB7enBSJ2x2DqQFi38=",
        version = "v0.5.9",
    )
    go_repository(
        name = "com_github_google_go_github",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/go-github",
        sum = "h1:N0LgJ1j65A7kfXrZnUDaYCs/Sf4rEjNlfyDHW9dolSY=",
        version = "v17.0.0+incompatible",
    )
    go_repository(
        name = "com_github_google_go_metrics_stackdriver",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/go-metrics-stackdriver",
        sum = "h1:rbs2sxHAPn2OtUj9JdR/Gij1YKGl0BTVD0augB+HEjE=",
        version = "v0.2.0",
    )

    go_repository(
        name = "com_github_google_go_querystring",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/go-querystring",
        sum = "h1:AnCroh3fv4ZBgVIf1Iwtovgjaw/GiKJo8M8yD/fhyJ8=",
        version = "v1.1.0",
    )

    go_repository(
        name = "com_github_google_gofuzz",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/gofuzz",
        sum = "h1:xRy4A+RhZaiKjJ1bPfwQ8sedCA+YS2YcCHW6ec7JMi0=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_google_martian",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/martian",
        sum = "h1:/CP5g8u/VJHijgedC/Legn3BAbAaWPgecwXBIDzw5no=",
        version = "v2.1.0+incompatible",
    )
    go_repository(
        name = "com_github_google_martian_v3",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/martian/v3",
        sum = "h1:d8MncMlErDFTwQGBK1xhv026j9kqhvw1Qv9IbWT1VLQ=",
        version = "v3.2.1",
    )

    go_repository(
        name = "com_github_google_pprof",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/pprof",
        sum = "h1:hFhpt7CTmR3DX+b4R19ydQFtofxT0Sv3QsKNMVQYTMQ=",
        version = "v0.0.0-20230406165453-00490a63f317",
    )
    go_repository(
        name = "com_github_google_renameio",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/renameio",
        sum = "h1:GOZbcHa3HfsPKPlmyPyN2KEohoMXOhdMbHrvbpl2QaA=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_google_shlex",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/shlex",
        sum = "h1:El6M4kTTCOh6aBiKaUGG7oYTSPP8MxqL4YI3kZKwcP4=",
        version = "v0.0.0-20191202100458-e7afc7fbc510",
    )
    go_repository(
        name = "com_github_google_tink_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/tink/go",
        sum = "h1:t7JHqO8Ath2w2ig5vjwQYJzhGEZymedQc90lQXUBa4I=",
        version = "v1.6.1",
    )

    go_repository(
        name = "com_github_google_uuid",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/google/uuid",
        sum = "h1:t6JiXgmwXMjEs8VusXIJk2BXHsn+wx8BZdTaoZ5fu7I=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_github_googleapis_enterprise_certificate_proxy",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/googleapis/enterprise-certificate-proxy",
        sum = "h1:yk9/cqRKtT9wXZSsRH9aurXEpJX+U6FLtpYTdC3R06k=",
        version = "v0.2.3",
    )

    go_repository(
        name = "com_github_googleapis_gax_go_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/googleapis/gax-go/v2",
        sum = "h1:gF4c0zjUP2H/s/hEGyLA3I0fA2ZWjzYiONAD6cvPr8A=",
        version = "v2.7.1",
    )
    go_repository(
        name = "com_github_googleapis_gnostic",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/googleapis/gnostic",
        sum = "h1:WeAefnSUHlBb0iJKwxFDZdbfGwkd7xRNuV+IpXMJhYk=",
        version = "v0.3.1",
    )

    go_repository(
        name = "com_github_googlecloudplatform_k8s_cloud_provider",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/GoogleCloudPlatform/k8s-cloud-provider",
        sum = "h1:Heo1J/ttaQFgGJSVnCZquy3e5eH5j1nqxBuomztB3P0=",
        version = "v1.18.1-0.20220218231025-f11817397a1b",
    )
    go_repository(
        name = "com_github_gophercloud_gophercloud",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/gophercloud/gophercloud",
        sum = "h1:RUKyCMiZoQR3VlVR5E3K7PK1AC3/qppsWYo6dtBiqs8=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_github_gopherjs_gopherjs",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/gopherjs/gopherjs",
        sum = "h1:EGx4pi6eqNxGaHF6qqu48+N2wcFQ5qg5FXgOdqsJ5d8=",
        version = "v0.0.0-20181017120253-0766667cb4d1",
    )
    go_repository(
        name = "com_github_gorhill_cronexpr",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/gorhill/cronexpr",
        sum = "h1:f0n1xnMSmBLzVfsMMvriDyA75NB/oBgILX2GcHXIQzY=",
        version = "v0.0.0-20180427100037-88b0669f7d75",
    )
    go_repository(
        name = "com_github_gorilla_context",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/gorilla/context",
        sum = "h1:AWwleXJkX/nhcU9bZSnZoi3h/qGYqQAGhq6zZe/aQW8=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_gorilla_mux",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/gorilla/mux",
        sum = "h1:Pgr17XVTNXAk3q/r4CpKzC5xBM/qW1uVLV+IhRZpIIk=",
        version = "v1.6.2",
    )
    go_repository(
        name = "com_github_gorilla_securecookie",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/gorilla/securecookie",
        sum = "h1:miw7JPhV+b/lAHSXz4qd/nN9jRiAFV5FwjeKyCS8BvQ=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_gorilla_sessions",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/gorilla/sessions",
        sum = "h1:S7P+1Hm5V/AT9cjEcUD5uDaQSX0OE577aCXgoaKpYbQ=",
        version = "v1.2.0",
    )

    go_repository(
        name = "com_github_gorilla_websocket",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/gorilla/websocket",
        sum = "h1:PPwGk2jz7EePpoHN/+ClbZu8SPxiqlu12wZP/3sWmnc=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_github_gotestyourself_gotestyourself",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/gotestyourself/gotestyourself",
        sum = "h1:AQwinXlbQR2HvPjQZOmDhRqsv5mZf+Jb1RnSLxcqZcI=",
        version = "v2.2.0+incompatible",
    )

    go_repository(
        name = "com_github_grafana_regexp",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/grafana/regexp",
        sum = "h1:PpuIBO5P3e9hpqBD0O/HjhShYuM6XE0i/lbE6J94kww=",
        version = "v0.0.0-20221122212121-6b5c0a4cb7fd",
    )

    go_repository(
        name = "com_github_gregjones_httpcache",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/gregjones/httpcache",
        sum = "h1:+ngKgrYPPJrOjhax5N+uePQ0Fh1Z7PheYoUI/0nzkPA=",
        version = "v0.0.0-20190611155906-901d90724c79",
    )
    go_repository(
        name = "com_github_grpc_ecosystem_go_grpc_middleware",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/grpc-ecosystem/go-grpc-middleware",
        sum = "h1:+9834+KizmvFV7pXQGSXQTsaWhq2GjuNUt0aUU0YBYw=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_github_grpc_ecosystem_go_grpc_prometheus",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/grpc-ecosystem/go-grpc-prometheus",
        sum = "h1:Ovs26xHkKqVztRpIrF/92BcuyuQ/YW4NSIpoGtfXNho=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_grpc_ecosystem_grpc_gateway",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/grpc-ecosystem/grpc-gateway",
        sum = "h1:gmcG1KaJ57LophUzW0Hy8NmPhnMZb4M0+kPpLofRdBo=",
        version = "v1.16.0",
    )
    go_repository(
        name = "com_github_grpc_ecosystem_grpc_gateway_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/grpc-ecosystem/grpc-gateway/v2",
        sum = "h1:gDLXvp5S9izjldquuoAhDzccbskOL6tDC5jMSyx3zxE=",
        version = "v2.15.2",
    )
    go_repository(
        name = "com_github_h2non_parth",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/h2non/parth",
        sum = "h1:2VTzZjLZBgl62/EtslCrtky5vbi9dd7HrQPQIx6wqiw=",
        version = "v0.0.0-20190131123155-b4df798d6542",
    )
    go_repository(
        name = "com_github_hailocab_go_hostpool",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hailocab/go-hostpool",
        sum = "h1:5upAirOpQc1Q53c0bnx2ufif5kANL7bfZWcc6VJWJd8=",
        version = "v0.0.0-20160125115350-e80d13ce29ed",
    )
    go_repository(
        name = "com_github_hashicorp_cap",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/cap",
        sum = "h1:Vgv3jG0kicczshK+lOHWJ9OososZjnjSu1YslqofFYY=",
        version = "v0.2.1-0.20220727210936-60cd1534e220",
    )

    go_repository(
        name = "com_github_hashicorp_consul_api",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/consul/api",
        sum = "h1:9IHTjNVSZ7MIwjlW3N3a7iGiykCMDpxZu8jsxFJh0yc=",
        version = "v1.20.0",
    )
    go_repository(
        name = "com_github_hashicorp_consul_sdk",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/consul/sdk",
        sum = "h1:zBtCfKJZcJDBvSCkQJch4ulp59m1rATFLKwNo/LYY30=",
        version = "v0.4.0",
    )
    go_repository(
        name = "com_github_hashicorp_consul_template",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/consul-template",
        sum = "h1:tzEo93RqODAX2cgOe/ke8xcpdPdxg5rxl6d22wE3f6c=",
        version = "v0.29.5",
    )

    go_repository(
        name = "com_github_hashicorp_cronexpr",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/cronexpr",
        sum = "h1:NJZDd87hGXjoZBdvyCF9mX4DCq5Wy7+A/w+A7q0wn6c=",
        version = "v1.1.1",
    )

    go_repository(
        name = "com_github_hashicorp_errwrap",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/errwrap",
        sum = "h1:OxrOeh75EUXMY8TBjag2fzXGZ40LB6IKw45YeGUDY2I=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_hashicorp_eventlogger",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/eventlogger",
        sum = "h1:zyCjxsy7KunFsMPZKU5PnwWEakSrp1zjj2vPFmrDaeo=",
        version = "v0.1.1",
    )

    go_repository(
        name = "com_github_hashicorp_go_cleanhttp",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-cleanhttp",
        sum = "h1:035FKYIWjmULyFRBKPs8TBQoi0x6d9G4xc9neXJWAZQ=",
        version = "v0.5.2",
    )
    go_repository(
        name = "com_github_hashicorp_go_discover",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-discover",
        sum = "h1:eje2KOX8Sf7aYPiAsLnpWdAIrGRMcpFjN/Go/Exb7Zo=",
        version = "v0.0.0-20210818145131-c573d69da192",
    )
    go_repository(
        name = "com_github_hashicorp_go_gatedio",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-gatedio",
        sum = "h1:Jm1X5yP4yCqqWj5L1TgW7iZwCVPGtVc+mro5r/XX7Tg=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_github_hashicorp_go_gcp_common",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-gcp-common",
        sum = "h1:/2vGAbCU1v+BZ3YHXTCzTvxqma9WOJHYtADTfhZixLo=",
        version = "v0.8.0",
    )

    go_repository(
        name = "com_github_hashicorp_go_hclog",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-hclog",
        sum = "h1:bI2ocEMgcVlz55Oj1xZNBsVi900c7II+fWDyV9o+13c=",
        version = "v1.5.0",
    )

    go_repository(
        name = "com_github_hashicorp_go_immutable_radix",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-immutable-radix",
        sum = "h1:DKHmCUm2hRBK510BaiZlwvpD40f8bJFeZnpfm2KLowc=",
        version = "v1.3.1",
    )
    go_repository(
        name = "com_github_hashicorp_go_kms_wrapping",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-kms-wrapping",
        sum = "h1:Ed6Z5gV3LY3J9Ora4cwxVmV8Hyt6CPOTrQoGIPry2Ew=",
        version = "v0.5.1",
    )
    go_repository(
        name = "com_github_hashicorp_go_kms_wrapping_entropy",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-kms-wrapping/entropy",
        sum = "h1:xuTi5ZwjimfpvpL09jDE71smCBRpnF5xfo871BSX4gs=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_hashicorp_go_kms_wrapping_entropy_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-kms-wrapping/entropy/v2",
        sum = "h1:pSjQfW3vPtrOTcasTUKgCTQT7OGPPTTMVRrOfU6FJD8=",
        version = "v2.0.0",
    )
    go_repository(
        name = "com_github_hashicorp_go_kms_wrapping_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-kms-wrapping/v2",
        sum = "h1:9Q2lu1YbbmiAgvYZ7Pr31RdlVonUpX+mmDL7Z7qTA2U=",
        version = "v2.0.8",
    )
    go_repository(
        name = "com_github_hashicorp_go_kms_wrapping_wrappers_aead_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-kms-wrapping/wrappers/aead/v2",
        sum = "h1:ZV26VJYcITBom0QqYSUOIj4HOHCVPEFjLqjxyXV/AbA=",
        version = "v2.0.7-1",
    )
    go_repository(
        name = "com_github_hashicorp_go_kms_wrapping_wrappers_alicloudkms_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-kms-wrapping/wrappers/alicloudkms/v2",
        sum = "h1:ydUCtmr8f9F+mHZ1iCsvzqFTXqNVpewX3s9zcYipMKI=",
        version = "v2.0.1",
    )
    go_repository(
        name = "com_github_hashicorp_go_kms_wrapping_wrappers_awskms_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-kms-wrapping/wrappers/awskms/v2",
        sum = "h1:E3eEWpkofgPNrYyYznfS1+drq4/jFcqHQVNcL7WhUCo=",
        version = "v2.0.7",
    )
    go_repository(
        name = "com_github_hashicorp_go_kms_wrapping_wrappers_azurekeyvault_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-kms-wrapping/wrappers/azurekeyvault/v2",
        sum = "h1:X27JWuPW6Gmi2l7NMm0pvnp7z7hhtns2TeIOQU93mqI=",
        version = "v2.0.7",
    )
    go_repository(
        name = "com_github_hashicorp_go_kms_wrapping_wrappers_gcpckms_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-kms-wrapping/wrappers/gcpckms/v2",
        sum = "h1:16I8OqBEuxZIowwn3jiLvhlx+z+ia4dJc9stvz0yUBU=",
        version = "v2.0.8",
    )
    go_repository(
        name = "com_github_hashicorp_go_kms_wrapping_wrappers_ocikms_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-kms-wrapping/wrappers/ocikms/v2",
        sum = "h1:KeG3QGrbxbr2qAqCJdf3NR4ijAYwdcWLTmwSbR0yusM=",
        version = "v2.0.7",
    )
    go_repository(
        name = "com_github_hashicorp_go_kms_wrapping_wrappers_transit_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-kms-wrapping/wrappers/transit/v2",
        sum = "h1:G25tZFw/LrAzJWxvS0/BFI7V1xAP/UsAIsgBwiE0mwo=",
        version = "v2.0.7",
    )
    go_repository(
        name = "com_github_hashicorp_go_memdb",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-memdb",
        sum = "h1:oGfEWrFuxtIUF3W2q/Jzt6G85TrMk9ey6XfYLvVe1Wo=",
        version = "v1.3.3",
    )
    go_repository(
        name = "com_github_hashicorp_go_msgpack",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-msgpack",
        sum = "h1:9byZdVjKTe5mce63pRVNP1L7UAmdHOTEMGehn6KvJWs=",
        version = "v1.1.5",
    )
    go_repository(
        name = "com_github_hashicorp_go_msgpack_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-msgpack/v2",
        sum = "h1:c1fiLq1LNghmLOry1ipGhvLDi+/zEoaEP2JrE1oFJ9s=",
        version = "v2.0.0",
    )

    go_repository(
        name = "com_github_hashicorp_go_multierror",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-multierror",
        sum = "h1:H5DkEtf6CXdFp0N0Em5UCwQpXMWke8IA0+lD48awMYo=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_hashicorp_go_net",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go.net",
        sum = "h1:sNCoNyDEvN1xa+X0baata4RdcpKwcMS6DH+xwfqPgjw=",
        version = "v0.0.1",
    )
    go_repository(
        name = "com_github_hashicorp_go_plugin",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-plugin",
        sum = "h1:CHGwpxYDOttQOY7HOWgETU9dyVjOXzniXDqJcYJE1zM=",
        version = "v1.4.8",
    )
    go_repository(
        name = "com_github_hashicorp_go_raftchunking",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-raftchunking",
        sum = "h1:FmnBDwGwlTgugDGbVxwV8UavqSMACbGrUpfc98yFLR4=",
        version = "v0.6.3-0.20191002164813-7e9e8525653a",
    )

    go_repository(
        name = "com_github_hashicorp_go_retryablehttp",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-retryablehttp",
        sum = "h1:AcYqCvkpalPnPF2pn0KamgwamS42TqUDDYFRKq/RAd0=",
        version = "v0.7.2",
    )

    go_repository(
        name = "com_github_hashicorp_go_rootcerts",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-rootcerts",
        sum = "h1:jzhAVGtqPKbwpyCPELlgNWhE1znq+qwJtW5Oi2viEzc=",
        version = "v1.0.2",
    )
    go_repository(
        name = "com_github_hashicorp_go_secure_stdlib_awsutil",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-secure-stdlib/awsutil",
        sum = "h1:W9WN8p6moV1fjKLkeqEgkAMu5rauy9QeYDAmIaPuuiA=",
        version = "v0.1.6",
    )
    go_repository(
        name = "com_github_hashicorp_go_secure_stdlib_base62",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-secure-stdlib/base62",
        sum = "h1:ET4pqyjiGmY09R5y+rSd70J2w45CtbWDNvGqWp/R3Ng=",
        version = "v0.1.2",
    )
    go_repository(
        name = "com_github_hashicorp_go_secure_stdlib_fileutil",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-secure-stdlib/fileutil",
        sum = "h1:f2mwVgMJjXuX/+eWD6ZW30+oIRgCofL+XMWknFkB1WM=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_hashicorp_go_secure_stdlib_gatedwriter",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-secure-stdlib/gatedwriter",
        sum = "h1:9um9R8i0+HbRHS9d64kdvWR0/LJvo12sIonvR9zr1+U=",
        version = "v0.1.1",
    )
    go_repository(
        name = "com_github_hashicorp_go_secure_stdlib_kv_builder",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-secure-stdlib/kv-builder",
        sum = "h1:NS6BHieb/pDfx3M9jDdaPpGyyVp+aD4A3DjX3dgRmzs=",
        version = "v0.1.2",
    )
    go_repository(
        name = "com_github_hashicorp_go_secure_stdlib_mlock",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-secure-stdlib/mlock",
        sum = "h1:p4AKXPPS24tO8Wc8i1gLvSKdmkiSY5xuju57czJ/IJQ=",
        version = "v0.1.2",
    )
    go_repository(
        name = "com_github_hashicorp_go_secure_stdlib_parseutil",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-secure-stdlib/parseutil",
        sum = "h1:UpiO20jno/eV1eVZcxqWnUohyKRe1g8FPV/xH1s/2qs=",
        version = "v0.1.7",
    )
    go_repository(
        name = "com_github_hashicorp_go_secure_stdlib_password",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-secure-stdlib/password",
        sum = "h1:6JzmBqXprakgFEHwBgdchsjaA9x3GyjdI568bXKxa60=",
        version = "v0.1.1",
    )
    go_repository(
        name = "com_github_hashicorp_go_secure_stdlib_reloadutil",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-secure-stdlib/reloadutil",
        sum = "h1:SMGUnbpAcat8rIKHkBPjfv81yC46a8eCNZ2hsR2l1EI=",
        version = "v0.1.1",
    )
    go_repository(
        name = "com_github_hashicorp_go_secure_stdlib_strutil",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-secure-stdlib/strutil",
        sum = "h1:kes8mmyCpxJsI7FTwtzRqEy9CdjCtrXrXGuOpxEA7Ts=",
        version = "v0.1.2",
    )
    go_repository(
        name = "com_github_hashicorp_go_secure_stdlib_tlsutil",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-secure-stdlib/tlsutil",
        sum = "h1:phcbL8urUzF/kxA/Oj6awENaRwfWsjP59GW7u2qlDyY=",
        version = "v0.1.2",
    )
    go_repository(
        name = "com_github_hashicorp_go_slug",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-slug",
        sum = "h1:8HIi6oreWPtnhpYd8lIGQBgp4rXzDWQTOhfILZm+nok=",
        version = "v0.7.0",
    )
    go_repository(
        name = "com_github_hashicorp_go_sockaddr",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-sockaddr",
        sum = "h1:ztczhD1jLxIRjVejw8gFomI1BQZOe2WoVOu0SyteCQc=",
        version = "v1.0.2",
    )
    go_repository(
        name = "com_github_hashicorp_go_syslog",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-syslog",
        sum = "h1:KaodqZuhUoZereWVIYmpUgZysurB1kBLX2j0MwMrUAE=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_hashicorp_go_tfe",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-tfe",
        sum = "h1:XUAhKoCX8ZUQfwBebC8hz7nkSSnqgNkaablIfxnZ0PQ=",
        version = "v0.20.0",
    )
    go_repository(
        name = "com_github_hashicorp_go_uuid",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-uuid",
        sum = "h1:2gKiV6YVmrJ1i2CKKa9obLvRieoRGviZFL26PcT/Co8=",
        version = "v1.0.3",
    )
    go_repository(
        name = "com_github_hashicorp_go_version",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/go-version",
        sum = "h1:feTTfFNnjP967rlCxM/I9g701jU+RN74YKx2mOkIeek=",
        version = "v1.6.0",
    )

    go_repository(
        name = "com_github_hashicorp_golang_lru",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/golang-lru",
        sum = "h1:uL2shRDx7RTrOrTCUZEGP/wJUFiUI8QT6E7z5o8jga4=",
        version = "v0.6.0",
    )
    go_repository(
        name = "com_github_hashicorp_hcl",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/hcl",
        sum = "h1:kI3hhbbyzr4dldA8UdTb7ZlVVlI2DACdCfz31RPDgJM=",
        version = "v1.0.1-vault-5",
    )
    go_repository(
        name = "com_github_hashicorp_hcp_link",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/hcp-link",
        sum = "h1:F6F1cpADc+o5EBI5CbJn5RX4qdFSLpuA4fN69eeE5lQ=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_hashicorp_hcp_scada_provider",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/hcp-scada-provider",
        sum = "h1:yr+Uxini7SWTZ2t49d3Xi+6+X/rbsSFx8gq6WVcC91c=",
        version = "v0.2.1",
    )
    go_repository(
        name = "com_github_hashicorp_hcp_sdk_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/hcp-sdk-go",
        sum = "h1:3WarkQSK0VzxJaH6psHIGQagag3ujL+NjWagZZHpiZM=",
        version = "v0.23.0",
    )
    go_repository(
        name = "com_github_hashicorp_jsonapi",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/jsonapi",
        sum = "h1:9ARUJJ1VVynB176G1HCwleORqCaXm/Vx0uUi0dL26I0=",
        version = "v0.0.0-20210826224640-ee7dae0fb22d",
    )
    go_repository(
        name = "com_github_hashicorp_logutils",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/logutils",
        sum = "h1:dLEQVugN8vlakKOUE3ihGLTZJRB4j+M2cdTm/ORI65Y=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_hashicorp_mdns",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/mdns",
        sum = "h1:sY0CMhFmjIPDMlTB+HfymFHCaYLhgifZ0QhjaYKD/UQ=",
        version = "v1.0.4",
    )
    go_repository(
        name = "com_github_hashicorp_memberlist",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/memberlist",
        sum = "h1:gkyML/r71w3FL8gUi74Vk76avkj/9lYAY9lvg0OcoGs=",
        version = "v0.1.4",
    )
    go_repository(
        name = "com_github_hashicorp_net_rpc_msgpackrpc_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/net-rpc-msgpackrpc/v2",
        sum = "h1:kBpVVl1sl3MaSrs97e0+pDQhSrqJv9gVbSUrPpVfl1w=",
        version = "v2.0.0",
    )

    go_repository(
        name = "com_github_hashicorp_nomad_api",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/nomad/api",
        sum = "h1:I5xhKLePXpXgM6pZ4xZNTiurLLS3sGuZrZFFzAbM67A=",
        version = "v0.0.0-20230418003350-3067191c5197",
    )
    go_repository(
        name = "com_github_hashicorp_raft",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/raft",
        sum = "h1:LR5QZX1VQd0DFWZfeCwWawyeKfpS/Tm1yjnJIY5X4Tw=",
        version = "v1.3.10",
    )
    go_repository(
        name = "com_github_hashicorp_raft_autopilot",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/raft-autopilot",
        sum = "h1:C1q3RNF2FfXNZfHWbvVAu0QixaQK8K5pX4O5lh+9z4I=",
        version = "v0.1.6",
    )
    go_repository(
        name = "com_github_hashicorp_raft_boltdb",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/raft-boltdb",
        sum = "h1:xykPFhrBAS2J0VBzVa5e80b5ZtYuNQtgXjN40qBZlD4=",
        version = "v0.0.0-20171010151810-6e5ba93211ea",
    )
    go_repository(
        name = "com_github_hashicorp_raft_boltdb_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/raft-boltdb/v2",
        sum = "h1:oiKun9QlrOz5yQxMZJ3tf1kWtFYuKSJzxzEDxDPevj4=",
        version = "v2.0.0-20210421194847-a7e34179d62c",
    )
    go_repository(
        name = "com_github_hashicorp_raft_snapshot",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/raft-snapshot",
        sum = "h1:EuDuayAJPdiDmVk1ygTDnG2zDzrs0/6/yBuma1IYSow=",
        version = "v1.0.4",
    )

    go_repository(
        name = "com_github_hashicorp_serf",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/serf",
        sum = "h1:Z1H2J60yRKvfDYAOZLd2MU0ND4AH/WDz7xYHDWQsIPY=",
        version = "v0.10.1",
    )
    go_repository(
        name = "com_github_hashicorp_vault",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault",
        sum = "h1:4Q31hCWCwD2XRCwGL+9gsrCwxn6+ngToBgjT0FCTG+M=",
        version = "v1.13.1",
    )
    go_repository(
        name = "com_github_hashicorp_vault_api",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault/api",
        sum = "h1:ab7dI6W8DuCY7yCU8blo0UCYl2oHre/dloCmzMWg9w8=",
        version = "v1.9.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_api_auth_approle",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault/api/auth/approle",
        sum = "h1:Ib0oCNXsCq/QZhPYtXPzJEbGS5WR/KoZf8c84QoFdkU=",
        version = "v0.3.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_api_auth_kubernetes",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault/api/auth/kubernetes",
        sum = "h1:HkaCmTKzcgLa2tjdiAid1rbmyQNmQGHfnmvIIM2WorY=",
        version = "v0.3.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_api_auth_userpass",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault/api/auth/userpass",
        sum = "h1:C6OdAYczMbzd1Pe1LLf2SHDulxOq/iybWV3kbgV/PS4=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_auth_alicloud",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-auth-alicloud",
        sum = "h1:O6tNk0s/arubLUbLeCyaRs5xGo9VwmbQazISY/BfPK4=",
        version = "v0.14.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_auth_azure",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-auth-azure",
        sum = "h1:1j8fPQPumYg9oZG+MCFftglu/Edd6YGOuBvEWEkK0qQ=",
        version = "v0.13.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_auth_centrify",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-auth-centrify",
        sum = "h1:qZKnqU1tX1WS6+11+PskGMhlXl5LnfkVrDvJO4BRY7s=",
        version = "v0.14.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_auth_cf",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-auth-cf",
        sum = "h1:n/ojZukcH8YAOy/7JXITJn21byr1yxhujlR3DKlR3FY=",
        version = "v0.14.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_auth_gcp",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-auth-gcp",
        sum = "h1:EmfbQkYufMSFcbnOyn0f7bv2QYyyQyMx/D+qO04jfr0=",
        version = "v0.15.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_auth_jwt",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-auth-jwt",
        sum = "h1:GGS/64MmoobWZFA07nYEPan9NLw2NhqRrmVLra7JHNM=",
        version = "v0.15.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_auth_kerberos",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-auth-kerberos",
        sum = "h1:gdbrEwpPICDt8xQ7C595M+DXaojHvkA9/AhCKbvE+jY=",
        version = "v0.9.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_auth_kubernetes",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-auth-kubernetes",
        sum = "h1:uHsn1fJqxGxbWiiD2resMYZzPJWPwPMCGNCEziGHfwE=",
        version = "v0.15.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_auth_oci",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-auth-oci",
        sum = "h1:xThaZC9jzZoqqccfxTk11hfwgqwN3yEZ3kYOnY2v2Fs=",
        version = "v0.13.1",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_database_couchbase",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-database-couchbase",
        sum = "h1:hJOHJ9yZ9kt1/DuRaU5Sa339j3/QcPL4esT9JLQonYA=",
        version = "v0.9.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_database_elasticsearch",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-database-elasticsearch",
        sum = "h1:nVO6F8V69E2fAQklh/Ds+EypVMutN4iIlt3sat9qW9M=",
        version = "v0.13.1",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_database_mongodbatlas",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-database-mongodbatlas",
        sum = "h1:wlWrg1z5Pyx+FTUCOzA9yh0FTI+pfA9tMrsFPFBcjjA=",
        version = "v0.9.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_database_redis",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-database-redis",
        sum = "h1:Fg1inevnDhj58+/y5SY1CihLftytG1D+3QqbUJbHYUM=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_database_redis_elasticache",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-database-redis-elasticache",
        sum = "h1:dgTT7E8xj56hjktMxHNAgFpy7pchpoQ20cIhDsBcgz8=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_database_snowflake",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-database-snowflake",
        sum = "h1:Od5M2ddxRiHjDkHFto+aInru44/6Dy4jjrxyoKh3AW4=",
        version = "v0.7.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_mock",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-mock",
        sum = "h1:5QQvSUHxDjEEbrd2REOeacqyJnCLPD51IQzy71hx8P0=",
        version = "v0.16.1",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_secrets_ad",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-secrets-ad",
        sum = "h1:4y/CtX4977uJXPWh5d70Raw5Mo+kCGDo9de2A6cOFso=",
        version = "v0.15.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_secrets_alicloud",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-secrets-alicloud",
        sum = "h1:kFcdTltTe5HP0ILuB+YNw++Iy/PZMLv/i2FsmdXfGfM=",
        version = "v0.14.1",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_secrets_azure",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-secrets-azure",
        sum = "h1:R/3KLTOwvPIZenMrmeSIBWymKq5nYgA/bucXzBPyb3Q=",
        version = "v0.15.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_secrets_gcp",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-secrets-gcp",
        sum = "h1:SfYIFmgFg/8p4fgLCV8YxxkI+iQN0c4gSjMJhg9vFJw=",
        version = "v0.15.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_secrets_gcpkms",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-secrets-gcpkms",
        sum = "h1:eUC5ltK+1bkc+SVMzAUq4tBeNrsDXyCuITH8jeajXcM=",
        version = "v0.14.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_secrets_kubernetes",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-secrets-kubernetes",
        sum = "h1:Joz9SBwjpEOGu+Ynv60JC3fAA4UuLJzu7NcrKm6wMMs=",
        version = "v0.3.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_secrets_kv",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-secrets-kv",
        sum = "h1:13p50RIltQM/JH32uWZe9sAp16Uaj0zCLmVGPvS09qo=",
        version = "v0.14.2",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_secrets_mongodbatlas",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-secrets-mongodbatlas",
        sum = "h1:WkW8fyHxEdz1wGSTxCnSCrzXvgLXqXr8Iqp7upa/s4E=",
        version = "v0.9.1",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_secrets_openldap",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-secrets-openldap",
        sum = "h1:EN3/iEjPPmcpX9yihybQNHvewc+YoJw7aoKsio1WK5s=",
        version = "v0.10.1",
    )
    go_repository(
        name = "com_github_hashicorp_vault_plugin_secrets_terraform",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-plugin-secrets-terraform",
        sum = "h1:jgJpVKhV0Eh6EjpUEIf7VYH2D6D0xW2Lry9/3PI8hy0=",
        version = "v0.7.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_sdk",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault/sdk",
        sum = "h1:Cbu9ezaZafZTXnen98QKVmufEPquhZ+r1ORZ7csNLFU=",
        version = "v0.9.0",
    )
    go_repository(
        name = "com_github_hashicorp_vault_testing_stepwise",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault-testing-stepwise",
        sum = "h1:7ASzAq/gPihP/HAd8RmS9c7LiJtDMnjkPbfWKhm/XiI=",
        version = "v0.1.3-0.20230203193428-3a789cb2c68f",
    )
    go_repository(
        name = "com_github_hashicorp_vault_vault_hcp_link_proto",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vault/vault/hcp_link/proto",
        sum = "h1:Y/+BtwxmRak3Us9jrByARvYW6uNeqZlEpMylIdXVIjY=",
        version = "v0.0.0-20230201201504-b741fa893d77",
    )
    go_repository(
        name = "com_github_hashicorp_vic",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/vic",
        sum = "h1:O/pT5C1Q3mVXMyuqg7yuAWUg/jMZR1/0QTzTRdNR6Uw=",
        version = "v1.5.1-0.20190403131502-bbfe86ec9443",
    )
    go_repository(
        name = "com_github_hashicorp_yamux",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hashicorp/yamux",
        sum = "h1:yrQxtgseBDrq9Y652vSRDvsKCJKOUD+GzTS4Y0Y8pvE=",
        version = "v0.1.1",
    )

    go_repository(
        name = "com_github_hetznercloud_hcloud_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hetznercloud/hcloud-go",
        sum = "h1:Es/CDOForQN3nOOP5Vxh1N/YHjpCg386iYEX5zCgi+A=",
        version = "v1.42.0",
    )
    go_repository(
        name = "com_github_hpcloud_tail",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hpcloud/tail",
        sum = "h1:nfCOvKYfkgYP8hkirhJocXT2+zOD8yUNjXaWfTlyFKI=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_huandu_xstrings",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/huandu/xstrings",
        sum = "h1:L18LIDzqlW6xN2rEkpdV8+oL/IXWJ1APd+vsdYy4Wdw=",
        version = "v1.3.2",
    )

    go_repository(
        name = "com_github_ianlancetaylor_demangle",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/ianlancetaylor/demangle",
        sum = "h1:mV02weKRL81bEnm8A0HT1/CAelMQDBuQIfLw8n+d6xI=",
        version = "v0.0.0-20200824232613-28f6c0f3b639",
    )
    go_repository(
        name = "com_github_ibm_keyprotect_go_client",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/IBM/keyprotect-go-client",
        sum = "h1:zryNbTAwrg4ZOdn0PvZDxzTb805OM2MgvyFwz5sPyt4=",
        version = "v0.5.1",
    )

    go_repository(
        name = "com_github_imdario_mergo",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/imdario/mergo",
        sum = "h1:M8XP7IuFNsqUx6VPK2P9OSmsYsI/YFaGil0uD21V3dM=",
        version = "v0.3.15",
    )
    go_repository(
        name = "com_github_inconshreveable_mousetrap",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/inconshreveable/mousetrap",
        sum = "h1:wN+x4NVGpMsO7ErUn/mUI3vEoE6Jt13X2s0bqwp9tc8=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_influxdata_influxdb",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/influxdata/influxdb",
        sum = "h1:3K3KcD4S6/Y2hevi70EzUTNKOS3cryQyhUnkjE6Tz0w=",
        version = "v0.0.0-20190411212539-d24b7ba8c4c4",
    )
    go_repository(
        name = "com_github_influxdata_influxdb1_client",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/influxdata/influxdb1-client",
        sum = "h1:HqW4xhhynfjrtEiiSGcQUd6vrK23iMam1FO8rI7mwig=",
        version = "v0.0.0-20200827194710-b269163b24ab",
    )

    go_repository(
        name = "com_github_ionos_cloud_sdk_go_v6",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/ionos-cloud/sdk-go/v6",
        sum = "h1:0n4irdqNska+1s3YMCRhrAqKbibEgQ7SwwhAlHzYT5A=",
        version = "v6.1.6",
    )
    go_repository(
        name = "com_github_ishidawataru_sctp",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/ishidawataru/sctp",
        sum = "h1:qPmlgoeRS18y2dT+iAH5vEKZgIqgiPi2Y8UCu/b7Aq8=",
        version = "v0.0.0-20190723014705-7c296d48a2b5",
    )
    go_repository(
        name = "com_github_jackc_chunkreader_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jackc/chunkreader/v2",
        sum = "h1:i+RDz65UE+mmpjTfyz0MoVTnzeYxroil2G82ki7MGG8=",
        version = "v2.0.1",
    )
    go_repository(
        name = "com_github_jackc_fake",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jackc/fake",
        sum = "h1:vr3AYkKovP8uR8AvSGGUK1IDqRa5lAAvEkZG1LKaCRc=",
        version = "v0.0.0-20150926172116-812a484cc733",
    )
    go_repository(
        name = "com_github_jackc_pgconn",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jackc/pgconn",
        sum = "h1:HiHArx4yFbwl91X3qqIHtUFoiIfLNJXCQRsnzkiwwaQ=",
        version = "v1.11.0",
    )
    go_repository(
        name = "com_github_jackc_pgio",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jackc/pgio",
        sum = "h1:g12B9UwVnzGhueNavwioyEEpAmqMe1E/BN9ES+8ovkE=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_jackc_pgpassfile",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jackc/pgpassfile",
        sum = "h1:/6Hmqy13Ss2zCq62VdNG8tM1wchn8zjSGOBJ6icpsIM=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_jackc_pgproto3_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jackc/pgproto3/v2",
        sum = "h1:r7JypeP2D3onoQTCxWdTpCtJ4D+qpKr0TxvoyMhZ5ns=",
        version = "v2.2.0",
    )
    go_repository(
        name = "com_github_jackc_pgservicefile",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jackc/pgservicefile",
        sum = "h1:C8S2+VttkHFdOOCXJe+YGfa4vHYwlt4Zx+IVXQ97jYg=",
        version = "v0.0.0-20200714003250-2b9c44734f2b",
    )
    go_repository(
        name = "com_github_jackc_pgtype",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jackc/pgtype",
        sum = "h1:ILnBWrRMSXGczYvmkYD6PsYyVFUNLTnIUJHHDLmqk38=",
        version = "v1.10.0",
    )
    go_repository(
        name = "com_github_jackc_pgx",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jackc/pgx",
        sum = "h1:Wa90/+qsITBAPkAZjiByeIGHFcj3Ztu+VzrrIpHjL90=",
        version = "v3.3.0+incompatible",
    )
    go_repository(
        name = "com_github_jackc_pgx_v4",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jackc/pgx/v4",
        sum = "h1:B7dTkXsdILD3MF987WGGCcg+tvLW6bZJdEcqVFeU//w=",
        version = "v4.15.0",
    )
    go_repository(
        name = "com_github_jcmturner_aescts",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jcmturner/aescts",
        sum = "h1:5jhUSHbHSZjQeWFY//Lv8dpP/O3sMDOxrGV/IfCqh44=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_jcmturner_aescts_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jcmturner/aescts/v2",
        sum = "h1:9YKLH6ey7H4eDBXW8khjYslgyqG2xZikXP0EQFKrle8=",
        version = "v2.0.0",
    )
    go_repository(
        name = "com_github_jcmturner_dnsutils",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jcmturner/dnsutils",
        sum = "h1:zkF8SbVatbr5LGrvcPSes62SV68lASVv6+x9wo2De+w=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_jcmturner_dnsutils_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jcmturner/dnsutils/v2",
        sum = "h1:lltnkeZGL0wILNvrNiVCR6Ro5PGU/SeBvVO/8c/iPbo=",
        version = "v2.0.0",
    )
    go_repository(
        name = "com_github_jcmturner_gofork",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jcmturner/gofork",
        sum = "h1:QH0l3hzAU1tfT3rZCnW5zXl+orbkNMMRGJfdJjHVETg=",
        version = "v1.7.6",
    )
    go_repository(
        name = "com_github_jcmturner_goidentity_v6",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jcmturner/goidentity/v6",
        sum = "h1:VKnZd2oEIMorCTsFBnJWbExfNN7yZr3EhJAxwOkZg6o=",
        version = "v6.0.1",
    )
    go_repository(
        name = "com_github_jcmturner_gokrb5_v8",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jcmturner/gokrb5/v8",
        sum = "h1:iTonLeSJOn7MVUtyMT+arAn5AKAPrkilzhGw8wE/Tq8=",
        version = "v8.4.3",
    )
    go_repository(
        name = "com_github_jcmturner_rpc_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jcmturner/rpc/v2",
        sum = "h1:7FXXj8Ti1IaVFpSAziCZWNzbNuZmnvw/i6CqLNdWfZY=",
        version = "v2.0.3",
    )
    go_repository(
        name = "com_github_jeffail_gabs",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Jeffail/gabs",
        sum = "h1:V0uzR08Hj22EX8+8QMhyI9sX2hwRu+/RJhJUmnwda/E=",
        version = "v1.1.1",
    )

    go_repository(
        name = "com_github_jeffashton_win_pdh",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/JeffAshton/win_pdh",
        sum = "h1:UKkYhof1njT1/xq4SEg5z+VpTgjmNeHwPGRQl7takDI=",
        version = "v0.0.0-20161109143554-76bb4ee9f0ab",
    )
    go_repository(
        name = "com_github_jeffchao_backoff",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jeffchao/backoff",
        sum = "h1:mex1izRBCD+7WjieGgRdy7e651vD/lvB1bD9vNE/3K4=",
        version = "v0.0.0-20140404060208-9d7fd7aa17f2",
    )
    go_repository(
        name = "com_github_jefferai_isbadcipher",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jefferai/isbadcipher",
        sum = "h1:E87tDTVS5W65euzixn7clSzK66puSt1H4I5SC0EmHH4=",
        version = "v0.0.0-20190226160619-51d2077c035f",
    )
    go_repository(
        name = "com_github_jefferai_jsonx",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jefferai/jsonx",
        sum = "h1:Xoz0ZbmkpBvED5W9W1B5B/zc3Oiq7oXqiW7iRV3B6EI=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_jessevdk_go_flags",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jessevdk/go-flags",
        sum = "h1:4IU2WS7AumrZ/40jfhf4QVDMsQwqA7VEHozFRrGARJA=",
        version = "v1.4.0",
    )
    go_repository(
        name = "com_github_jhump_protoreflect",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jhump/protoreflect",
        sum = "h1:h5jfMVslIg6l29nsMs0D8Wj17RDVdNYti0vDN/PZZoE=",
        version = "v1.6.0",
    )

    go_repository(
        name = "com_github_jmespath_go_jmespath",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jmespath/go-jmespath",
        sum = "h1:BEgLn5cpjn8UN1mAw4NjwDrS35OdebyEtFe+9YPoQUg=",
        version = "v0.4.0",
    )
    go_repository(
        name = "com_github_jmespath_go_jmespath_internal_testify",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jmespath/go-jmespath/internal/testify",
        sum = "h1:shLQSRRSCCPj3f2gpwzGwWFoC7ycTf1rcQZHOlsJ6N8=",
        version = "v1.5.1",
    )

    go_repository(
        name = "com_github_jonboulle_clockwork",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jonboulle/clockwork",
        sum = "h1:p4Cf1aMWXnXAUh8lVfewRBx1zaTSYKrKMF2g3ST4RZ4=",
        version = "v0.4.0",
    )
    go_repository(
        name = "com_github_josharian_intern",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/josharian/intern",
        sum = "h1:vlS4z54oSdjm0bgjRigI+G1HpF+tI+9rE5LLzOg8HmY=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_joyent_triton_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/joyent/triton-go",
        sum = "h1:ENpDacvnr8faw5ugQmEF1QYk+f/Y9lXFvuYmRxykago=",
        version = "v1.7.1-0.20200416154420-6801d15b779f",
    )

    go_repository(
        name = "com_github_jpillora_backoff",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jpillora/backoff",
        sum = "h1:uvFg412JmmHBHw7iwprIxkPMI+sGQ4kzOWsMeHnm2EA=",
        version = "v1.0.0",
    )

    go_repository(
        name = "com_github_json_iterator_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/json-iterator/go",
        sum = "h1:PV8peI4a0ysnczrg+LtxykD8LfKY9ML6u2jnxaEnrnM=",
        version = "v1.1.12",
    )
    go_repository(
        name = "com_github_jstemmer_go_junit_report",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jstemmer/go-junit-report",
        sum = "h1:6QPYqodiu3GuPL+7mfx+NwDdp2eTkp9IfEUpgAwUN0o=",
        version = "v0.9.1",
    )
    go_repository(
        name = "com_github_jtolds_gls",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/jtolds/gls",
        sum = "h1:xdiiI2gbIgH/gLH7ADydsJ1uDOEzR8yvV7C0MuV77Wo=",
        version = "v4.20.0+incompatible",
    )

    go_repository(
        name = "com_github_julienschmidt_httprouter",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/julienschmidt/httprouter",
        sum = "h1:U0609e9tgbseu3rBINet9P48AI/D3oJs4dN7jwJOQ1U=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_github_karrick_godirwalk",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/karrick/godirwalk",
        sum = "h1:b4kY7nqDdioR/6qnbHQyDvmA17u5G1cZ6J+CZXwSWoI=",
        version = "v1.17.0",
    )
    go_repository(
        name = "com_github_kelseyhightower_envconfig",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/kelseyhightower/envconfig",
        sum = "h1:Im6hONhd3pLkfDFsbRgu68RDNkGF1r3dvMUtDTo2cv8=",
        version = "v1.4.0",
    )
    go_repository(
        name = "com_github_keybase_go_crypto",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/keybase/go-crypto",
        sum = "h1:Gsc9mVHLRqBjMgdQCghN9NObCcRncDqxJvBvEaIIQEo=",
        version = "v0.0.0-20190403132359-d65b6b94177f",
    )

    go_repository(
        name = "com_github_kisielk_errcheck",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/kisielk/errcheck",
        sum = "h1:e8esj/e4R+SAOwFwN+n3zr0nYeCyeweozKfO23MvHzY=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_github_kisielk_gotool",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/kisielk/gotool",
        sum = "h1:AV2c/EiW3KqPNT9ZKl07ehoAGi4C5/01Cfbblndcapg=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_klauspost_compress",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/klauspost/compress",
        sum = "h1:EF27CXIuDsYJ6mmvtBRlEuB2UVOqHG1tAXgZ7yIO+lw=",
        version = "v1.15.15",
    )
    go_repository(
        name = "com_github_klauspost_cpuid",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/klauspost/cpuid",
        sum = "h1:NMpwD2G9JSFOE1/TJjGSo5zG7Yb2bTe7eq1jH+irmeE=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_klauspost_pgzip",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/klauspost/pgzip",
        sum = "h1:qnWYvvKqedOF2ulHpMG72XQol4ILEJ8k2wwRl/Km8oE=",
        version = "v1.2.5",
    )

    go_repository(
        name = "com_github_kolo_xmlrpc",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/kolo/xmlrpc",
        sum = "h1:udzkj9S/zlT5X367kqJis0QP7YMxobob6zhzq6Yre00=",
        version = "v0.0.0-20220921171641-a4b6fa1dd06b",
    )

    go_repository(
        name = "com_github_konsorten_go_windows_terminal_sequences",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/konsorten/go-windows-terminal-sequences",
        sum = "h1:CE8S1cTafDpPvMhIxNJKvHsGVBgn1xWYf1NbHQhywc8=",
        version = "v1.0.3",
    )
    go_repository(
        name = "com_github_kr_logfmt",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/kr/logfmt",
        sum = "h1:T+h1c/A9Gawja4Y9mFVWj2vyii2bbUNDw3kt9VxK2EY=",
        version = "v0.0.0-20140226030751-b84e30acd515",
    )
    go_repository(
        name = "com_github_kr_pretty",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/kr/pretty",
        sum = "h1:flRD4NNwYAUpkphVc1HcthR4KEIFJ65n8Mw5qdRn3LE=",
        version = "v0.3.1",
    )
    go_repository(
        name = "com_github_kr_pty",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/kr/pty",
        sum = "h1:VkoXIwSboBpnk99O/KFauAEILuNHv5DVFKZMBN/gUgw=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_kr_text",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/kr/text",
        sum = "h1:5Nx0Ya0ZqY2ygV366QzturHI13Jq95ApcVaJBhpS+AY=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_kube_object_storage_lib_bucket_provisioner",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/kube-object-storage/lib-bucket-provisioner",
        sum = "h1:dQEHhTfi+bSIOSViQrKY9PqJvZenD6tFz+3lPzux58o=",
        version = "v0.0.0-20221122204822-d1a8c34382f1",
    )
    go_repository(
        name = "com_github_kubernetes_csi_external_snapshotter_client_v4",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/kubernetes-csi/external-snapshotter/client/v4",
        sum = "h1:ipLtV9ubLEYx42YvwDa12eVPQvjuGZoPdbCozGzVNRc=",
        version = "v4.0.0",
    )

    go_repository(
        name = "com_github_kylelemons_godebug",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/kylelemons/godebug",
        sum = "h1:RPNrshWIDI6G2gRW9EHilWtl7Z6Sb1BR0xunSBf0SNc=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_lib_pq",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/lib/pq",
        sum = "h1:jbk+ZieJ0D7EVGJYpL9QTz7/YW6UHbmdnZWYyK5cdBs=",
        version = "v1.10.6",
    )
    go_repository(
        name = "com_github_libopenstorage_autopilot_api",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/libopenstorage/autopilot-api",
        sum = "h1:PpwnWKh2Fa8JIXFbSEKci8k67f/jHPU4J+S0DFRrJYQ=",
        version = "v0.6.1-0.20210128210103-5fbb67948648",
    )

    go_repository(
        name = "com_github_libopenstorage_openstorage",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/libopenstorage/openstorage",
        sum = "h1:C4cFpStNOhsqShZSDRtW+4t5uCHbcdyPszG5ADwIRTM=",
        version = "v8.0.0+incompatible",
    )
    go_repository(
        name = "com_github_libopenstorage_operator",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/libopenstorage/operator",
        sum = "h1:Idj0mi+1f1xTBdtTbJKmgoMQqVYoTmw2geekszGGhT4=",
        version = "v0.0.0-20200725001727-48d03e197117",
    )
    go_repository(
        name = "com_github_libopenstorage_secrets",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/libopenstorage/secrets",
        sum = "h1:dHCYranrn+6LzONAnhB3YPHBpMz4vP1IN8BsZNaY+IY=",
        version = "v0.0.0-20220823020833-2ecadaf59d8a",
    )
    go_repository(
        name = "com_github_libopenstorage_stork",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/libopenstorage/stork",
        sum = "h1:ew2s3COKTFudvNCZoyZuGS7KbUOU0qxiMw38f8xMrH0=",
        version = "v1.3.0-beta1.0.20200630005842-9255e7a98775",
    )

    go_repository(
        name = "com_github_liggitt_tabwriter",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/liggitt/tabwriter",
        sum = "h1:9TO3cAIGXtEhnIaL+V+BEER86oLrvS+kWobKpbJuye0=",
        version = "v0.0.0-20181228230101-89fcab3d43de",
    )
    go_repository(
        name = "com_github_linode_linodego",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/linode/linodego",
        sum = "h1:5otq57M4PdHycPERRfSFZ0s1yz1ETVWGjCp3hh7+F9w=",
        version = "v1.16.1",
    )
    go_repository(
        name = "com_github_lithammer_dedent",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/lithammer/dedent",
        sum = "h1:VNzHMVCBNG1j0fh3OrsFRkVUwStdDArbgBWoPAffktY=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_lufia_plan9stats",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/lufia/plan9stats",
        sum = "h1:6E+4a0GO5zZEnZ81pIr0yLvtUWk2if982qA3F3QD6H4=",
        version = "v0.0.0-20211012122336-39d0f177ccd0",
    )
    go_repository(
        name = "com_github_magiconair_properties",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/magiconair/properties",
        sum = "h1:ZC2Vc7/ZFkGmsVC9KvOjumD+G5lXy2RtTKyzRKO2BQ4=",
        version = "v1.8.1",
    )

    go_repository(
        name = "com_github_mailru_easyjson",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mailru/easyjson",
        sum = "h1:UGYAvKxe3sBsEDzO8ZeWOSlIQfWFlxbzLZe7hwFURr0=",
        version = "v0.7.7",
    )
    go_repository(
        name = "com_github_makenowjust_heredoc",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/MakeNowJust/heredoc",
        sum = "h1:cXCdzVdstXyiTqTvfqk9SDHpKNjxuom+DOlyEeQ4pzQ=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_martini_contrib_render",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/martini-contrib/render",
        sum = "h1:YFh+sjyJTMQSYjKwM4dFKhJPJC/wfo98tPUc17HdoYw=",
        version = "v0.0.0-20150707142108-ec18f8345a11",
    )
    go_repository(
        name = "com_github_masterminds_goutils",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Masterminds/goutils",
        sum = "h1:5nUrii3FMTL5diU80unEVvNevw1nH4+ZV4DSLVJLSYI=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_masterminds_semver",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Masterminds/semver",
        sum = "h1:H65muMkzWKEuNDnfl9d70GUjFniHKHRbFPGBuZ3QEww=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_github_masterminds_sprig",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Masterminds/sprig",
        sum = "h1:z4yfnGrZ7netVz+0EDJ0Wi+5VZCSYp4Z0m2dk6cEM60=",
        version = "v2.22.0+incompatible",
    )

    go_repository(
        name = "com_github_mattn_go_colorable",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mattn/go-colorable",
        sum = "h1:fFA4WZxdEF4tXPZVKMLwD8oUnCTTo08duU7wxecdEvA=",
        version = "v0.1.13",
    )
    go_repository(
        name = "com_github_mattn_go_ieproxy",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mattn/go-ieproxy",
        sum = "h1:qiyop7gCflfhwCzGyeT0gro3sF9AIg9HU98JORTkqfI=",
        version = "v0.0.1",
    )

    go_repository(
        name = "com_github_mattn_go_isatty",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mattn/go-isatty",
        sum = "h1:BTarxUcIeDqL27Mc+vyvdWYSL28zpIhv3RoTdsLMPng=",
        version = "v0.0.17",
    )
    go_repository(
        name = "com_github_mattn_go_runewidth",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mattn/go-runewidth",
        sum = "h1:UnlwIPBGaTZfPQ6T1IGzPI0EkYAQmT9fAEJ/poFC63o=",
        version = "v0.0.2",
    )
    go_repository(
        name = "com_github_mattn_go_shellwords",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mattn/go-shellwords",
        sum = "h1:JhhFTIOslh5ZsPrpa3Wdg8bF0WI3b44EMblmU9wIsXc=",
        version = "v1.0.5",
    )

    go_repository(
        name = "com_github_matttproud_golang_protobuf_extensions",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/matttproud/golang_protobuf_extensions",
        sum = "h1:mmDVorXM7PCGKw94cs5zkfA9PSy5pEvNWRP0ET0TIVo=",
        version = "v1.0.4",
    )
    go_repository(
        name = "com_github_mediocregopher_radix_v4",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mediocregopher/radix/v4",
        sum = "h1:JkZBEp0y8pWGNZkmO3RR5oEO5huwd4zKKt4rh1C+P8s=",
        version = "v4.1.1",
    )
    go_repository(
        name = "com_github_mholt_archiver",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mholt/archiver",
        sum = "h1:1dCVxuqs0dJseYEhi5pl7MYPH9zDa1wBi7mF09cbNkU=",
        version = "v3.1.1+incompatible",
    )
    go_repository(
        name = "com_github_mholt_archiver_v3",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mholt/archiver/v3",
        sum = "h1:rDjOBX9JSF5BvoJGvjqK479aL70qh9DIpZCl+k7Clwo=",
        version = "v3.5.1",
    )
    go_repository(
        name = "com_github_michaelklishin_rabbit_hole",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/michaelklishin/rabbit-hole",
        sum = "h1:uA3b4GgZMZxAJsTkd+CVQ85b7KBlD7HLpd/FfTNlGN0=",
        version = "v0.0.0-20191008194146-93d9988f0cd5",
    )
    go_repository(
        name = "com_github_michaelklishin_rabbit_hole_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/michaelklishin/rabbit-hole/v2",
        sum = "h1:946p6jOYFcVJdtBBX8MwXvuBkpPjwm1Nm2Qg8oX+uFk=",
        version = "v2.12.0",
    )

    go_repository(
        name = "com_github_microsoft_go_winio",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Microsoft/go-winio",
        sum = "h1:slsWYD/zyx7lCXoZVlvQrj0hPTM1HI4+v1sIda2yDvg=",
        version = "v0.6.0",
    )
    go_repository(
        name = "com_github_microsoft_hcsshim",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Microsoft/hcsshim",
        sum = "h1:BBgYMxl5YZDZVIijz02AlDINpYZOzQqRNCl9CZM13vk=",
        version = "v0.9.0",
    )

    go_repository(
        name = "com_github_miekg_dns",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/miekg/dns",
        sum = "h1:ZBkuHr5dxHtB1caEOlZTLPo7D3L3TWckgUUs/RHfDxw=",
        version = "v1.1.53",
    )
    go_repository(
        name = "com_github_mikesmitty_edkey",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mikesmitty/edkey",
        sum = "h1:eU8j/ClY2Ty3qdHnn0TyW3ivFoPC/0F1gQZz8yTxbbE=",
        version = "v0.0.0-20170222072505-3356ea4e686a",
    )

    go_repository(
        name = "com_github_mistifyio_go_zfs",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mistifyio/go-zfs",
        sum = "h1:aKW/4cBs+yK6gpqU3K/oIwk9Q/XICqd3zOX/UFuvqmk=",
        version = "v2.1.2-0.20190413222219-f784269be439+incompatible",
    )
    go_repository(
        name = "com_github_mitchellh_cli",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mitchellh/cli",
        sum = "h1:PvH+lL2B7IQ101xQL63Of8yFS2y+aDlsFcsqNc+u/Kw=",
        version = "v1.1.2",
    )
    go_repository(
        name = "com_github_mitchellh_colorstring",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mitchellh/colorstring",
        sum = "h1:62I3jR2EmQ4l5rM/4FEfDWcRD+abF5XlKShorW5LRoQ=",
        version = "v0.0.0-20190213212951-d06e56a500db",
    )
    go_repository(
        name = "com_github_mitchellh_copystructure",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mitchellh/copystructure",
        sum = "h1:vpKXTN4ewci03Vljg/q9QvCGUDttBOGBIa15WveJJGw=",
        version = "v1.2.0",
    )

    go_repository(
        name = "com_github_mitchellh_go_homedir",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mitchellh/go-homedir",
        sum = "h1:lukF9ziXFxDFPkA1vsr5zpc1XuPDn/wFntq5mG+4E0Y=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_mitchellh_go_testing_interface",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mitchellh/go-testing-interface",
        sum = "h1:jrgshOhYAUVNMAJiKbEu7EqAwgJJ2JqpQmpLJOu07cU=",
        version = "v1.14.1",
    )

    go_repository(
        name = "com_github_mitchellh_go_wordwrap",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mitchellh/go-wordwrap",
        sum = "h1:TLuKupo69TCn6TQSyGxwI1EblZZEsQ0vMlAFQflz0v0=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_mitchellh_gox",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mitchellh/gox",
        sum = "h1:lfGJxY7ToLJQjHHwi0EX6uYBdK78egf954SQl13PQJc=",
        version = "v0.4.0",
    )
    go_repository(
        name = "com_github_mitchellh_hashstructure",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mitchellh/hashstructure",
        sum = "h1:P6P1hdjqAAknpY/M1CGipelZgp+4y9ja9kmUZPXP+H0=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_mitchellh_iochan",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mitchellh/iochan",
        sum = "h1:C+X3KsSTLFVBr/tK1eYN/vs4rJcvsiLU338UhYPJWeY=",
        version = "v1.0.0",
    )

    go_repository(
        name = "com_github_mitchellh_mapstructure",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mitchellh/mapstructure",
        sum = "h1:jeMsZIYE/09sWLaz43PL7Gy6RuMjD2eJVyuac5Z2hdY=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_github_mitchellh_pointerstructure",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mitchellh/pointerstructure",
        sum = "h1:O+i9nHnXS3l/9Wu7r4NrEdwA2VFTicjUEN1uBnDo34A=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_mitchellh_reflectwalk",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mitchellh/reflectwalk",
        sum = "h1:G2LzWKi524PWgd3mLHV8Y5k7s6XUvT0Gef6zxSIeXaQ=",
        version = "v1.0.2",
    )

    go_repository(
        name = "com_github_moby_ipvs",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/moby/ipvs",
        sum = "h1:ONN4pGaZQgAx+1Scz5RvWV4Q7Gb+mvfRh3NsPS+1XQQ=",
        version = "v1.1.0",
    )

    go_repository(
        name = "com_github_moby_spdystream",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/moby/spdystream",
        sum = "h1:cjW1zVyyoiM0T7b6UoySUFqzXMoqRckQtXwGPiBhOM8=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_moby_sys_mount",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/moby/sys/mount",
        sum = "h1:WhCW5B355jtxndN5ovugJlMFJawbUODuW8fSnEH6SSM=",
        version = "v0.2.0",
    )

    go_repository(
        name = "com_github_moby_sys_mountinfo",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/moby/sys/mountinfo",
        sum = "h1:BzJjoreD5BMFNmD9Rus6gdd1pLuecOFPt8wC+Vygl78=",
        version = "v0.6.2",
    )

    go_repository(
        name = "com_github_moby_term",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/moby/term",
        sum = "h1:xt8Q1nalod/v7BqbG21f8mQPqH+xAaC9C3N3wfWbVP0=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_github_modern_go_concurrent",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/modern-go/concurrent",
        sum = "h1:TRLaZ9cD/w8PVh93nsPXa1VrQ6jlwL5oN8l14QlcNfg=",
        version = "v0.0.0-20180306012644-bacd9c7ef1dd",
    )
    go_repository(
        name = "com_github_modern_go_reflect2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/modern-go/reflect2",
        sum = "h1:xBagoLtFs94CBntxluKeaWgTMpvLxC4ur3nMaC9Gz0M=",
        version = "v1.0.2",
    )
    go_repository(
        name = "com_github_mohae_deepcopy",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mohae/deepcopy",
        sum = "h1:RWengNIwukTxcDr9M+97sNutRR1RKhG96O6jWumTTnw=",
        version = "v0.0.0-20170929034955-c48cc78d4826",
    )
    go_repository(
        name = "com_github_mongodb_forks_digest",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mongodb-forks/digest",
        sum = "h1:ZUK1vyZnBiRMvET0O1SzmnBmv935CkcOTjhfR4zIQ2s=",
        version = "v1.0.3",
    )
    go_repository(
        name = "com_github_mongodb_go_client_mongodb_atlas",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mongodb/go-client-mongodb-atlas",
        sum = "h1:qmUme1TlQBPZupmXMnpD8DxnfGXLVGs3w+0Z17HBiSA=",
        version = "v0.1.2",
    )

    go_repository(
        name = "com_github_monochromegane_go_gitignore",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/monochromegane/go-gitignore",
        sum = "h1:n6/2gBQ3RWajuToeY6ZtZTIKv2v7ThUy5KKusIT0yc0=",
        version = "v0.0.0-20200626010858-205db1a8cc00",
    )
    go_repository(
        name = "com_github_morikuni_aec",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/morikuni/aec",
        sum = "h1:nP9CBfwrvYnBRgY6qfDQkygYDmYwOilePFkwzv4dU8A=",
        version = "v1.0.0",
    )

    go_repository(
        name = "com_github_mpvl_unique",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mpvl/unique",
        sum = "h1:D5x39vF5KCwKQaw+OC9ZPiLVHXz3UFw2+psEX+gYcto=",
        version = "v0.0.0-20150818121801-cbe035fff7de",
    )
    go_repository(
        name = "com_github_mrunalp_fileutils",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mrunalp/fileutils",
        sum = "h1:NKzVxiH7eSk+OQ4M+ZYW1K6h27RUV3MI6NUTsHhU6Z4=",
        version = "v0.5.0",
    )

    go_repository(
        name = "com_github_munnerz_goautoneg",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/munnerz/goautoneg",
        sum = "h1:C3w9PqII01/Oq1c1nUAm88MOHcQC9l5mIlSMApZMrHA=",
        version = "v0.0.0-20191010083416-a7dc8b61c822",
    )
    go_repository(
        name = "com_github_mwielbut_pointy",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mwielbut/pointy",
        sum = "h1:U5/YEfoIkaGCHv0St3CgjduqXID4FNRoyZgLM1kY9vg=",
        version = "v1.1.0",
    )

    go_repository(
        name = "com_github_mwitkow_go_conntrack",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mwitkow/go-conntrack",
        sum = "h1:KUppIJq7/+SVif2QVs3tOP0zanoHgBEVAwHxUSIzRqU=",
        version = "v0.0.0-20190716064945-2f068394615f",
    )
    go_repository(
        name = "com_github_mxk_go_flowrate",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/mxk/go-flowrate",
        sum = "h1:y5//uYreIhSUg3J1GEMiLbxo1LJaP8RfCpH6pymGZus=",
        version = "v0.0.0-20140419014527-cca7078d478f",
    )
    go_repository(
        name = "com_github_natefinch_atomic",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/natefinch/atomic",
        sum = "h1:7xGrl4tTpBQu5Zjll08WupHyq+Sp0Z/adtyf1cfk3Q8=",
        version = "v0.0.0-20150920032501-a62ce929ffcc",
    )
    go_repository(
        name = "com_github_nbio_st",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/nbio/st",
        sum = "h1:W6apQkHrMkS0Muv8G/TipAy/FJl/rCYT0+EuS8+Z0z4=",
        version = "v0.0.0-20140626010706-e9e8d9816f32",
    )
    go_repository(
        name = "com_github_ncw_swift",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/ncw/swift",
        sum = "h1:4DQRPj35Y41WogBxyhOXlrI37nzGlyEcsforeudyYPQ=",
        version = "v1.0.47",
    )
    go_repository(
        name = "com_github_nicolai86_scaleway_sdk",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/nicolai86/scaleway-sdk",
        sum = "h1:BQ1HW7hr4IVovMwWg0E0PYcyW8CzqDcVmaew9cujU4s=",
        version = "v1.10.2-0.20180628010248-798f60e20bb2",
    )
    go_repository(
        name = "com_github_niemeyer_pretty",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/niemeyer/pretty",
        sum = "h1:fD57ERR4JtEqsWbfPhv4DMiApHyliiK5xCTNVSPiaAs=",
        version = "v0.0.0-20200227124842-a10e7caefd8e",
    )
    go_repository(
        name = "com_github_nvveen_gotty",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Nvveen/Gotty",
        sum = "h1:TngWCqHvy9oXAN6lEVMRuU21PR1EtLVZJmdB18Gu3Rw=",
        version = "v0.0.0-20120604004816-cd527374f1e5",
    )
    go_repository(
        name = "com_github_nwaples_rardecode",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/nwaples/rardecode",
        sum = "h1:Cj0yZY6T1Zx1R7AhTbyGSALm44/Mmq+BAPc4B/p/d3M=",
        version = "v1.1.2",
    )
    go_repository(
        name = "com_github_nxadm_tail",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/nxadm/tail",
        sum = "h1:nPr65rt6Y5JFSKQO7qToXr7pePgD6Gwiw05lkbyAQTE=",
        version = "v1.4.8",
    )

    go_repository(
        name = "com_github_nytimes_gziphandler",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/NYTimes/gziphandler",
        sum = "h1:ZUDjpQae29j0ryrS0u/B8HZfJBtBQHjqw2rQ2cqUQ3I=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_oklog_run",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/oklog/run",
        sum = "h1:GEenZ1cK0+q0+wsJew9qUg/DyD8k3JzYsZAi5gYi2mA=",
        version = "v1.1.0",
    )

    go_repository(
        name = "com_github_oklog_ulid",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/oklog/ulid",
        sum = "h1:EGfNDEx6MqHz8B3uNV6QAib1UR2Lm97sHi3ocA6ESJ4=",
        version = "v1.3.1",
    )
    go_repository(
        name = "com_github_okta_okta_sdk_golang",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/okta/okta-sdk-golang",
        sum = "h1:1DGm5+h2JvfdHz07yVVM7+LgUVSwxnk+6RoLUOB6CwI=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_okta_okta_sdk_golang_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/okta/okta-sdk-golang/v2",
        sum = "h1:U+smE7trkHSZO8Mval3Ow85dbxawO+pMAr692VZq9gM=",
        version = "v2.12.1",
    )
    go_repository(
        name = "com_github_olekukonko_tablewriter",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/olekukonko/tablewriter",
        sum = "h1:58+kh9C6jJVXYjt8IE48G2eWl6BjwU5Gj0gqY84fy78=",
        version = "v0.0.0-20170122224234-a0225b3f23b5",
    )

    go_repository(
        name = "com_github_oneofone_xxhash",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/OneOfOne/xxhash",
        sum = "h1:KMrpdQIwFcEqXDklaen+P1axHaj9BSKzvpUUfnHldSE=",
        version = "v1.2.2",
    )
    go_repository(
        name = "com_github_onsi_ginkgo",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/onsi/ginkgo",
        sum = "h1:29JGrr5oVBm5ulCWet69zQkzWipVXIol6ygQUe/EzNc=",
        version = "v1.16.4",
    )

    go_repository(
        name = "com_github_onsi_ginkgo_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/onsi/ginkgo/v2",
        sum = "h1:zie5Ly042PD3bsCvsSOPvRnFwyo3rKe64TJlD6nu0mk=",
        version = "v2.9.1",
    )

    go_repository(
        name = "com_github_onsi_gomega",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/onsi/gomega",
        sum = "h1:Z2AnStgsdSayCMDiCU42qIz+HLqEPcgiOCXjAU/w+8E=",
        version = "v1.27.4",
    )
    go_repository(
        name = "com_github_opencontainers_go_digest",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/opencontainers/go-digest",
        sum = "h1:apOUWs51W5PlhuyGyz9FCeeBIOUDA/6nW8Oi/yOhh5U=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_opencontainers_image_spec",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/opencontainers/image-spec",
        sum = "h1:9yCKha/T5XdGtO0q9Q9a6T5NUCsTn/DrBg0D7ufOcFM=",
        version = "v1.0.2",
    )
    go_repository(
        name = "com_github_opencontainers_runc",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/opencontainers/runc",
        sum = "h1:XbhB8IfG/EsnhNvZtNdLB0GBw92GYEFvKlhaJk9jUgA=",
        version = "v1.1.6",
    )
    go_repository(
        name = "com_github_opencontainers_runtime_spec",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/opencontainers/runtime-spec",
        sum = "h1:R5M2qXZiK/mWPMT4VldCOiSL9HIAMuxQZWdG0CSM5+4=",
        version = "v1.0.3-0.20220909204839-494a5a6aca78",
    )
    go_repository(
        name = "com_github_opencontainers_selinux",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/opencontainers/selinux",
        sum = "h1:rAiKF8hTcgLI3w0DHm6i0ylVVcOrlgR1kK99DRLDhyU=",
        version = "v1.10.0",
    )
    go_repository(
        name = "com_github_openlyinc_pointy",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/openlyinc/pointy",
        sum = "h1:LywVV2BWC5Sp5v7FoP4bUD+2Yn5k0VNeRbU5vq9jUMY=",
        version = "v1.1.2",
    )
    go_repository(
        name = "com_github_openshift_api",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/openshift/api",
        sum = "h1:+ShYlGoPriGahTTFTjQ0RtNXW0srxDodk2STdc238Rk=",
        version = "v0.0.0-20211217221424-8779abfbd571",
    )
    go_repository(
        name = "com_github_openshift_build_machinery_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/openshift/build-machinery-go",
        sum = "h1:65oBhJYHzYK5VL0gF1eiYY37lLzyLZ47b9y5Kib1nf8=",
        version = "v0.0.0-20211213093930-7e33a7eb4ce3",
    )
    go_repository(
        name = "com_github_openshift_client_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/openshift/client-go",
        sum = "h1:+TEY29DK0XhqB7HFC9OfV8qf3wffSyi7MWv3AP28DGQ=",
        version = "v0.0.0-20210112165513-ebc401615f47",
    )
    go_repository(
        name = "com_github_openshift_custom_resource_status",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/openshift/custom-resource-status",
        sum = "h1:C3DL44LEbvlbItfd8mT5jWrqPfHnSOQoQf/sypqA6A4=",
        version = "v1.1.2",
    )

    go_repository(
        name = "com_github_opentracing_opentracing_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/opentracing/opentracing-go",
        sum = "h1:FfH+VrHHk6Lxt9HdVS0PXzSXFyS2NbZKXv33FYPol0A=",
        version = "v1.2.1-0.20220228012449-10b1cf09e00b",
    )
    go_repository(
        name = "com_github_openzipkin_zipkin_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/openzipkin/zipkin-go",
        sum = "h1:yXiysv1CSK7Q5yjGy1710zZGnsbMUIjluWBxtLXHPBo=",
        version = "v0.1.6",
    )
    go_repository(
        name = "com_github_oracle_oci_go_sdk",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/oracle/oci-go-sdk",
        sum = "h1:x4mcfb4agelf1O4/1/auGlZ1lr97jXRSSN5MxTgG/zU=",
        version = "v24.3.0+incompatible",
    )
    go_repository(
        name = "com_github_oracle_oci_go_sdk_v60",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/oracle/oci-go-sdk/v60",
        sum = "h1:EJAWjEi4SY5Raha6iUzq4LTQ0uM5YFw/wat/L1ehIEM=",
        version = "v60.0.0",
    )
    go_repository(
        name = "com_github_ory_dockertest",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/ory/dockertest",
        sum = "h1:iLLK6SQwIhcbrG783Dghaaa3WPzGc+4Emza6EbVUUGA=",
        version = "v3.3.5+incompatible",
    )
    go_repository(
        name = "com_github_ory_dockertest_v3",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/ory/dockertest/v3",
        sum = "h1:v4dkG+dlu76goxMiTT2j8zV7s4oPPEppKT8K8p2f1kY=",
        version = "v3.9.1",
    )

    go_repository(
        name = "com_github_ovh_go_ovh",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/ovh/go-ovh",
        sum = "h1:VBGa5wMyQtTP7Zb+w97zRCh9sLtM/2YKRyy+MEJmWaM=",
        version = "v1.4.1",
    )
    go_repository(
        name = "com_github_oxtoacart_bpool",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/oxtoacart/bpool",
        sum = "h1:CXwSGu/LYmbjEab5aMCs5usQRVBGThelUKBNnoSOuso=",
        version = "v0.0.0-20150712133111-4e1c5567d7c2",
    )
    go_repository(
        name = "com_github_packethost_packngo",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/packethost/packngo",
        sum = "h1:vwpFWvAO8DeIZfFeqASzZfsxuWPno9ncAebBEP0N3uE=",
        version = "v0.1.1-0.20180711074735-b9cb5096f54c",
    )
    go_repository(
        name = "com_github_pascaldekloe_goe",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/pascaldekloe/goe",
        sum = "h1:cBOtyMzM9HTpWjXfbbunk26uA6nG3a8n06Wieeh0MwY=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_patrickmn_go_cache",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/patrickmn/go-cache",
        sum = "h1:HRMgzkcYKYpi3C8ajMPV8OFXaaRUnok+kx1WdO15EQc=",
        version = "v2.1.0+incompatible",
    )
    go_repository(
        name = "com_github_pborman_uuid",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/pborman/uuid",
        sum = "h1:J7Q5mO4ysT1dv8hyrUGHb9+ooztCXu1D8MY8DZYsu3g=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_pelletier_go_toml",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/pelletier/go-toml",
        sum = "h1:T5zMGML61Wp+FlcbWjRDT7yAxhJNAiPPLOFECq181zc=",
        version = "v1.2.0",
    )

    go_repository(
        name = "com_github_peterbourgon_diskv",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/peterbourgon/diskv",
        sum = "h1:UBdAOUP5p4RWqPBg048CAvpKN+vxiaj6gdUUzhl4XmI=",
        version = "v2.0.1+incompatible",
    )
    go_repository(
        name = "com_github_petermattis_goid",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/petermattis/goid",
        sum = "h1:q2e307iGHPdTGp0hoxKjt1H5pDo6utceo3dQVK3I5XQ=",
        version = "v0.0.0-20180202154549-b0b1615b78e5",
    )
    go_repository(
        name = "com_github_pierrec_lz4",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/pierrec/lz4",
        sum = "h1:9UY3+iC23yxF0UfGaYrGplQ+79Rg+h/q9FV9ix19jjM=",
        version = "v2.6.1+incompatible",
    )
    go_repository(
        name = "com_github_pierrec_lz4_v4",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/pierrec/lz4/v4",
        sum = "h1:ieHkV+i2BRzngO4Wd/3HGowuZStgq6QkPsD1eolNAO4=",
        version = "v4.1.8",
    )
    go_repository(
        name = "com_github_pires_go_proxyproto",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/pires/go-proxyproto",
        sum = "h1:EBupykFmo22SDjv4fQVQd2J9NOoLPmyZA/15ldOGkPw=",
        version = "v0.6.1",
    )
    go_repository(
        name = "com_github_pkg_browser",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/pkg/browser",
        sum = "h1:KoWmjvw+nsYOo29YJK9vDA65RGE3NrOnUtO7a+RF9HU=",
        version = "v0.0.0-20210911075715-681adbf594b8",
    )

    go_repository(
        name = "com_github_pkg_diff",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/pkg/diff",
        sum = "h1:aoZm08cpOy4WuID//EZDgcC4zIxODThtZNPirFr42+A=",
        version = "v0.0.0-20210226163009-20ebb0f2a09e",
    )
    go_repository(
        name = "com_github_pkg_errors",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/pkg/errors",
        sum = "h1:FEBLx1zS214owpjy7qsBeixbURkuhQAwrK5UwLGTwt4=",
        version = "v0.9.1",
    )
    go_repository(
        name = "com_github_pmezard_go_difflib",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/pmezard/go-difflib",
        sum = "h1:Jamvg5psRIccs7FGNTlIRMkT8wgtp5eCXdBlqhYGL6U=",
        version = "v1.0.1-0.20181226105442-5d4384ee4fb2",
    )
    go_repository(
        name = "com_github_portworx_dcos_secrets",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/portworx/dcos-secrets",
        sum = "h1:JTJ9Vl7Wnd0aKzmGbKPR0P/N6wOM8DAIqjrwrxl1vOM=",
        version = "v0.0.0-20180616013705-8e8ec3f66611",
    )
    go_repository(
        name = "com_github_portworx_kvdb",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/portworx/kvdb",
        sum = "h1:jkqzdbOnejgSN5HG/FLt4enNrozWT/K+nlmaRm3P1II=",
        version = "v0.0.0-20200929023115-b312c7519467",
    )
    go_repository(
        name = "com_github_portworx_sched_ops",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/portworx/sched-ops",
        replace = "github.com/portworx/sched-ops",
        sum = "h1:tXnHsjZT2wZ2BCXf8avDoya7zGyCgLNUC8Upt+WEQrY=",
        version = "v0.20.4-openstorage-rc3",
    )
    go_repository(
        name = "com_github_portworx_talisman",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/portworx/talisman",
        sum = "h1:r4LpGHxnh3tliXnaJcciROXU/snARMN6/OXhGPJyzGA=",
        version = "v0.0.0-20191007232806-837747f38224",
    )
    go_repository(
        name = "com_github_posener_complete",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/posener/complete",
        sum = "h1:NP0eAhjcjImqslEwo/1hq7gpajME0fTLTezBKDqfXqo=",
        version = "v1.2.3",
    )
    go_repository(
        name = "com_github_power_devops_perfstat",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/power-devops/perfstat",
        sum = "h1:ncq/mPwQF4JjgDlrVEn3C11VoGHZN7m8qihwgMEtzYw=",
        version = "v0.0.0-20210106213030-5aafc221ea8c",
    )

    go_repository(
        name = "com_github_pquerna_cachecontrol",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/pquerna/cachecontrol",
        sum = "h1:yJMy84ti9h/+OEWa752kBTKv4XC30OtVVHYv/8cTqKc=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_pquerna_otp",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/pquerna/otp",
        sum = "h1:PinQItctnaL2LtkaSM678+ZLLy5TajwOeXzWvYC7tII=",
        version = "v1.2.1-0.20191009055518-468c2dd2b58d",
    )

    go_repository(
        name = "com_github_prometheus_alertmanager",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/prometheus/alertmanager",
        sum = "h1:vbXKUR6PYRiZPRIKfmXaG+dmCKG52RtPL4Btl8hQGvg=",
        version = "v0.25.0",
    )

    go_repository(
        name = "com_github_prometheus_client_golang",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/prometheus/client_golang",
        sum = "h1:8tXpTmJbyH5lydzFPoxSIJ0J46jdh3tylbvM1xCv0LI=",
        version = "v1.15.1",
    )
    go_repository(
        name = "com_github_prometheus_client_model",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/prometheus/client_model",
        sum = "h1:5lQXD3cAg1OXBf4Wq03gTrXHeaV0TQvGfUooCfx1yqY=",
        version = "v0.4.0",
    )
    go_repository(
        name = "com_github_prometheus_common",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/prometheus/common",
        sum = "h1:+5BrQJwiBB9xsMygAB3TNvpQKOwlkc25LbISbrdOOfY=",
        version = "v0.44.0",
    )
    go_repository(
        name = "com_github_prometheus_common_assets",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/prometheus/common/assets",
        sum = "h1:0P5OrzoHrYBOSM1OigWL3mY8ZvV2N4zIE/5AahrSrfM=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_prometheus_common_sigv4",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/prometheus/common/sigv4",
        sum = "h1:qoVebwtwwEhS85Czm2dSROY5fTo2PAPEVdDeppTwGX4=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_prometheus_exporter_toolkit",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/prometheus/exporter-toolkit",
        sum = "h1:cNkC01riqiOS+kh3zdnNwRsbe/Blh0WwK3ij5rPJ9Sw=",
        version = "v0.9.1",
    )
    go_repository(
        name = "com_github_prometheus_operator_prometheus_operator_pkg_apis_monitoring",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring",
        sum = "h1:J+aQlaDVIemgZDR1f/48MBaiA7rDTm6OyKSRhDX2ZTY=",
        version = "v0.46.0",
    )
    go_repository(
        name = "com_github_prometheus_operator_prometheus_operator_pkg_client",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/prometheus-operator/prometheus-operator/pkg/client",
        sum = "h1:J5gQysJlkhJWOzCZQUx/POBqD6dpM5OI6TRZtAXgYpM=",
        version = "v0.46.0",
    )

    go_repository(
        name = "com_github_prometheus_procfs",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/prometheus/procfs",
        sum = "h1:UkG7GPYkO4UZyLnyXjaWYcgOSONqwdBqFUT95ugmt6I=",
        version = "v0.10.0",
    )
    go_repository(
        name = "com_github_prometheus_prometheus",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/prometheus/prometheus",
        sum = "h1:sgn8Fdx+uE5tHQn0/622swlk2XnIj6udoZCnbVjHIgc=",
        version = "v0.44.0",
    )
    go_repository(
        name = "com_github_prometheus_tsdb",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/prometheus/tsdb",
        sum = "h1:YZcsG11NqnK4czYLrWd9mpEuAJIHVQLwdrleYfszMAA=",
        version = "v0.7.1",
    )

    go_repository(
        name = "com_github_protocolbuffers_txtpbfmt",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/protocolbuffers/txtpbfmt",
        sum = "h1:XHLAvwaTYM0PxS/HO7E0PfBaY/y0jGM5NM7g05lCb0k=",
        version = "v0.0.0-20230412060525-fa9f017c0ded",
    )
    go_repository(
        name = "com_github_protonmail_go_crypto",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/ProtonMail/go-crypto",
        sum = "h1:NsReiLpErIPzRrnogAXYwSoU7txA977LjDGrbkewJbg=",
        version = "v0.0.0-20220824120805-4b6e5c587895",
    )
    go_repository(
        name = "com_github_puerkitobio_purell",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/PuerkitoBio/purell",
        sum = "h1:WEQqlqaGbrPkxLJWfBwQmfEAE1Z7ONdDLqrN38tNFfI=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_puerkitobio_urlesc",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/PuerkitoBio/urlesc",
        sum = "h1:d+Bc7a5rLufV/sSk/8dngufqelfh6jnri85riMAaF/M=",
        version = "v0.0.0-20170810143723-de5bf2ad4578",
    )
    go_repository(
        name = "com_github_rboyer_safeio",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/rboyer/safeio",
        sum = "h1:05xhhdRNAdS3apYm7JRjOqngf4xruaW959jmRxGDuSU=",
        version = "v0.2.1",
    )
    go_repository(
        name = "com_github_rcrowley_go_metrics",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/rcrowley/go-metrics",
        sum = "h1:9ZKAASQSHhDYGoxY8uLVpewe1GDZ2vu2Tr/vTdVAkFQ=",
        version = "v0.0.0-20181016184325-3113b8401b8a",
    )
    go_repository(
        name = "com_github_renier_xmlrpc",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/renier/xmlrpc",
        sum = "h1:Wdi9nwnhFNAlseAOekn6B5G/+GMtks9UKbvRU/CMM/o=",
        version = "v0.0.0-20170708154548-ce4a1a486c03",
    )

    go_repository(
        name = "com_github_robfig_cron_v3",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/robfig/cron/v3",
        sum = "h1:WdRxkvbJztn8LMz/QEvLN5sBU+xKpSqwwUO1Pjr4qDs=",
        version = "v3.0.1",
    )

    go_repository(
        name = "com_github_rogpeppe_fastuuid",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/rogpeppe/fastuuid",
        sum = "h1:Ppwyp6VYCF1nvBTXL3trRso7mXMlRrw9ooo375wvi2s=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_rogpeppe_go_charset",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/rogpeppe/go-charset",
        sum = "h1:BN/Nyn2nWMoqGRA7G7paDNDqTXE30mXGqzzybrfo05w=",
        version = "v0.0.0-20180617210344-2471d30d28b4",
    )

    go_repository(
        name = "com_github_rogpeppe_go_internal",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/rogpeppe/go-internal",
        sum = "h1:TMyTOH3F/DB16zRVcYyreMH6GnZZrwQVAoYjRBZyWFQ=",
        version = "v1.10.0",
    )
    go_repository(
        name = "com_github_rook_rook_pkg_apis",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/rook/rook/pkg/apis",
        sum = "h1:WWQ05yYL5G3VlFNBI3pS9eyEBD4h/K9/omyY17ELK2s=",
        version = "v0.0.0-20230524222013-4af3f3784bd8",
    )

    go_repository(
        name = "com_github_rubiojr_go_vhd",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/rubiojr/go-vhd",
        sum = "h1:if3/24+h9Sq6eDx8UUz1SO9cT9tizyIsATfB7b4D3tc=",
        version = "v0.0.0-20200706105327-02e210299021",
    )

    go_repository(
        name = "com_github_russross_blackfriday_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/russross/blackfriday/v2",
        sum = "h1:JIOH55/0cWyOuilr9/qlrm0BSXldqnqwMsf35Ld67mk=",
        version = "v2.1.0",
    )
    go_repository(
        name = "com_github_ryanuber_columnize",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/ryanuber/columnize",
        sum = "h1:j1Wcmh8OrK4Q7GXY+V7SVSY8nUWQxHW5TkBe7YUl+2s=",
        version = "v2.1.0+incompatible",
    )
    go_repository(
        name = "com_github_ryanuber_go_glob",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/ryanuber/go-glob",
        sum = "h1:iQh3xXAumdQ+4Ufa5b25cRpC5TYKlno6hsv6Cb3pkBk=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_samuel_go_zookeeper",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/samuel/go-zookeeper",
        sum = "h1:6ncX5ko6B9LntYM0YBRXkiSaZMmLYeZ/NWcmeB43mMY=",
        version = "v0.0.0-20180130194729-c4fab1ac1bec",
    )
    go_repository(
        name = "com_github_sap_go_hdb",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/SAP/go-hdb",
        sum = "h1:hkw4ozGZ/i4eak7ZuGkY5e0hxiXFdNUBNhr4AvZVNFE=",
        version = "v0.14.1",
    )
    go_repository(
        name = "com_github_sasha_s_go_deadlock",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/sasha-s/go-deadlock",
        sum = "h1:lMqc+fUb7RrFS3gQLtoQsJ7/6TV/pAIFvBsqX73DK8Y=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_satori_go_uuid",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/satori/go.uuid",
        sum = "h1:0uYX9dsZ2yD7q2RtLRtPSdGDWzjeM3TbMJP9utgA0ww=",
        version = "v1.2.0",
    )

    go_repository(
        name = "com_github_scaleway_scaleway_sdk_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/scaleway/scaleway-sdk-go",
        sum = "h1:Y7xOFbD+3jaPw+VN7lkakNJ/pa+ZSQVFp1ONtJaBxns=",
        version = "v1.0.0-beta.15",
    )
    go_repository(
        name = "com_github_sean_seed",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/sean-/seed",
        sum = "h1:nn5Wsu0esKSJiIVhscUtVbo7ada43DJhG55ua/hjS5I=",
        version = "v0.0.0-20170313163322-e2103e2c3529",
    )

    go_repository(
        name = "com_github_seccomp_libseccomp_golang",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/seccomp/libseccomp-golang",
        sum = "h1:RpforrEYXWkmGwJHIGnLZ3tTWStkjVVstwzNGqxX2Ds=",
        version = "v0.9.2-0.20220502022130-f33da4d89646",
    )
    go_repository(
        name = "com_github_sectorbob_mlab_ns2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Sectorbob/mlab-ns2",
        sum = "h1:KFHLI4QGttB0i7M3qOkAo8Zn/GSsxwwCnInFqBaYtkM=",
        version = "v0.0.0-20171030222938-d3aa0c295a8a",
    )

    go_repository(
        name = "com_github_sergi_go_diff",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/sergi/go-diff",
        sum = "h1:we8PVUC3FE2uYfodKH/nBHMSetSfHDR6scGdBi+erh0=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_sethvargo_go_limiter",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/sethvargo/go-limiter",
        sum = "h1:FgC4N7RMpV5gMrUdda15FaFTkQ/L4fEqM7seXMs4oO8=",
        version = "v0.7.2",
    )
    go_repository(
        name = "com_github_shirou_gopsutil",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/shirou/gopsutil",
        sum = "h1:IrPVlK4nfwW10DF7pW+7YJKws9NkgNzWozwwWv9FsgY=",
        version = "v2.19.9+incompatible",
    )
    go_repository(
        name = "com_github_shirou_gopsutil_v3",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/shirou/gopsutil/v3",
        sum = "h1:FnHOFOh+cYAM0C30P+zysPISzlknLC5Z1G4EAElznfQ=",
        version = "v3.22.6",
    )
    go_repository(
        name = "com_github_shirou_w32",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/shirou/w32",
        sum = "h1:udFKJ0aHUL60LboW/A+DfgoHVedieIzIXE8uylPue0U=",
        version = "v0.0.0-20160930032740-bb4de0191aa4",
    )
    go_repository(
        name = "com_github_shopify_sarama",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Shopify/sarama",
        sum = "h1:9oksLxC6uxVPHPVYUmq6xhr1BOF/hHobWH2UzO67z1s=",
        version = "v1.19.0",
    )
    go_repository(
        name = "com_github_shopify_toxiproxy",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/Shopify/toxiproxy",
        sum = "h1:TKdv8HiTLgE5wdJuEML90aBgNWsokNbMijUGhmcoBJc=",
        version = "v2.1.4+incompatible",
    )
    go_repository(
        name = "com_github_shopspring_decimal",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/shopspring/decimal",
        sum = "h1:pntxY8Ary0t43dCZ5dqY4YTJCObLY1kIXl0uzMv+7DE=",
        version = "v0.0.0-20180709203117-cd690d0c9e24",
    )

    go_repository(
        name = "com_github_shurcool_httpfs",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/shurcooL/httpfs",
        sum = "h1:bUGsEnyNbVPw06Bs80sCeARAlK8lhwqGyi6UT8ymuGk=",
        version = "v0.0.0-20190707220628-8d4bc4ba7749",
    )
    go_repository(
        name = "com_github_shurcool_sanitized_anchor_name",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/shurcooL/sanitized_anchor_name",
        sum = "h1:PdmoCO6wvbs+7yrJyMORt4/BmY5IYyJwS/kOiWx8mHo=",
        version = "v1.0.0",
    )

    go_repository(
        name = "com_github_sirupsen_logrus",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/sirupsen/logrus",
        sum = "h1:trlNQbNUG3OdDrDil03MCb1H2o9nJ1x4/5LYw7byDE0=",
        version = "v1.9.0",
    )
    go_repository(
        name = "com_github_skratchdot_open_golang",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/skratchdot/open-golang",
        sum = "h1:JIAuq3EEf9cgbU6AtGPK4CTG3Zf6CKMNqf0MHTggAUA=",
        version = "v0.0.0-20200116055534-eef842397966",
    )
    go_repository(
        name = "com_github_smartystreets_assertions",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/smartystreets/assertions",
        sum = "h1:zE9ykElWQ6/NYmHa3jpm/yHnI4xSofP+UP6SpjHcSeM=",
        version = "v0.0.0-20180927180507-b2de0cb4f26d",
    )
    go_repository(
        name = "com_github_smartystreets_goconvey",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/smartystreets/goconvey",
        sum = "h1:fv0U8FUIMPNf1L9lnHLvLhgicrIVChEkdzIKYqbNC9s=",
        version = "v1.6.4",
    )
    go_repository(
        name = "com_github_snowflakedb_gosnowflake",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/snowflakedb/gosnowflake",
        sum = "h1:EJDdDi74YbYt1ty164ge3fMZ0eVZ6KA7b1zmAa/wnRo=",
        version = "v1.6.3",
    )
    go_repository(
        name = "com_github_softlayer_softlayer_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/softlayer/softlayer-go",
        sum = "h1:bVQRCxQvfjNUeRqaY/uT0tFuvuFY0ulgnczuR684Xic=",
        version = "v0.0.0-20180806151055-260589d94c7d",
    )

    go_repository(
        name = "com_github_soheilhy_cmux",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/soheilhy/cmux",
        sum = "h1:jjzc5WVemNEDTLwv9tlmemhC73tI08BNOIGwBOo10Js=",
        version = "v0.1.5",
    )
    go_repository(
        name = "com_github_sony_gobreaker",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/sony/gobreaker",
        sum = "h1:br+bPNZsJWKicw/5rALEo67QHs5weyD5tf8WST+4sJ0=",
        version = "v0.4.2-0.20210216022020-dd874f9dd33b",
    )

    go_repository(
        name = "com_github_spaolacci_murmur3",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/spaolacci/murmur3",
        sum = "h1:qLC7fQah7D6K1B0ujays3HV9gkFtllcxhzImRR7ArPQ=",
        version = "v0.0.0-20180118202830-f09979ecbc72",
    )
    go_repository(
        name = "com_github_spf13_afero",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/spf13/afero",
        sum = "h1:5jhuqJyZCZf2JRofRvN/nIFgIWNzPa3/Vz8mYylgbWc=",
        version = "v1.2.2",
    )
    go_repository(
        name = "com_github_spf13_cast",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/spf13/cast",
        sum = "h1:oget//CVOEoFewqQxwr0Ej5yjygnqGkvggSE/gB35Q8=",
        version = "v1.3.0",
    )

    go_repository(
        name = "com_github_spf13_cobra",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/spf13/cobra",
        sum = "h1:hyqWnYt1ZQShIddO5kBpj3vu05/++x6tJ6dg8EC572I=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_github_spf13_jwalterweatherman",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/spf13/jwalterweatherman",
        sum = "h1:XHEdyB+EcvlqZamSM4ZOMGlc93t6AcsBEu9Gc1vn7yk=",
        version = "v1.0.0",
    )

    go_repository(
        name = "com_github_spf13_pflag",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/spf13/pflag",
        sum = "h1:iy+VFUOCP1a+8yFto/drg2CJ5u0yRoB7fZw3DKv/JXA=",
        version = "v1.0.5",
    )
    go_repository(
        name = "com_github_spf13_viper",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/spf13/viper",
        sum = "h1:xVKxvI7ouOI5I+U9s2eeiUfMaWBVoXA3AWskkrqK0VM=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_github_stackexchange_wmi",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/StackExchange/wmi",
        sum = "h1:fLjPD/aNc3UIOA6tDi6QXUemppXK3P9BI7mr2hd6gx8=",
        version = "v0.0.0-20180116203802-5d049714c4a6",
    )

    go_repository(
        name = "com_github_stoewer_go_strcase",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/stoewer/go-strcase",
        sum = "h1:g0eASXYtp+yvN9fK8sH94oCIk0fau9uV1/ZdJ0AVEzs=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_github_streadway_amqp",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/streadway/amqp",
        sum = "h1:0ngsPmuP6XIjiFRNFYlvKwSr5zff2v+uPHaffZ6/M4k=",
        version = "v0.0.0-20190404075320-75d898a42a94",
    )

    go_repository(
        name = "com_github_stretchr_objx",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/stretchr/objx",
        sum = "h1:1zr/of2m5FGMsad5YfcqgdqdWrIhu+EBEJRhR1U7z/c=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_github_stretchr_testify",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/stretchr/testify",
        sum = "h1:RP3t2pwF7cMEbC1dqtB6poj3niw/9gnV4Cjg5oW5gtY=",
        version = "v1.8.3",
    )
    go_repository(
        name = "com_github_subosito_gotenv",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/subosito/gotenv",
        sum = "h1:Slr1R9HxAlEKefgq5jn9U+DnETlIUa6HfgEzj0g5d7s=",
        version = "v1.2.0",
    )

    go_repository(
        name = "com_github_syndtr_gocapability",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/syndtr/gocapability",
        sum = "h1:kdXcSzyDtseVEc4yCz2qF8ZrQvIDBJLl4S1c3GCXmoI=",
        version = "v0.0.0-20200815063812-42c35b437635",
    )
    go_repository(
        name = "com_github_tencentcloud_tencentcloud_sdk_go",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/tencentcloud/tencentcloud-sdk-go",
        sum = "h1:K3fcS92NS8cRntIdu8Uqy2ZSePvX73nNhOkKuPGJLXQ=",
        version = "v3.0.171+incompatible",
    )
    go_repository(
        name = "com_github_tidwall_pretty",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/tidwall/pretty",
        sum = "h1:HsD+QiTn7sK6flMKIvNmpqz1qrpP3Ps6jOKIKMooyg4=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_tilinna_clock",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/tilinna/clock",
        sum = "h1:6BO2tyAC9JbPExKH/z9zl44FLu1lImh3nDNKA0kgrkI=",
        version = "v1.0.2",
    )
    go_repository(
        name = "com_github_tklauser_go_sysconf",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/tklauser/go-sysconf",
        sum = "h1:IJ1AZGZRWbY8T5Vfk04D9WOA5WSejdflXxP03OUqALw=",
        version = "v0.3.10",
    )
    go_repository(
        name = "com_github_tklauser_numcpus",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/tklauser/numcpus",
        sum = "h1:E53Dm1HjH1/R2/aoCtXtPgzmElmn51aOkhCFSuZq//o=",
        version = "v0.4.0",
    )

    go_repository(
        name = "com_github_tmc_grpc_websocket_proxy",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/tmc/grpc-websocket-proxy",
        sum = "h1:6fotK7otjonDflCTK0BCfls4SPy3NcCVb5dqqmbRknE=",
        version = "v0.0.0-20220101234140-673ab2c3ae75",
    )
    go_repository(
        name = "com_github_tv42_httpunix",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/tv42/httpunix",
        sum = "h1:u6SKchux2yDvFQnDHS3lPnIRmfVJ5Sxy3ao2SIdysLQ=",
        version = "v0.0.0-20191220191345-2ba4b9c3382c",
    )
    go_repository(
        name = "com_github_ulikunitz_xz",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/ulikunitz/xz",
        sum = "h1:t92gobL9l3HE202wg3rlk19F6X+JOxl9BBrCCMYEYd8=",
        version = "v0.5.10",
    )
    go_repository(
        name = "com_github_urfave_cli",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/urfave/cli",
        sum = "h1:fDqGv3UG/4jbVl/QkFwEdddtEDjh/5Ov6X+0B/3bPaw=",
        version = "v1.20.0",
    )

    go_repository(
        name = "com_github_vishvananda_netlink",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/vishvananda/netlink",
        sum = "h1:1iyaYNBLmP6L0220aDnYQpo1QEV4t4hJ+xEEhhJH8j0=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_vishvananda_netns",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/vishvananda/netns",
        sum = "h1:Cn05BRLm+iRP/DZxyVSsfVyrzgjDbwHwkVt38qvXnNI=",
        version = "v0.0.2",
    )
    go_repository(
        name = "com_github_vmware_govmomi",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/vmware/govmomi",
        sum = "h1:Fm8ugPnnlMSTSceDKY9goGvjmqc6eQLPUSUeNXdpeXA=",
        version = "v0.30.0",
    )
    go_repository(
        name = "com_github_vultr_govultr_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/vultr/govultr/v2",
        sum = "h1:gej/rwr91Puc/tgh+j33p/BLR16UrIPnSr+AIwYWZQs=",
        version = "v2.17.2",
    )
    go_repository(
        name = "com_github_xdg_go_pbkdf2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/xdg-go/pbkdf2",
        sum = "h1:Su7DPu48wXMwC3bs7MCNG+z4FhcyEuz5dlvchbq0B0c=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_xdg_go_scram",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/xdg-go/scram",
        sum = "h1:akYIkZ28e6A96dkWNJQu3nmCzH3YfwMPQExUYDaRv7w=",
        version = "v1.0.2",
    )
    go_repository(
        name = "com_github_xdg_go_stringprep",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/xdg-go/stringprep",
        sum = "h1:6iq84/ryjjeRmMJwxutI51F2GIPlP5BfTvXHeYjyhBc=",
        version = "v1.0.2",
    )
    go_repository(
        name = "com_github_xdg_scram",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/xdg/scram",
        sum = "h1:u40Z8hqBAAQyv+vATcGgV0YCnDjqSL7/q/JyPhhJSPk=",
        version = "v0.0.0-20180814205039-7eeb5667e42c",
    )
    go_repository(
        name = "com_github_xdg_stringprep",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/xdg/stringprep",
        sum = "h1:d9X0esnoa3dFsV0FG35rAT0RIhYFlPq7MiP+DW89La0=",
        version = "v1.0.0",
    )

    go_repository(
        name = "com_github_xeipuuv_gojsonpointer",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/xeipuuv/gojsonpointer",
        sum = "h1:zGWFAtiMcyryUHoUjUJX0/lt1H2+i2Ka2n+D3DImSNo=",
        version = "v0.0.0-20190905194746-02993c407bfb",
    )
    go_repository(
        name = "com_github_xeipuuv_gojsonreference",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/xeipuuv/gojsonreference",
        sum = "h1:EzJWgHovont7NscjpAxXsDA8S8BMYve8Y5+7cuRE7R0=",
        version = "v0.0.0-20180127040603-bd5ef7bd5415",
    )
    go_repository(
        name = "com_github_xeipuuv_gojsonschema",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/xeipuuv/gojsonschema",
        sum = "h1:LhYJRs+L4fBtjZUfuSZIKGeVu0QRy8e5Xi7D17UxZ74=",
        version = "v1.2.0",
    )

    go_repository(
        name = "com_github_xhit_go_str2duration_v2",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/xhit/go-str2duration/v2",
        sum = "h1:lxklc02Drh6ynqX+DdPyp5pCKLUQpRT8bp8Ydu2Bstc=",
        version = "v2.1.0",
    )
    go_repository(
        name = "com_github_xi2_xz",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/xi2/xz",
        sum = "h1:nIPpBwaJSVYIxUFsDv3M8ofmx9yWTog9BfvIu0q41lo=",
        version = "v0.0.0-20171230120015-48954b6210f8",
    )

    go_repository(
        name = "com_github_xiang90_probing",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/xiang90/probing",
        sum = "h1:eY9dn8+vbi4tKz5Qo6v2eYzo7kUS51QINcR5jNpbZS8=",
        version = "v0.0.0-20190116061207-43a291ad63a2",
    )
    go_repository(
        name = "com_github_xlab_treeprint",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/xlab/treeprint",
        sum = "h1:HzHnuAF1plUN2zGlAFHbSQP2qJ0ZAD3XF5XD7OesXRQ=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_youmark_pkcs8",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/youmark/pkcs8",
        sum = "h1:splanxYIlg+5LfHAM6xpdFEAYOk8iySO56hMFq6uLyA=",
        version = "v0.0.0-20181117223130-1be2e3e5546d",
    )

    go_repository(
        name = "com_github_yuin_goldmark",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/yuin/goldmark",
        sum = "h1:fVcFKWvrslecOb/tg+Cc05dkeYx540o0FuFt3nUVDoE=",
        version = "v1.4.13",
    )
    go_repository(
        name = "com_github_yuin_gopher_lua",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/yuin/gopher-lua",
        sum = "h1:k/gmLsJDWwWqbLCur2yWnJzwQEKRcAHXo6seXGuSwWw=",
        version = "v0.0.0-20210529063254-f4c35e4016d9",
    )
    go_repository(
        name = "com_github_yusufpapurcu_wmi",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/yusufpapurcu/wmi",
        sum = "h1:KBNDSne4vP5mbSWnJbO+51IMOXJB67QiYCSBrubbPRg=",
        version = "v1.2.2",
    )

    go_repository(
        name = "com_google_cloud_go",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go",
        sum = "h1:Zc8gqp3+a9/Eyph2KDmcGaPtbKRIoqq4YTlL4NMD0Ys=",
        version = "v0.110.0",
    )
    go_repository(
        name = "com_google_cloud_go_accessapproval",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/accessapproval",
        sum = "h1:x0cEHro/JFPd7eS4BlEWNTMecIj2HdXjOVB5BtvwER0=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_accesscontextmanager",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/accesscontextmanager",
        sum = "h1:MG60JgnEoawHJrbWw0jGdv6HLNSf6gQvYRiXpuzqgEA=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_aiplatform",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/aiplatform",
        sum = "h1:zTw+suCVchgZyO+k847wjzdVjWmrAuehxdvcZvJwfGg=",
        version = "v1.37.0",
    )
    go_repository(
        name = "com_google_cloud_go_analytics",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/analytics",
        sum = "h1:LqAo3tAh2FU9+w/r7vc3hBjU23Kv7GhO/PDIW7kIYgM=",
        version = "v0.19.0",
    )
    go_repository(
        name = "com_google_cloud_go_apigateway",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/apigateway",
        sum = "h1:ZI9mVO7x3E9RK/BURm2p1aw9YTBSCQe3klmyP1WxWEg=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_apigeeconnect",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/apigeeconnect",
        sum = "h1:sWOmgDyAsi1AZ48XRHcATC0tsi9SkPT7DA/+VCfkaeA=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_apigeeregistry",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/apigeeregistry",
        sum = "h1:E43RdhhCxdlV+I161gUY2rI4eOaMzHTA5kNkvRsFXvc=",
        version = "v0.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_apikeys",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/apikeys",
        sum = "h1:B9CdHFZTFjVti89tmyXXrO+7vSNo2jvZuHG8zD5trdQ=",
        version = "v0.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_appengine",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/appengine",
        sum = "h1:aBGDKmRIaRRoWJ2tAoN0oVSHoWLhtO9aj/NvUyP4aYs=",
        version = "v1.7.1",
    )
    go_repository(
        name = "com_google_cloud_go_area120",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/area120",
        sum = "h1:ugckkFh4XkHJMPhTIx0CyvdoBxmOpMe8rNs4Ok8GAag=",
        version = "v0.7.1",
    )
    go_repository(
        name = "com_google_cloud_go_artifactregistry",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/artifactregistry",
        sum = "h1:o1Q80vqEB6Qp8WLEH3b8FBLNUCrGQ4k5RFj0sn/sgO8=",
        version = "v1.13.0",
    )
    go_repository(
        name = "com_google_cloud_go_asset",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/asset",
        sum = "h1:YAsssO08BqZ6mncbb6FPlj9h6ACS7bJQUOlzciSfbNk=",
        version = "v1.13.0",
    )
    go_repository(
        name = "com_google_cloud_go_assuredworkloads",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/assuredworkloads",
        sum = "h1:VLGnVFta+N4WM+ASHbhc14ZOItOabDLH1MSoDv+Xuag=",
        version = "v1.10.0",
    )
    go_repository(
        name = "com_google_cloud_go_automl",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/automl",
        sum = "h1:50VugllC+U4IGl3tDNcZaWvApHBTrn/TvyHDJ0wM+Uw=",
        version = "v1.12.0",
    )
    go_repository(
        name = "com_google_cloud_go_baremetalsolution",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/baremetalsolution",
        sum = "h1:2AipdYXL0VxMboelTTw8c1UJ7gYu35LZYUbuRv9Q28s=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_batch",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/batch",
        sum = "h1:YbMt0E6BtqeD5FvSv1d56jbVsWEzlGm55lYte+M6Mzs=",
        version = "v0.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_beyondcorp",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/beyondcorp",
        sum = "h1:UkY2BTZkEUAVrgqnSdOJ4p3y9ZRBPEe1LkjgC8Bj/Pc=",
        version = "v0.5.0",
    )

    go_repository(
        name = "com_google_cloud_go_bigquery",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/bigquery",
        sum = "h1:RscMV6LbnAmhAzD893Lv9nXXy2WCaJmbxYPWDLbGqNQ=",
        version = "v1.50.0",
    )
    go_repository(
        name = "com_google_cloud_go_billing",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/billing",
        sum = "h1:JYj28UYF5w6VBAh0gQYlgHJ/OD1oA+JgW29YZQU+UHM=",
        version = "v1.13.0",
    )
    go_repository(
        name = "com_google_cloud_go_binaryauthorization",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/binaryauthorization",
        sum = "h1:d3pMDBCCNivxt5a4eaV7FwL7cSH0H7RrEnFrTb1QKWs=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_certificatemanager",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/certificatemanager",
        sum = "h1:5C5UWeSt8Jkgp7OWn2rCkLmYurar/vIWIoSQ2+LaTOc=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_channel",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/channel",
        sum = "h1:GpcQY5UJKeOekYgsX3QXbzzAc/kRGtBq43fTmyKe6Uw=",
        version = "v1.12.0",
    )
    go_repository(
        name = "com_google_cloud_go_cloudbuild",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/cloudbuild",
        sum = "h1:GHQCjV4WlPPVU/j3Rlpc8vNIDwThhd1U9qSY/NPZdko=",
        version = "v1.9.0",
    )
    go_repository(
        name = "com_google_cloud_go_clouddms",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/clouddms",
        sum = "h1:E7v4TpDGUyEm1C/4KIrpVSOCTm0P6vWdHT0I4mostRA=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_cloudtasks",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/cloudtasks",
        sum = "h1:uK5k6abf4yligFgYFnG0ni8msai/dSv6mDmiBulU0hU=",
        version = "v1.10.0",
    )
    go_repository(
        name = "com_google_cloud_go_compute",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/compute",
        sum = "h1:+9zda3WGgW1ZSTlVppLCYFIr48Pa35q1uG2N1itbCEQ=",
        version = "v1.19.0",
    )
    go_repository(
        name = "com_google_cloud_go_compute_metadata",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/compute/metadata",
        sum = "h1:mg4jlk7mCAj6xXp9UJ4fjI9VUI5rubuGBW5aJ7UnBMY=",
        version = "v0.2.3",
    )
    go_repository(
        name = "com_google_cloud_go_contactcenterinsights",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/contactcenterinsights",
        sum = "h1:jXIpfcH/VYSE1SYcPzO0n1VVb+sAamiLOgCw45JbOQk=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_container",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/container",
        sum = "h1:NKlY/wCDapfVZlbVVaeuu2UZZED5Dy1z4Zx1KhEzm8c=",
        version = "v1.15.0",
    )
    go_repository(
        name = "com_google_cloud_go_containeranalysis",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/containeranalysis",
        sum = "h1:EQ4FFxNaEAg8PqQCO7bVQfWz9NVwZCUKaM1b3ycfx3U=",
        version = "v0.9.0",
    )
    go_repository(
        name = "com_google_cloud_go_datacatalog",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/datacatalog",
        sum = "h1:4H5IJiyUE0X6ShQBqgFFZvGGcrwGVndTwUSLP4c52gw=",
        version = "v1.13.0",
    )
    go_repository(
        name = "com_google_cloud_go_dataflow",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/dataflow",
        sum = "h1:eYyD9o/8Nm6EttsKZaEGD84xC17bNgSKCu0ZxwqUbpg=",
        version = "v0.8.0",
    )
    go_repository(
        name = "com_google_cloud_go_dataform",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/dataform",
        sum = "h1:Dyk+fufup1FR6cbHjFpMuP4SfPiF3LI3JtoIIALoq48=",
        version = "v0.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_datafusion",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/datafusion",
        sum = "h1:sZjRnS3TWkGsu1LjYPFD/fHeMLZNXDK6PDHi2s2s/bk=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_datalabeling",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/datalabeling",
        sum = "h1:ch4qA2yvddGRUrlfwrNJCr79qLqhS9QBwofPHfFlDIk=",
        version = "v0.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_dataplex",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/dataplex",
        sum = "h1:RvoZ5T7gySwm1CHzAw7yY1QwwqaGswunmqEssPxU/AM=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_dataproc",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/dataproc",
        sum = "h1:W47qHL3W4BPkAIbk4SWmIERwsWBaNnWm0P2sdx3YgGU=",
        version = "v1.12.0",
    )
    go_repository(
        name = "com_google_cloud_go_dataqna",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/dataqna",
        sum = "h1:yFzi/YU4YAdjyo7pXkBE2FeHbgz5OQQBVDdbErEHmVQ=",
        version = "v0.7.0",
    )

    go_repository(
        name = "com_google_cloud_go_datastore",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/datastore",
        sum = "h1:iF6I/HaLs3Ado8uRKMvZRvF/ZLkWaWE9i8AiHzbC774=",
        version = "v1.11.0",
    )
    go_repository(
        name = "com_google_cloud_go_datastream",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/datastream",
        sum = "h1:BBCBTnWMDwwEzQQmipUXxATa7Cm7CA/gKjKcR2w35T0=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_deploy",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/deploy",
        sum = "h1:otshdKEbmsi1ELYeCKNYppwV0UH5xD05drSdBm7ouTk=",
        version = "v1.8.0",
    )
    go_repository(
        name = "com_google_cloud_go_dialogflow",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/dialogflow",
        sum = "h1:uVlKKzp6G/VtSW0E7IH1Y5o0H48/UOCmqksG2riYCwQ=",
        version = "v1.32.0",
    )
    go_repository(
        name = "com_google_cloud_go_dlp",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/dlp",
        sum = "h1:1JoJqezlgu6NWCroBxr4rOZnwNFILXr4cB9dMaSKO4A=",
        version = "v1.9.0",
    )
    go_repository(
        name = "com_google_cloud_go_documentai",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/documentai",
        sum = "h1:KM3Xh0QQyyEdC8Gs2vhZfU+rt6OCPF0dwVwxKgLmWfI=",
        version = "v1.18.0",
    )
    go_repository(
        name = "com_google_cloud_go_domains",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/domains",
        sum = "h1:2ti/o9tlWL4N+wIuWUNH+LbfgpwxPr8J1sv9RHA4bYQ=",
        version = "v0.8.0",
    )
    go_repository(
        name = "com_google_cloud_go_edgecontainer",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/edgecontainer",
        sum = "h1:O0YVE5v+O0Q/ODXYsQHmHb+sYM8KNjGZw2pjX2Ws41c=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_google_cloud_go_errorreporting",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/errorreporting",
        sum = "h1:kj1XEWMu8P0qlLhm3FwcaFsUvXChV/OraZwA70trRR0=",
        version = "v0.3.0",
    )
    go_repository(
        name = "com_google_cloud_go_essentialcontacts",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/essentialcontacts",
        sum = "h1:gIzEhCoOT7bi+6QZqZIzX1Erj4SswMPIteNvYVlu+pM=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_eventarc",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/eventarc",
        sum = "h1:fsJmNeqvqtk74FsaVDU6cH79lyZNCYP8Rrv7EhaB/PU=",
        version = "v1.11.0",
    )
    go_repository(
        name = "com_google_cloud_go_filestore",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/filestore",
        sum = "h1:ckTEXN5towyTMu4q0uQ1Mde/JwTHur0gXs8oaIZnKfw=",
        version = "v1.6.0",
    )

    go_repository(
        name = "com_google_cloud_go_firestore",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/firestore",
        sum = "h1:IBlRyxgGySXu5VuW0RgGFlTtLukSnNkpDiEOMkQkmpA=",
        version = "v1.9.0",
    )
    go_repository(
        name = "com_google_cloud_go_functions",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/functions",
        sum = "h1:pPDqtsXG2g9HeOQLoquLbmvmb82Y4Ezdo1GXuotFoWg=",
        version = "v1.13.0",
    )
    go_repository(
        name = "com_google_cloud_go_gaming",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/gaming",
        sum = "h1:7vEhFnZmd931Mo7sZ6pJy7uQPDxF7m7v8xtBheG08tc=",
        version = "v1.9.0",
    )
    go_repository(
        name = "com_google_cloud_go_gkebackup",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/gkebackup",
        sum = "h1:za3QZvw6ujR0uyqkhomKKKNoXDyqYGPJies3voUK8DA=",
        version = "v0.4.0",
    )
    go_repository(
        name = "com_google_cloud_go_gkeconnect",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/gkeconnect",
        sum = "h1:gXYKciHS/Lgq0GJ5Kc9SzPA35NGc3yqu6SkjonpEr2Q=",
        version = "v0.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_gkehub",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/gkehub",
        sum = "h1:TqCSPsEBQ6oZSJgEYZ3XT8x2gUadbvfwI32YB0kuHCs=",
        version = "v0.12.0",
    )
    go_repository(
        name = "com_google_cloud_go_gkemulticloud",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/gkemulticloud",
        sum = "h1:8I84Q4vl02rJRsFiinBxl7WCozfdLlUVBQuSrqr9Wtk=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_gsuiteaddons",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/gsuiteaddons",
        sum = "h1:1mvhXqJzV0Vg5Fa95QwckljODJJfDFXV4pn+iL50zzA=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_iam",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/iam",
        sum = "h1:+CmB+K0J/33d0zSQ9SlFWUeCCEn5XJA0ZMZ3pHE9u8k=",
        version = "v0.13.0",
    )
    go_repository(
        name = "com_google_cloud_go_iap",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/iap",
        sum = "h1:PxVHFuMxmSZyfntKXHXhd8bo82WJ+LcATenq7HLdVnU=",
        version = "v1.7.1",
    )
    go_repository(
        name = "com_google_cloud_go_ids",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/ids",
        sum = "h1:fodnCDtOXuMmS8LTC2y3h8t24U8F3eKWfhi+3LY6Qf0=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_google_cloud_go_iot",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/iot",
        sum = "h1:39W5BFSarRNZfVG0eXI5LYux+OVQT8GkgpHCnrZL2vM=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_kms",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/kms",
        sum = "h1:7hm1bRqGCA1GBRQUrp831TwJ9TWhP+tvLuP497CQS2g=",
        version = "v1.10.1",
    )
    go_repository(
        name = "com_google_cloud_go_language",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/language",
        sum = "h1:7Ulo2mDk9huBoBi8zCE3ONOoBrL6UXfAI71CLQ9GEIM=",
        version = "v1.9.0",
    )
    go_repository(
        name = "com_google_cloud_go_lifesciences",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/lifesciences",
        sum = "h1:uWrMjWTsGjLZpCTWEAzYvyXj+7fhiZST45u9AgasasI=",
        version = "v0.8.0",
    )
    go_repository(
        name = "com_google_cloud_go_logging",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/logging",
        sum = "h1:CJYxlNNNNAMkHp9em/YEXcfJg+rPDg7YfwoRpMU+t5I=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_longrunning",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/longrunning",
        sum = "h1:v+yFJOfKC3yZdY6ZUI933pIYdhyhV8S3NpWrXWmg7jM=",
        version = "v0.4.1",
    )
    go_repository(
        name = "com_google_cloud_go_managedidentities",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/managedidentities",
        sum = "h1:ZRQ4k21/jAhrHBVKl/AY7SjgzeJwG1iZa+mJ82P+VNg=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_maps",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/maps",
        sum = "h1:mv9YaczD4oZBZkM5XJl6fXQ984IkJNHPwkc8MUsdkBo=",
        version = "v0.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_mediatranslation",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/mediatranslation",
        sum = "h1:anPxH+/WWt8Yc3EdoEJhPMBRF7EhIdz426A+tuoA0OU=",
        version = "v0.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_memcache",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/memcache",
        sum = "h1:8/VEmWCpnETCrBwS3z4MhT+tIdKgR1Z4Tr2tvYH32rg=",
        version = "v1.9.0",
    )
    go_repository(
        name = "com_google_cloud_go_metastore",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/metastore",
        sum = "h1:QCFhZVe2289KDBQ7WxaHV2rAmPrmRAdLC6gbjUd3HPo=",
        version = "v1.10.0",
    )
    go_repository(
        name = "com_google_cloud_go_monitoring",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/monitoring",
        sum = "h1:2qsrgXGVoRXpP7otZ14eE1I568zAa92sJSDPyOJvwjM=",
        version = "v1.13.0",
    )
    go_repository(
        name = "com_google_cloud_go_networkconnectivity",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/networkconnectivity",
        sum = "h1:ZD6b4Pk1jEtp/cx9nx0ZYcL3BKqDa+KixNDZ6Bjs1B8=",
        version = "v1.11.0",
    )
    go_repository(
        name = "com_google_cloud_go_networkmanagement",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/networkmanagement",
        sum = "h1:8KWEUNGcpSX9WwZXq7FtciuNGPdPdPN/ruDm769yAEM=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_networksecurity",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/networksecurity",
        sum = "h1:sOc42Ig1K2LiKlzG71GUVloeSJ0J3mffEBYmvu+P0eo=",
        version = "v0.8.0",
    )
    go_repository(
        name = "com_google_cloud_go_notebooks",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/notebooks",
        sum = "h1:Kg2K3K7CbSXYJHZ1aGQpf1xi5x2GUvQWf2sFVuiZh8M=",
        version = "v1.8.0",
    )
    go_repository(
        name = "com_google_cloud_go_optimization",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/optimization",
        sum = "h1:dj8O4VOJRB4CUwZXdmwNViH1OtI0WtWL867/lnYH248=",
        version = "v1.3.1",
    )
    go_repository(
        name = "com_google_cloud_go_orchestration",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/orchestration",
        sum = "h1:Vw+CEXo8M/FZ1rb4EjcLv0gJqqw89b7+g+C/EmniTb8=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_orgpolicy",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/orgpolicy",
        sum = "h1:XDriMWug7sd0kYT1QKofRpRHzjad0bK8Q8uA9q+XrU4=",
        version = "v1.10.0",
    )
    go_repository(
        name = "com_google_cloud_go_osconfig",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/osconfig",
        sum = "h1:PkSQx4OHit5xz2bNyr11KGcaFccL5oqglFPdTboyqwQ=",
        version = "v1.11.0",
    )
    go_repository(
        name = "com_google_cloud_go_oslogin",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/oslogin",
        sum = "h1:whP7vhpmc+ufZa90eVpkfbgzJRK/Xomjz+XCD4aGwWw=",
        version = "v1.9.0",
    )
    go_repository(
        name = "com_google_cloud_go_phishingprotection",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/phishingprotection",
        sum = "h1:l6tDkT7qAEV49MNEJkEJTB6vOO/onbSOcNtAT09HPuA=",
        version = "v0.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_policytroubleshooter",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/policytroubleshooter",
        sum = "h1:yKAGC4p9O61ttZUswaq9GAn1SZnEzTd0vUYXD7ZBT7Y=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_privatecatalog",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/privatecatalog",
        sum = "h1:EPEJ1DpEGXLDnmc7mnCAqFmkwUJbIsaLAiLHVOkkwtc=",
        version = "v0.8.0",
    )

    go_repository(
        name = "com_google_cloud_go_pubsub",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/pubsub",
        sum = "h1:vCge8m7aUKBJYOgrZp7EsNDf6QMd2CAlXZqWTn3yq6s=",
        version = "v1.30.0",
    )
    go_repository(
        name = "com_google_cloud_go_pubsublite",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/pubsublite",
        sum = "h1:cb9fsrtpINtETHiJ3ECeaVzrfIVhcGjhhJEjybHXHao=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_recaptchaenterprise_v2",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/recaptchaenterprise/v2",
        sum = "h1:6iOCujSNJ0YS7oNymI64hXsjGq60T4FK1zdLugxbzvU=",
        version = "v2.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_recommendationengine",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/recommendationengine",
        sum = "h1:VibRFCwWXrFebEWKHfZAt2kta6pS7Tlimsnms0fjv7k=",
        version = "v0.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_recommender",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/recommender",
        sum = "h1:ZnFRY5R6zOVk2IDS1Jbv5Bw+DExCI5rFumsTnMXiu/A=",
        version = "v1.9.0",
    )
    go_repository(
        name = "com_google_cloud_go_redis",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/redis",
        sum = "h1:JoAd3SkeDt3rLFAAxEvw6wV4t+8y4ZzfZcZmddqphQ8=",
        version = "v1.11.0",
    )
    go_repository(
        name = "com_google_cloud_go_resourcemanager",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/resourcemanager",
        sum = "h1:NRM0p+RJkaQF9Ee9JMnUV9BQ2QBIOq/v8M+Pbv/wmCs=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_resourcesettings",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/resourcesettings",
        sum = "h1:8Dua37kQt27CCWHm4h/Q1XqCF6ByD7Ouu49xg95qJzI=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_retail",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/retail",
        sum = "h1:1Dda2OpFNzIb4qWgFZjYlpP7sxX3aLeypKG6A3H4Yys=",
        version = "v1.12.0",
    )
    go_repository(
        name = "com_google_cloud_go_run",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/run",
        sum = "h1:ydJQo+k+MShYnBfhaRHSZYeD/SQKZzZLAROyfpeD9zw=",
        version = "v0.9.0",
    )
    go_repository(
        name = "com_google_cloud_go_scheduler",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/scheduler",
        sum = "h1:NpQAHtx3sulByTLe2dMwWmah8PWgeoieFPpJpArwFV0=",
        version = "v1.9.0",
    )
    go_repository(
        name = "com_google_cloud_go_secretmanager",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/secretmanager",
        sum = "h1:pu03bha7ukxF8otyPKTFdDz+rr9sE3YauS5PliDXK60=",
        version = "v1.10.0",
    )
    go_repository(
        name = "com_google_cloud_go_security",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/security",
        sum = "h1:PYvDxopRQBfYAXKAuDpFCKBvDOWPWzp9k/H5nB3ud3o=",
        version = "v1.13.0",
    )
    go_repository(
        name = "com_google_cloud_go_securitycenter",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/securitycenter",
        sum = "h1:AF3c2s3awNTMoBtMX3oCUoOMmGlYxGOeuXSYHNBkf14=",
        version = "v1.19.0",
    )
    go_repository(
        name = "com_google_cloud_go_servicecontrol",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/servicecontrol",
        sum = "h1:d0uV7Qegtfaa7Z2ClDzr9HJmnbJW7jn0WhZ7wOX6hLE=",
        version = "v1.11.1",
    )
    go_repository(
        name = "com_google_cloud_go_servicedirectory",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/servicedirectory",
        sum = "h1:SJwk0XX2e26o25ObYUORXx6torSFiYgsGkWSkZgkoSU=",
        version = "v1.9.0",
    )
    go_repository(
        name = "com_google_cloud_go_servicemanagement",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/servicemanagement",
        sum = "h1:fopAQI/IAzlxnVeiKn/8WiV6zKndjFkvi+gzu+NjywY=",
        version = "v1.8.0",
    )
    go_repository(
        name = "com_google_cloud_go_serviceusage",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/serviceusage",
        sum = "h1:rXyq+0+RSIm3HFypctp7WoXxIA563rn206CfMWdqXX4=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_shell",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/shell",
        sum = "h1:wT0Uw7ib7+AgZST9eCDygwTJn4+bHMDtZo5fh7kGWDU=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_spanner",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/spanner",
        sum = "h1:7VdjZ8zj4sHbDw55atp5dfY6kn1j9sam9DRNpPQhqR4=",
        version = "v1.45.0",
    )
    go_repository(
        name = "com_google_cloud_go_speech",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/speech",
        sum = "h1:JEVoWGNnTF128kNty7T4aG4eqv2z86yiMJPT9Zjp+iw=",
        version = "v1.15.0",
    )

    go_repository(
        name = "com_google_cloud_go_storage",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/storage",
        sum = "h1:YOO045NZI9RKfCj1c5A/ZtuuENUc8OAW+gHdGnDgyMQ=",
        version = "v1.27.0",
    )
    go_repository(
        name = "com_google_cloud_go_storagetransfer",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/storagetransfer",
        sum = "h1:5T+PM+3ECU3EY2y9Brv0Sf3oka8pKmsCfpQ07+91G9o=",
        version = "v1.8.0",
    )
    go_repository(
        name = "com_google_cloud_go_talent",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/talent",
        sum = "h1:nI9sVZPjMKiO2q3Uu0KhTDVov3Xrlpt63fghP9XjyEM=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_texttospeech",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/texttospeech",
        sum = "h1:H4g1ULStsbVtalbZGktyzXzw6jP26RjVGYx9RaYjBzc=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_tpu",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/tpu",
        sum = "h1:/34T6CbSi+kTv5E19Q9zbU/ix8IviInZpzwz3rsFE+A=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_trace",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/trace",
        sum = "h1:olxC0QHC59zgJVALtgqfD9tGk0lfeCP5/AGXL3Px/no=",
        version = "v1.9.0",
    )
    go_repository(
        name = "com_google_cloud_go_translate",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/translate",
        sum = "h1:GvLP4oQ4uPdChBmBaUSa/SaZxCdyWELtlAaKzpHsXdA=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_video",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/video",
        sum = "h1:upIbnGI0ZgACm58HPjAeBMleW3sl5cT84AbYQ8PWOgM=",
        version = "v1.15.0",
    )
    go_repository(
        name = "com_google_cloud_go_videointelligence",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/videointelligence",
        sum = "h1:Uh5BdoET8XXqXX2uXIahGb+wTKbLkGH7s4GXR58RrG8=",
        version = "v1.10.0",
    )
    go_repository(
        name = "com_google_cloud_go_vision_v2",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/vision/v2",
        sum = "h1:8C8RXUJoflCI4yVdqhTy9tRyygSHmp60aP363z23HKg=",
        version = "v2.7.0",
    )
    go_repository(
        name = "com_google_cloud_go_vmmigration",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/vmmigration",
        sum = "h1:Azs5WKtfOC8pxvkyrDvt7J0/4DYBch0cVbuFfCCFt5k=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_vmwareengine",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/vmwareengine",
        sum = "h1:b0NBu7S294l0gmtrT0nOJneMYgZapr5x9tVWvgDoVEM=",
        version = "v0.3.0",
    )
    go_repository(
        name = "com_google_cloud_go_vpcaccess",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/vpcaccess",
        sum = "h1:FOe6CuiQD3BhHJWt7E8QlbBcaIzVRddupwJlp7eqmn4=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_webrisk",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/webrisk",
        sum = "h1:IY+L2+UwxcVm2zayMAtBhZleecdIFLiC+QJMzgb0kT0=",
        version = "v1.8.0",
    )
    go_repository(
        name = "com_google_cloud_go_websecurityscanner",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/websecurityscanner",
        sum = "h1:AHC1xmaNMOZtNqxI9Rmm87IJEyPaRkOxeI0gpAacXGk=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_workflows",
        build_file_proto_mode = "disable_global",
        importpath = "cloud.google.com/go/workflows",
        sum = "h1:FfGp9w0cYnaKZJhUOMqCOJCYT/WlvYBfTQhFWV3sRKI=",
        version = "v1.10.0",
    )
    go_repository(
        name = "com_layeh_radius",
        build_file_proto_mode = "disable_global",
        importpath = "layeh.com/radius",
        sum = "h1:BDXFaFzUt5EIqe/4wrTc4AcYZWP6iC6Ult+jQWLh5eU=",
        version = "v0.0.0-20190322222518-890bc1058917",
    )

    go_repository(
        name = "com_shuralyov_dmitri_gpu_mtl",
        build_file_proto_mode = "disable_global",
        importpath = "dmitri.shuralyov.com/gpu/mtl",
        sum = "h1:VpgP7xuJadIUuKccphEpTJnWhS2jkQyMt6Y7pJCD7fY=",
        version = "v0.0.0-20190408044501-666a987793e9",
    )
    go_repository(
        name = "in_gopkg_alecthomas_kingpin_v2",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/alecthomas/kingpin.v2",
        sum = "h1:jMFz6MfLP0/4fUyZle81rXUoxOBFi19VUFKVDOQfozc=",
        version = "v2.2.6",
    )
    go_repository(
        name = "in_gopkg_asn1_ber_v1",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/asn1-ber.v1",
        sum = "h1:TxyelI5cVkbREznMhfzycHdkp5cLA7DpE+GKjSslYhM=",
        version = "v1.0.0-20181015200546-f715ec2f112d",
    )

    go_repository(
        name = "in_gopkg_check_v1",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/check.v1",
        sum = "h1:Hei/4ADfdWqJk1ZMxUNpqntNwaWcugrBjAiHlqqRiVk=",
        version = "v1.0.0-20201130134442-10cb98267c6c",
    )
    go_repository(
        name = "in_gopkg_cheggaaa_pb_v1",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/cheggaaa/pb.v1",
        sum = "h1:Ev7yu1/f6+d+b3pi5vPdRPc6nNtP1umSfcWiEfRqv6I=",
        version = "v1.0.25",
    )

    go_repository(
        name = "in_gopkg_errgo_v2",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/errgo.v2",
        sum = "h1:0vLT13EuvQ0hNvakwLuFZ/jYrLp5F3kcWHXdRggjCE8=",
        version = "v2.1.0",
    )
    go_repository(
        name = "in_gopkg_fsnotify_v1",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/fsnotify.v1",
        sum = "h1:xOHLXZwVvI9hhs+cLKq5+I5onOuwQLhQwiu63xxlHs4=",
        version = "v1.4.7",
    )

    go_repository(
        name = "in_gopkg_gcfg_v1",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/gcfg.v1",
        sum = "h1:0HIbH907iBTAntm+88IJV2qmJALDAh8sPekI9Vc1fm0=",
        version = "v1.2.0",
    )
    go_repository(
        name = "in_gopkg_h2non_gock_v1",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/h2non/gock.v1",
        sum = "h1:SzLqcIlb/fDfg7UvukMpNcWsu7sI5tWwL+KCATZqks0=",
        version = "v1.0.15",
    )

    go_repository(
        name = "in_gopkg_inf_v0",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/inf.v0",
        sum = "h1:73M5CoZyi3ZLMOyDlQh031Cx6N9NDJ2Vvfl76EDAgDc=",
        version = "v0.9.1",
    )
    go_repository(
        name = "in_gopkg_ini_v1",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/ini.v1",
        sum = "h1:Dgnx+6+nfE+IfzjUEISNeydPJh9AXNNsWbGP9KzCsOA=",
        version = "v1.67.0",
    )
    go_repository(
        name = "in_gopkg_jcmturner_goidentity_v3",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/jcmturner/goidentity.v3",
        sum = "h1:1duIyWiTaYvVx3YX2CYtpJbUFd7/UuPYCfgXtQ3VTbI=",
        version = "v3.0.0",
    )
    go_repository(
        name = "in_gopkg_ldap_v3",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/ldap.v3",
        sum = "h1:YKRHW/2sIl05JsCtx/5ZuUueFuJyoj/6+DGXe3wp6ro=",
        version = "v3.0.3",
    )
    go_repository(
        name = "in_gopkg_mgo_v2",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/mgo.v2",
        sum = "h1:xcEWjVhvbDy+nHP67nPDDpbYrY+ILlfndk4bRioVHaU=",
        version = "v2.0.0-20180705113604-9856a29383ce",
    )

    go_repository(
        name = "in_gopkg_natefinch_lumberjack_v2",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/natefinch/lumberjack.v2",
        sum = "h1:bBRl1b0OH9s/DuPhuXpNl+VtCaJXFZ5/uEFST95x9zc=",
        version = "v2.2.1",
    )
    go_repository(
        name = "in_gopkg_ory_am_dockertest_v3",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/ory-am/dockertest.v3",
        sum = "h1:oen8RiwxVNxtQ1pRoV4e4jqh6UjNsOuIZ1NXns6jdcw=",
        version = "v3.3.4",
    )
    go_repository(
        name = "in_gopkg_resty_v1",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/resty.v1",
        sum = "h1:CuXP0Pjfw9rOuY6EP+UvtNvt5DSqHpIxILZKT/quCZI=",
        version = "v1.12.0",
    )

    go_repository(
        name = "in_gopkg_square_go_jose_v2",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/square/go-jose.v2",
        sum = "h1:NGk74WTnPKBNUhNzQX7PYcTLUjoq7mzKk2OKbvwk2iI=",
        version = "v2.6.0",
    )
    go_repository(
        name = "in_gopkg_src_d_go_billy_v4",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/src-d/go-billy.v4",
        sum = "h1:KtlZ4c1OWbIs4jCv5ZXrTqG8EQocr0g/d4DjNg70aek=",
        version = "v4.3.0",
    )

    go_repository(
        name = "in_gopkg_tomb_v1",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/tomb.v1",
        sum = "h1:uRGJdciOHaEIrze2W8Q3AKkepLTh2hOroT7a+7czfdQ=",
        version = "v1.0.0-20141024135613-dd632973f1e7",
    )

    go_repository(
        name = "in_gopkg_warnings_v0",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/warnings.v0",
        sum = "h1:XM28wIgFzaBmeZ5dNHIpWLQpt/9DGKxk+rCg/22nnYE=",
        version = "v0.1.1",
    )

    go_repository(
        name = "in_gopkg_yaml_v2",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/yaml.v2",
        sum = "h1:D8xgwECY7CYvx+Y2n4sBz93Jn9JRvxdiyyo8CTfuKaY=",
        version = "v2.4.0",
    )
    go_repository(
        name = "in_gopkg_yaml_v3",
        build_file_proto_mode = "disable_global",
        importpath = "gopkg.in/yaml.v3",
        sum = "h1:fxVm/GzAzEWqLHuvctI91KS9hhNmmWOoWu0XTYJS7CA=",
        version = "v3.0.1",
    )
    go_repository(
        name = "io_etcd_go_bbolt",
        build_file_proto_mode = "disable_global",
        importpath = "go.etcd.io/bbolt",
        sum = "h1:/ecaJf0sk1l4l6V4awd65v2C3ILy7MSj+s/x1ADCIMU=",
        version = "v1.3.6",
    )
    go_repository(
        name = "io_etcd_go_etcd",
        build_file_proto_mode = "disable_global",
        importpath = "go.etcd.io/etcd",
        sum = "h1:lWF4f9Nypl1ZqSb4gLeh/DGvBYVaUYHuiB93teOmwgc=",
        version = "v0.5.0-alpha.5.0.20191023171146-3cf2f69b5738",
    )

    go_repository(
        name = "io_etcd_go_etcd_api_v3",
        build_file_proto_mode = "disable_global",
        importpath = "go.etcd.io/etcd/api/v3",
        sum = "h1:4wSsluwyTbGGmyjJktOf3wFQoTBIURXHnq9n/G/JQHs=",
        version = "v3.5.9",
    )
    go_repository(
        name = "io_etcd_go_etcd_client_pkg_v3",
        build_file_proto_mode = "disable_global",
        importpath = "go.etcd.io/etcd/client/pkg/v3",
        sum = "h1:oidDC4+YEuSIQbsR94rY9gur91UPL6DnxDCIYd2IGsE=",
        version = "v3.5.9",
    )
    go_repository(
        name = "io_etcd_go_etcd_client_v2",
        build_file_proto_mode = "disable_global",
        importpath = "go.etcd.io/etcd/client/v2",
        sum = "h1:AELPkjNR3/igjbO7CjyF1fPuVPjrblliiKj+Y6xSGOU=",
        version = "v2.305.7",
    )
    go_repository(
        name = "io_etcd_go_etcd_client_v3",
        build_file_proto_mode = "disable_global",
        importpath = "go.etcd.io/etcd/client/v3",
        sum = "h1:r5xghnU7CwbUxD/fbUtRyJGaYNfDun8sp/gTr1hew6E=",
        version = "v3.5.9",
    )
    go_repository(
        name = "io_etcd_go_etcd_pkg_v3",
        build_file_proto_mode = "disable_global",
        importpath = "go.etcd.io/etcd/pkg/v3",
        sum = "h1:obOzeVwerFwZ9trMWapU/VjDcYUJb5OfgC1zqEGWO/0=",
        version = "v3.5.7",
    )
    go_repository(
        name = "io_etcd_go_etcd_raft_v3",
        build_file_proto_mode = "disable_global",
        importpath = "go.etcd.io/etcd/raft/v3",
        sum = "h1:aN79qxLmV3SvIq84aNTliYGmjwsW6NqJSnqmI1HLJKc=",
        version = "v3.5.7",
    )
    go_repository(
        name = "io_etcd_go_etcd_server_v3",
        build_file_proto_mode = "disable_global",
        importpath = "go.etcd.io/etcd/server/v3",
        sum = "h1:BTBD8IJUV7YFgsczZMHhMTS67XuA4KpRquL0MFOJGRk=",
        version = "v3.5.7",
    )

    go_repository(
        name = "io_k8s_api",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/api",
        replace = "k8s.io/api",
        sum = "h1:+H17AJpUMvl+clT+BPnKf0E3ksMAzoBBg7CntpSuADo=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_apiextensions_apiserver",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/apiextensions-apiserver",
        replace = "k8s.io/apiextensions-apiserver",
        sum = "h1:iwhyoeS4xj9Y7v8YExhUwbVuBhMr3Q4bd/laClBV6Bo=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_apimachinery",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/apimachinery",
        replace = "k8s.io/apimachinery",
        sum = "h1:vBjGaKKieaIreI+oQwELalVG4d8f3YAMNpWLzDXkxeg=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_apiserver",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/apiserver",
        replace = "k8s.io/apiserver",
        sum = "h1:p+tjwrcQEZDrEorCZV2/qE8osGTINPuS5ZNqWAvKm5E=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_cli_runtime",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/cli-runtime",
        replace = "k8s.io/cli-runtime",
        sum = "h1:9HI8gfReNujKXt16tGOAnb8b4NZ5E+e0mQQHKhFGwYw=",
        version = "v0.27.2",
    )

    go_repository(
        name = "io_k8s_client_go",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/client-go",
        replace = "k8s.io/client-go",
        sum = "h1:vDLSeuYvCHKeoQRhCXjxXO45nHVv2Ip4Fe0MfioMrhE=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_cloud_provider",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/cloud-provider",
        replace = "k8s.io/cloud-provider",
        sum = "h1:IiQWyFtdzcPOqvrBZE9FCt0CDCx3GUcZhKkykEgKlM4=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_cluster_bootstrap",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/cluster-bootstrap",
        replace = "k8s.io/cluster-bootstrap",
        sum = "h1:OL3onrOwrUD7NQxBUqQwTl1Uu2GQKCkw9BMHpc4PbiA=",
        version = "v0.27.2",
    )

    go_repository(
        name = "io_k8s_code_generator",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/code-generator",
        replace = "k8s.io/code-generator",
        sum = "h1:RmK0CnU5qRaK6WRtSyWNODmfTZNoJbrizpVcsgbtrvI=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_component_base",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/component-base",
        replace = "k8s.io/component-base",
        sum = "h1:neju+7s/r5O4x4/txeUONNTS9r1HsPbyoPBAtHsDCpo=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_component_helpers",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/component-helpers",
        replace = "k8s.io/component-helpers",
        sum = "h1:i9TgWJ6TH8lQ9x4ExHOwhVitrRpBOr7Wn8aZLbBWxkc=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_controller_manager",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/controller-manager",
        replace = "k8s.io/controller-manager",
        sum = "h1:S7984FVb5ajp8YqMQGAm8zXEUEl0Omw6FJlOiQU2Ne8=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_cri_api",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/cri-api",
        replace = "k8s.io/cri-api",
        sum = "h1:8o4LqKumNoBQ3eJCymIK/QR1gIt5IGptPaj4RSWBJO4=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_csi_translation_lib",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/csi-translation-lib",
        replace = "k8s.io/csi-translation-lib",
        sum = "h1:HbwiOk+M3jIkTC+e5nxUCwmux68OguKV/g9NaHDQhzs=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_dynamic_resource_allocation",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/dynamic-resource-allocation",
        replace = "k8s.io/dynamic-resource-allocation",
        sum = "h1:lNt4YOVoJqi+wcBesTVJ3KAfr3HnvLedO1/ZovE26pk=",
        version = "v0.27.2",
    )

    go_repository(
        name = "io_k8s_gengo",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/gengo",
        sum = "h1:U9tB195lKdzwqicbJvyJeOXV7Klv+wNAWENRnXEGi08=",
        version = "v0.0.0-20220902162205-c0856e24416d",
    )
    go_repository(
        name = "io_k8s_klog",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/klog",
        sum = "h1:Pt+yjF5aB1xDSVbau4VsWe+dQNzA0qv1LlXdC2dF6Q8=",
        version = "v1.0.0",
    )

    go_repository(
        name = "io_k8s_klog_v2",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/klog/v2",
        sum = "h1:7WCHKK6K8fNhTqfBhISHQ97KrnJNFZMcQvKp7gP/tmg=",
        version = "v2.100.1",
    )
    go_repository(
        name = "io_k8s_kms",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/kms",
        replace = "k8s.io/kms",
        sum = "h1:wCdmPCa3kubcVd3AssOeaVjLQSu45k5g/vruJ3iqwDU=",
        version = "v0.27.2",
    )

    go_repository(
        name = "io_k8s_kube_aggregator",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/kube-aggregator",
        replace = "k8s.io/kube-aggregator",
        sum = "h1:jfHoPip+qN/fn3OcrYs8/xMuVYvkJHKo0H0DYciqdns=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_kube_controller_manager",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/kube-controller-manager",
        replace = "k8s.io/kube-controller-manager",
        sum = "h1:+sPNPN0Fyhycd8iRwpV+zG3eL/uAlekWihgOAZxGZs0=",
        version = "v0.27.2",
    )

    go_repository(
        name = "io_k8s_kube_openapi",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/kube-openapi",
        sum = "h1:azYPdzztXxPSa8wb+hksEKayiz0o+PPisO/d+QhWnoo=",
        version = "v0.0.0-20230515203736-54b630e78af5",
    )
    go_repository(
        name = "io_k8s_kube_proxy",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/kube-proxy",
        replace = "k8s.io/kube-proxy",
        sum = "h1:nb/ASUpYoXlueURXnY+O2IZkCZmIYOnDprFEeiwwOCY=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_kube_scheduler",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/kube-scheduler",
        replace = "k8s.io/kube-scheduler",
        sum = "h1:ZsN8meIkmJ+wnFrvhi5YzIbueBeBz2xx4I/0cKgpnlg=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_kubectl",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/kubectl",
        replace = "k8s.io/kubectl",
        sum = "h1:sSBM2j94MHBFRWfHIWtEXWCicViQzZsb177rNsKBhZg=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_kubelet",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/kubelet",
        replace = "k8s.io/kubelet",
        sum = "h1:vpJnBkqQjxItEhehKG0toXoZ+G+tf4UXAOqtMJy6qgc=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_kubernetes",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/kubernetes",
        sum = "h1:g4v9oY6u7vBUDEuq4FvC50Bbw2K7GZuvM00IIESWVf4=",
        version = "v1.27.2",
    )
    go_repository(
        name = "io_k8s_legacy_cloud_providers",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/legacy-cloud-providers",
        replace = "k8s.io/legacy-cloud-providers",
        sum = "h1:4D56C4lm+Byu4z34f0sGBkMFlUWpPUqYjaawIrXaGZQ=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_metrics",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/metrics",
        replace = "k8s.io/metrics",
        sum = "h1:TD6z3dhhN9bgg5YkbTh72bPiC1BsxipBLPBWyC3VQAU=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_mount_utils",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/mount-utils",
        replace = "k8s.io/mount-utils",
        sum = "h1:fEqtBdAv88xpoPr3nR0MgYs6P+2PjXyUTwd4NmqSBjY=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_pod_security_admission",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/pod-security-admission",
        replace = "k8s.io/pod-security-admission",
        sum = "h1:dSGK0ftJwJNHSp5fMAwVuFIMMY1MlzW4k82mjar6G8I=",
        version = "v0.27.2",
    )
    go_repository(
        name = "io_k8s_sample_apiserver",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/sample-apiserver",
        replace = "k8s.io/sample-apiserver",
        sum = "h1:fF3AvtOh/D3HOoIIKC+PIkNHyZJP2uy8Wq/CXiOLXQw=",
        version = "v0.27.2",
    )

    go_repository(
        name = "io_k8s_sigs_apiserver_network_proxy_konnectivity_client",
        build_file_proto_mode = "disable_global",
        importpath = "sigs.k8s.io/apiserver-network-proxy/konnectivity-client",
        sum = "h1:I3qQxpzWFcsU7IV/MENc5x125HxRtchsNPtE6Pu+bBc=",
        version = "v0.1.3",
    )
    go_repository(
        name = "io_k8s_sigs_controller_runtime",
        build_file_proto_mode = "disable_global",
        importpath = "sigs.k8s.io/controller-runtime",
        sum = "h1:6xaWFqzT5KuAQ9ufgUaj1G/+C4Y1GRkhrxl+BJ9i+5s=",
        version = "v0.14.5",
    )

    go_repository(
        name = "io_k8s_sigs_json",
        build_file_proto_mode = "disable_global",
        importpath = "sigs.k8s.io/json",
        sum = "h1:EDPBXCAspyGV4jQlpZSudPeMmr1bNJefnuqLsRAsHZo=",
        version = "v0.0.0-20221116044647-bc3834ca7abd",
    )
    go_repository(
        name = "io_k8s_sigs_kustomize_api",
        build_file_proto_mode = "disable_global",
        importpath = "sigs.k8s.io/kustomize/api",
        sum = "h1:E38Hfx0G9R9v7vRgKshviPotJQETG0S2gD3JdHLCAsI=",
        version = "v0.13.4",
    )
    go_repository(
        name = "io_k8s_sigs_kustomize_cmd_config",
        build_file_proto_mode = "disable_global",
        importpath = "sigs.k8s.io/kustomize/cmd/config",
        sum = "h1:YyoHHbxxsLUts/gWLGgIQkdT82ekp3zautbpcml54vc=",
        version = "v0.11.2",
    )
    go_repository(
        name = "io_k8s_sigs_kustomize_kustomize_v5",
        build_file_proto_mode = "disable_global",
        importpath = "sigs.k8s.io/kustomize/kustomize/v5",
        sum = "h1:3krCsUOkGhECi/uP8eZ2e6nR9i/ht+5xIdXeg12Pso4=",
        version = "v5.0.3",
    )
    go_repository(
        name = "io_k8s_sigs_kustomize_kyaml",
        build_file_proto_mode = "disable_global",
        importpath = "sigs.k8s.io/kustomize/kyaml",
        sum = "h1:9WSwztbzwGszG1bZTziQUmVMrJccnyrLb5ZMKpJGvXw=",
        version = "v0.14.2",
    )

    go_repository(
        name = "io_k8s_sigs_structured_merge_diff_v4",
        build_file_proto_mode = "disable_global",
        importpath = "sigs.k8s.io/structured-merge-diff/v4",
        sum = "h1:PRbqxJClWWYMNV1dhaG4NsibJbArud9kFxnAMREiWFE=",
        version = "v4.2.3",
    )
    go_repository(
        name = "io_k8s_sigs_testing_frameworks",
        build_file_proto_mode = "disable_global",
        importpath = "sigs.k8s.io/testing_frameworks",
        sum = "h1:cP2l8fkA3O9vekpy5Ks8mmA0NW/F7yBdXf8brkWhVrs=",
        version = "v0.1.1",
    )

    go_repository(
        name = "io_k8s_sigs_yaml",
        build_file_proto_mode = "disable_global",
        importpath = "sigs.k8s.io/yaml",
        sum = "h1:a2VclLzOGrwOHDiV8EfBGhvjHvP46CtW5j6POvhYGGo=",
        version = "v1.3.0",
    )
    go_repository(
        name = "io_k8s_system_validators",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/system-validators",
        sum = "h1:tq05tdO9zdJZnNF3SXrq6LE7Knc/KfJm5wk68467JDg=",
        version = "v1.8.0",
    )

    go_repository(
        name = "io_k8s_utils",
        build_file_proto_mode = "disable_global",
        importpath = "k8s.io/utils",
        sum = "h1:EObNQ3TW2D+WptiYXlApGNLVy0zm/JIBVY9i+M4wpAU=",
        version = "v0.0.0-20230505201702-9f6742963106",
    )
    go_repository(
        name = "io_kubevirt_api",
        build_file_proto_mode = "disable_global",
        importpath = "kubevirt.io/api",
        sum = "h1:UDsJWklzd0x/w3EQjc48jafZc4p4vVxKUpmBhg2nVRk=",
        version = "v0.59.0",
    )
    go_repository(
        name = "io_kubevirt_containerized_data_importer_api",
        build_file_proto_mode = "disable_global",
        importpath = "kubevirt.io/containerized-data-importer-api",
        sum = "h1:IQNc8PYVq1cTwKNPEJza5xSlcnXeYVNt76M5kZ8X7xo=",
        version = "v1.55.0",
    )
    go_repository(
        name = "io_kubevirt_controller_lifecycle_operator_sdk_api",
        build_file_proto_mode = "disable_global",
        importpath = "kubevirt.io/controller-lifecycle-operator-sdk/api",
        sum = "h1:QMrd0nKP0BGbnxTqakhDZAUhGKxPiPiN5gSDqKUmGGc=",
        version = "v0.0.0-20220329064328-f3cc58c6ed90",
    )

    go_repository(
        name = "io_nhooyr_websocket",
        build_file_proto_mode = "disable_global",
        importpath = "nhooyr.io/websocket",
        sum = "h1:usjR2uOr/zjjkVMy0lW+PPohFok7PCow5sDjLgX4P4g=",
        version = "v1.8.7",
    )

    go_repository(
        name = "io_opencensus_go",
        build_file_proto_mode = "disable_global",
        importpath = "go.opencensus.io",
        sum = "h1:y73uSU6J157QMP2kn2r30vwW1A2W2WFwSCGnAVxeaD0=",
        version = "v0.24.0",
    )
    go_repository(
        name = "io_opentelemetry_go_contrib_instrumentation_github_com_emicklei_go_restful_otelrestful",
        build_file_proto_mode = "disable_global",
        importpath = "go.opentelemetry.io/contrib/instrumentation/github.com/emicklei/go-restful/otelrestful",
        sum = "h1:KQjX0qQ8H21oBUAvFp4ZLKJMMLIluONvSPDAFIGmX58=",
        version = "v0.35.0",
    )
    go_repository(
        name = "io_opentelemetry_go_contrib_instrumentation_google_golang_org_grpc_otelgrpc",
        build_file_proto_mode = "disable_global",
        importpath = "go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc",
        sum = "h1:ZOLJc06r4CB42laIXg/7udr0pbZyuAihN10A/XuiQRY=",
        version = "v0.42.0",
    )
    go_repository(
        name = "io_opentelemetry_go_contrib_instrumentation_net_http_otelhttp",
        build_file_proto_mode = "disable_global",
        importpath = "go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp",
        sum = "h1:pginetY7+onl4qN1vl0xW/V/v6OBZ0vVdH+esuJgvmM=",
        version = "v0.42.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel",
        build_file_proto_mode = "disable_global",
        importpath = "go.opentelemetry.io/otel",
        sum = "h1:Z7GVAX/UkAXPKsy94IU+i6thsQS4nb7LviLpnaNeW8s=",
        version = "v1.16.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_exporters_otlp_internal_retry",
        build_file_proto_mode = "disable_global",
        importpath = "go.opentelemetry.io/otel/exporters/otlp/internal/retry",
        sum = "h1:t4ZwRPU+emrcvM2e9DHd0Fsf0JTPVcbfa/BhTDF03d0=",
        version = "v1.16.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_exporters_otlp_otlptrace",
        build_file_proto_mode = "disable_global",
        importpath = "go.opentelemetry.io/otel/exporters/otlp/otlptrace",
        sum = "h1:cbsD4cUcviQGXdw8+bo5x2wazq10SKz8hEbtCRPcU78=",
        version = "v1.16.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_exporters_otlp_otlptrace_otlptracegrpc",
        build_file_proto_mode = "disable_global",
        importpath = "go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc",
        sum = "h1:TVQp/bboR4mhZSav+MdgXB8FaRho1RC8UwVn3T0vjVc=",
        version = "v1.16.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_exporters_otlp_otlptrace_otlptracehttp",
        build_file_proto_mode = "disable_global",
        importpath = "go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp",
        sum = "h1:3jAYbRHQAqzLjd9I4tzxwJ8Pk/N6AqBcF6m1ZHrxG94=",
        version = "v1.14.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_metric",
        build_file_proto_mode = "disable_global",
        importpath = "go.opentelemetry.io/otel/metric",
        sum = "h1:RbrpwVG1Hfv85LgnZ7+txXioPDoh6EdbZHo26Q3hqOo=",
        version = "v1.16.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_sdk",
        build_file_proto_mode = "disable_global",
        importpath = "go.opentelemetry.io/otel/sdk",
        sum = "h1:Z1Ok1YsijYL0CSJpHt4cS3wDDh7p572grzNrBMiMWgE=",
        version = "v1.16.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_trace",
        build_file_proto_mode = "disable_global",
        importpath = "go.opentelemetry.io/otel/trace",
        sum = "h1:8JRpaObFoW0pxuVPapkgH8UhHQj+bJW8jJsCZEu5MQs=",
        version = "v1.16.0",
    )
    go_repository(
        name = "io_opentelemetry_go_proto_otlp",
        build_file_proto_mode = "disable_global",
        importpath = "go.opentelemetry.io/proto/otlp",
        sum = "h1:IVN6GR+mhC4s5yfcTbmzHYODqvWAp3ZedA2SJPI1Nnw=",
        version = "v0.19.0",
    )

    go_repository(
        name = "io_rsc_binaryregexp",
        build_file_proto_mode = "disable_global",
        importpath = "rsc.io/binaryregexp",
        sum = "h1:HfqmD5MEmC0zvwBuF187nq9mdnXjXsSivRiXN7SmRkE=",
        version = "v0.2.0",
    )
    go_repository(
        name = "io_rsc_quote_v3",
        build_file_proto_mode = "disable_global",
        importpath = "rsc.io/quote/v3",
        sum = "h1:9JKUTTIUgS6kzR9mK1YuGKv6Nl+DijDNIc0ghT58FaY=",
        version = "v3.1.0",
    )
    go_repository(
        name = "io_rsc_sampler",
        build_file_proto_mode = "disable_global",
        importpath = "rsc.io/sampler",
        sum = "h1:7uVkIFmeBqHfdjD+gZwtXXI+RODJ2Wc4O7MPEh/QiW4=",
        version = "v1.3.0",
    )
    go_repository(
        name = "net_starlark_go",
        build_file_proto_mode = "disable_global",
        importpath = "go.starlark.net",
        sum = "h1:Ss6D3hLXTM0KobyBYEAygXzFfGcjnmfEJOBgSbemCtg=",
        version = "v0.0.0-20230302034142-4b1e35fe2254",
    )
    go_repository(
        name = "org_apache_git_thrift_git",
        build_file_proto_mode = "disable_global",
        importpath = "git.apache.org/thrift.git",
        sum = "h1:CMxsZlAmxKs+VAZMlDDL0wXciMblJcutQbEe3A9CYUM=",
        version = "v0.12.0",
    )

    go_repository(
        name = "org_bitbucket_bertimus9_systemstat",
        build_file_proto_mode = "disable_global",
        importpath = "bitbucket.org/bertimus9/systemstat",
        sum = "h1:n0aLnh2Jo4nBUBym9cE5PJDG8GT6g+4VuS2Ya2jYYpA=",
        version = "v0.5.0",
    )
    go_repository(
        name = "org_cloudfoundry_code_gofileutils",
        build_file_proto_mode = "disable_global",
        importpath = "code.cloudfoundry.org/gofileutils",
        sum = "h1:UrKzEwTgeiff9vxdrfdqxibzpWjxLnuXDI5m6z3GJAk=",
        version = "v0.0.0-20170111115228-4d0c80011a0f",
    )

    go_repository(
        name = "org_cuelang_go",
        build_file_proto_mode = "disable_global",
        importpath = "cuelang.org/go",
        sum = "h1:D6N0UgTGJCOxFKU8RU+qYvavKNsVc/+ZobmifStVJzU=",
        version = "v0.5.0",
    )
    go_repository(
        name = "org_golang_google_api",
        build_file_proto_mode = "disable_global",
        importpath = "google.golang.org/api",
        sum = "h1:1xQPji6cO2E2vLiI+C/XiFAnsn1WV3mjaEwGLhi3grE=",
        version = "v0.114.0",
    )
    go_repository(
        name = "org_golang_google_appengine",
        build_file_proto_mode = "disable_global",
        importpath = "google.golang.org/appengine",
        sum = "h1:FZR1q0exgwxzPzp/aF+VccGrSfxfPpkBqjIIEq3ru6c=",
        version = "v1.6.7",
    )
    go_repository(
        name = "org_golang_google_genproto",
        build_file_proto_mode = "disable_global",
        importpath = "google.golang.org/genproto",
        sum = "h1:KpwkzHKEF7B9Zxg18WzOa7djJ+Ha5DzthMyZYQfEn2A=",
        version = "v0.0.0-20230410155749-daa745c078e1",
    )
    go_repository(
        name = "org_golang_google_grpc",
        build_file_proto_mode = "disable_global",
        importpath = "google.golang.org/grpc",
        sum = "h1:3Oj82/tFSCeUrRTg/5E/7d/W5A1tj6Ky1ABAuZuv5ag=",
        version = "v1.55.0",
    )
    go_repository(
        name = "org_golang_google_grpc_cmd_protoc_gen_go_grpc",
        build_file_proto_mode = "disable_global",
        importpath = "google.golang.org/grpc/cmd/protoc-gen-go-grpc",
        sum = "h1:M1YKkFIboKNieVO5DLUEVzQfGwJD30Nv2jfUgzb5UcE=",
        version = "v1.1.0",
    )

    go_repository(
        name = "org_golang_google_protobuf",
        build_file_proto_mode = "disable_global",
        importpath = "google.golang.org/protobuf",
        sum = "h1:kPPoIgf3TsEvrm0PFe15JQ+570QVxYzEvvHqChK+cng=",
        version = "v1.30.0",
    )
    go_repository(
        name = "org_golang_x_arch",
        build_file_proto_mode = "disable_global",
        importpath = "golang.org/x/arch",
        sum = "h1:Vsc61gop4hfHdzQNolo6Fi/sw7TnJ2yl3ZR4i7bYirs=",
        version = "v0.0.0-20180920145803-b19384d3c130",
    )

    go_repository(
        name = "org_golang_x_crypto",
        build_file_proto_mode = "disable_global",
        importpath = "golang.org/x/crypto",
        sum = "h1:LF6fAI+IutBocDJ2OT0Q1g8plpYljMZ4+lty+dsqw3g=",
        version = "v0.9.0",
    )
    go_repository(
        name = "org_golang_x_exp",
        build_file_proto_mode = "disable_global",
        importpath = "golang.org/x/exp",
        sum = "h1:k/i9J1pBpvlfR+9QsetwPyERsqu1GIbi967PQMq3Ivc=",
        version = "v0.0.0-20230522175609-2e198f4a06a1",
    )
    go_repository(
        name = "org_golang_x_image",
        build_file_proto_mode = "disable_global",
        importpath = "golang.org/x/image",
        sum = "h1:+qEpEAPhDZ1o0x3tHzZTQDArnOixOzGD9HUJfcg0mb4=",
        version = "v0.0.0-20190802002840-cff245a6509b",
    )
    go_repository(
        name = "org_golang_x_lint",
        build_file_proto_mode = "disable_global",
        importpath = "golang.org/x/lint",
        sum = "h1:VLliZ0d+/avPrXXH+OakdXhpJuEoBZuwh1m2j7U6Iug=",
        version = "v0.0.0-20210508222113-6edffad5e616",
    )
    go_repository(
        name = "org_golang_x_mobile",
        build_file_proto_mode = "disable_global",
        importpath = "golang.org/x/mobile",
        sum = "h1:4+4C/Iv2U4fMZBiMCc98MG1In4gJY5YRhtpDNeDeHWs=",
        version = "v0.0.0-20190719004257-d2bd2a29d028",
    )
    go_repository(
        name = "org_golang_x_mod",
        build_file_proto_mode = "disable_global",
        importpath = "golang.org/x/mod",
        sum = "h1:lFO9qtOdlre5W1jxS3r/4szv2/6iXxScdzjoBMXNhYk=",
        version = "v0.10.0",
    )
    go_repository(
        name = "org_golang_x_net",
        build_file_proto_mode = "disable_global",
        importpath = "golang.org/x/net",
        sum = "h1:X2//UzNDwYmtCLn7To6G58Wr6f5ahEAQgKNzv9Y951M=",
        version = "v0.10.0",
    )
    go_repository(
        name = "org_golang_x_oauth2",
        build_file_proto_mode = "disable_global",
        importpath = "golang.org/x/oauth2",
        sum = "h1:6dkIjl3j3LtZ/O3sTgZTMsLKSftL/B8Zgq4huOIIUu8=",
        version = "v0.8.0",
    )
    go_repository(
        name = "org_golang_x_sync",
        build_file_proto_mode = "disable_global",
        importpath = "golang.org/x/sync",
        sum = "h1:PUR+T4wwASmuSTYdKjYHI5TD22Wy5ogLU5qZCOLxBrI=",
        version = "v0.2.0",
    )
    go_repository(
        name = "org_golang_x_sys",
        build_file_proto_mode = "disable_global",
        importpath = "golang.org/x/sys",
        sum = "h1:EBmGv8NaZBZTWvrbjNoL6HVt+IVy3QDQpJs7VRIw3tU=",
        version = "v0.8.0",
    )
    go_repository(
        name = "org_golang_x_term",
        build_file_proto_mode = "disable_global",
        importpath = "golang.org/x/term",
        sum = "h1:n5xxQn2i3PC0yLAbjTpNT85q/Kgzcr2gIoX9OrJUols=",
        version = "v0.8.0",
    )
    go_repository(
        name = "org_golang_x_text",
        build_file_proto_mode = "disable_global",
        importpath = "golang.org/x/text",
        sum = "h1:2sjJmO8cDvYveuX97RDLsxlyUxLl+GHoLxBiRdHllBE=",
        version = "v0.9.0",
    )
    go_repository(
        name = "org_golang_x_time",
        build_file_proto_mode = "disable_global",
        importpath = "golang.org/x/time",
        sum = "h1:rg5rLMjNzMS1RkNLzCG38eapWhnYLFYXDXj2gOlr8j4=",
        version = "v0.3.0",
    )
    go_repository(
        name = "org_golang_x_tools",
        build_file_proto_mode = "disable_global",
        importpath = "golang.org/x/tools",
        sum = "h1:8WMNJAz3zrtPmnYC7ISf5dEn3MT0gY7jBJfw27yrrLo=",
        version = "v0.9.1",
    )
    go_repository(
        name = "org_golang_x_xerrors",
        build_file_proto_mode = "disable_global",
        importpath = "golang.org/x/xerrors",
        sum = "h1:H2TDz8ibqkAF6YGhCdN3jS9O0/s90v0rJh3X/OLHEUk=",
        version = "v0.0.0-20220907171357-04be3eba64a2",
    )
    go_repository(
        name = "org_mongodb_go_atlas",
        build_file_proto_mode = "disable_global",
        importpath = "go.mongodb.org/atlas",
        sum = "h1:YyOBdBIuI//krRITf4r7PSirJ3YDNNUfNmapxwSyDow=",
        version = "v0.15.0",
    )

    go_repository(
        name = "org_mongodb_go_mongo_driver",
        build_file_proto_mode = "disable_global",
        importpath = "go.mongodb.org/mongo-driver",
        sum = "h1:Ql6K6qYHEzB6xvu4+AU0BoRoqf9vFPcc4o7MUIdPW8Y=",
        version = "v1.11.3",
    )

    go_repository(
        name = "org_uber_go_atomic",
        build_file_proto_mode = "disable_global",
        importpath = "go.uber.org/atomic",
        sum = "h1:ZvwS0R+56ePWxUNi+Atn9dWONBPp/AUETXlHW0DxSjE=",
        version = "v1.11.0",
    )
    go_repository(
        name = "org_uber_go_automaxprocs",
        build_file_proto_mode = "disable_global",
        importpath = "go.uber.org/automaxprocs",
        sum = "h1:2LxUOGiR3O6tw8ui5sZa2LAaHnsviZdVOUZw4fvbnME=",
        version = "v1.5.2",
    )
    go_repository(
        name = "org_uber_go_goleak",
        build_file_proto_mode = "disable_global",
        importpath = "go.uber.org/goleak",
        sum = "h1:NBol2c7O1ZokfZ0LEU9K6Whx/KnwvepVetCUhtKja4A=",
        version = "v1.2.1",
    )

    go_repository(
        name = "org_uber_go_multierr",
        build_file_proto_mode = "disable_global",
        importpath = "go.uber.org/multierr",
        sum = "h1:blXXJkSxSSfBVBlC76pxqeO+LN3aDfLQo+309xJstO0=",
        version = "v1.11.0",
    )
    go_repository(
        name = "org_uber_go_zap",
        build_file_proto_mode = "disable_global",
        importpath = "go.uber.org/zap",
        sum = "h1:FiJd5l1UOLj0wCgbSE0rwwXHzEdAZS6hiiSnxJN/D60=",
        version = "v1.24.0",
    )
    go_repository(
        name = "tools_gotest",
        build_file_proto_mode = "disable_global",
        importpath = "gotest.tools",
        sum = "h1:VsBPFP1AI068pPrMxtb/S8Zkgf9xEmTLJjfM+P5UIEo=",
        version = "v2.2.0+incompatible",
    )

    go_repository(
        name = "tools_gotest_v3",
        build_file_proto_mode = "disable_global",
        importpath = "gotest.tools/v3",
        sum = "h1:4AuOwCGf4lLR9u3YOe2awrHygurzhO/HeQ6laiA6Sx0=",
        version = "v3.0.3",
    )
    go_repository(
        name = "xyz_gomodules_jsonpatch_v2",
        build_file_proto_mode = "disable_global",
        importpath = "gomodules.xyz/jsonpatch/v2",
        sum = "h1:4pT439QV83L+G9FkcCriY6EkpcK6r6bK+A5FBUMI7qY=",
        version = "v2.2.0",
    )

    manual_go_dependencies()

def manual_go_dependencies():
    go_repository(
        name = "com_github_google_go_containerregistry",
        importpath = "github.com/google/go-containerregistry",
        urls = ["https://github.com/google/go-containerregistry/archive/refs/tags/v0.5.1.tar.gz"],
        strip_prefix = "go-containerregistry-0.5.1",
        sha256 = "c3e28d8820056e7cc870dbb5f18b4f7f7cbd4e1b14633a6317cef895fdb35203",
    )
