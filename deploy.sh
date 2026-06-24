#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
COMPOSE_FILE="docker-compose.production.yml"
ENV_FILE=".env.production"

# Functions
print_banner() {
    echo -e "${BLUE}"
    cat << 'BANNER'
    ╔═══════════════════════════════════════════════════════════╗
    ║   Smart Social Media Platform - Docker Deployment         ║
    ║   Production-Ready Infrastructure Setup                   ║
    ╚═══════════════════════════════════════════════════════════╝
BANNER
    echo -e "${NC}"
}

print_status() {
    echo -e "${BLUE}[*]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

check_docker() {
    print_status "Checking Docker installation..."
    
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    if ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
    
    DOCKER_VERSION=$(docker --version)
    COMPOSE_VERSION=$(docker-compose --version)
    
    print_success "Docker: $DOCKER_VERSION"
    print_success "Docker Compose: $COMPOSE_VERSION"
}

check_env_file() {
    print_status "Checking environment file..."
    
    if [ ! -f "$ENV_FILE" ]; then
        print_warning "Environment file not found. Creating from template..."
        if [ ! -f ".env.production" ]; then
            print_error "No environment template found. Exiting."
            exit 1
        fi
        cp .env.production "$ENV_FILE"
        print_warning "Created $ENV_FILE. Please edit and set your variables before deploying."
        exit 0
    fi
    
    # Check for critical variables
    CRITICAL_VARS=("JWT_SECRET" "MONGO_PASSWORD" "REDIS_PASSWORD")
    for var in "${CRITICAL_VARS[@]}"; do
        if ! grep -q "^$var=" "$ENV_FILE"; then
            print_error "Missing critical variable: $var"
            exit 1
        fi
    done
    
    print_success "Environment file validated"
}

build_images() {
    print_status "Building Docker images..."
    
    docker-compose -f "$COMPOSE_FILE" build --no-cache
    
    if [ $? -eq 0 ]; then
        print_success "Docker images built successfully"
    else
        print_error "Failed to build Docker images"
        exit 1
    fi
}

start_services() {
    print_status "Starting all services..."
    
    docker-compose -f "$COMPOSE_FILE" up -d
    
    if [ $? -eq 0 ]; then
        print_success "All services started"
    else
        print_error "Failed to start services"
        exit 1
    fi
}

wait_for_health() {
    print_status "Waiting for services to become healthy..."
    
    local max_attempts=30
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        HEALTHY=$(docker-compose -f "$COMPOSE_FILE" ps --services --filter "health=healthy" | wc -l)
        TOTAL=$(docker-compose -f "$COMPOSE_FILE" ps --services | wc -l)
        
        echo -ne "\r${BLUE}[*]${NC} Service health check: $HEALTHY/$TOTAL healthy (attempt $attempt/$max_attempts)"
        
        if [ "$HEALTHY" -eq "$TOTAL" ]; then
            echo ""
            print_success "All services are healthy"
            return 0
        fi
        
        sleep 2
        ((attempt++))
    done
    
    echo ""
    print_warning "Some services may still be initializing. Check logs with: docker-compose logs"
}

show_endpoints() {
    print_status "Services are running. Access them at:"
    echo ""
    echo -e "${GREEN}Frontend${NC}"
    echo "  HTTP: http://localhost"
    echo ""
    echo -e "${GREEN}API Gateway${NC}"
    echo "  HTTP: http://localhost:8000"
    echo "  Health: http://localhost:8000/health"
    echo ""
    echo -e "${GREEN}Monitoring${NC}"
    echo "  Grafana: http://localhost:3000"
    echo "  Prometheus: http://localhost:9090"
    echo "  RabbitMQ: http://localhost:15672"
    echo ""
    echo -e "${GREEN}Databases${NC}"
    echo "  MongoDB: mongodb://localhost:27017"
    echo "  PostgreSQL: postgresql://localhost:5432"
    echo "  Redis: redis://localhost:6379"
    echo "  Elasticsearch: http://localhost:9200"
    echo ""
    echo -e "${GREEN}Microservices${NC}"
    echo "  Auth: http://localhost:3001/health"
    echo "  Content: http://localhost:3003/health"
    echo "  Feed: http://localhost:3004/health"
    echo "  Chat: http://localhost:3002/health"
    echo "  Search: http://localhost:3006/health"
    echo ""
}

show_logs() {
    echo ""
    print_status "To view logs:"
    echo "  All services: docker-compose logs -f"
    echo "  Specific service: docker-compose logs -f auth-service"
    echo ""
}

cleanup() {
    print_status "Stopping all services..."
    docker-compose -f "$COMPOSE_FILE" down
    print_success "Services stopped"
}

# Main deployment flow
main() {
    print_banner
    
    case "${1:-deploy}" in
        deploy)
            check_docker
            check_env_file
            build_images
            start_services
            wait_for_health
            show_endpoints
            show_logs
            print_success "Deployment completed successfully!"
            ;;
        stop)
            cleanup
            ;;
        restart)
            cleanup
            sleep 2
            check_docker
            start_services
            wait_for_health
            show_endpoints
            ;;
        logs)
            docker-compose -f "$COMPOSE_FILE" logs -f
            ;;
        status)
            docker-compose -f "$COMPOSE_FILE" ps
            ;;
        *)
            echo "Usage: $0 {deploy|stop|restart|logs|status}"
            echo ""
            echo "Commands:"
            echo "  deploy   - Full deployment (default)"
            echo "  stop     - Stop all services"
            echo "  restart  - Restart all services"
            echo "  logs     - View live logs"
            echo "  status   - Show service status"
            exit 1
            ;;
    esac
}

main "$@"
