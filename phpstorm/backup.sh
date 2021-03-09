#!/usr/bin/env bash

set -e

PHPSTORM="PhpStorm2021.1"

echo "Backup $PHPSTORM"
echo "==================="
echo ""

echo "Templates ..."
mkdir -p phpstorm/templates
cp ~/Library/Application\ Support/JetBrains/$PHPSTORM/templates/* phpstorm/templates/

echo "FileTemplates - code ..."
mkdir -p phpstorm/fileTemplates/code
cp ~/Library/Application\ Support/JetBrains/$PHPSTORM/fileTemplates/code/* phpstorm/fileTemplates/code/

echo "FileTemplates - includes ..."
mkdir -p phpstorm/fileTemplates/includes
cp ~/Library/Application\ Support/JetBrains/$PHPSTORM/fileTemplates/includes/* phpstorm/fileTemplates/includes/

echo "Scratches ..."
mkdir -p phpstorm/scratches
cp ~/Library/Application\ Support/JetBrains/$PHPSTORM/scratches/* phpstorm/scratches/

echo "Tools ..."
mkdir -p phpstorm/tools
cp ~/Library/Application\ Support/JetBrains/$PHPSTORM/tools/* phpstorm/tools/

echo "Done"
