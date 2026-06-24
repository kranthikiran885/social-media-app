# Complete Docker Infrastructure Setup Guide

## Overview

This document provides a comprehensive guide for setting up the entire Smart Social Media Platform using Docker and Docker Compose.

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                       LOAD BALANCER (Nginx)                    │
│                          Port: 80/443                          │
└────────────────────────────┬──────────────────────────────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
        ▼                    ▼                    ▼
   ┌─────────┐          ┌─────────┐         ┌──────────┐
   │Frontend │          │  API    │         │Monitoring│
   │ (Nginx) │          │Gateway  │         │ (Grafana)│
   │Port:80  │          │Port:8000│         │Port:3000 │
   └─────────┘          └────┬────┘         └──────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
        ▼                    ▼                    ▼
   MICROSERVICES        DATABASES         MESSAGE QUEUE
   
   ┌─────────────────┐  ┌─────────────┐   ┌──────────┐
   │ Auth Service    │  │  MongoDB    │   │RabbitMQ  │
   │ Port: 3001      │  │  Port:27017 │   │Port:5672 │
   ├─────────────────┤  ├─────────────┤   ├──────────┤
   │ Content Service │  │ PostgreSQL  │   │ Redis    │
   │ Port: 3003      │  │  Port:5432  │   │Port:6379 │
   ├─────────────────┤  ├─────────────┤   ├──────────┤
   │ Feed Service    │  │Elasticsearch│   │Memcached │
   │ Port: 3004      │  │  Port:9200  │   │Port:11211│
   ├─────────────────┤  └─────────────┘   └──────────┘
   │ Chat Service    │
   │ Port: 3002      │
   ├─────────────────┤
   │ Search Service  │
   │ Port: 3006      │
   ├─────────────────┤
   │ Notification    │
   │ Service:3007    │
   ├─────────────────┤
   │ Analytics       │
   │ Service:3008    │
   ├─────────────────┤
   │ AI Moderation   │
   │ Service:3005    │
   ├─────────────────┤
   │ Payment Service │
   │ Port: 3009      │
   └─────────────────┘
```

## Prerequisites

- Docker Engine 20.10+
- Docker Compose 2.0+
- 8GB RAM minimum
- 50GB disk space
- Linux, macOS, or Windows with WSL2

## Quick Start

### 1. Clone Repository
```bash
git clone <repository-url>
cd social-media-app
```

### 2. Setup Environment Variables
```bash
# Copy production environment template
cp .env.production .env.local

# Edit and set your variables
nano .env.local
```

### 3. Generate SSL Certificates (Optional)
```bash
mkdir -p ./nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout ./nginx/ssl/private.key \
  -out ./nginx/ssl/certificate.crt
