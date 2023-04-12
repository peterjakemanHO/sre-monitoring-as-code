// See contributing.md for further details.
{
  gitlab_prometheus_http_request_duration_seconds: {
    metricTypeConfig: {
      selectorLabels: {
        environment: 'namespace',
        product: 'job',
        resource: 'handler',
      },
      metrics: {
        sum: 'prometheus_http_request_duration_seconds_sum',
        count: 'prometheus_http_request_duration_seconds_count',
        bucket: 'prometheus_http_request_duration_seconds_bucket',
      },
    },
    sliTypesConfig: {
      latency: {
        library: (import '../src/sli-value-libraries/histogram-quantile-latency.libsonnet'),
        description: 'Request latency for %(sliDescription)s should be below %(metricTarget)0.1fs for the %(latencyPercentile)0.0fth percentile',
        targetMetrics: {
          bucket: 'bucket',
          sum: 'sum',
          count: 'count',
        },
      },
      },
    detailDashboardConfig: {
      standardTemplates: ['resource'],
      elements: ['httpRequestsLatency'],
      targetMetrics: {
        requestCount: 'count',
        requestBucket: 'bucket',
      },
    },
},
}
// docker run --mount type=bind,source="$PWD"/mixin-defs,target=/input --mount type=bind,source="$PWD"/output,target=/output -it sre-monitoring-as-code:latest -m "gitlab" -rd -i input -o output
