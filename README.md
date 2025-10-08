# Talks: Mocking with Prism

A containerized API mocking solution using [Stoplight Prism](https://stoplight.io/open-source/prism) to generate mock servers from OpenAPI specifications.

## Overview

This project provides a Docker-based setup for running API mock servers using Prism. It can download and mock any OpenAPI specification, making it useful for development, testing, and API demonstrations.

## Features

- **Containerized Setup**: Run mock servers in isolated Docker containers
- **Flexible OpenAPI Sources**: Support for remote URLs or local OpenAPI specifications
- **Built on Alpine Linux**: Lightweight Node.js Alpine base image for minimal footprint
- **Configurable**: Customizable OpenAPI specification URL via build arguments
- **Development Ready**: Exposed on standard port 4010 for easy integration

## Quick Start

### Prerequisites

- Docker or Podman installed on your system
- Network access to download OpenAPI specifications (for remote URLs)

### Building the Container

Build the Docker image with the default OpenAPI specification (Swagger Petstore):

```bash
docker build -t prism-mock .
```

Or build with a custom OpenAPI specification URL:

```bash
docker build --build-arg OPENAPI_URL=https://your-api.com/openapi.json -t prism-mock .
```

### Running the Mock Server

Run the container and expose the mock server on port 4010:

```bash
docker run -p 4010:4010 prism-mock
```

The mock server will be available at `http://localhost:4010`

## Configuration

### OpenAPI Specification URL

The Docker image accepts an `OPENAPI_URL` build argument to specify which OpenAPI specification to mock:

- **Default**: `https://petstore3.swagger.io/api/v3/openapi.json` (Swagger Petstore v3)
- **Custom**: Any publicly accessible OpenAPI specification URL

Example with custom specification:

```bash
docker build --build-arg OPENAPI_URL=https://api.github.com/openapi.yaml -t github-mock .
```

### Port Configuration

The mock server runs on port 4010 by default. You can map it to a different host port:

```bash
docker run -p 8080:4010 prism-mock
```

## Using the Mock Server

Once running, the mock server will provide:

- **Mock endpoints** based on your OpenAPI specification
- **Request validation** according to the schema
- **Example responses** generated from the specification
- **Interactive documentation** (if available in the spec)

### Example API Calls

With the default Petstore specification:

```bash
# Get all pets
curl http://localhost:4010/pet

# Get a specific pet
curl http://localhost:4010/pet/1

# Add a new pet
curl -X POST http://localhost:4010/pet \
  -H "Content-Type: application/json" \
  -d '{"name": "doggie", "status": "available"}'
```

## Development

This project is designed for educational purposes and API development workflows. It demonstrates how to:

- Containerize API mocking tools
- Work with OpenAPI specifications
- Set up development environments with mock services
- Use Prism for API contract testing

## About Prism

[Stoplight Prism](https://stoplight.io/open-source/prism) is a set of packages for API mocking, contract testing, and validation. It can create mock servers from OpenAPI specifications, validate requests and responses, and help with API development workflows.

## License

This project is intended for educational and development purposes. Please refer to individual tool licenses for production use.