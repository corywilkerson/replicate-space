FROM mcr.microsoft.com/devcontainers/python:3.10

# Install Go (official tarball, latest stable)
ENV GO_VERSION=1.22.3
RUN curl -LO https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz \
    && rm go${GO_VERSION}.linux-amd64.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}" 