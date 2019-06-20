#!/bin/bash

dotnet tool install --global fake-cli
dotnet tool install --global dotnet-fsharplint
dotnet tool install --global dotnet-sonarscanner

dotnet tool list --global
