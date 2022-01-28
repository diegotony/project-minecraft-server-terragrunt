FROM alpine/terragrunt:latest
WORKDIR /app/src/
COPY . /app/src/
WORKDIR /app/src/minecraft-server/
RUN terragrunt --version