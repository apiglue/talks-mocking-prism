#!/bin/zsh
podman build --build-arg OPENAPI_URL=https://raw.githubusercontent.com/apiglue/openapi-specs/refs/heads/main/contacts-api.json -t talks-prism-mock-contacts-api:latest .