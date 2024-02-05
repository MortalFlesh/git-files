#!/usr/bin/env bash

dotnet tool install --global amazon.lambda.tools
dotnet tool install --global dotnet-fsharplint --version 0.21.2
dotnet tool install --global fake-cli --version 6.0.0
dotnet tool install --global paket --version 8.0.0
#dotnet tool install --global dotnet-sonarscanner

dotnet tool list --global
