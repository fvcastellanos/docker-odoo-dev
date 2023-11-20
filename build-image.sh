#!/bin/bash

# This script is used to build the image for the application.

# Exit on error
set -e

# Build the image
docker build -f docker/Dockerfile -t odoo-dev:17 .

# Create odoo volume
docker volume create odoo-data

# Exit successfully
exit 0