```

### 4. Start All Services
```bash
docker-compose -f docker-compose.production.yml up -d
```

### 5. Verify Services
```bash
docker-compose -f docker-compose.production.yml ps
```

## Configuration Details

### Environment Variables

#### Critical Secrets (MUST CHANGE IN PRODUCTION)
- `JWT_SECRET` - Random 32+ character string
- `JWT_REFRESH_SECRET` - Random 32+ character string
- `MONGO_PASSWORD` - Strong database password
- `POSTGRES_PASSWORD` - Strong database password
- `REDIS_PASSWORD` - Strong cache password
- `RABBITMQ_PASSWORD` - Strong message queue password
- `ELASTICSEARCH_PASSWORD` - Strong search engine password

#### External Services
- `AWS_ACCESS_KEY_ID` - AWS IAM credentials
- `AWS_SECRET_ACCESS_KEY` - AWS IAM secret
- `OPENAI_API_KEY` - OpenAI API key
- `STRIPE_SECRET_KEY` - Stripe payment keys
- `FIREBASE_PROJECT_ID` - Firebase configuration
- `GOOGLE_VISION_KEY_PATH` - Google Vision API credentials

## Services Details

### Frontend
- **Technology**: Flutter (Web)
- **Container**: smart_social_frontend
- **Port**: 80 (80 internal)
- **Image**: Build from ./frontend/Dockerfile
- **Volumes**: None (stateless)
- **Health Check**: HTTP GET /health

### API Gateway
- **Technology**: Node.js/Express
- **Container**: smart_social_api_gateway
- **Port**: 8000
- **Image**: Build from ./backend/api-gateway/Dockerfile
- **Routes**: Routes to all microservices
- **Load Balancing**: Least connections algorithm

### Authentication Service
- **Port**: 3001
- **Database**: MongoDB (smart_social_auth)
- **Features**: JWT, OAuth, 2FA
- **Key Variables**: JWT_SECRET, JWT_REFRESH_SECRET
- **Health Check**: /health endpoint

### Content Service
- **Port**: 3003
- **Database**: MongoDB (smart_social_content)
- **Storage**: AWS S3
- **Features**: Image/video upload, processing
- **Key Variables**: AWS credentials, S3 bucket

### Feed Service
- **Port**: 3004
- **Database**: MongoDB (smart_social_feed)
- **Search**: Elasticsearch
- **Features**: Feed generation, recommendations
- **Cache**: Redis for feed caching

### Chat Service
- **Port**: 3002
- **Database**: MongoDB (smart_social_chat)
- **Queue**: RabbitMQ for message distribution
- **Real-time**: Socket.io
- **Cache**: Redis for active conversations

### Search Service
- **Port**: 3006
- **Search**: Elasticsearch
- **Cache**: Redis for query results
- **Indexes**: Posts, users, hashtags, locations
- **Features**: Full-text search, filters

### Notification Service
- **Port**: 3007
- **Database**: MongoDB (smart_social_notifications)
- **Queue**: RabbitMQ for event handling
- **Push**: Firebase Cloud Messaging
- **Email**: SMTP (Nodemailer)

### Analytics Service
- **Port**: 3008
- **Database**: MongoDB (smart_social_analytics)
- **Metrics**: Prometheus
- **Dashboards**: Grafana
- **Features**: User analytics, engagement metrics

### AI Moderation Service
- **Port**: 3005
- **APIs**: OpenAI, Google Vision
- **Features**: Content moderation, image analysis
- **Cache**: Redis for model caching

### Payment Service
- **Port**: 3009
- **Database**: MongoDB (smart_social_payments)
- **Provider**: Stripe
- **Features**: Subscriptions, one-time payments
- **Cache**: Redis for transaction cache

### Databases

#### MongoDB
- **Image**: mongo:7.0-alpine
- **Port**: 27017
- **Authentication**: admin/password
- **Storage**: `/data/db` volume
- **Backup**: Daily automatic backups

#### PostgreSQL
- **Image**: postgres:16-alpine
- **Port**: 5432
- **Initialization**: init-postgres.sql script
- **Storage**: `/var/lib/postgresql/data` volume
- **Backup**: WAL-based continuous archiving

#### Redis
- **Image**: redis:7-alpine
- **Port**: 6379
- **Authentication**: requirepass
- **Storage**: `/data` volume with AOF
- **Persistence**: Append-only file (AOF)

#### Elasticsearch
- **Image**: elasticsearch:8.9.0
- **Port**: 9200
- **Authentication**: Built-in security
- **Storage**: `/usr/share/elasticsearch/data` volume
- **Cluster**: Single-node configuration

### Message Queue

#### RabbitMQ
- **Image**: rabbitmq:3.12-management-alpine
- **Port**: 5672 (AMQP)
- **Management**: 15672 (Web UI)
- **Storage**: `/var/lib/rabbitmq` volume
- **Features**: Message persistence, clustering ready

### Monitoring

#### Prometheus
- **Image**: prom/prometheus:latest
- **Port**: 9090
- **Config**: prometheus.yml
- **Retention**: 15 days (configurable)
- **Scrape Interval**: 15s (configurable)

#### Grafana
- **Image**: grafana/grafana:latest
- **Port**: 3000
- **Admin**: admin/password
- **Storage**: `/var/lib/grafana` volume
- **Dashboards**: Pre-configured for monitoring

## Common Operations

### Start Services
```bash
# Start all services
docker-compose -f docker-compose.production.yml up -d

# Start specific service
docker-compose -f docker-compose.production.yml up -d auth-service

# With logs
docker-compose -f docker-compose.production.yml up
```

### Stop Services
```bash
# Stop all services
docker-compose -f docker-compose.production.yml down

# Stop with cleanup
docker-compose -f docker-compose.production.yml down --volumes

# Stop specific service
docker-compose -f docker-compose.production.yml stop auth-service
```

### View Logs
```bash
# All services
docker-compose -f docker-compose.production.yml logs -f

# Specific service
docker-compose -f docker-compose.production.yml logs -f auth-service

# Last 100 lines
docker-compose -f docker-compose.production.yml logs --tail=100

# Since specific time
docker-compose -f docker-compose.production.yml logs --since 2024-01-15T10:00:00
```

### Restart Service
```bash
docker-compose -f docker-compose.production.yml restart auth-service
```

### Scale Service
```bash
docker-compose -f docker-compose.production.yml up -d --scale chat-service=3
```

### Access Databases

#### MongoDB
```bash
docker exec -it smart_social_mongodb mongosh \
  -u admin -p smartsocial123 --authenticationDatabase admin
```

#### PostgreSQL
```bash
docker exec -it smart_social_postgresql psql \
  -U postgres -d smart_social
