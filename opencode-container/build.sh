#!/usr/bin/env bash

set -e

ENGINE=$(which podman 2>/dev/null || which docker 2>/dev/null)

$ENGINE build -t opencode .
