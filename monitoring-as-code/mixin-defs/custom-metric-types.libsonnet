// See contributing.md for further details.
{
  gitlab_prometheus_http_request_duration_seconds: {
    metricTypeConfig: {
      selectorLabels: {
        environment: 'namespace',
        product: 'job',
        resource: 'handler',
        errorStatus: 'code',
      },
      metrics: {
        sum: 'prometheus_http_request_duration_seconds_sum',
        count: 'prometheus_http_requests_total',
        bucket: 'prometheus_http_request_duration_seconds_bucket',
      },
    },
    sliTypesConfig: {
      availability: {
        library: (import 'sli-value-libraries/proportion-of-errors-using-label.libsonnet'),
        description: 'Error rate for %(sliDescription)s should be below %(metric_target_percent)0.1f%%',
        targetMetrics: {
          target: 'count',
        },
      },
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
      standardTemplates: [],
      elements: [],
      targetMetrics: {
      },
    },
},
}
// docker run --mount type=bind,source="$PWD"/mixin-defs,target=/input --mount type=bind,source="$PWD"/output,target=/output -it sre-monitoring-as-code:latest -m "gitlab" -rd -i input -o output
