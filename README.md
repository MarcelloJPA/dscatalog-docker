#  DSCatalog — Dockerized Spring Boot API

API REST dockerizada com multi-stage build, Alpine, cache de layers e Buildx multi-plataforma.

##  Redução de tamanho da imagem

| Versão | Técnica | Tamanho |
|--------|---------|---------|
| v1 | Dockerfile básico | 974 MB |
| v2 | Multi-stage build | 498 MB (-49%) |
| v3 | Multi-stage + Alpine | 381 MB (-61%) |
| v4 | Cache de layers | 381 MB + 5x mais rápido |
| v5 | Buildx multi-plataforma | 381 MB (amd64 + arm64) |
