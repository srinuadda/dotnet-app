FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY Api/ Api/
COPY Api.Tests/ Api.Tests/
RUN dotnet restore Api/Api.csproj
RUN dotnet build Api/Api.csproj -c Release -o /app/build
RUN dotnet test Api.Tests/Api.Tests.csproj -c Release --no-build

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/build .
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "Api.dll"]
