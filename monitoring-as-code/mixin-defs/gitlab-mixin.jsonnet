// Jsonnet file to define SLIs and associated SLOs to allow automtic generation of monitoring configuration
// Configured using mixin format, so exports a grafanaDashboards: object to be consumed by eg Grizzly

// Import Health Config generator framework
local mixinFunctions = import '../src/lib/mixin-functions.libsonnet';

// Define product name and technow details
local config = {
  product: 'monitoring',
  applicationServiceName: 'Monitoring and Logging Components',
  servicenowAssignmentGroup: 'HO_PLATFORM',
  // Alerts set to test only - remove/adjust once ready for alerts for production
  maxAlertSeverity: 'P1',
  configurationItem: 'Gitlab-ce',
  alertingSlackChannel: 'sas-monitoring-test',
  grafanaUrl: 'http://localhost:3000',
  alertmanagerUrl: 'http://localhost:9093',
};

local sliSpecList = {
  gitlab: {
    SLI01: {
      title: 'gitlab',
      sliDescription: 'Requests through gitlab-ce',
      period: '7d',
      metricType: 'gitlab_prometheus_http_request_duration_seconds',
      evalInterval: '1m',
      selectors: {
        product: 'gitlab',
        resource: '/.*',
        errorStatus: '4..|5..',
      },
      sloTarget: 90,
      sliTypes: {
        availability: {
          intervalTarget: 90,
        },
        latency: {
          histogramSecondsTarget: 15,
          percentile: 90,
        },
      },
    },
    },
  };


// Run generator to create dashboards, prometheus rules
mixinFunctions.buildMixin(config, sliSpecList)
