# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY Soft.Taxas.API/*.csproj Soft.Taxas.API/
COPY Soft.Taxas.Dominio/*.csproj Soft.Taxas.Dominio/
RUN dotnet restore Soft.Taxas.API/Soft.Taxas.API.csproj

# copy and build app and libraries
COPY Soft.Taxas.API/ Soft.Taxas.API/
COPY Soft.Taxas.Dominio/ Soft.Taxas.Dominio/
WORKDIR /source/Soft.Taxas.API
RUN dotnet build -c release --no-restore

# test stage -- exposes optional entrypoint
# target entrypoint with: docker build --target test
FROM build AS test
WORKDIR /source/tests
COPY Soft.Taxas.Tests/ .
ENTRYPOINT ["dotnet", "test", "--logger:trx"]

FROM build AS publish
RUN dotnet publish -c release --no-build -o /app

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:3.1
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Soft.Taxas.API.dll"]