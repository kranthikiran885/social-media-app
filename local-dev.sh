#!/bin/bash

set -e

# Local development script

print_status() {
    echo "[*] $1"
}

print_success() {
    echo "[✓] $1"
}

print_error() {
    echo "[✗] $1"
}

print_status "Starting development environment..."

# Build and start services
docker-compose -f docker-compose.yml up -d

print_success "Development services started!"
echo ""
echo "Services running at:"
echo "  Frontend: http://localhost:3000"
echo "  API Gateway: http://localhost:8000"
echo "  MongoDB: localhost:27017"
echo "  Redis: localhost:6379"
echo ""
echo "View logs with: docker-compose logs -f"
echo "Stop services with: docker-compose down"

