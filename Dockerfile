FROM opensearchproject/opensearch:2.6.0@sha256:40f5bb40a543f7ea6458bc0ecffc7679c9df6f8836a9e3781a78829d587ef552

LABEL maintainer="ownCloud GmbH"
LABEL org.opencontainers.image.authors="ownCloud GmbH"
LABEL org.opencontainers.image.title="OpenSearch"
LABEL org.opencontainers.image.url="https://github.com/owncloud-ops/opensearch"
LABEL org.opencontainers.image.source="https://github.com/owncloud-ops/opensearch"
LABEL org.opencontainers.image.documentation="https://github.com/owncloud-ops/opensearch"

ARG GOMPLATE_VERSION
ARG CONTAINER_LIBRARY_VERSION
ARG OPENSEARCH_PLUGINS

# renovate: datasource=github-releases depName=hairyhenderson/gomplate
ENV GOMPLATE_VERSION="${GOMPLATE_VERSION:-v3.11.4}"
# renovate: datasource=github-releases depName=owncloud-ops/container-library
ENV CONTAINER_LIBRARY_VERSION="${CONTAINER_LIBRARY_VERSION:-v0.1.0}"

ADD overlay/ /

USER 0

RUN yum install -y wget curl && \
    curl -SsfL -o /usr/local/bin/gomplate "https://github.com/hairyhenderson/gomplate/releases/download/${GOMPLATE_VERSION}/gomplate_linux-amd64" && \
    curl -SsfL "https://github.com/owncloud-ops/container-library/releases/download/${CONTAINER_LIBRARY_VERSION}/container-library.tar.gz" | tar xz -C / && \
    chmod 755 /usr/local/bin/gomplate && \
    mkdir -p /usr/share/opensearch/backup && \
    chown -R opensearch:root /usr/share/opensearch/backup && \
    chmod 755 /usr/share/opensearch/backup && \
    chown -R opensearch:root /usr/share/opensearch/config && \
    chmod 750 /usr/share/opensearch/config && \
    ln -s /etc/ssl/certs/ca-bundle.trust.crt /usr/share/opensearch/config/ca-bundle.trust.crt && \
    for PLUGIN in ${OPENSEARCH_PLUGINS}; do /usr/share/opensearch/bin/opensearch-plugin install -s -b "${PLUGIN}" || exit 1; done && \
    yum clean all && \
    rm -rf /tmp/*

USER 1000

WORKDIR /usr/share/opensearch
ENTRYPOINT ["/usr/bin/entrypoint"]
HEALTHCHECK --interval=15s --timeout=5s --retries=5 CMD /usr/bin/healthcheck
CMD []
