#!/usr/bin/env bash
# Repository bootstrap for the mariadb-operator Cloud Agent environment.
# Runs after the source tree is checked out. Idempotent: safe to re-run.
set -euo pipefail

cd "$(dirname "$0")/.."

# Warm the Go module cache.
go mod download

# Fetch the pinned development tooling into ./bin (kind, kubectl, helm,
# kustomize, controller-gen, setup-envtest, ginkgo, golangci-lint). These
# targets are no-ops when the binary is already present.
make kind kubectl kustomize helm controller-gen envtest ginkgo golangci-lint

# Pre-build the operator binary so the first `make build`/`make run` is fast.
make build
