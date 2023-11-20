#!/bin/bash

# Exit on error
set -e

docker compose -f docker/docker-compose.yml up -d

# Exit successfully
exit 0

