#!/bin/bash

# Exit on error
set -e

docker compose -f docker/docker-compose.yml down

# Exit successfully
exit 0

