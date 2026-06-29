#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<EOF
Usage: $0 [options]

Options:
  -b, --rebuild        Force rebuild the image
  -i, --image IMAGE    Image name (default: opencode:latest)
  -n, --name NAME      Container name (default: opencode)
  -h, --help           Show this help
EOF
}

# detect engine (podman preferred if present)
ENGINE=$(command -v podman || command -v docker || true)
if [[ -z "$ENGINE" ]]; then
  echo "Error: neither podman nor docker found in PATH" >&2
  exit 1
fi

# defaults
IMAGE="opencode:latest"
CONTAINER_NAME="opencode"
FORCE_BUILD=0
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
  -b | --rebuild)
    FORCE_BUILD=1
    shift
    ;;
  -i | --image)
    IMAGE="$2"
    shift 2
    ;;
  -n | --name)
    CONTAINER_NAME="$2"
    shift 2
    ;;
  -h | --help)
    usage
    exit 0
    ;;
  *)
    echo "Unknown option: $1" >&2
    usage
    exit 2
    ;;
  esac
done

image_exists() {
  # image inspect returns 0 if image exists
  "$ENGINE" image inspect "$1" >/dev/null 2>&1
}

if [[ $FORCE_BUILD -eq 1 ]]; then
  echo "Forcing rebuild of $IMAGE"
  BUILD=1
elif image_exists "$IMAGE"; then
  echo "Image $IMAGE found locally."
  BUILD=0
else
  echo "Image $IMAGE not found. Will build."
  BUILD=1
fi

if [[ $BUILD -eq 1 ]]; then
  echo "Building image: $IMAGE (context: $SCRIPT_DIR)"
  "$ENGINE" build -t "$IMAGE" "$SCRIPT_DIR"
fi

# run container
RUN_OPTS=(--name "$CONTAINER_NAME"
  -v "$HOME/.local/state/opencode:/home/opencode/.local/state/opencode"
  -v "$HOME/.local/share/opencode:/home/opencode/.local/share/opencode"
  -v "$PWD:/workspace"
  -w "/workspace")

echo "Starting container $CONTAINER_NAME"
exec "$ENGINE" run -it --rm "${RUN_OPTS[@]}" "$IMAGE"
