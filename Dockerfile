#-------------Estágio 1: Build------------------
FROM eclipse-temurin:21-jdk AS builder
WORKDIR /app

# Copia só o pom.xml e o Maven Wrapper primeiro
# Isso cria uma layer separada só para dependências
COPY backend/pom.xml .
COPY backend/mvnw .
COPY backend/.mvn .mvn

# Baixa todas as dependências e guarda em cache
# Essa layer só vai ser refeita se o pom.xml mudar
RUN ./mvnw dependency:go-offline -q

# Agora sim copia o código fonte
# Separado das dependências para não invalidar o cache delas
COPY backend/src ./src

# Compila usando as dependências já em cache
RUN ./mvnw package -DskipTests


#-------------Estágio 2: Runtime------------------
FROM eclipse-temurin:21-jre-alpine AS runtime
WORKDIR /app


COPY --from=builder /app/target/dscatalog-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]