```

#### Redis
```bash
docker exec -it smart_social_redis redis-cli
```

### Access Services

#### RabbitMQ Management
- URL: http://localhost:15672
- Username: admin
- Password: ${RABBITMQ_PASSWORD}

#### Grafana Dashboards
- URL: http://localhost:3000
- Username: admin
- Password: ${GRAFANA_PASSWORD}

#### Prometheus Metrics
- URL: http://localhost:9090

## Health Checks

### Check Service Status
```bash
docker-compose -f docker-compose.production.yml ps
```

### Test API Gateway
```bash
curl http://localhost:8000/health
```

### Test Frontend
```bash
curl http://localhost/health
```

### Test Individual Services
```bash
curl http://localhost:3001/health  # Auth
curl http://localhost:3003/health  # Content
curl http://localhost:3004/health  # Feed
curl http://localhost:3002/health  # Chat
curl http://localhost:3006/health  # Search
```

## Backup & Disaster Recovery

### MongoDB Backup
```bash
docker exec smart_social_mongodb mongodump \
  --username admin \
  --password smartsocial123 \
  --authenticationDatabase admin \
  --out /backups/mongo-backup
```

### PostgreSQL Backup
```bash
docker exec smart_social_postgresql pg_dump \
  -U postgres \
  -d smart_social > backup.sql
```

### Redis Backup
```bash
docker exec smart_social_redis redis-cli BGSAVE
```

### Elasticsearch Backup
```bash
curl -X PUT "http://localhost:9200/_snapshot/backup" \
  -H 'Content-Type: application/json' \
  -d '{"type": "fs", "settings": {"location": "/backups"}}'
```

## Security Best Practices

### 1. Change Default Passwords
```bash
# Edit .env.production
MONGO_PASSWORD=your_strong_password
POSTGRES_PASSWORD=your_strong_password
REDIS_PASSWORD=your_strong_password
```

### 2. Use Strong Secrets
```bash
# Generate random strings
openssl rand -base64 32  # For JWT secrets
```

### 3. Enable HTTPS
```bash
# Generate SSL certificates
certbot certonly --standalone -d your-domain.com

# Update docker-compose to use certificates
volumes:
  - /etc/letsencrypt:/etc/letsencrypt:ro
```

### 4. Restrict Network Access
```yaml
# In docker-compose
ports:
  - "127.0.0.1:27017:27017"  # Only local access
```

### 5. Regular Updates
```bash
# Update images
docker-compose -f docker-compose.production.yml pull

# Rebuild with latest
docker-compose -f docker-compose.production.yml up -d --build
```

## Performance Optimization

### Enable Logging Rotation
```yaml
logging:
  driver: json-file
  options:
    max-size: 10m
    max-file: 3
```

### Resource Limits
```yaml
services:
  auth-service:
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M
```

### Database Optimization
- MongoDB: Enable compression, create indexes
- PostgreSQL: Enable WAL archiving, autovacuum
- Redis: Set maxmemory policies
- Elasticsearch: Tune JVM heap size

## Troubleshooting

### Service Won't Start
```bash
# Check logs
docker-compose logs service-name

# Check dependencies
docker-compose ps

# Rebuild image
docker-compose build --no-cache service-name
```

### Database Connection Issues
```bash
# Test MongoDB
docker exec smart_social_mongodb mongosh --eval "db.adminCommand('ping')"

# Test PostgreSQL
docker exec smart_social_postgresql psql -U postgres -c "SELECT version();"
```

### High Memory Usage
```bash
# Check memory per container
docker stats

# Adjust service limits
# Edit docker-compose and set memory limits
```

### Network Issues
```bash
# Check network
docker network ls
docker network inspect smart_social_network

# Test connectivity
docker exec auth-service curl http://mongodb:27017
```

## Production Deployment

### Using Docker Swarm
```bash
docker swarm init
docker stack deploy -c docker-compose.production.yml smart_social
```

### Using Kubernetes
```bash
# Convert docker-compose to Kubernetes
kompose convert -f docker-compose.production.yml

# Deploy to Kubernetes
kubectl apply -f .
```

### CI/CD Integration

#### GitHub Actions
```yaml
name: Deploy
on: [push]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Deploy
        run: docker-compose -f docker-compose.production.yml up -d
```

## Monitoring & Metrics

### Key Metrics to Monitor
- CPU Usage
- Memory Usage
- Disk I/O
- Network I/O
- Database Connections
- Request Latency
- Error Rates

### Prometheus Queries
```
# Service availability
up{job="auth-service"}

# Request duration
histogram_quantile(0.95, request_duration_seconds)

# Error rate
rate(errors_total[5m])
```

## Maintenance Schedule

| Task | Frequency | Command |
|------|-----------|---------|
| Backup Databases | Daily | See Backup section |
| Update Images | Weekly | `docker-compose pull` |
| Log Rotation | Daily | Automatic (configured) |
| Security Patches | Monthly | OS & package updates |
| Performance Review | Weekly | Check metrics in Grafana |

## Support & Documentation

- Docker Compose: https://docs.docker.com/compose/
- MongoDB: https://docs.mongodb.com/
- PostgreSQL: https://www.postgresql.org/docs/
- Redis: https://redis.io/documentation
- Elasticsearch: https://www.elastic.co/guide/
- RabbitMQ: https://www.rabbitmq.com/documentation.html

## Conclusion

This Docker setup provides a complete, production-ready infrastructure for the Smart Social Media Platform. Follow the guidelines for security, monitoring, and maintenance to ensure optimal performance and reliability.

