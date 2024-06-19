#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <ProjectName>"
  exit 1
fi

# create project folders
NAME=$1
TYPE=$2

GIT_IGNORE_URL="https://raw.githubusercontent.com/leopoldev404/quizz/main/.gitignore"
DOCKER_IGNORE_URL="https://raw.githubusercontent.com/leopoldev404/quizz/main/docker/.dockerignore"

mkdir $NAME
cd $NAME
mkdir src
mkdir tests
mkdir docker

# create solution
dotnet new sln -n $NAME

# create project
if [[ "$TYPE" == "api" ]]; then
  dotnet new console -n Service -o src/Service
  sed -i '1s/.*/<Project Sdk="Microsoft.NET.Sdk.Web">/' src/Service/Service.csproj
  cat <<EOL >src/Service/Program.cs
  var builder = WebApplication.CreateBuilder(args);
  var app = builder.Build();

  app.MapGet("", () => "We Gucci!");
  await app.RunAsync();
EOL

elif [[ "$TYPE" == "worker" ]]; then
  # create project
  dotnet new worker -n Service -o src/Service
else
  echo "Missing project type (supported: [api, worker])"
  exit 1
fi

# create class libs
dotnet new classlib -n Core -o src/Core
dotnet new classlib -n Infrastructure -o src/Infrastructure

# create tests
dotnet new xunit -n UnitTests -o tests/UnitTests
dotnet new xunit -n IntegrationTests -o tests/IntegrationTests

# add references
dotnet add src/Service reference src/Core src/Infrastructure
dotnet add src/Infrastructure reference src/Core
dotnet add tests/IntegrationTests reference src/Service
dotnet add tests/UnitTests reference src/Core src/Infrastructure
dotnet sln add src/Service src/Core src/Infrastructure tests/UnitTests tests/IntegrationTests

# remove useless files
find "./" -type f -name "Class1.cs" -exec rm -f {} \;
find "./" -type f -name "UnitTest1.cs" -exec rm -f {} \;

# create makefile
touch makefile
cat <<EOL >makefile
clean:
  @dotnet clean

build: clean
  @dotnet build

run: build
  @dotnet run --project src/Service
EOL

# init docker
touch docker/dockerfile
cat <<EOL >docker/dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY src/Service/Service.csproj Service/Service.csproj
COPY src/Core/Core.csproj Core/Core.csproj
COPY src/Infrastructure/Infrastructure.csproj Infrastructure/Infrastructure.csproj
RUN dotnet restore "Service/Service.csproj"
COPY src/Service/ Service/
COPY src/Core/ Core/
COPY src/Repository/ Repository/
WORKDIR /src/Service
RUN dotnet publish -c Release -o /app "Service.csproj"
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "Service.dll"]
EOL

touch docker/.dockerignore
curl -sL $DOCKER_IGNORE_URL -o docker/.dockerignore

touch docker/docker-compose.yml
cat <<EOL >docker/docker-compose.yml
services:
  db:
    image: mongo
    restart: always
    container_name: db
    environment:
      MONGO_INITDB_DATABASE: db
    ports:
      - "27017:27017"
    volumes:
      - db-data:/data/db

volumes:
  db-data:
EOL

# install csharpier
dotnet new tool-manifest
dotnet tool install csharpier

# create git repo
touch .gitignore
curl -sL $GIT_IGNORE_URL -o .gitignore

touch readme.md
cat <<EOL >readme.md
<div align="center">

# $NAME

</div>

## Intro

## Features

## Run

## Test

## Considerations
 
EOL

git init
git add .
git commit -m "feat: init repo 💲"

echo "Have Fun! 🦄🚀"
