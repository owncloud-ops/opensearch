# opensearch

[![Build Status](https://drone.owncloud.com/api/badges/owncloud-ops/opensearch/status.svg)](https://drone.owncloud.com/owncloud-ops/opensearch/)
[![Docker Hub](https://img.shields.io/badge/docker-latest-blue.svg?logo=docker&logoColor=white)](https://hub.docker.com/r/owncloudops/opensearch)

Custom container image for [OpenSearch](https://github.com/elastic/opensearch/).

## Ports

- 9200
- 9300

## Volumes

- /usr/share/opensearch/data
- /usr/share/opensearch/backup
- /usr/share/opensearch/log

## Bundled Plugins

- repository-s3
- ingest-attachment

## Environment Variables

```Shell
OPENSEARCH_CLUSTER_NAME=opensearch
OPENSEARCH_CLUSTER_MODE=false
# Enable this setting only to bootstrap a new cluster **not** for existing clusters.
OPENSEARCH_CLUSTER_INIT=false
# Comma-separated list
OPENSEARCH_INITIAL_MASTER_NODES=elastic-node1
OPENSEARCH_NODE_NAME=elastic-node1
OPENSEARCH_NODE_MASTER=true
OPENSEARCH_NODE_DATA=true
OPENSEARCH_NODE_INGEST=true
# Comma-separated list
OPENSEARCH_DISCOVERY_SEED_HOSTS=elastic-node1
OPENSEARCH_NETWORK_HOST=0.0.0.0
OPENSEARCH_NETWORK_PUBLISH_HOST=
OPENSEARCH_BOOTSTRAP_MEMORY_LOCK=true
OPENSEARCH_HTTP_PORT=9200
OPENSEARCH_HTTP_COMPRESSION=true

OPENSEARCH_PLUGINS_SECURITY_ENABLED=false
# If you enable securoty on a production mode cluster, transport ssl is mandatory
# and need to be configured.
OPENSEARCH_PLUGINS_SECURITY_SSL_TRANSPORT_ENABLED=false
OPENSEARCH_PLUGINS_SECURITY_SSL_TRANSPORT_KEY=node-key.pem
OPENSEARCH_PLUGINS_SECURITY_SSL_TRANSPORT_CERTIFICATE=node.pem
OPENSEARCH_PLUGINS_SECURITY_SSL_TRANSPORT_CERTIFICATE_AUTHORITIES=
OPENSEARCH_PLUGINS_SECURITY_HTTP_SSL_ENABLED=false
OPENSEARCH_PLUGINS_SECURITY_HTTP_SSL_KEY=node-key.pem
OPENSEARCH_PLUGINS_SECURITY_HTTP_SSL_CERTIFICATE=node.pem
OPENSEARCH_PLUGINS_SECURITY_HTTP_SSL_CERTIFICATE_AUTHORITIES=

OPENSEARCH_ROOT_LOG_LEVEL=info
OPENSEARCH_JVM_HEAP_SIZE=512m

OPENSEARCH_S3_CLIENT_DEFAULT_ACCESS_KEY=
OPENSEARCH_S3_CLIENT_DEFAULT_SECRET_KEY=

# Space-separated list of extra options to set for the Java JVM.
# Example: OPENSEARCH_JVM_EXTRA_OPTS=-Djava.option1=foo -Djava.option2=bar
OPENSEARCH_JVM_EXTRA_OPTS=
```

## Build

```Shell
docker build -f Dockerfile -t opensearch:latest .
```

## License

This project is licensed under the Apache 2.0 License - see the [LICENSE](https://github.com/owncloud-ops/opensearch/blob/main/LICENSE) file for details.
