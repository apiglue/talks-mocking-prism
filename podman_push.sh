#! /bin/zsh

# Exit on error, undefined variables, and pipe failures
set -euo pipefail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print error messages
error() {
    echo "${RED}ERROR: $1${NC}" >&2
}

# Function to print success messages
success() {
    echo "${GREEN}SUCCESS: $1${NC}"
}

# Function to print info messages
info() {
    echo "${YELLOW}INFO: $1${NC}"
}

# Trap errors and cleanup
trap 'error "Script failed at line $LINENO"' ERR

# Variables
IMAGE_NAME="talks-prism-mock-contacts-api"
TAG="latest"
REGISTRY="docker.io/marcelo10"
FULL_IMAGE_NAME="${REGISTRY}/${IMAGE_NAME}:${TAG}"
OPENAPI_URL="https://raw.githubusercontent.com/apiglue/openapi-specs/refs/heads/main/contacts-api.json"

# Check if podman is installed
if ! command -v podman &> /dev/null; then
    error "podman is not installed. Please install podman first."
    exit 1
fi

# Build the image
info "Building image ${IMAGE_NAME}:${TAG} for linux/amd64..."
if podman build --platform linux/amd64 --build-arg OPENAPI_URL="${OPENAPI_URL}" -t "${IMAGE_NAME}:${TAG}" .; then
    success "Image built successfully"
else
    error "Failed to build image"
    exit 1
fi

# Tag the image
info "Tagging image as ${FULL_IMAGE_NAME}..."
if podman tag "${IMAGE_NAME}:${TAG}" "${FULL_IMAGE_NAME}"; then
    success "Image tagged successfully"
else
    error "Failed to tag image"
    exit 1
fi

# Push the image
info "Pushing image to ${FULL_IMAGE_NAME}..."
if podman push "${FULL_IMAGE_NAME}"; then
    success "Image pushed successfully to registry"
else
    error "Failed to push image. Make sure you're logged in to the registry with 'podman login ${REGISTRY}'"
    exit 1
fi

success "All operations completed successfully!"