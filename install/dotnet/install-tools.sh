#!/usr/bin/env bash

dotnet tool install --global fake-cli
dotnet tool install --global dotnet-fsharplint
#dotnet tool install --global dotnet-sonarscanner
dotnet tool install --global paket --version 6.0.0-alpha018

dotnet tool list --global
