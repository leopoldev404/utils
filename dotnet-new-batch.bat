@echo off
setlocal enabledelayedexpansion

REM Check if a parameter is passed
if "%1"=="" (
    echo Usage: %0 ProjectName [api|worker]
    exit /b 1
)

set "NAME=%1"
set "TYPE=%2"

set "GIT_IGNORE_URL=https://raw.githubusercontent.com/leopoldev404/quizz/main/.gitignore"
set "DOCKER_IGNORE_URL=https://raw.githubusercontent.com/leopoldev404/quizz/main/docker/.dockerignore"

REM Create project folders
mkdir "%NAME%"
cd "%NAME%"
mkdir src
mkdir tests
mkdir docker

REM Create solution
dotnet new sln -n %NAME%

REM Create project based on type
if /i "%TYPE%"=="api" (
    dotnet new console -n Service -o src\Service
    powershell -Command "(gc src\Service\Service.csproj) -replace '<Project Sdk=\"Microsoft.NET.Sdk\">', '<Project Sdk=\"Microsoft.NET.Sdk.Web\">' | sc src\Service\Service.csproj"
    (
        echo var builder = WebApplication.CreateBuilder(args^);
        echo var app = builder.Build();
        echo;
        echo app.MapGet("/", () => "We Gucci!"^);
        echo await app.RunAsync();
    ) > src\Service\Program.cs
) else if /i "%TYPE%"=="worker" (
    dotnet new worker -n Service -o src\Service
) else (
    echo Missing project type (supported: [api, worker])
    exit /b 1
)

REM Create class libraries
dotnet new classlib -n Core -o src\Core
dotnet new classlib -n Infrastructure -o src\Infrastructure

REM Create tests
dotnet new xunit -n UnitTests -o tests\UnitTests
dotnet new xunit -n IntegrationTests -o tests\IntegrationTests

REM Add references
dotnet add src\Service reference src\Core src\Infrastructure
dotnet add src\Infrastructure reference src\Core
dotnet add tests\IntegrationTests reference src\Service
dotnet add tests\UnitTests reference src\Core src\Infrastructure
dotnet sln add src\Service src\Core src\Infrastructure tests\UnitTests tests\IntegrationTests

REM Remove useless files
for /r %%i in (Class1.cs) do del "%%i"
for /r %%i in (UnitTest1.cs) do del "%%i"

REM Create makefile
(
    echo clean:
    echo.    @dotnet clean
    echo.
    echo build: clean
    echo.    @dotnet build
    echo.
    echo run: build
    echo.    @dotnet run --project src/Service
) > makefile

REM Initialize Docker
(
    echo FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
    echo WORKDIR /src
    echo COPY src/Service/Service.csproj Service/Service.csproj
    echo COPY src/Core/Core.csproj Core/Core.csproj
    echo COPY src/Infrastructure/Infrastructure.csproj Infrastructure/Infrastructure.csproj
    echo RUN dotnet restore "Service/Service.csproj"
    echo COPY src/Service/ Service/
    echo COPY src/Core/ Core/
    echo COPY src/Repository/ Repository/
    echo WORKDIR /src/Service
    echo RUN dotnet publish -c Release -o /app "Service.csproj"
    echo FROM mcr.microsoft.com/dotnet/aspnet:8.0
    echo WORKDIR /app
    echo COPY --from=build /app .
    echo ENTRYPOINT ["dotnet", "Service.dll"]
) > docker\dockerfile

powershell -Command "Invoke-WebRequest -Uri %DOCKER_IGNORE_URL% -OutFile docker\.dockerignore"

(
    echo services:
    echo.  db:
    echo.    image: mongo
    echo.    restart: always
    echo.    container_name: db
    echo.    environment:
    echo.      MONGO_INITDB_DATABASE: db
    echo.    ports:
    echo.      - "27017:27017"
    echo.    volumes:
    echo.      - db-data:/data/db
    echo.
    echo volumes:
    echo.  db-data:
) > docker\docker-compose.yml

REM Install CSharpier
dotnet new tool-manifest
dotnet tool install csharpier

REM Initialize Git repository
powershell -Command "Invoke-WebRequest -Uri %GIT_IGNORE_URL% -OutFile .gitignore"

(
    echo ^<div align="center"^>
    echo.
    echo # %NAME%
    echo.
    echo ^</div^>
    echo.
    echo ## Intro
    echo.
    echo ## Features
    echo.
    echo ## Run
    echo.
    echo ## Test
    echo.
    echo ## Considerations
) > readme.md

git init
git add .
git commit -m "feat: init repo 💲"

echo Have Fun! 🦄🚀
