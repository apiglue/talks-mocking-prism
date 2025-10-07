# Use the official Node.js Alpine image for a minimal base
FROM node:22-alpine

# Set the working directory inside the container
WORKDIR /app

# Install wget for downloading files (curl is an alternative)
RUN apk add --no-cache wget

# Install Prism CLI globally
RUN npm install -g @stoplight/prism-cli

# Define a build argument for the OpenAPI spec URL with a default value
ARG OPENAPI_URL=https://petstore3.swagger.io/api/v3/openapi.json

# Download the OpenAPI specification from GitHub
RUN wget -O /app/openapi.json ${OPENAPI_URL}

# Expose the default Prism port
EXPOSE 4010

# Set the default command to run Prism
CMD ["prism", "mock", "-h", "0.0.0.0", "/app/openapi.json"]