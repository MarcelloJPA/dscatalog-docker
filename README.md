# 🐳 DSCatalog — Dockerized Spring Boot API

API REST de catálogo de produtos desenvolvida com **Spring Boot 3 + Java 21**, dockerizada com boas práticas de produção: multi-stage build, imagem Alpine, cache de layers otimizado e build multi-plataforma com Docker Buildx.

## 🚀 Técnicas aplicadas

**Multi-stage Build** — Separação entre ambiente de compilação e imagem final. O Stage 1 usa o JDK completo para compilar e gerar o `.jar`. O Stage 2 usa apenas o JRE Alpine para executar, descartando compilador, Maven e código-fonte da imagem final.

**Cache de layers otimizado** — O `pom.xml` é copiado antes do código-fonte e as dependências são baixadas em uma layer separada com `dependency:go-offline`. Mudanças no código não invalidam o cache das dependências Maven.

**Docker Buildx multi-plataforma** — Geração de imagem para `linux/amd64` e `linux/arm64` com um único comando, garantindo compatibilidade com servidores Linux e Macs com Apple Silicon.

## 📊 Redução de tamanho da imagem

| Versão | Técnica aplicada | Tamanho |
|--------|-----------------|---------|
| v1 | Dockerfile básico (JDK) | **974 MB** |
| v2 | Multi-stage build | **498 MB** (-49%) |
| v3 | Multi-stage + Alpine | **381 MB** (-61%) |
| v4 | Cache de layers otimizado | **381 MB** + builds 5x mais rápidos |
| v5 | Buildx multi-plataforma | **381 MB** (amd64 + arm64) ✅ |

## 🐋 Imagem no Docker Hub
```bash
docker pull cellops/dscatalog:v1
```

🔗 [hub.docker.com/r/cellops/dscatalog](https://hub.docker.com/r/cellops/dscatalog)

## ⚙️ Como rodar localmente
```bash
git clone https://github.com/MarcelloJPA/dscatalog-docker.git
cd dscatalog-docker
docker build -t dscatalog .
docker run -p 8080:8080 dscatalog
```

A API estará disponível em `http://localhost:8080`

## 🛠️ Stack

- Java 21 + Spring Boot 3.3
- Spring Data JPA
- H2 (testes) + PostgreSQL (produção)
- Docker + Buildx + Maven

## 🔜 Próximos passos

- [ ] docker-compose com PostgreSQL
- [ ] Pipeline CI/CD com GitHub Actions

> Projeto base do curso DevSuperior, dockerizado como projeto prático do módulo Docker Buildx e Cache — FullCycle.
