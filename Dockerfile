ARG base_image=mcr.microsoft.com/dotnet/sdk:8.0
ARG runtime_image=mcr.microsoft.com/dotnet/aspnet:8.0
FROM ${base_image} AS build-env
WORKDIR /app

COPY WeatherApp.Api ./
RUN dotnet publish WeatherApp.Api.csproj -c Release -o ../out

FROM ${runtime_image}

COPY --from=build-env /out /app
WORKDIR /app
EXPOSE 8080
ENTRYPOINT ["dotnet", "WeatherApp.Api.dll"]